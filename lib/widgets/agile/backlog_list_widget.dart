import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/sprint_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'story_card_widget.dart';
import 'story_form_dialog.dart';
import 'story_detail_dialog.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Widget per visualizzare e gestire il Product Backlog
///
/// Funzionalità:
/// - Lista ordinabile con drag & drop
/// - Filtri per status, priority, tag, assignee
/// - Ricerca
/// - Azioni bulk (prioritize, change status)
/// - Archivio stories completate (separato dal backlog attivo)
class BacklogListWidget extends StatefulWidget {
  final List<UserStoryModel> stories;
  final List<SprintModel> sprints;
  final String projectId;
  final bool canEdit;
  final void Function(UserStoryModel story)? onStoryTap;
  final void Function(UserStoryModel story)? onStoryEdit;
  final void Function(String storyId)? onStoryDelete;
  final void Function(List<String> newOrder)? onReorder;
  final void Function(String storyId, StoryStatus newStatus)? onStatusChange;
  final void Function(UserStoryModel story)? onStoryEstimate;
  final void Function(UserStoryModel story)? onAddToSprint;
  final VoidCallback? onAddStory;

  const BacklogListWidget({
    super.key,
    required this.stories,
    this.sprints = const [],
    required this.projectId,
    this.canEdit = true,
    this.onStoryTap,
    this.onStoryEdit,
    this.onStoryDelete,
    this.onReorder,
    this.onStatusChange,
    this.onStoryEstimate,
    this.onAddToSprint,
    this.onAddStory,
    this.shrinkWrap = false,
    this.physics,
  });

  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  State<BacklogListWidget> createState() => _BacklogListWidgetState();
}

class _BacklogListWidgetState extends State<BacklogListWidget> {
  String _searchQuery = '';
  StoryStatus? _statusFilter;
  StoryPriority? _priorityFilter;
  String? _tagFilter;
  bool _showFilters = false;
  bool _showArchive = false; // Toggle per mostrare archivio completate

  /// Helper per trovare lo sprint di una story
  SprintModel? _getSprintForStory(UserStoryModel story) {
    if (story.sprintId == null) return null;
    return widget.sprints.where((s) => s.id == story.sprintId).firstOrNull;
  }

  /// Stories attive (non completate o in sprint non completati)
  List<UserStoryModel> get _activeStories {
    return widget.stories.where((story) {
      // Stories completate (Done) vanno nell'archivio
      if (story.status == StoryStatus.done) return false;

      // Stories in sprint completati vanno nell'archivio
      if (story.sprintId != null) {
        final sprint = _getSprintForStory(story);
        if (sprint != null && sprint.status == SprintStatus.completed) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  /// Stories archiviate (completate o in sprint completati)
  List<UserStoryModel> get _archivedStories {
    return widget.stories.where((story) {
      // Stories completate (Done) sono archiviate
      if (story.status == StoryStatus.done) return true;

      // Stories in sprint completati sono archiviate
      if (story.sprintId != null) {
        final sprint = _getSprintForStory(story);
        if (sprint != null && sprint.status == SprintStatus.completed) {
          return true;
        }
      }

      return false;
    }).toList();
  }

  List<UserStoryModel> get _filteredStories {
    // Scegli la lista base in base al toggle archivio
    var filtered = _showArchive ? _archivedStories : _activeStories;

    // Filtra per ricerca
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((s) =>
          s.title.toLowerCase().contains(query) ||
          s.description.toLowerCase().contains(query) ||
          s.storyId.toLowerCase().contains(query)
      ).toList();
    }

    // Filtra per status
    if (_statusFilter != null) {
      filtered = filtered.where((s) => s.status == _statusFilter).toList();
    }

    // Filtra per priority
    if (_priorityFilter != null) {
      filtered = filtered.where((s) => s.priority == _priorityFilter).toList();
    }

    // Filtra per tag
    if (_tagFilter != null) {
      filtered = filtered.where((s) => s.tags.contains(_tagFilter)).toList();
    }

    return filtered;
  }

  Set<String> get _allTags {
    final tags = <String>{};
    for (final story in widget.stories) {
      tags.addAll(story.tags);
    }
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stories = _filteredStories;

    // Stats
    final totalPoints = stories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
    // Considera stimata sia se isEstimated=true, sia se ha storyPoints (retrocompatibilità)
    final estimatedCount = stories.where((s) => s.isEstimated || s.storyPoints != null).length;

    return Column(
      children: [
        // Header con ricerca e filtri
        _buildHeader(stories.length, totalPoints, estimatedCount),

        // Filtri espandibili
        if (_showFilters) _buildFilters(),

        // Lista stories
        widget.shrinkWrap
            ? (stories.isEmpty ? _buildEmptyState() : _buildStoryList(stories))
            : Expanded(
                child: stories.isEmpty
                    ? _buildEmptyState()
                    : _buildStoryList(stories),
              ),
      ],
    );
  }

  Widget _buildHeader(int count, int totalPoints, int estimatedCount) {
    final l10n = AppLocalizations.of(context)!;
    final archivedCount = _archivedStories.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          bottom: BorderSide(color: context.borderColor),
        ),
      ),
      child: Column(
        children: [
          // Riga superiore: titolo e pulsanti
          Row(
            children: [
              Icon(
                _showArchive ? Icons.archive : Icons.list_alt,
                color: _showArchive ? Colors.grey : AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                _showArchive ? l10n.agileBacklogArchiveTitle : l10n.agileBacklogTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
              const Spacer(),
              // Stats badges
              _buildStatBadge(l10n.agileBacklogStatsStories(count), Colors.blue),
              const SizedBox(width: 8),
              _buildStatBadge(l10n.agileBacklogStatsPoints(totalPoints), Colors.green),
              const SizedBox(width: 8),
              _buildStatBadge(l10n.agileBacklogStatsEstimated(estimatedCount), Colors.orange),
              const SizedBox(width: 16),
              // Toggle Archivio
              Tooltip(
                message: _showArchive
                    ? l10n.agileBacklogToggleActive
                    : l10n.agileBacklogToggleArchive(archivedCount),
                child: InkWell(
                  onTap: () => setState(() => _showArchive = !_showArchive),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _showArchive
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _showArchive
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.green.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _showArchive ? Icons.list_alt : Icons.archive,
                          size: 16,
                          color: _showArchive ? Colors.grey : Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _showArchive ? l10n.agileBacklogTitle : l10n.agileBacklogArchiveBadge(archivedCount),
                          style: TextStyle(
                            fontSize: 12,
                            color: _showArchive ? Colors.grey : Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Bottone filtri
              IconButton(
                icon: Icon(
                  _showFilters ? Icons.filter_list_off : Icons.filter_list,
                  color: _hasActiveFilters ? AppColors.primary : context.textMutedColor,
                ),
                onPressed: () => setState(() => _showFilters = !_showFilters),
                tooltip: l10n.agileFiltersTitle,
              ),
              // Bottone aggiungi (solo nel backlog attivo)
              if (widget.canEdit && widget.onAddStory != null && !_showArchive)
                ElevatedButton.icon(
                  onPressed: widget.onAddStory,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(l10n.agileActionNewStory),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Riga ricerca
          TextField(
            style: TextStyle(color: context.textPrimaryColor),
            decoration: InputDecoration(
              hintText: l10n.agileBacklogSearchHint,
              hintStyle: TextStyle(color: context.textMutedColor),
              prefixIcon: Icon(Icons.search, color: context.textMutedColor),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: context.textMutedColor),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
              filled: true,
              fillColor: context.surfaceVariantColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  bool get _hasActiveFilters =>
      _statusFilter != null || _priorityFilter != null || _tagFilter != null;

  Widget _buildFilters() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        border: Border(
          bottom: BorderSide(color: context.borderColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status filter
          Row(
            children: [
              Text('${l10n.agileFiltersStatus} ', style: TextStyle(fontWeight: FontWeight.w500, color: context.textSecondaryColor)),
              const SizedBox(width: 8),
              FilterChip(
                label: Text(l10n.agileFiltersAll),
                selected: _statusFilter == null,
                onSelected: (_) => setState(() => _statusFilter = null),
              ),
              const SizedBox(width: 4),
              ...StoryStatus.values.map((status) => Padding(
                padding: const EdgeInsets.only(left: 4),
                child: FilterChip(
                  label: Text(status.displayName),
                  selected: _statusFilter == status,
                  onSelected: (_) => setState(() => _statusFilter = status),
                  selectedColor: status.color.withOpacity(0.2),
                ),
              )),
            ],
          ),
          const SizedBox(height: 8),
          // Priority filter
          Row(
            children: [
              Text('${l10n.agileFiltersPriority} ', style: TextStyle(fontWeight: FontWeight.w500, color: context.textSecondaryColor)),
              const SizedBox(width: 8),
              FilterChip(
                label: Text(l10n.agileFiltersAll),
                selected: _priorityFilter == null,
                onSelected: (_) => setState(() => _priorityFilter = null),
              ),
              const SizedBox(width: 4),
              ...StoryPriority.values.map((priority) => Padding(
                padding: const EdgeInsets.only(left: 4),
                child: FilterChip(
                  label: Text(priority.displayName),
                  selected: _priorityFilter == priority,
                  onSelected: (_) => setState(() => _priorityFilter = priority),
                  selectedColor: priority.color.withOpacity(0.2),
                ),
              )),
            ],
          ),
          // Tags filter
          if (_allTags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Text('${l10n.agileFiltersTags} ', style: TextStyle(fontWeight: FontWeight.w500, color: context.textSecondaryColor)),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.agileFiltersAll),
                  selected: _tagFilter == null,
                  onSelected: (_) => setState(() => _tagFilter = null),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _allTags.map((tag) => Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: FilterChip(
                          label: Text(tag),
                          selected: _tagFilter == tag,
                          onSelected: (_) => setState(() => _tagFilter = tag),
                        ),
                      )).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
          // Clear filters
          if (_hasActiveFilters) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => setState(() {
                _statusFilter = null;
                _priorityFilter = null;
                _tagFilter = null;
              }),
              icon: const Icon(Icons.clear_all, size: 18),
              label: Text(l10n.agileFiltersClear),
            ),
          ],
        ],
      ),
    );
  }

   Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    if (_hasActiveFilters || _searchQuery.isNotEmpty) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: context.textMutedColor),
              const SizedBox(height: 16),
              Text(
                l10n.agileEmptyBacklogMatch,
                style: TextStyle(fontSize: 18, color: context.textSecondaryColor),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => setState(() {
                  _searchQuery = '';
                  _statusFilter = null;
                  _priorityFilter = null;
                  _tagFilter = null;
                }),
                child: Text(l10n.agileFiltersClear),
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, size: 64, color: context.textMutedColor),
            const SizedBox(height: 16),
            Text(
              l10n.agileEmptyBacklog,
              style: TextStyle(fontSize: 18, color: context.textSecondaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.agileEmptyBacklogHint,
              style: TextStyle(color: context.textTertiaryColor),
            ),
            if (widget.canEdit && widget.onAddStory != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: widget.onAddStory,
                icon: const Icon(Icons.add),
                label: Text(l10n.agileActionNewStory),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStoryList(List<UserStoryModel> stories) {
    if (widget.canEdit && widget.onReorder != null) {
      return ReorderableListView.builder(
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
        padding: const EdgeInsets.all(16),
        itemCount: stories.length,
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) newIndex--;
          final newOrder = List<String>.from(stories.map((s) => s.id));
          final item = newOrder.removeAt(oldIndex);
          newOrder.insert(newIndex, item);
          widget.onReorder!(newOrder);
        },
        itemBuilder: (context, index) {
          final story = stories[index];
          return _buildStoryItem(story, key: ValueKey(story.id));
        },
      );
    }

    return ListView.builder(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      padding: const EdgeInsets.all(16),
      itemCount: stories.length,
      itemBuilder: (context, index) => _buildStoryItem(stories[index]),
    );
  }

  Widget _buildStoryItem(UserStoryModel story, {Key? key}) {
    // Trova lo sprint associato alla story (se presente)
    final sprint = _getSprintForStory(story);
    final sprintName = sprint?.name;
    final isSprintCompleted = sprint?.status == SprintStatus.completed;

    return Padding(
      key: key,
      padding: const EdgeInsets.only(bottom: 8),
      child: StoryCardWidget(
        story: story,
        sprintName: sprintName,
        isSprintCompleted: isSprintCompleted,
        onTap: widget.onStoryTap != null ? () => widget.onStoryTap!(story) : null,
        onEdit: widget.canEdit && widget.onStoryEdit != null
            ? () => widget.onStoryEdit!(story)
            : null,
        onDelete: widget.canEdit && widget.onStoryDelete != null
            ? () => widget.onStoryDelete!(story.id)
            : null,
        onStatusChange: widget.canEdit && widget.onStatusChange != null
            ? (status) => widget.onStatusChange!(story.id, status)
            : null,
        onEstimate: widget.canEdit && widget.onStoryEstimate != null
            ? () => widget.onStoryEstimate!(story)
            : null,
        // Non permettere di aggiungere a sprint se già in un altro sprint o se nell'archivio
        onAddToSprint: widget.canEdit && widget.onAddToSprint != null && story.sprintId == null && !_showArchive
            ? () => widget.onAddToSprint!(story)
            : null,
        showDragHandle: widget.canEdit && widget.onReorder != null && !_showArchive,
      ),
    );
  }
}
