import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'story_card_widget.dart';

/// Dialog per visualizzare i dettagli completi di una User Story
class StoryDetailDialog extends StatelessWidget {
  final UserStoryModel story;
  final VoidCallback? onEdit;
  final void Function(StoryStatus)? onStatusChange;
  final void Function(int index, bool completed)? onCriterionToggle;

  const StoryDetailDialog({
    super.key,
    required this.story,
    this.onEdit,
    this.onStatusChange,
    this.onCriterionToggle,
  });

  static Future<void> show({
    required BuildContext context,
    required UserStoryModel story,
    VoidCallback? onEdit,
    void Function(StoryStatus)? onStatusChange,
    void Function(int index, bool completed)? onCriterionToggle,
  }) {
    return showDialog(
      context: context,
      builder: (context) => StoryDetailDialog(
        story: story,
        onEdit: onEdit,
        onStatusChange: onStatusChange,
        onCriterionToggle: onCriterionToggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.surfaceVariantColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              story.storyId,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              story.title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pop(context);
                onEdit?.call();
              },
              tooltip: 'Modifica',
            ),
        ],
      ),
      content: SizedBox(
        width: 600,
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status e Priority row
              Row(
                children: [
                  // Status
                  if (onStatusChange != null)
                    PopupMenuButton<StoryStatus>(
                      initialValue: story.status,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: story.status.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(story.status.icon, size: 16, color: story.status.color),
                            const SizedBox(width: 8),
                            Text(
                              story.status.displayName,
                              style: TextStyle(
                                color: story.status.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.arrow_drop_down, color: story.status.color),
                          ],
                        ),
                      ),
                      itemBuilder: (context) => StoryStatus.values.map((status) =>
                        PopupMenuItem(
                          value: status,
                          child: Row(
                            children: [
                              Icon(status.icon, color: status.color),
                              const SizedBox(width: 8),
                              Text(status.displayName),
                            ],
                          ),
                        ),
                      ).toList(),
                      onSelected: (status) {
                        onStatusChange?.call(status);
                        Navigator.pop(context);
                      },
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: story.status.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(story.status.icon, size: 16, color: story.status.color),
                          const SizedBox(width: 8),
                          Text(
                            story.status.displayName,
                            style: TextStyle(
                              color: story.status.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(width: 12),
                  // Priority
                  PriorityBadgeWidget(priority: story.priority, large: true),
                  const Spacer(),
                  // Story Points
                  if (story.storyPoints != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.stars, size: 16, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            '${story.storyPoints} punti',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),

              // Description
              _buildSection(
                context,
                'Descrizione',
                Icons.description,
                child: Text(
                  story.description.isNotEmpty
                      ? story.description
                      : 'Nessuna descrizione',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: story.description.isEmpty ? FontStyle.italic : null,
                    color: story.description.isEmpty ? context.textMutedColor : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Acceptance Criteria
              _buildSection(
                context,
                'Acceptance Criteria (${story.completedAcceptanceCriteria}/${story.acceptanceCriteria.length})',
                Icons.checklist,
                child: story.acceptanceCriteria.isEmpty
                    ? Text(
                        'Nessun criterio definito',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: context.textSecondaryColor,
                        ),
                      )
                    : Column(
                        children: List.generate(story.acceptanceCriteria.length, (index) {
                          final criterion = story.acceptanceCriteria[index];
                          // Per ora non gestiamo il completamento
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.check_circle_outline,
                              color: context.textMutedColor,
                            ),
                            title: Text(criterion),
                          );
                        }),
                      ),
              ),
              const SizedBox(height: 16),

              // Tags
              if (story.tags.isNotEmpty) ...[
                _buildSection(
                  context,
                  'Tags',
                  Icons.label,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: story.tags.map((tag) => Chip(
                      label: Text(tag),
                      backgroundColor: Colors.blue.withOpacity(0.1),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Estimation info
              if (story.isEstimated) ...[
                _buildSection(
                  context,
                  'Stima',
                  Icons.calculate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Stima finale: '),
                          Text(
                            story.finalEstimate ?? '${story.storyPoints} pts',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      if (story.estimates.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          '${story.estimates.length} stime ricevute',
                          style: TextStyle(color: context.textSecondaryColor, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Metadata
              _buildSection(
                context,
                'Informazioni',
                Icons.info_outline,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(context, 'Business Value', '${story.businessValue}/10'),
                    if (story.assigneeEmail != null)
                      _buildInfoRow(context, 'Assegnato a', story.assigneeEmail!),
                    if (story.sprintId != null)
                      _buildInfoRow(context, 'Sprint', story.sprintId!),
                    _buildInfoRow(context, 'Creato il', _formatDate(story.createdAt)),
                    if (story.startedAt != null)
                      _buildInfoRow(context, 'Iniziato il', _formatDate(story.startedAt!)),
                    if (story.completedAt != null)
                      _buildInfoRow(context, 'Completato il', _formatDate(story.completedAt!)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Chiudi'),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, IconData icon, {required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: child,
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(color: context.textSecondaryColor),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
