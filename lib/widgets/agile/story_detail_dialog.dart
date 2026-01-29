import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../models/sprint_model.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'story_card_widget.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Dialog per visualizzare i dettagli completi di una User Story
class StoryDetailDialog extends StatefulWidget {
  final UserStoryModel story;
  final VoidCallback? onEdit;
  final void Function(StoryStatus)? onStatusChange;
  final void Function(int index, bool completed)? onCriterionToggle;
  final void Function(String? email)? onAssigneeChange;
  final List<String> teamMembers;
  final List<SprintModel> sprints;

  const StoryDetailDialog({
    super.key,
    required this.story,
    this.onEdit,
    this.onStatusChange,
    this.onCriterionToggle,
    this.onAssigneeChange,
    this.teamMembers = const [],
    this.sprints = const [],
  });

  static Future<void> show({
    required BuildContext context,
    required UserStoryModel story,
    VoidCallback? onEdit,
    void Function(StoryStatus)? onStatusChange,
    void Function(int index, bool completed)? onCriterionToggle,
    void Function(String? email)? onAssigneeChange,
    List<String> teamMembers = const [],
    List<SprintModel> sprints = const [],
  }) {
    return showDialog(
      context: context,
      builder: (context) => StoryDetailDialog(
        story: story,
        onEdit: onEdit,
        onStatusChange: onStatusChange,
        onCriterionToggle: onCriterionToggle,
        onAssigneeChange: onAssigneeChange,
        teamMembers: teamMembers,
        sprints: sprints,
      ),
    );
  }

  @override
  State<StoryDetailDialog> createState() => _StoryDetailDialogState();
}

class _StoryDetailDialogState extends State<StoryDetailDialog> {
  late List<String> _acceptanceCriteria;

  @override
  void initState() {
    super.initState();
    _acceptanceCriteria = List<String>.from(widget.story.acceptanceCriteria);
  }

  bool _isCriterionCompleted(String criterion) {
    return criterion.startsWith('[x]') ||
        criterion.startsWith('[X]') ||
        criterion.startsWith('✓');
  }

  String _cleanCriterionText(String criterion) {
    return criterion.replaceAll(RegExp(r'^\[[xX]\]\s*|^✓\s*'), '');
  }

  void _toggleCriterion(int index, bool completed) {
    final criterion = _acceptanceCriteria[index];
    final cleanText = _cleanCriterionText(criterion);

    setState(() {
      if (completed) {
        _acceptanceCriteria[index] = '[x] $cleanText';
      } else {
        _acceptanceCriteria[index] = cleanText;
      }
    });

    widget.onCriterionToggle?.call(index, completed);
  }

  String? _resolveSprintName(String? sprintId) {
    if (sprintId == null) return null;
    final sprint = widget.sprints.where((s) => s.id == sprintId).firstOrNull;
    return sprint?.name ?? sprintId;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final story = widget.story;

    final completedCount = _acceptanceCriteria.where(_isCriterionCompleted).length;

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
          if (widget.onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pop(context);
                widget.onEdit?.call();
              },
              tooltip: l10n.actionEdit,
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
                  if (widget.onStatusChange != null)
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
                        widget.onStatusChange?.call(status);
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
                            '${story.storyPoints} ${l10n.agileStatsPoints}',
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
                l10n.agileDescription,
                Icons.description,
                child: Text(
                  story.description.isNotEmpty
                      ? story.description
                      : l10n.agileNoDescription,
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
                l10n.agileAcceptanceCriteriaCount(completedCount, _acceptanceCriteria.length),
                Icons.checklist,
                child: _acceptanceCriteria.isEmpty
                    ? Text(
                        l10n.agileNoAcceptanceCriteria,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: context.textSecondaryColor,
                        ),
                      )
                    : Column(
                        children: List.generate(_acceptanceCriteria.length, (index) {
                          final criterion = _acceptanceCriteria[index];
                          final isCompleted = _isCriterionCompleted(criterion);
                          final cleanText = _cleanCriterionText(criterion);

                          return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              cleanText,
                              style: TextStyle(
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                                color: isCompleted ? context.textMutedColor : null,
                              ),
                            ),
                            value: isCompleted,
                            onChanged: widget.onCriterionToggle != null
                              ? (value) => _toggleCriterion(index, value ?? false)
                              : null,
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                          );
                        }),
                      ),
              ),
              const SizedBox(height: 16),

              // Tags
              if (story.tags.isNotEmpty) ...[
                _buildSection(
                  context,
                  l10n.agileTags,
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
                  l10n.agileEstimates,
                  Icons.calculate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${l10n.agileFinalEstimate}: '),
                          Text(
                            story.finalEstimate ?? '${story.storyPoints} pts',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      if (story.estimates.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          l10n.agileEstimatesReceived(story.estimates.length),
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
                l10n.agileInformation,
                Icons.info_outline,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(context, l10n.agileBusinessValue, '${story.businessValue}/10'),
                    // Assignee - interactive if onAssigneeChange is provided
                    _buildAssigneeRow(context, l10n),
                    if (story.sprintId != null)
                      _buildInfoRow(context, l10n.agileSprintTitle, _resolveSprintName(story.sprintId) ?? story.sprintId!),
                    _buildInfoRow(context, l10n.agileCreatedAt, _formatDate(story.createdAt)),
                    if (story.startedAt != null)
                      _buildInfoRow(context, l10n.agileStartedAt, _formatDate(story.startedAt!)),
                    if (story.completedAt != null)
                      _buildInfoRow(context, l10n.agileCompletedAt, _formatDate(story.completedAt!)),
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
          child: Text(l10n.actionClose),
        ),
      ],
    );
  }

  Widget _buildAssigneeRow(BuildContext context, AppLocalizations l10n) {
    final story = widget.story;

    if (widget.onAssigneeChange != null && widget.teamMembers.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Text(
              '${l10n.agileAssignee}: ',
              style: TextStyle(color: context.textSecondaryColor),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => _showAssigneePicker(context, l10n),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: story.assigneeEmail != null
                      ? AppColors.primary.withOpacity(0.1)
                      : context.surfaceVariantColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      story.assigneeEmail != null ? Icons.person : Icons.person_add,
                      size: 16,
                      color: story.assigneeEmail != null ? AppColors.primary : context.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      story.assigneeEmail ?? l10n.agileNoAssignee,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: story.assigneeEmail != null ? null : context.textSecondaryColor,
                        fontStyle: story.assigneeEmail == null ? FontStyle.italic : null,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, size: 16, color: context.textSecondaryColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Read-only display (no onAssigneeChange or no team members)
    if (story.assigneeEmail != null) {
      return _buildInfoRow(context, l10n.agileAssignee, story.assigneeEmail!);
    }
    return const SizedBox.shrink();
  }

  void _showAssigneePicker(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.agileAssignee),
        children: [
          // Option to unassign
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(dialogContext);
              widget.onAssigneeChange?.call(null);
            },
            child: Row(
              children: [
                Icon(Icons.person_off, color: context.textSecondaryColor),
                const SizedBox(width: 12),
                Text(
                  l10n.agileNoAssignee,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // Team members
          ...widget.teamMembers.map((email) => SimpleDialogOption(
            onPressed: () {
              Navigator.pop(dialogContext);
              widget.onAssigneeChange?.call(email);
            },
            child: Row(
              children: [
                Icon(
                  email == widget.story.assigneeEmail ? Icons.check_circle : Icons.person,
                  color: email == widget.story.assigneeEmail ? AppColors.primary : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    email,
                    style: TextStyle(
                      fontWeight: email == widget.story.assigneeEmail ? FontWeight.bold : null,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
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
