import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';

/// Card per visualizzare una User Story
///
/// Mostra:
/// - ID e titolo
/// - Priority badge (MoSCoW)
/// - Story points
/// - Status
/// - Tags
/// - Assignee
/// - Progress bar se in sprint
class StoryCardWidget extends StatelessWidget {
  final UserStoryModel story;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final void Function(StoryStatus)? onStatusChange;
  final bool showDragHandle;
  final bool compact;

  const StoryCardWidget({
    super.key,
    required this.story,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onStatusChange,
    this.showDragHandle = false,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: story.priority.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(compact ? 8 : 12),
          child: compact ? _buildCompactContent() : _buildFullContent(context),
        ),
      ),
    );
  }

  Widget _buildCompactContent() {
    return Row(
      children: [
        // Priority indicator
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: story.priority.color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                story.title,
                style: const TextStyle(fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    story.storyId,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                  if (story.storyPoints != null) ...[
                    const SizedBox(width: 8),
                    _buildPointsBadge(),
                  ],
                ],
              ),
            ],
          ),
        ),
        // Status badge
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildFullContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          children: [
            // Drag handle
            if (showDragHandle)
              ReorderableDragStartListener(
                index: 0,
                child: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.drag_handle, color: Colors.grey),
                ),
              ),
            // Story ID
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                story.storyId,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const Spacer(),
            // Priority badge
            _buildPriorityBadge(),
            const SizedBox(width: 8),
            // Points badge
            if (story.storyPoints != null) _buildPointsBadge(),
            // Actions
            if (onEdit != null || onDelete != null)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 20),
                itemBuilder: (context) => [
                  if (onEdit != null)
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18),
                          SizedBox(width: 8),
                          Text('Modifica'),
                        ],
                      ),
                    ),
                  if (onDelete != null)
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Elimina', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                ],
                onSelected: (value) {
                  if (value == 'edit') onEdit?.call();
                  if (value == 'delete') onDelete?.call();
                },
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Title
        Text(
          story.title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Description preview
        if (story.description.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            story.description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: 8),

        // Tags
        if (story.tags.isNotEmpty) ...[
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: story.tags.map((tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                tag,
                style: const TextStyle(fontSize: 10, color: Colors.blue),
              ),
            )).toList(),
          ),
          const SizedBox(height: 8),
        ],

        // Footer: status, assignee, acceptance criteria count
        Row(
          children: [
            // Status dropdown
            if (onStatusChange != null)
              _buildStatusDropdown(context)
            else
              _buildStatusBadge(),
            const Spacer(),
            // Acceptance criteria indicator
            if (story.acceptanceCriteria.isNotEmpty) ...[
              Icon(Icons.checklist, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${story.completedAcceptanceCriteria}/${story.acceptanceCriteria.length}',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
            ],
            // Estimated indicator
            Icon(
              story.isEstimated ? Icons.calculate : Icons.calculate_outlined,
              size: 14,
              color: story.isEstimated ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(
              story.isEstimated ? 'Stimata' : 'Da stimare',
              style: TextStyle(
                fontSize: 11,
                color: story.isEstimated ? Colors.green : Colors.grey,
              ),
            ),
            // Assignee
            if (story.assigneeEmail != null) ...[
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.purple.withOpacity(0.2),
                child: Text(
                  story.assigneeEmail![0].toUpperCase(),
                  style: const TextStyle(fontSize: 10, color: Colors.purple),
                ),
              ),
            ],
          ],
        ),

        // Progress bar if in sprint
        if (story.status == StoryStatus.inProgress || story.status == StoryStatus.inReview) ...[
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _calculateProgress(),
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(story.status.color),
              minHeight: 4,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPriorityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: story.priority.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: story.priority.color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(story.priority.icon, size: 12, color: story.priority.color),
          const SizedBox(width: 4),
          Text(
            story.priority.displayName,
            style: TextStyle(
              fontSize: 11,
              color: story.priority.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.stars, size: 12, color: Colors.green),
          const SizedBox(width: 4),
          Text(
            '${story.storyPoints}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: story.status.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(story.status.icon, size: 12, color: story.status.color),
          const SizedBox(width: 4),
          Text(
            story.status.displayName,
            style: TextStyle(
              fontSize: 11,
              color: story.status.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown(BuildContext context) {
    return PopupMenuButton<StoryStatus>(
      initialValue: story.status,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: story.status.color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(story.status.icon, size: 12, color: story.status.color),
            const SizedBox(width: 4),
            Text(
              story.status.displayName,
              style: TextStyle(
                fontSize: 11,
                color: story.status.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, size: 16, color: story.status.color),
          ],
        ),
      ),
      itemBuilder: (context) => StoryStatus.values.map((status) => PopupMenuItem(
        value: status,
        child: Row(
          children: [
            Icon(status.icon, size: 18, color: status.color),
            const SizedBox(width: 8),
            Text(status.displayName),
          ],
        ),
      )).toList(),
      onSelected: onStatusChange,
    );
  }

  double _calculateProgress() {
    if (story.acceptanceCriteria.isEmpty) {
      // Se non ci sono AC, usa lo status
      switch (story.status) {
        case StoryStatus.backlog:
        case StoryStatus.ready:
          return 0;
        case StoryStatus.inSprint:
          return 0.1;
        case StoryStatus.inProgress:
          return 0.5;
        case StoryStatus.inReview:
          return 0.8;
        case StoryStatus.done:
          return 1.0;
      }
    }

    // Usa acceptance criteria completati
    return story.completedAcceptanceCriteria / story.acceptanceCriteria.length;
  }
}

/// Badge standalone per la priorità MoSCoW
class PriorityBadgeWidget extends StatelessWidget {
  final StoryPriority priority;
  final bool large;

  const PriorityBadgeWidget({
    super.key,
    required this.priority,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 12 : 8,
        vertical: large ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: priority.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(large ? 6 : 4),
        border: Border.all(color: priority.color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            priority.icon,
            size: large ? 16 : 12,
            color: priority.color,
          ),
          const SizedBox(width: 4),
          Text(
            priority.displayName,
            style: TextStyle(
              fontSize: large ? 13 : 11,
              color: priority.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
