import 'package:flutter/material.dart';
import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

// =============================================================================
// SPRINT LIST WIDGET
// =============================================================================

/// Widget per visualizzare la lista degli sprint
class SprintListWidget extends StatelessWidget {
  final List<SprintModel> sprints;
  final SprintModel? activeSprint;
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
    this.canEdit = true,
    this.onSprintTap,
    this.onSprintEdit,
    this.onSprintDelete,
    this.onSprintStart,
    this.onSprintComplete,
    this.onAddSprint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.timeline, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Sprint (${sprints.length})',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (canEdit && onAddSprint != null)
                ElevatedButton.icon(
                  onPressed: onAddSprint,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Nuovo Sprint'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 0),

        // Lista sprint
        Expanded(
          child: sprints.isEmpty
              ? _buildEmptyState(context)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sprints.length,
                  itemBuilder: (context, index) => _buildSprintCard(context, sprints[index]),
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timeline, size: 64, color: context.textMutedColor),
          const SizedBox(height: 16),
          Text('Nessuno sprint', style: TextStyle(fontSize: 18, color: context.textSecondaryColor)),
          const SizedBox(height: 8),
          Text('Crea il primo sprint per iniziare', style: TextStyle(color: context.textTertiaryColor)),
        ],
      ),
    );
  }

  Widget _buildSprintCard(BuildContext context, SprintModel sprint) {
    final isActive = sprint.status == SprintStatus.active;
    final isCompleted = sprint.status == SprintStatus.completed;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isActive ? Colors.green : context.borderColor,
          width: isActive ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onSprintTap != null ? () => onSprintTap!(sprint) : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                          sprint.status.displayName,
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
                    'Sprint ${sprint.number}',
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
                          const PopupMenuItem(value: 'start', child: Text('Avvia Sprint')),
                        if (sprint.status == SprintStatus.active && onSprintComplete != null)
                          const PopupMenuItem(value: 'complete', child: Text('Completa Sprint')),
                        if (onSprintEdit != null)
                          const PopupMenuItem(value: 'edit', child: Text('Modifica')),
                        if (sprint.status == SprintStatus.planning && onSprintDelete != null)
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Elimina', style: TextStyle(color: Colors.red)),
                          ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 'start':
                            onSprintStart?.call(sprint.id);
                            break;
                          case 'complete':
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
              const SizedBox(height: 12),

              // Name
              Text(
                sprint.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              // Goal
              if (sprint.goal.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  sprint.goal,
                  style: TextStyle(color: context.textSecondaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),

              // Date range
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: context.textSecondaryColor),
                  const SizedBox(width: 4),
                  Text(
                    '${_formatDate(sprint.startDate)} - ${_formatDate(sprint.endDate)}',
                    style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time, size: 14, color: context.textSecondaryColor),
                  const SizedBox(width: 4),
                  Text(
                    '${sprint.durationDays} giorni',
                    style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Stats
              Row(
                children: [
                  _buildStat(
                    context,
                    '${sprint.storyIds.length}',
                    'stories',
                    Colors.blue,
                  ),
                  const SizedBox(width: 16),
                  _buildStat(
                    context,
                    '${sprint.plannedPoints}',
                    'pts pianificati',
                    Colors.orange,
                  ),
                  if (isCompleted) ...[
                    const SizedBox(width: 16),
                    _buildStat(
                      context,
                      '${sprint.completedPoints}',
                      'pts completati',
                      Colors.green,
                    ),
                    const SizedBox(width: 16),
                    _buildStat(
                      context,
                      sprint.velocity?.toStringAsFixed(1) ?? '-',
                      'velocity',
                      AppColors.primary,
                    ),
                  ],
                ],
              ),

              // Progress bar for active sprint
              if (isActive) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: sprint.progress,
                          backgroundColor: context.surfaceVariantColor,
                          valueColor: const AlwaysStoppedAnimation(Colors.green),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(sprint.progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${sprint.daysRemaining} giorni rimanenti',
                  style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
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
    _startDate = widget.sprint?.startDate ?? DateTime.now();
    _endDate = widget.sprint?.endDate ??
        DateTime.now().add(Duration(days: widget.suggestedDuration));
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
      setState(() {
        if (isStart) {
          _startDate = date;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate.add(Duration(days: widget.suggestedDuration));
          }
        } else {
          _endDate = date;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final duration = _endDate.difference(_startDate).inDays + 1;

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            _isEditing ? Icons.edit : Icons.add_circle,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(_isEditing ? 'Modifica Sprint' : 'Nuovo Sprint'),
        ],
      ),
      content: SizedBox(
        width: 450,
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
                  decoration: const InputDecoration(
                    labelText: 'Nome Sprint',
                    hintText: 'es. Sprint 1 - MVP',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci un nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Goal
                TextFormField(
                  controller: _goalController,
                  decoration: const InputDecoration(
                    labelText: 'Sprint Goal',
                    hintText: 'Obiettivo dello sprint',
                    border: OutlineInputBorder(),
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
                          decoration: const InputDecoration(
                            labelText: 'Data Inizio',
                            border: OutlineInputBorder(),
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
                          decoration: const InputDecoration(
                            labelText: 'Data Fine',
                            border: OutlineInputBorder(),
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
                  'Durata: $duration giorni',
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
                              'Velocity media: ${widget.averageVelocity!.toStringAsFixed(1)} pts/sprint',
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
                              'Team: ${widget.teamCapacity.length} membri',
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
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: Text(_isEditing ? 'Salva' : 'Crea'),
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
  final double? averageVelocity;
  final int totalCapacityHours;

  const SprintPlanningWizard({
    super.key,
    required this.sprint,
    required this.backlogStories,
    this.averageVelocity,
    required this.totalCapacityHours,
  });

  static Future<List<String>?> show({
    required BuildContext context,
    required SprintModel sprint,
    required List<UserStoryModel> backlogStories,
    double? averageVelocity,
    required int totalCapacityHours,
  }) {
    return showDialog<List<String>>(
      context: context,
      builder: (context) => SprintPlanningWizard(
        sprint: sprint,
        backlogStories: backlogStories,
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
    return widget.backlogStories
        .where((s) => _selectedStoryIds.contains(s.id))
        .fold(0, (sum, s) => sum + (s.storyPoints ?? 0));
  }

  int get _suggestedPoints {
    return widget.averageVelocity?.toInt() ?? widget.totalCapacityHours ~/ 8;
  }

  @override
  void initState() {
    super.initState();
    _selectedStoryIds = List.from(widget.sprint.storyIds);
    _availableStories = widget.backlogStories
        .where((s) => s.status == StoryStatus.ready || s.status == StoryStatus.backlog)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.assignment, color: AppColors.primary),
          SizedBox(width: 8),
          Text('Sprint Planning'),
        ],
      ),
      content: SizedBox(
        width: 700,
        height: 500,
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
                    'Selezionati',
                    '$_selectedPoints pts',
                    _selectedStoryIds.length.toString(),
                    AppColors.primary,
                  ),
                  _buildStatColumn(
                    'Suggeriti',
                    '$_suggestedPoints pts',
                    'basato su velocity',
                    Colors.blue,
                  ),
                  _buildStatColumn(
                    'Capacità',
                    '${widget.totalCapacityHours}h',
                    '${widget.sprint.durationDays} giorni',
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
                  '${((_selectedPoints / _suggestedPoints) * 100).toInt()}%',
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
                  'Attenzione: superata la velocity suggerita',
                  style: TextStyle(color: Colors.orange[700], fontSize: 12),
                ),
              ),
            const SizedBox(height: 16),

            // Story list
            Expanded(
              child: _availableStories.isEmpty
                  ? Center(
                      child: Text(
                        'Nessuna story disponibile nel backlog',
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
                                if (story.storyPoints != null)
                                  Text(
                                    '${story.storyPoints} pts',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  )
                                else
                                  Text(
                                    'Non stimata',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.textSecondaryColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                            secondary: story.storyPoints != null
                                ? Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${story.storyPoints}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
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
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _selectedStoryIds),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: Text('Conferma (${_selectedStoryIds.length} stories)'),
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
