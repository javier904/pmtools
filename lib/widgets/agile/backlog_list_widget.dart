import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import 'story_card_widget.dart';
import 'story_form_dialog.dart';
import 'story_detail_dialog.dart';

/// Widget per visualizzare e gestire il Product Backlog
///
/// Funzionalità:
/// - Lista ordinabile con drag & drop
/// - Filtri per status, priority, tag, assignee
/// - Ricerca
/// - Azioni bulk (prioritize, change status)
class BacklogListWidget extends StatefulWidget {
  final List<UserStoryModel> stories;
  final String projectId;
  final bool canEdit;
  final void Function(UserStoryModel story)? onStoryTap;
  final void Function(UserStoryModel story)? onStoryEdit;
  final void Function(String storyId)? onStoryDelete;
  final void Function(List<String> newOrder)? onReorder;
  final void Function(String storyId, StoryStatus newStatus)? onStatusChange;
  final VoidCallback? onAddStory;

  const BacklogListWidget({
    super.key,
    required this.stories,
    required this.projectId,
    this.canEdit = true,
    this.onStoryTap,
    this.onStoryEdit,
    this.onStoryDelete,
    this.onReorder,
    this.onStatusChange,
    this.onAddStory,
  });

  @override
  State<BacklogListWidget> createState() => _BacklogListWidgetState();
}

class _BacklogListWidgetState extends State<BacklogListWidget> {
  String _searchQuery = '';
  StoryStatus? _statusFilter;
  StoryPriority? _priorityFilter;
  String? _tagFilter;
  bool _showFilters = false;

  List<UserStoryModel> get _filteredStories {
    var filtered = widget.stories;

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
    final stories = _filteredStories;

    // Stats
    final totalPoints = stories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
    final estimatedCount = stories.where((s) => s.isEstimated).length;

    return Column(
      children: [
        // Header con ricerca e filtri
        _buildHeader(stories.length, totalPoints, estimatedCount),

        // Filtri espandibili
        if (_showFilters) _buildFilters(),

        // Lista stories
        Expanded(
          child: stories.isEmpty
              ? _buildEmptyState()
              : _buildStoryList(stories),
        ),
      ],
    );
  }

  Widget _buildHeader(int count, int totalPoints, int estimatedCount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Riga superiore: titolo e pulsanti
          Row(
            children: [
              const Icon(Icons.list_alt, color: Colors.purple),
              const SizedBox(width: 8),
              const Text(
                'Product Backlog',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // Stats badges
              _buildStatBadge('$count stories', Colors.blue),
              const SizedBox(width: 8),
              _buildStatBadge('$totalPoints pts', Colors.green),
              const SizedBox(width: 8),
              _buildStatBadge('$estimatedCount stimate', Colors.orange),
              const SizedBox(width: 16),
              // Bottone filtri
              IconButton(
                icon: Icon(
                  _showFilters ? Icons.filter_list_off : Icons.filter_list,
                  color: _hasActiveFilters ? Colors.purple : Colors.grey,
                ),
                onPressed: () => setState(() => _showFilters = !_showFilters),
                tooltip: 'Filtri',
              ),
              // Bottone aggiungi
              if (widget.canEdit && widget.onAddStory != null)
                ElevatedButton.icon(
                  onPressed: widget.onAddStory,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Nuova Story'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Riga ricerca
          TextField(
            decoration: InputDecoration(
              hintText: 'Cerca per titolo, descrizione o ID...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status filter
          Row(
            children: [
              const Text('Status: ', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Tutti'),
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
              const Text('Priorità: ', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Tutte'),
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
                const Text('Tag: ', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Tutti'),
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
              label: const Text('Rimuovi filtri'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    if (_hasActiveFilters || _searchQuery.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessuna story trovata',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => setState(() {
                _searchQuery = '';
                _statusFilter = null;
                _priorityFilter = null;
                _tagFilter = null;
              }),
              child: const Text('Rimuovi filtri'),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_add, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Backlog vuoto',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Aggiungi la prima User Story',
            style: TextStyle(color: Colors.grey[500]),
          ),
          if (widget.canEdit && widget.onAddStory != null) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: widget.onAddStory,
              icon: const Icon(Icons.add),
              label: const Text('Nuova Story'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStoryList(List<UserStoryModel> stories) {
    if (widget.canEdit && widget.onReorder != null) {
      return ReorderableListView.builder(
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
      padding: const EdgeInsets.all(16),
      itemCount: stories.length,
      itemBuilder: (context, index) => _buildStoryItem(stories[index]),
    );
  }

  Widget _buildStoryItem(UserStoryModel story, {Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.only(bottom: 8),
      child: StoryCardWidget(
        story: story,
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
        showDragHandle: widget.canEdit && widget.onReorder != null,
      ),
    );
  }
}
