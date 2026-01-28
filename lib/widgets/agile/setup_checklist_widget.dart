import 'package:flutter/material.dart';
import '../../models/agile_project_model.dart';
import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../models/framework_features.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import '../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final checklist = _buildChecklist(context, l10n);
    final completedCount = checklist.where((item) => item.isCompleted).length;
    final totalCount = checklist.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    // Se tutto completato, mostra solo un messaggio di successo
    if (completedCount == totalCount && totalCount > 0) {
      return _buildCompletedState(l10n);
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
                      Text(
                        l10n.agileSetupTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Builder(
                        builder: (context) => Text(
                          l10n.agileStepComplete(completedCount, totalCount),
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
            ...checklist.map((item) => _buildChecklistItem(context, l10n, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedState(AppLocalizations l10n) {
    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.agileSetupCompleteTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    l10n.agileSetupCompleteMessage,
                    style: const TextStyle(
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

  Widget _buildChecklistItem(BuildContext context, AppLocalizations l10n, ChecklistItem item) {
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
              child: Text(item.actionLabel ?? l10n.actionCreate),
            ),
        ],
      ),
    );
  }

  List<ChecklistItem> _buildChecklist(BuildContext context, AppLocalizations l10n) {
    final items = <ChecklistItem>[];
    int order = 1;

    // 1. Team members
    items.add(ChecklistItem(
      order: order++,
      title: l10n.agileChecklistAddMembers,
      description: l10n.agileChecklistAddMembersDesc,
      isCompleted: project.participantCount > 1,
      action: onAddTeamMember,
      actionLabel: l10n.agileChecklistInvite,
    ));

    // 2. Backlog items
    items.add(ChecklistItem(
      order: order++,
      title: l10n.agileChecklistCreateStories(_features.workItemLabelPlural.toLowerCase()),
      description: l10n.agileChecklistAddItems,
      isCompleted: stories.length >= 3,
      action: onAddStory,
      actionLabel: l10n.agileChecklistAdd,
    ));

    // 3. Framework-specific items
    if (_features.hasWipLimits) {
      // Kanban/Hybrid: Configura WIP limits
      final hasCustomWip = project.kanbanColumns.any((c) => c.wipLimit != null);
      items.add(ChecklistItem(
        order: order++,
        title: l10n.agileChecklistWipLimits,
        description: l10n.agileChecklistWipLimitsDesc,
        isCompleted: hasCustomWip,
        action: onConfigureWip,
        actionLabel: l10n.agileChecklistConfigure,
      ));
    }

    if (_features.hasStoryPoints) {
      // Scrum/Hybrid: Stima le stories
      final estimatedStories = stories.where((s) => s.storyPoints != null && s.storyPoints! > 0).length;
      items.add(ChecklistItem(
        order: order++,
        title: l10n.agileChecklistEstimate(_features.workItemLabelPlural.toLowerCase()),
        description: l10n.agileChecklistEstimateDesc,
        isCompleted: estimatedStories >= 3,
      ));
    }

    if (_features.showSprintTab) {
      // Scrum/Hybrid: Crea primo sprint
      items.add(ChecklistItem(
        order: order++,
        title: l10n.agileChecklistCreateSprint,
        description: l10n.agileChecklistSprintDesc,
        isCompleted: sprints.isNotEmpty,
        action: onStartSprint,
        actionLabel: l10n.agileChecklistCreateSprintAction,
      ));
    }

    // 4. Start working (common)
    final hasWorkInProgress = stories.any((s) =>
        s.status == StoryStatus.inProgress ||
        s.status == StoryStatus.inReview);
    items.add(ChecklistItem(
      order: order++,
      title: l10n.agileChecklistStartWork,
      description: l10n.agileChecklistStartWorkDesc,
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
    final tips = _getTips(context);

    if (tips.isEmpty) return const SizedBox.shrink();

    return Column(
      children: tips.map((tip) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: tip,
      )).toList(),
    );
  }

  List<Widget> _getTips(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tips = <Widget>[];

    switch (framework) {
      case AgileFramework.scrum:
        if (!hasActiveSprint && storiesCount >= 3) {
          tips.add(ContextualTipBanner(
            tipId: 'scrum_start_sprint',
            title: l10n.agileTipStartSprintTitle,
            message: l10n.agileTipStartSprintMessage,
            icon: Icons.flag,
            color: Colors.blue,
            actionLabel: l10n.agileTipDiscover,
            onDismiss: () {},
          ));
        }
        break;

      case AgileFramework.kanban:
        if (!hasWipLimits && storiesCount > 0) {
          tips.add(ContextualTipBanner(
            tipId: 'kanban_wip_limits',
            title: l10n.agileTipWipTitle,
            message: l10n.agileTipWipMessage,
            icon: Icons.speed,
            color: Colors.green,
            actionLabel: l10n.agileTipDiscover,
            onDismiss: () {},
          ));
        }
        break;

      case AgileFramework.hybrid:
        if (storiesCount >= 3 && !hasActiveSprint && !hasWipLimits) {
          tips.add(ContextualTipBanner(
            tipId: 'hybrid_setup',
            title: l10n.agileTipHybridTitle,
            message: l10n.agileTipHybridMessage,
            icon: Icons.all_inclusive,
            color: Colors.purple,
            actionLabel: l10n.agileTipDiscover,
            onDismiss: () {},
          ));
        }
        break;
    }

    return tips;
  }
} // End of FrameworkTipsWidget

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
  @override
  Widget build(BuildContext context) {
    final nextStep = _getNextStep(context);
    if (nextStep == null) return const SizedBox.shrink();

    return Card(
      color: context.surfaceVariantColor,
      child: ListTile(
        leading: Icon(nextStep.icon, color: AppColors.primary),
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

  _NextStep? _getNextStep(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final features = FrameworkFeatures(framework);

    // 1. No team members
    if (project.participantCount <= 1) {
      return _NextStep(
        icon: Icons.people,
        title: l10n.agileNextStepInviteTitle,
        description: l10n.agileNextStepInviteDesc,
        actionLabel: l10n.agileChecklistInvite,
      );
    }

    // 2. No stories
    if (stories.isEmpty) {
      return _NextStep(
        icon: Icons.add_task,
        title: l10n.agileNextStepBacklogTitle,
        description: l10n.agileNextStepBacklogDesc(features.workItemLabelPlural.toLowerCase()),
        actionLabel: l10n.agileChecklistAdd,
      );
    }

    // 3. Framework-specific
    if (features.showSprintTab && sprints.isEmpty && stories.length >= 3) {
      return _NextStep(
        icon: Icons.flag,
        title: l10n.agileNextStepSprintTitle,
        description: l10n.agileNextStepSprintDesc(stories.length),
        actionLabel: l10n.agileChecklistCreateSprintAction,
      );
    }

    if (features.hasWipLimits && !project.kanbanColumns.any((c) => c.wipLimit != null)) {
      return _NextStep(
        icon: Icons.tune,
        title: l10n.agileNextStepWipTitle,
        description: l10n.agileNextStepWipDesc,
        actionLabel: l10n.agileChecklistConfigure,
      );
    }

    // 4. No work in progress
    final hasWip = stories.any((s) => s.status == StoryStatus.inProgress);
    if (!hasWip && stories.isNotEmpty) {
      return _NextStep(
        icon: Icons.play_arrow,
        title: l10n.agileNextStepWorkTitle,
        description: l10n.agileNextStepWorkDesc,
        actionLabel: l10n.agileNextStepGoToKanban,
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
