import 'package:flutter/material.dart';
import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

// =============================================================================
// SPRINT LIST WIDGET
// =============================================================================

/// Widget per visualizzare la lista degli sprint
class SprintListWidget extends StatefulWidget {
  final List<SprintModel> sprints;
  final SprintModel? activeSprint;
  final List<UserStoryModel>? stories;
  final bool canEdit;
  final void Function(SprintModel)? onSprintTap;
  final void Function(SprintModel)? onSprintEdit;
  final void Function(String)? onSprintDelete;
  final void Function(String)? onSprintStart;
  final void Function(String)? onSprintComplete;
  final VoidCallback? onAddSprint;

  const SprintListWidget({
    super.key,
    required this.sprints,
    this.activeSprint,
    this.stories,
    this.canEdit = true,
    this.onSprintTap,
    this.onSprintEdit,
    this.onSprintDelete,
    this.onSprintStart,
    this.onSprintComplete,
    this.onAddSprint,
  });

  @override
  State<SprintListWidget> createState() => _SprintListWidgetState();
}

class _SprintListWidgetState extends State<SprintListWidget> {
  static const int _defaultVisibleCount = 3;
  bool _showAll = false;

  List<SprintModel> get sprints => widget.sprints;
  List<UserStoryModel>? get stories => widget.stories;
  bool get canEdit => widget.canEdit;
  VoidCallback? get onAddSprint => widget.onAddSprint;
  void Function(SprintModel)? get onSprintTap => widget.onSprintTap;
  void Function(SprintModel)? get onSprintEdit => widget.onSprintEdit;
  void Function(String)? get onSprintDelete => widget.onSprintDelete;
  void Function(String)? get onSprintStart => widget.onSprintStart;
  void Function(String)? get onSprintComplete => widget.onSprintComplete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasMore = sprints.length > _defaultVisibleCount;
    final visibleSprints = _showAll || !hasMore
        ? sprints
        : sprints.take(_defaultVisibleCount).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.timeline, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '${l10n.agileSprintTitle} (${sprints.length})',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (canEdit && onAddSprint != null)
                ElevatedButton.icon(
                  onPressed: onAddSprint,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(l10n.agileNewSprint),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 0),

        // Lista sprint - Layout orizzontale
        if (sprints.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: _buildEmptyState(context),
          )
        else
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final hasActiveSprint = sprints.any((s) => s.status.isActiveOrReview);
                // Calcola quante card per riga in base alla larghezza
                final cardWidth = constraints.maxWidth > 900
                    ? (constraints.maxWidth - 24) / 3 // 3 card
                    : constraints.maxWidth > 600
                        ? (constraints.maxWidth - 12) / 2 // 2 card
                        : constraints.maxWidth; // 1 card

                // Altezza minima uniforme per tutte le card (accomoda il contenuto più grande)
                const double minCardHeight = 200;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: visibleSprints.map((sprint) => SizedBox(
                    width: cardWidth,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: minCardHeight),
                      child: _buildSprintCard(context, sprint, hasActiveSprint: hasActiveSprint),
                    ),
                  )).toList(),
                );
              },
            ),
          ),

        // Show all / Show less toggle
        if (hasMore)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextButton.icon(
              onPressed: () => setState(() => _showAll = !_showAll),
              icon: Icon(
                _showAll ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
              ),
              label: Text(
                _showAll
                    ? '${l10n.actionClose}'
                    : '${l10n.actionViewAll} (${sprints.length - _defaultVisibleCount} +)',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timeline, size: 64, color: context.textMutedColor),
          const SizedBox(height: 16),
          Text(l10n.agileNoSprints, style: TextStyle(fontSize: 18, color: context.textSecondaryColor)),
          const SizedBox(height: 8),
          Text(l10n.agileCreateFirstSprint, style: TextStyle(color: context.textTertiaryColor)),
        ],
      ),
    );
  }

  Widget _buildSprintCard(BuildContext context, SprintModel sprint, {bool hasActiveSprint = false}) {
    final l10n = AppLocalizations.of(context)!;
    final isActive = sprint.status == SprintStatus.active;
    final isReview = sprint.status == SprintStatus.review;
    final isActiveOrReview = isActive || isReview;
    final isCompleted = sprint.status == SprintStatus.completed;
    final isOverdue = sprint.isOverdue;

    // Calculate dynamic stats if stories are provided
    int plannedPoints = sprint.plannedPoints;
    int completedPoints = sprint.completedPoints;
    double progress = sprint.progress;

    if (stories != null) {
      final sprintStories = stories!.where((s) => 
          s.sprintId == sprint.id &&
          s.status != StoryStatus.backlog &&
          s.status != StoryStatus.refinement &&
          s.status != StoryStatus.ready
      ).toList();
      plannedPoints = sprintStories.fold(0, (sum, s) => sum + s.effectiveStoryPoints);
      final actualCompletedPoints = sprintStories
          .where((s) => s.status == StoryStatus.done)
          .fold(0, (sum, s) => sum + s.effectiveStoryPoints);
      
      // Use dynamic totals for active/review/planning sprints, but respect stored completedPoints for completed sprints if stories were moved
      if (!isCompleted) {
        completedPoints = actualCompletedPoints;
      }
      
      if (plannedPoints > 0) {
        progress = completedPoints / plannedPoints;
      }
    }

    // Border color: red if overdue, orange if review or ≤3 days, green if active, default otherwise
    final Color borderColor;
    final double borderWidth;
    if (isActiveOrReview && isOverdue) {
      borderColor = Colors.red;
      borderWidth = 2;
    } else if (isReview) {
      borderColor = Colors.orange;
      borderWidth = 2;
    } else if (isActive && sprint.daysRemaining <= 3) {
      borderColor = Colors.orange;
      borderWidth = 2;
    } else if (isActive) {
      borderColor = Colors.green;
      borderWidth = 2;
    } else {
      borderColor = context.borderColor;
      borderWidth = 1;
    }

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: InkWell(
        onTap: onSprintTap != null ? () => onSprintTap!(sprint) : null,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: sprint.status.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(sprint.status.icon, size: 14, color: sprint.status.color),
                        const SizedBox(width: 4),
                        Text(
                          _getSprintStatusLabel(sprint.status, l10n),
                          style: TextStyle(
                            fontSize: 11,
                            color: sprint.status.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${l10n.agileSprintTitle} ${sprint.number}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: context.textMutedColor,
                    ),
                  ),
                  const Spacer(),
                  if (canEdit)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 20),
                      itemBuilder: (context) => [
                        if (sprint.status == SprintStatus.planning && onSprintStart != null)
                          PopupMenuItem(value: 'start', child: Text(l10n.agileStartSprint)),
                        if (sprint.status == SprintStatus.review && onSprintComplete != null)
                          PopupMenuItem(value: 'finalize', child: Text(l10n.agileFinalizeSprint)),
                        if (onSprintEdit != null)
                          PopupMenuItem(value: 'edit', child: Text(l10n.actionEdit)),
                        if (sprint.status == SprintStatus.planning && onSprintDelete != null)
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(l10n.agileDeleteSprint, style: const TextStyle(color: Colors.red)),
                          ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 'start':
                            onSprintStart?.call(sprint.id);
                            break;
                          case 'finalize':
                            onSprintComplete?.call(sprint.id);
                            break;
                          case 'edit':
                            onSprintEdit?.call(sprint);
                            break;
                          case 'delete':
                            onSprintDelete?.call(sprint.id);
                            break;
                        }
                      },
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Name
              Text(
                sprint.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // Goal
              if (sprint.goal.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  sprint.goal,
                  style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 8),

              // Date range compatto
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 12, color: context.textSecondaryColor),
                  const SizedBox(width: 4),
                  Text(
                    '${_formatDate(sprint.startDate)} - ${_formatDate(sprint.endDate)}',
                    style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.access_time, size: 12, color: context.textSecondaryColor),
                  const SizedBox(width: 2),
                  Text(
                    l10n.agileDurationDays(sprint.durationDays.toString()),
                    style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Stats compatte in Wrap con tooltip descrittivi
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _buildCompactStat(
                    context,
                    '${sprint.storyIds.length}',
                    l10n.agileStatsStories,
                    Colors.blue,
                    tooltip: l10n.agileStatsStories,
                  ),
                  _buildCompactStat(
                    context,
                    '$plannedPoints',
                    l10n.agileStatsPoints,
                    Colors.orange,
                    tooltip: l10n.agileStatsPoints,
                  ),
                  if (isCompleted) ...[
                    _buildCompactStat(
                      context,
                      '$completedPoints',
                      l10n.agileStatsCompleted,
                      Colors.green,
                      tooltip: l10n.agileStatsCompleted,
                    ),
                    _buildCompactStat(
                      context,
                      sprint.velocity?.toStringAsFixed(1) ?? '-',
                      l10n.agileStatsVelocity,
                      AppColors.primary,
                      tooltip: l10n.agileStatsVelocity,
                    ),
                  ],
                ],
              ),

              // Progress bar for active/review sprint
              if (isActiveOrReview) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: context.surfaceVariantColor,
                          valueColor: AlwaysStoppedAnimation(
                            isOverdue ? Colors.red : (isReview ? Colors.orange : Colors.green),
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isOverdue ? Colors.red : (isReview ? Colors.orange : Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                if (isOverdue)
                  Text(
                    l10n.agileSprintOverdue(sprint.overdueDays),
                    style: const TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
                  )
                else if (isReview)
                  Text(
                    l10n.agileSprintClosingPhase,
                    style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold),
                  )
                else if (sprint.daysRemaining <= 3)
                  Text(
                    l10n.agileSprintDaysWarning(sprint.daysRemaining),
                    style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold),
                  )
                else
                  Text(
                    l10n.agileDaysRemaining(sprint.daysRemaining.toString()),
                    style: TextStyle(fontSize: 10, color: context.textSecondaryColor),
                  ),
              ],

              // Action Button row
              if (sprint.status == SprintStatus.planning && onSprintStart != null && canEdit) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: hasActiveSprint
                      ? Tooltip(
                          message: l10n.agileCompleteActiveFirst,
                          child: OutlinedButton.icon(
                            onPressed: null,
                            icon: const Icon(Icons.play_arrow, size: 14),
                            label: Text(l10n.agileStartSprint, style: const TextStyle(fontSize: 11)),
                            style: OutlinedButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            ),
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: () => onSprintStart?.call(sprint.id),
                          icon: const Icon(Icons.play_arrow, size: 14),
                          label: Text(l10n.agileStartSprint, style: const TextStyle(fontSize: 11)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            visualDensity: VisualDensity.compact,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          ),
                        ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String value, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
        ),
      ],
    );
  }

  Widget _buildCompactStat(BuildContext context, String value, String label, Color color, {String? tooltip}) {
    final widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: context.textSecondaryColor),
        ),
      ],
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        child: widget,
      );
    }
    return widget;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }

  String _getSprintStatusLabel(SprintStatus status, AppLocalizations l10n) {
    switch (status) {
      case SprintStatus.planning:
        return l10n.agileSprintStatusPlanning;
      case SprintStatus.active:
        return l10n.agileSprintStatusActive;
      case SprintStatus.review:
        return l10n.agileSprintStatusReview;
      case SprintStatus.completed:
        return l10n.agileSprintStatusCompleted;
    }
  }
}

// =============================================================================
// SPRINT FORM DIALOG
// =============================================================================

/// Dialog per creare o modificare uno sprint
class SprintFormDialog extends StatefulWidget {
  final SprintModel? sprint;
  final String projectId;
  final int suggestedDuration;
  final double? averageVelocity;
  final Map<String, int> teamCapacity;

  const SprintFormDialog({
    super.key,
    this.sprint,
    required this.projectId,
    this.suggestedDuration = 14,
    this.averageVelocity,
    this.teamCapacity = const {},
  });

  static Future<SprintModel?> show({
    required BuildContext context,
    required String projectId,
    SprintModel? sprint,
    int suggestedDuration = 14,
    double? averageVelocity,
    Map<String, int> teamCapacity = const {},
  }) {
    return showDialog<SprintModel>(
      context: context,
      builder: (context) => SprintFormDialog(
        sprint: sprint,
        projectId: projectId,
        suggestedDuration: suggestedDuration,
        averageVelocity: averageVelocity,
        teamCapacity: teamCapacity,
      ),
    );
  }

  @override
  State<SprintFormDialog> createState() => _SprintFormDialogState();
}

class _SprintFormDialogState extends State<SprintFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _goalController;
  late DateTime _startDate;
  late DateTime _endDate;

  bool get _isEditing => widget.sprint != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sprint?.name ?? '');
    _goalController = TextEditingController(text: widget.sprint?.goal ?? '');
    
    // Normalize dates to midnight to avoid time-of-day issues
    final start = widget.sprint?.startDate ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    
    if (widget.sprint?.endDate != null) {
      final end = widget.sprint!.endDate;
      _endDate = DateTime(end.year, end.month, end.day);
    } else {
      // Default duration: 14 days (Start + 13 days)
      // Example: Start Mon 1st, End Sun 14th. (14-1 = 1) -> 1st + 13 = 14th.
      // Duration is inclusive: 14th - 1st = 13 days diff. 13 + 1 = 14 days duration.
      _endDate = _startDate.add(Duration(days: widget.suggestedDuration - 1));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final sprint = SprintModel(
      id: widget.sprint?.id ?? '',
      projectId: widget.projectId,
      name: _nameController.text.trim(),
      goal: _goalController.text.trim(),
      number: widget.sprint?.number ?? 0,
      startDate: _startDate,
      endDate: _endDate,
      status: widget.sprint?.status ?? SprintStatus.planning,
      storyIds: widget.sprint?.storyIds ?? [],
      plannedPoints: widget.sprint?.plannedPoints ?? 0,
      completedPoints: widget.sprint?.completedPoints ?? 0,
      teamCapacity: widget.teamCapacity,
      totalCapacityHours: widget.teamCapacity.values.fold(0, (sum, h) => sum + h),
      createdAt: widget.sprint?.createdAt ?? DateTime.now(),
      createdBy: widget.sprint?.createdBy ?? '',
    );

    Navigator.pop(context, sprint);
  }

  Future<void> _selectDate(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      // DatePicker returns midnight, so no need to normalize further
      setState(() {
        if (isStart) {
          final duration = _endDate.difference(_startDate).inDays;
          _startDate = date;
          _endDate = _startDate.add(Duration(days: duration));
        } else {
          _endDate = date;
          if (_endDate.isBefore(_startDate)) {
            _startDate = _endDate; 
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final duration = _endDate.difference(_startDate).inDays + 1;
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            _isEditing ? Icons.edit : Icons.add_circle,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(_isEditing ? '${l10n.actionEdit} ${l10n.agileSprintTitle}' : l10n.agileNewSprint),
        ],
      ),
      insetPadding: const EdgeInsets.all(16),
      content: SizedBox(
        width: MediaQuery.of(context).size.width < 450
            ? MediaQuery.of(context).size.width * 0.85
            : 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.agileSprintName,
                    hintText: 'es. ${l10n.agileSprintTitle} 1 - MVP',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.formRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Goal
                TextFormField(
                  controller: _goalController,
                  decoration: InputDecoration(
                    labelText: l10n.agileSprintGoal,
                    hintText: l10n.agileSprintGoalHint,
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),

                // Date range
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(true),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: l10n.agileStartDate,
                            border: const OutlineInputBorder(),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 18),
                              const SizedBox(width: 8),
                              Text(_formatDate(_startDate)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(false),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: l10n.agileEndDate,
                            border: const OutlineInputBorder(),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 18),
                              const SizedBox(width: 8),
                              Text(_formatDate(_endDate)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.agileDurationDays(duration.toString()),
                  style: TextStyle(color: context.textSecondaryColor, fontSize: 12),
                ),
                const SizedBox(height: 16),

                // Info box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.averageVelocity != null) ...[
                        Row(
                          children: [
                            const Icon(Icons.speed, size: 16, color: Colors.blue),
                            const SizedBox(width: 8),
                            Text(
                              '${l10n.agileAverageVelocity}: ${widget.averageVelocity!.toStringAsFixed(1)} ${l10n.agilePoints}/sprint',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                      if (widget.teamCapacity.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(Icons.people, size: 16, color: Colors.blue),
                            const SizedBox(width: 8),
                            Text(
                              l10n.agileTeamMembersCount(widget.teamCapacity.length.toString()),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.agileActionCancel),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: Text(_isEditing ? l10n.agileActionSave : l10n.agileActionCreate),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// =============================================================================
// SPRINT PLANNING WIZARD
// =============================================================================

/// Wizard guidato per la pianificazione dello sprint
class SprintPlanningWizard extends StatefulWidget {
  final SprintModel sprint;
  final List<UserStoryModel> backlogStories;
  final Stream<List<UserStoryModel>>? storiesStream;
  final double? averageVelocity;
  final int totalCapacityHours;

  const SprintPlanningWizard({
    super.key,
    required this.sprint,
    required this.backlogStories,
    this.storiesStream,
    this.averageVelocity,
    required this.totalCapacityHours,
  });

  static Future<List<String>?> show({
    required BuildContext context,
    required SprintModel sprint,
    required List<UserStoryModel> backlogStories,
    Stream<List<UserStoryModel>>? storiesStream,
    double? averageVelocity,
    required int totalCapacityHours,
  }) {
    return showDialog<List<String>>(
      context: context,
      builder: (context) => SprintPlanningWizard(
        sprint: sprint,
        backlogStories: backlogStories,
        storiesStream: storiesStream,
        averageVelocity: averageVelocity,
        totalCapacityHours: totalCapacityHours,
      ),
    );
  }

  @override
  State<SprintPlanningWizard> createState() => _SprintPlanningWizardState();
}

class _SprintPlanningWizardState extends State<SprintPlanningWizard> {
  late List<String> _selectedStoryIds;
  late List<UserStoryModel> _availableStories;

  int get _selectedPoints {
    return _availableStories
        .where((s) => _selectedStoryIds.contains(s.id))
        .fold(0, (sum, s) => sum + s.effectiveStoryPoints);
  }

  int get _suggestedPoints {
    return widget.averageVelocity?.toInt() ?? widget.totalCapacityHours ~/ 8;
  }

  @override
  void initState() {
    super.initState();
    _availableStories = List.from(widget.backlogStories);
    // Pre-select stories already in "To Do" (inSprint) - either assigned to this sprint or unassigned
    final alreadyInSprint = _availableStories
        .where((s) => s.status == StoryStatus.inSprint && (s.sprintId == widget.sprint.id || s.sprintId == null))
        .map((s) => s.id)
        .toSet();
    _selectedStoryIds = {...alreadyInSprint, ...widget.sprint.storyIds}.toList();
  }

  @override
  void didUpdateWidget(SprintPlanningWizard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.backlogStories != widget.backlogStories) {
      setState(() {
        _availableStories = List.from(widget.backlogStories);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Revert to using static data to ensure consistency with Backlog
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.assignment, color: AppColors.primary),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.agileSprintPlanningTitle),
              Text(
                l10n.agileSprintPlanningSubtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
      insetPadding: const EdgeInsets.all(16),
      content: SizedBox(
        width: MediaQuery.of(context).size.width < 700
            ? MediaQuery.of(context).size.width * 0.9
            : 700,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            // Header stats
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn(
                    l10n.agileSelectedPoints,
                    '$_selectedPoints ${l10n.agileStatsPoints}',
                    _selectedStoryIds.length.toString(),
                    AppColors.primary,
                  ),
                  _buildStatColumn(
                    l10n.agileSuggestedPoints,
                    '$_suggestedPoints ${l10n.agileStatsPoints}',
                    l10n.agileAverageVelocity,
                    Colors.blue,
                  ),
                  _buildStatColumn(
                    l10n.agileTeamCapacity,
                    '${widget.totalCapacityHours}h',
                    l10n.agileDurationDays(widget.sprint.durationDays.toString()),
                    Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Progress indicator
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _suggestedPoints > 0 ? _selectedPoints / _suggestedPoints : 0,
                      backgroundColor: context.surfaceVariantColor,
                      valueColor: AlwaysStoppedAnimation(
                        _selectedPoints > _suggestedPoints ? Colors.orange : Colors.green,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _suggestedPoints > 0 
                      ? '${((_selectedPoints / _suggestedPoints) * 100).toInt()}%'
                      : '0%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedPoints > _suggestedPoints ? Colors.orange : Colors.green,
                  ),
                ),
              ],
            ),
            if (_selectedPoints > _suggestedPoints)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${l10n.agileHoursOverloaded}: ${l10n.agileSuggestedPoints}',
                  style: TextStyle(color: Colors.orange[700], fontSize: 12),
                ),
              ),
            const SizedBox(height: 16),

            // Story list
            Expanded(
              child: _availableStories.isEmpty
                  ? Center(
                      child: Text(
                        l10n.agileEmptyBacklogMatch,
                        style: TextStyle(color: context.textSecondaryColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _availableStories.length,
                      itemBuilder: (context, index) {
                        final story = _availableStories[index];
                        final isSelected = _selectedStoryIds.contains(story.id);

                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          color: isSelected ? AppColors.primary.withOpacity(0.05) : null,
                          child: CheckboxListTile(
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  _selectedStoryIds.add(story.id);
                                } else {
                                  _selectedStoryIds.remove(story.id);
                                }
                              });
                            },
                            title: Text(
                              story.title,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: story.priority.color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    story.priority.displayName,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: story.priority.color,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.agilePointsValue(story.effectiveStoryPoints),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: story.effectiveStoryPoints > 0 ? Colors.green : context.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            secondary: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: story.effectiveStoryPoints > 0
                                      ? Colors.green.withOpacity(0.1)
                                      : context.surfaceVariantColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '${story.effectiveStoryPoints}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.agileActionCancel),
        ),
        // Scrum Guide: Sprint deve avere almeno 1 story per raggiungere lo Sprint Goal
        Tooltip(
          message: _selectedStoryIds.isEmpty
              ? l10n.agileSelectAtLeastOne
              : l10n.agileConfirmStories(_selectedStoryIds.length.toString()),
          child: ElevatedButton(
            onPressed: _selectedStoryIds.isEmpty
                ? null  // Disabilitato se 0 stories
                : () => Navigator.pop(context, _selectedStoryIds),
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedStoryIds.isEmpty ? Colors.grey : AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(_selectedStoryIds.isEmpty
                ? l10n.agileSelectAtLeastOne
                : l10n.agileConfirmStories(_selectedStoryIds.length.toString())),
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn(String label, String value, String subValue, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: context.textSecondaryColor)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
        Text(subValue, style: TextStyle(fontSize: 10, color: context.textTertiaryColor)),
      ],
    );
  }
}
