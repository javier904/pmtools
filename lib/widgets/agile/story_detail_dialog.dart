import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../models/sprint_model.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'story_card_widget.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../../services/jira_service.dart';
import '../../services/secure_storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

/// Dialog per visualizzare i dettagli completi di una User Story
class StoryDetailDialog extends StatefulWidget {
  final UserStoryModel story;
  final VoidCallback? onEdit;
  final void Function(StoryStatus)? onStatusChange;
  final void Function(int index, bool completed)? onCriterionToggle;
  final void Function(int index)? onCriterionDelete; // Callback opzionale per cancellazione
  final void Function(String criterion)? onCriterionAdd; // NEW: Callback per aggiunta
  final void Function(String? email)? onAssigneeChange;
  final void Function(int? progress)? onProgressChange;
  final List<String> teamMembers;

  final List<SprintModel> sprints;
  final Future<void> Function()? onJiraSync;

  const StoryDetailDialog({
    super.key,
    required this.story,
    this.onEdit,
    this.onStatusChange,
    this.onCriterionToggle,
    this.onCriterionDelete, // NEW
    this.onCriterionAdd, // NEW
    this.onAssigneeChange,
    this.onProgressChange,
    this.teamMembers = const [],
    this.sprints = const [],
    this.onJiraSync,
  });

  static Future<void> show({
    required BuildContext context,
    required UserStoryModel story,
    VoidCallback? onEdit,
    void Function(StoryStatus)? onStatusChange,
    void Function(int index, bool completed)? onCriterionToggle,
    void Function(int index)? onCriterionDelete, // NEW
    void Function(String criterion)? onCriterionAdd, // NEW
    void Function(String? email)? onAssigneeChange,
    void Function(int? progress)? onProgressChange,
    List<String> teamMembers = const [],

    List<SprintModel> sprints = const [],
    Future<void> Function()? onJiraSync,
  }) {
    return showDialog(
      context: context,
      builder: (context) => StoryDetailDialog(
        story: story,
        onEdit: onEdit,
        onStatusChange: onStatusChange,
        onCriterionToggle: onCriterionToggle,
        onCriterionDelete: onCriterionDelete, // NEW
        onCriterionAdd: onCriterionAdd, // NEW
        onAssigneeChange: onAssigneeChange,
        onProgressChange: onProgressChange,
        teamMembers: teamMembers,
        sprints: sprints,
        onJiraSync: onJiraSync,
      ),
    );
  }

  @override
  State<StoryDetailDialog> createState() => _StoryDetailDialogState();
}

class _StoryDetailDialogState extends State<StoryDetailDialog> {
  late List<String> _acceptanceCriteria;
  late TextEditingController _newCriterionController;
  int? _customProgress; // NEW: State for custom progress // NEW

  @override
  void initState() {
    super.initState();
    _acceptanceCriteria = List<String>.from(widget.story.acceptanceCriteria);
    _newCriterionController = TextEditingController(); // NEW
    _customProgress = widget.story.customProgress;
  }

  @override
  void dispose() {
    _newCriterionController.dispose(); // NEW
    super.dispose();
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

  void _addCriterion() {
    final text = _newCriterionController.text.trim();
    if (text.isNotEmpty) {
      // Aggiorna UI locale
      setState(() {
        _acceptanceCriteria.add(text);
        _newCriterionController.clear();
      });
      // Notifica parent
      widget.onCriterionAdd?.call(text);
    }
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
    final hasJira = story.externalIntegration?.provider == 'jira';

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
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              story.title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          if (hasJira) ...[
             const SizedBox(width: 8),
             InkWell(
               onTap: () async {
                 final creds = await SecureStorageService().getJiraCredentials();
                 final domain = creds['domain'];
                 if (domain != null && domain.isNotEmpty) {
                   final url = Uri.parse('https://$domain/browse/${story.externalIntegration!.externalId}');
                   if (await canLaunchUrl(url)) {
                     await launchUrl(url, mode: LaunchMode.externalApplication);
                   }
                 }
               },
               borderRadius: BorderRadius.circular(4),
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                   color: Colors.blue.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(4),
                   border: Border.all(color: Colors.blue.withOpacity(0.3)),
                 ),
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     const Icon(Icons.link, size: 14, color: Colors.blue),
                     const SizedBox(width: 4),
                     Text(
                       story.externalIntegration!.externalId,
                       style: const TextStyle(
                         fontSize: 12,
                         color: Colors.blue,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ],
                 ),
               ),
             ),
          ],
          const SizedBox(width: 8),
          if (widget.onJiraSync != null && hasJira)
            IconButton(
              icon: const Icon(Icons.sync, color: Colors.blue),
              onPressed: () async {
                await widget.onJiraSync?.call();
                if (mounted) Navigator.pop(context); // Refresh
              },
              tooltip: l10n.actionSyncJira,
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
        child: DefaultTabController(
          length: hasJira ? 2 : 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: context.textSecondaryColor,
                isScrollable: true,
                tabs: [
                  Tab(text: l10n.storyFormDetailsTab),
                  if (hasJira)
                    const Tab(text: 'Jira'),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: TabBarView(
                  children: [
                    // Tab 1: Details (Merged: Desc + AC + Info)
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status & Priority
                          Row(
                            children: [
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
                              PriorityBadgeWidget(priority: story.priority, large: true),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Progress Section
                          if (widget.onProgressChange != null) ...[
                            _buildProgressSection(context, l10n),
                            const SizedBox(height: 16),
                          ],
                          
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
                          
                          // Tags
                          if (story.tags.isNotEmpty)
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
                          
                          const Divider(height: 32),
                          
                          // Acceptance Criteria (Merged)
                          _buildSection(
                            context,
                            l10n.agileAcceptanceCriteriaCount(completedCount, _acceptanceCriteria.length),
                            Icons.checklist,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_acceptanceCriteria.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      l10n.agileNoAcceptanceCriteria,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: context.textSecondaryColor,
                                      ),
                                    ),
                                  )
                                else
                                  Column(
                                    children: List.generate(_acceptanceCriteria.length, (index) {
                                      final criterion = _acceptanceCriteria[index];
                                      final isCompleted = _isCriterionCompleted(criterion);
                                      final cleanText = _cleanCriterionText(criterion);

                                      return Row(
                                        children: [
                                          Checkbox(
                                            value: isCompleted,
                                            onChanged: widget.onCriterionToggle != null
                                              ? (value) => _toggleCriterion(index, value ?? false)
                                              : null,
                                          ),
                                          Expanded(
                                            child: Text(
                                              cleanText,
                                              style: TextStyle(
                                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                                                color: isCompleted ? context.textMutedColor : null,
                                              ),
                                            ),
                                          ),
                                          if (widget.onCriterionDelete != null)
                                            IconButton(
                                              icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                                              onPressed: () {
                                                setState(() {
                                                  _acceptanceCriteria.removeAt(index);
                                                });
                                                widget.onCriterionDelete?.call(index);
                                              },
                                              tooltip: l10n.actionDelete,
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(),
                                            ),
                                          const SizedBox(width: 12), // Padding for scrollbar
                                        ],
                                      );
                                    }),
                                  ),
                                
                                // NEW: Add Criterion Input
                                if (widget.onCriterionAdd != null) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _newCriterionController,
                                          decoration: InputDecoration(
                                            hintText: l10n.agileAddCriterionHint,
                                            isDense: true,
                                            border: const OutlineInputBorder(),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                          ),
                                          onSubmitted: (_) => _addCriterion(),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle, color: Colors.blue),
                                        onPressed: _addCriterion,
                                        tooltip: l10n.actionAdd,
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),

                          const Divider(height: 32),

                          // Info / Estimates (Merged)
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
                          _buildSection(
                            context,
                            l10n.agileInformation,
                            Icons.info_outline,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(context, l10n.agileBusinessValue, '${story.businessValue}/10'),
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
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),

                    // Tab 2: Jira
                    if (hasJira)
                      _buildJiraTab(l10n),
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

  Widget _buildProgressSection(BuildContext context, AppLocalizations l10n) {
    final isManual = _customProgress != null;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.percent, size: 16, color: context.textSecondaryColor),
                  const SizedBox(width: 8),
                  Text(
                    l10n.agileProgress,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    isManual ? l10n.agileProgressManual : l10n.agileProgressAuto,
                    style: TextStyle(
                      fontSize: 12,
                      color: isManual ? Colors.orange : Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: isManual,
                    activeColor: Colors.orange,
                    onChanged: (val) {
                      setState(() {
                         if (val) {
                           _customProgress = 50;
                         } else {
                           _customProgress = null;
                         }
                      });
                      widget.onProgressChange?.call(_customProgress);
                    },
                  ),
                ],
              ),
            ],
          ),
          
          if (isManual) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _customProgress?.toDouble() ?? 50,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    activeColor: Colors.orange,
                    label: '${_customProgress}%',
                    onChanged: (val) {
                      setState(() {
                        _customProgress = val.round();
                      });
                    },
                    onChangeEnd: (val) {
                      widget.onProgressChange?.call(val.round());
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    '${_customProgress}%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
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
  Widget _buildJiraTab(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.link, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                'Linked to ${widget.story.externalIntegration!.externalId}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer(),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          
          // Comments Section
          const Text('Comments', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _JiraCommentsSection(issueId: widget.story.externalIntegration!.externalId),
          
          const SizedBox(height: 24),
          
          // Worklog Section
          const Text('Work Log', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _JiraWorklogSection(issueId: widget.story.externalIntegration!.externalId),
        ],
      ),
    );
  }
}

class _JiraCommentsSection extends StatefulWidget {
  final String issueId;
  const _JiraCommentsSection({required this.issueId});

  @override
  State<_JiraCommentsSection> createState() => _JiraCommentsSectionState();
}

class _JiraCommentsSectionState extends State<_JiraCommentsSection> {
  final _commentController = TextEditingController();
  bool _isSending = false;

  Future<void> _sendComment() async {
    if (_commentController.text.trim().isEmpty) return;
    
    setState(() => _isSending = true);
    try {
      await JiraService().addComment(widget.issueId, _commentController.text.trim());
      _commentController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment sent to Jira'), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _commentController,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'Add a comment...',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: _isSending 
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.send),
              onPressed: _isSending ? null : _sendComment,
            ),
          ),
        ),
      ],
    );
  }
}

class _JiraWorklogSection extends StatefulWidget {
  final String issueId;
  const _JiraWorklogSection({required this.issueId});

  @override
  State<_JiraWorklogSection> createState() => _JiraWorklogSectionState();
}

class _JiraWorklogSectionState extends State<_JiraWorklogSection> {
  final _timeController = TextEditingController(); // e.g., "1h 30m"
  DateTime _selectedDate = DateTime.now();
  bool _isLogging = false;

  Future<void> _logWork() async {
    if (_timeController.text.trim().isEmpty) return;

    setState(() => _isLogging = true);
    try {
      await JiraService().addWorklog(
        widget.issueId, 
        _timeController.text.trim(),
        date: _selectedDate,
      );
      _timeController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Worklog added to Jira'), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLogging = false);
    }
  }



  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // Keep current time, just change date
      final now = DateTime.now();
      setState(() {
        _selectedDate = DateTime(
          picked.year, 
          picked.month, 
          picked.day, 
          now.hour, 
          now.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  hintText: 'Time spent (e.g. 1h 30m)',
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, size: 20),
                    onPressed: _pickDate,
                    tooltip: 'Log date: ${_selectedDate.day}/${_selectedDate.month}',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: _isLogging ? null : _logWork,
              child: _isLogging 
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Log Time'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 4),
          child: Text(
            'Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            style: TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
          ),
        ),
      ],
    );
  }
}
