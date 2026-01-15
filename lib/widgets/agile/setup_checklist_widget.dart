import 'package:flutter/material.dart';
import '../../models/agile_project_model.dart';
import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../models/framework_features.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

/// Checklist di setup per un nuovo progetto Agile
///
/// Mostra i passi da completare per iniziare a lavorare in modo efficace.
class SetupChecklistWidget extends StatelessWidget {
  final AgileProjectModel project;
  final List<UserStoryModel> stories;
  final List<SprintModel> sprints;
  final VoidCallback? onAddTeamMember;
  final VoidCallback? onAddStory;
  final VoidCallback? onStartSprint;
  final VoidCallback? onConfigureWip;

  const SetupChecklistWidget({
    super.key,
    required this.project,
    required this.stories,
    required this.sprints,
    this.onAddTeamMember,
    this.onAddStory,
    this.onStartSprint,
    this.onConfigureWip,
  });

  FrameworkFeatures get _features => FrameworkFeatures(project.framework);

  @override
  Widget build(BuildContext context) {
    final checklist = _buildChecklist();
    final completedCount = checklist.where((item) => item.isCompleted).length;
    final totalCount = checklist.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    // Se tutto completato, mostra solo un messaggio di successo
    if (completedCount == totalCount && totalCount > 0) {
      return _buildCompletedState();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.checklist,
                  color: _features.primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Setup del Progetto',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Builder(
                        builder: (context) => Text(
                          '$completedCount di $totalCount passi completati',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Progress indicator
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Builder(
                        builder: (context) => CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 4,
                          backgroundColor: context.borderColor,
                          valueColor: AlwaysStoppedAnimation(_features.primaryColor),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${(progress * 100).round()}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _features.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Checklist items
            ...checklist.map((item) => _buildChecklistItem(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedState() {
    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 32),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Setup Completato!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Il tuo progetto è pronto per iniziare.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(ChecklistItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Checkbox icon
          Builder(
            builder: (context) => Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: item.isCompleted
                    ? Colors.green.withOpacity(0.1)
                    : context.textMutedColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: item.isCompleted ? Colors.green : context.textMutedColor,
                ),
              ),
              child: item.isCompleted
                  ? const Icon(Icons.check, color: Colors.green, size: 16)
                  : Text(
                      '${item.order}',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textSecondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Builder(
              builder: (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      decoration: item.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: item.isCompleted ? context.textMutedColor : null,
                    ),
                  ),
                  if (item.description != null)
                    Text(
                      item.description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textSecondaryColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Action button
          if (!item.isCompleted && item.action != null)
            TextButton(
              onPressed: item.action,
              child: Text(item.actionLabel ?? 'Inizia'),
            ),
        ],
      ),
    );
  }

  List<ChecklistItem> _buildChecklist() {
    final items = <ChecklistItem>[];
    int order = 1;

    // 1. Team members
    items.add(ChecklistItem(
      order: order++,
      title: 'Aggiungi membri al team',
      description: 'Invita i membri del team a collaborare',
      isCompleted: project.participantCount > 1,
      action: onAddTeamMember,
      actionLabel: 'Invita',
    ));

    // 2. Backlog items
    items.add(ChecklistItem(
      order: order++,
      title: 'Crea le prime ${_features.workItemLabelPlural.toLowerCase()}',
      description: 'Aggiungi almeno 3 item al backlog',
      isCompleted: stories.length >= 3,
      action: onAddStory,
      actionLabel: 'Aggiungi',
    ));

    // 3. Framework-specific items
    if (_features.hasWipLimits) {
      // Kanban/Hybrid: Configura WIP limits
      final hasCustomWip = project.kanbanColumns.any((c) => c.wipLimit != null);
      items.add(ChecklistItem(
        order: order++,
        title: 'Configura i WIP limits',
        description: 'Imposta limiti per ogni colonna Kanban',
        isCompleted: hasCustomWip,
        action: onConfigureWip,
        actionLabel: 'Configura',
      ));
    }

    if (_features.hasStoryPoints) {
      // Scrum/Hybrid: Stima le stories
      final estimatedStories = stories.where((s) => s.storyPoints != null && s.storyPoints! > 0).length;
      items.add(ChecklistItem(
        order: order++,
        title: 'Stima le ${_features.workItemLabelPlural.toLowerCase()}',
        description: 'Assegna Story Points per pianificare meglio',
        isCompleted: estimatedStories >= 3,
      ));
    }

    if (_features.showSprintTab) {
      // Scrum/Hybrid: Crea primo sprint
      items.add(ChecklistItem(
        order: order++,
        title: 'Crea il primo Sprint',
        description: 'Seleziona le stories e inizia a lavorare',
        isCompleted: sprints.isNotEmpty,
        action: onStartSprint,
        actionLabel: 'Crea Sprint',
      ));
    }

    // 4. Start working (common)
    final hasWorkInProgress = stories.any((s) =>
        s.status == StoryStatus.inProgress ||
        s.status == StoryStatus.inReview);
    items.add(ChecklistItem(
      order: order++,
      title: 'Inizia a lavorare',
      description: 'Sposta un item in lavorazione',
      isCompleted: hasWorkInProgress,
    ));

    return items;
  }
}

/// Singolo item della checklist
class ChecklistItem {
  final int order;
  final String title;
  final String? description;
  final bool isCompleted;
  final VoidCallback? action;
  final String? actionLabel;

  const ChecklistItem({
    required this.order,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.action,
    this.actionLabel,
  });
}

/// Banner compatto per mostrare suggerimenti contestuali
class ContextualTipBanner extends StatefulWidget {
  final String tipId;
  final String title;
  final String message;
  final IconData icon;
  final Color color;
  final VoidCallback? onAction;
  final String? actionLabel;
  final VoidCallback? onDismiss;

  const ContextualTipBanner({
    super.key,
    required this.tipId,
    required this.title,
    required this.message,
    this.icon = Icons.lightbulb_outline,
    this.color = Colors.amber,
    this.onAction,
    this.actionLabel,
    this.onDismiss,
  });

  @override
  State<ContextualTipBanner> createState() => _ContextualTipBannerState();
}

class _ContextualTipBannerState extends State<ContextualTipBanner> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    return Card(
      color: widget.color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(widget.icon, color: widget.color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.color.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Builder(
                    builder: (context) => Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: 13,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.onAction != null) ...[
              TextButton(
                onPressed: widget.onAction,
                child: Text(widget.actionLabel ?? 'Scopri'),
              ),
            ],
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: () {
                setState(() => _dismissed = true);
                widget.onDismiss?.call();
              },
              tooltip: 'Chiudi',
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget per mostrare suggerimenti specifici per framework
class FrameworkTipsWidget extends StatelessWidget {
  final AgileFramework framework;
  final int storiesCount;
  final int completedStoriesCount;
  final bool hasActiveSprint;
  final bool hasWipLimits;

  const FrameworkTipsWidget({
    super.key,
    required this.framework,
    required this.storiesCount,
    required this.completedStoriesCount,
    required this.hasActiveSprint,
    required this.hasWipLimits,
  });

  @override
  Widget build(BuildContext context) {
    final tips = _getTips();

    if (tips.isEmpty) return const SizedBox.shrink();

    return Column(
      children: tips.map((tip) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: tip,
      )).toList(),
    );
  }

  List<Widget> _getTips() {
    final tips = <Widget>[];

    switch (framework) {
      case AgileFramework.scrum:
        if (!hasActiveSprint && storiesCount >= 3) {
          tips.add(const ContextualTipBanner(
            tipId: 'scrum_start_sprint',
            title: 'Pronto per uno Sprint?',
            message: 'Hai abbastanza stories nel backlog. Considera di pianificare il primo Sprint.',
            icon: Icons.flag,
            color: Colors.blue,
          ));
        }
        break;

      case AgileFramework.kanban:
        if (!hasWipLimits && storiesCount > 0) {
          tips.add(const ContextualTipBanner(
            tipId: 'kanban_wip_limits',
            title: 'Configura i WIP Limits',
            message: 'I WIP limits sono fondamentali in Kanban. Limita il lavoro in corso per migliorare il flusso.',
            icon: Icons.speed,
            color: Colors.green,
          ));
        }
        break;

      case AgileFramework.hybrid:
        if (storiesCount >= 3 && !hasActiveSprint && !hasWipLimits) {
          tips.add(const ContextualTipBanner(
            tipId: 'hybrid_setup',
            title: 'Configura il tuo Scrumban',
            message: 'Puoi usare Sprint per cadenza o WIP limits per flusso continuo. Sperimenta!',
            icon: Icons.all_inclusive,
            color: Colors.purple,
          ));
        }
        break;
    }

    return tips;
  }
}

/// Widget per mostrare il passo successivo consigliato
class NextStepWidget extends StatelessWidget {
  final AgileFramework framework;
  final AgileProjectModel project;
  final List<UserStoryModel> stories;
  final List<SprintModel> sprints;
  final VoidCallback? onAction;

  const NextStepWidget({
    super.key,
    required this.framework,
    required this.project,
    required this.stories,
    required this.sprints,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final nextStep = _getNextStep();
    if (nextStep == null) return const SizedBox.shrink();

    return Card(
      color: Colors.teal.shade50,
      child: ListTile(
        leading: Icon(nextStep.icon, color: Colors.teal),
        title: Text(
          nextStep.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(nextStep.description),
        trailing: nextStep.action != null
            ? ElevatedButton(
                onPressed: () {
                  nextStep.action?.call();
                  onAction?.call();
                },
                child: Text(nextStep.actionLabel),
              )
            : null,
      ),
    );
  }

  _NextStep? _getNextStep() {
    final features = FrameworkFeatures(framework);

    // 1. No team members
    if (project.participantCount <= 1) {
      return _NextStep(
        icon: Icons.people,
        title: 'Invita il Team',
        description: 'Aggiungi membri per collaborare al progetto.',
        actionLabel: 'Invita',
      );
    }

    // 2. No stories
    if (stories.isEmpty) {
      return _NextStep(
        icon: Icons.add_task,
        title: 'Crea il Backlog',
        description: 'Aggiungi le prime ${features.workItemLabelPlural.toLowerCase()} al backlog.',
        actionLabel: 'Aggiungi',
      );
    }

    // 3. Framework-specific
    if (features.showSprintTab && sprints.isEmpty && stories.length >= 3) {
      return _NextStep(
        icon: Icons.flag,
        title: 'Pianifica uno Sprint',
        description: 'Hai ${stories.length} items pronti. Crea il primo Sprint!',
        actionLabel: 'Crea Sprint',
      );
    }

    if (features.hasWipLimits && !project.kanbanColumns.any((c) => c.wipLimit != null)) {
      return _NextStep(
        icon: Icons.tune,
        title: 'Configura WIP Limits',
        description: 'Limita il lavoro in corso per migliorare il flusso.',
        actionLabel: 'Configura',
      );
    }

    // 4. No work in progress
    final hasWip = stories.any((s) => s.status == StoryStatus.inProgress);
    if (!hasWip && stories.isNotEmpty) {
      return _NextStep(
        icon: Icons.play_arrow,
        title: 'Inizia a Lavorare',
        description: 'Sposta un item "In Progress" per iniziare.',
        actionLabel: 'Vai al Kanban',
      );
    }

    return null;
  }
}

class _NextStep {
  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback? action;

  _NextStep({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    this.action,
  });
}
