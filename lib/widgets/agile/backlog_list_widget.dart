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
  final void Function(String storyId, StoryPriority newPriority)? onPriorityChange;
  final void Function(String storyId, String newTitle)? onTitleChange;
  final void Function(String storyId, int? newPoints)? onStoryPointsChange;
  final void Function(String storyId, String? newAssigneeEmail)? onAssigneeChange;
  final List<String> teamMembers;
  final void Function(UserStoryModel story)? onStoryEstimate;
  final void Function(UserStoryModel story)? onAddToSprint;
  final VoidCallback? onAddStory;
  final AgileFramework framework;
  final bool canMoveToBacklog;
  final bool canMarkAsReady;

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
    this.onPriorityChange,
    this.onTitleChange,
    this.onStoryPointsChange,
    this.onAssigneeChange,
    this.teamMembers = const [],
    this.onStoryEstimate,
    this.onAddToSprint,
    this.onAddStory,
    required this.framework,
    this.shrinkWrap = false,
    this.physics,
    this.canMoveToBacklog = true, // Default true for backward compatibility
    this.canMarkAsReady = false,
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

  /// Helper per trovare lo sprint di una story
  SprintModel? _getSprintForStory(UserStoryModel story) {
    if (story.sprintId == null) return null;
    return widget.sprints.where((s) => s.id == story.sprintId).firstOrNull;
  }

  /// Stories "Archiviate" (completate o in sprint completati)
  bool _isArchived(UserStoryModel story) {
    if (story.status == StoryStatus.done) return true;
    if (story.sprintId != null) {
      final sprint = _getSprintForStory(story);
      if (sprint != null && sprint.status == SprintStatus.completed) {
        return true;
      }
    }
    return false;
  }

  List<UserStoryModel> get _filteredStories {
    var filtered = widget.stories;

    // Filtra per status: 
    // Se "Tutti" (null), escludi le archiviate (Done o Sprint completati)
    if (_statusFilter == null) {
      filtered = filtered.where((s) => !_isArchived(s)).toList();
    } else {
      filtered = filtered.where((s) => s.status == _statusFilter).toList();
    }

    // Filtra per ricerca
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((s) =>
          s.title.toLowerCase().contains(query) ||
          s.description.toLowerCase().contains(query) ||
          s.storyId.toLowerCase().contains(query)
      ).toList();
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
    final archivedCount = widget.stories.where((s) => _isArchived(s)).length;

    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          bottom: BorderSide(color: context.borderColor),
        ),
      ),
      child: Column(
        children: [
          // Riga superiore: titolo e pulsanti
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.list_alt,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    l10n.agileBacklogTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.textPrimaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                // Stats badges - Moved to RIGHT side
                _buildStatBadge(l10n.agileBacklogStatsStories(count), Colors.blue),
                const SizedBox(width: 8),
                _buildStatBadge(l10n.agileBacklogStatsPoints(totalPoints), Colors.green),
                const SizedBox(width: 8),
                _buildStatBadge(l10n.agileBacklogStatsEstimated(estimatedCount), Colors.orange),
                const SizedBox(width: 8),
                Tooltip(
                  message: l10n.agileBacklogDoneBadgeTooltip,
                  child: _buildStatBadge(l10n.agileBacklogDoneBadge(archivedCount), Colors.teal),
                ),
                const SizedBox(width: 16),
                // Bottone filtri
                IconButton(
                  icon: Icon(
                    _showFilters ? Icons.filter_list_off : Icons.filter_list,
                    color: _hasActiveFilters ? AppColors.primary : context.textMutedColor,
                  ),
                  onPressed: () => setState(() => _showFilters = !_showFilters),
                  tooltip: l10n.agileFiltersTitle,
                ),
                // Bottone aggiungi
                if (widget.canEdit && widget.onAddStory != null)
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
          ),
          const SizedBox(height: 12),
          // Riga ricerca
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
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
              ...StoryStatus.values.map((status) {
                final chip = FilterChip(
                  label: Text(status.getDisplayName(widget.framework)),
                  selected: _statusFilter == status,
                  onSelected: (_) => setState(() => _statusFilter = status),
                  selectedColor: status.color.withOpacity(0.2),
                );

                if (status == StoryStatus.done) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Tooltip(
                      message: l10n.agileFiltersDoneTooltip,
                      child: chip,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: chip,
                );
              }),
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
        buildDefaultDragHandles: false, // Disable default right-side handles
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
      itemBuilder: (context, index) {
        final story = stories[index];
        return _buildStoryItem(story, key: ValueKey(story.id));
      },
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
        key: key,
        story: story,
        sprintName: sprintName,
        isSprintCompleted: isSprintCompleted,
        teamMembers: widget.teamMembers,
        onTap: widget.onStoryTap != null ? () => widget.onStoryTap!(story) : null,
        onEdit: widget.canEdit && widget.onStoryEdit != null
            ? () => widget.onStoryEdit!(story)
            : null,
        onDelete: widget.canEdit && widget.onStoryDelete != null
            ? () => widget.onStoryDelete!(story.id)
            : null,
        framework: widget.framework,
        canMoveToBacklog: widget.canMoveToBacklog,
        isBoardContext: false,
        canMarkAsReady: widget.canMarkAsReady,
        onStatusChange: widget.canEdit && widget.onStatusChange != null
            ? (status) => widget.onStatusChange!(story.id, status)
            : null,
        onPriorityChange: widget.canEdit && widget.onPriorityChange != null
            ? (priority) => widget.onPriorityChange!(story.id, priority)
            : null,
        onTitleChange: widget.canEdit && widget.onTitleChange != null
            ? (title) => widget.onTitleChange!(story.id, title)
            : null,
        onStoryPointsChange: widget.canEdit && widget.onStoryPointsChange != null
            ? (points) => widget.onStoryPointsChange!(story.id, points)
            : null,
        onAssigneeChange: widget.canEdit && widget.onAssigneeChange != null
            ? (assignee) => widget.onAssigneeChange!(story.id, assignee)
            : null,
        onEstimate: widget.canEdit && widget.onStoryEstimate != null
            ? () => widget.onStoryEstimate!(story)
            : null,
        // Non permettere di aggiungere a sprint se già in un altro sprint o se nell'archivio
        onAddToSprint: widget.canEdit && widget.onAddToSprint != null && story.sprintId == null && !_isArchived(story)
            ? () => widget.onAddToSprint!(story)
            : null,
        showDragHandle: widget.canEdit && widget.onReorder != null && !_isArchived(story),
      ),
    );
  }
}
