import 'package:flutter/material.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Dialog che mostra il flusso di lavoro delle stories in base alla metodologia
class StoryWorkflowDialog extends StatelessWidget {
  final AgileFramework framework;

  const StoryWorkflowDialog({
    super.key,
    required this.framework,
  });

  /// Mostra il dialog
  static Future<void> show(BuildContext context, AgileFramework framework) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => StoryWorkflowDialog(framework: framework),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Dialog(
      child: Container(
        width: 700,
        constraints: const BoxConstraints(maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(context, l10n),
            
            // Body
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMethodologyInfo(context, l10n),
                    const SizedBox(height: 24),
                    _buildWorkflowDiagram(context, l10n),
                    const SizedBox(height: 24),
                    _buildLegend(context, l10n),
                  ],
                ),
              ),
            ),
            
            // Footer
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.actionClose),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.route, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          Text(
            l10n.workflowTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Chip(
            label: Text(framework.displayName),
            avatar: Icon(framework.icon, size: 16),
            backgroundColor: framework == AgileFramework.scrum
                ? Colors.blue.withValues(alpha: 0.2)
                : framework == AgileFramework.kanban
                    ? Colors.purple.withValues(alpha: 0.2)
                    : Colors.orange.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodologyInfo(BuildContext context, AppLocalizations l10n) {
    String description;
    IconData icon;
    Color color;

    switch (framework) {
      case AgileFramework.scrum:
        description = l10n.workflowScrumDesc;
        icon = Icons.loop;
        color = Colors.blue;
        break;
      case AgileFramework.kanban:
        description = l10n.workflowKanbanDesc;
        icon = Icons.view_column;
        color = Colors.purple;
        break;
      case AgileFramework.hybrid:
        description = l10n.workflowHybridDesc;
        icon = Icons.merge_type;
        color = Colors.orange;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              description,
              style: TextStyle(color: context.textSecondaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowDiagram(BuildContext context, AppLocalizations l10n) {
    // Definiamo le transizioni in base alla metodologia
    final transitions = _getTransitions();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.workflowDiagramTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Workflow visualizer
        _buildVisualWorkflow(context, transitions),
      ],
    );
  }

  List<_WorkflowTransition> _getTransitions() {
    // Transizioni comuni a tutte le metodologie
    final common = <_WorkflowTransition>[
      _WorkflowTransition(
        from: null,
        to: StoryStatus.backlog,
        label: 'Create',
        isStart: true,
      ),
      _WorkflowTransition(
        from: StoryStatus.backlog,
        to: StoryStatus.refinement,
        label: 'Start Refinement',
      ),
      _WorkflowTransition(
        from: StoryStatus.refinement,
        to: StoryStatus.ready,
        label: 'Mark Ready',
      ),
    ];

    switch (framework) {
      case AgileFramework.scrum:
        return [
          ...common,
          _WorkflowTransition(
            from: StoryStatus.ready,
            to: StoryStatus.inSprint,
            label: 'Sprint Planning',
          ),
          _WorkflowTransition(
            from: StoryStatus.inSprint,
            to: StoryStatus.inProgress,
            label: 'Start Work',
          ),
          _WorkflowTransition(
            from: StoryStatus.inProgress,
            to: StoryStatus.inReview,
            label: 'Submit for Review',
          ),
          _WorkflowTransition(
            from: StoryStatus.inReview,
            to: StoryStatus.done,
            label: 'Approve',
          ),
          // Reverse transitions
          _WorkflowTransition(
            from: StoryStatus.inReview,
            to: StoryStatus.inProgress,
            label: 'Request Changes',
            isReverse: true,
          ),
          _WorkflowTransition(
            from: StoryStatus.inSprint,
            to: StoryStatus.backlog,
            label: 'Return to Backlog',
            isReverse: true,
          ),
        ];

      case AgileFramework.kanban:
        return [
          ...common,
          _WorkflowTransition(
            from: StoryStatus.ready,
            to: StoryStatus.inProgress,
            label: 'Pull',
          ),
          _WorkflowTransition(
            from: StoryStatus.inProgress,
            to: StoryStatus.inReview,
            label: 'Submit for Review',
          ),
          _WorkflowTransition(
            from: StoryStatus.inReview,
            to: StoryStatus.done,
            label: 'Complete',
          ),
          // Reverse transitions
          _WorkflowTransition(
            from: StoryStatus.inReview,
            to: StoryStatus.inProgress,
            label: 'Rework',
            isReverse: true,
          ),
        ];

      case AgileFramework.hybrid:
        return [
          ...common,
          _WorkflowTransition(
            from: StoryStatus.ready,
            to: StoryStatus.inSprint,
            label: 'Sprint Planning (Optional)',
          ),
          _WorkflowTransition(
            from: StoryStatus.ready,
            to: StoryStatus.inProgress,
            label: 'Pull (Continuous)',
          ),
          _WorkflowTransition(
            from: StoryStatus.inSprint,
            to: StoryStatus.inProgress,
            label: 'Start Work',
          ),
          _WorkflowTransition(
            from: StoryStatus.inProgress,
            to: StoryStatus.inReview,
            label: 'Submit for Review',
          ),
          _WorkflowTransition(
            from: StoryStatus.inReview,
            to: StoryStatus.done,
            label: 'Approve',
          ),
          // Reverse
          _WorkflowTransition(
            from: StoryStatus.inReview,
            to: StoryStatus.inProgress,
            label: 'Request Changes',
            isReverse: true,
          ),
        ];
    }
  }

  Widget _buildVisualWorkflow(BuildContext context, List<_WorkflowTransition> transitions) {
    // Determina i nodi principali (forward flow only per il diagramma principale)
    final forwardTransitions = transitions.where((t) => !t.isReverse && !t.isStart).toList();
    final reverseTransitions = transitions.where((t) => t.isReverse).toList();

    // Estrai tutti gli stati unici nell'ordine del flusso
    final states = <StoryStatus>[];
    for (final t in forwardTransitions) {
      if (t.from != null && !states.contains(t.from)) {
        states.add(t.from!);
      }
      if (!states.contains(t.to)) {
        states.add(t.to);
      }
    }

    // Gestione speciale: assicuriamoci che backlog sia primo
    if (!states.contains(StoryStatus.backlog)) {
      states.insert(0, StoryStatus.backlog);
    }

    return Column(
      children: [
        // Main flow (horizontal)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Start node
                _buildStartNode(context),
                _buildArrow(context, 'Create', false),
                // Status nodes
                for (int i = 0; i < states.length; i++) ...[
                  _buildStatusNode(context, states[i]),
                  if (i < states.length - 1)
                    _buildArrow(
                      context,
                      _getTransitionLabel(forwardTransitions, states[i], states[i + 1]),
                      false,
                    ),
                ],
              ],
            ),
          ),
        ),

        // Reverse transitions (below)
        if (reverseTransitions.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.undo, size: 16, color: Colors.orange),
                    const SizedBox(width: 8),
                    Text(
                      'Reverse Transitions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: reverseTransitions.map((t) => _buildReverseTransition(context, t)).toList(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _getTransitionLabel(List<_WorkflowTransition> transitions, StoryStatus from, StoryStatus to) {
    for (final t in transitions) {
      if (t.from == from && t.to == to) {
        return t.label;
      }
    }
    return '';
  }

  Widget _buildStartNode(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(Icons.play_arrow, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildStatusNode(BuildContext context, StoryStatus status) {
    final isEndState = status == StoryStatus.done;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isEndState ? status.color : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: status.color,
          width: isEndState ? 3 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: status.color.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status.icon,
            color: isEndState ? Colors.white : status.color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            status.displayName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: isEndState ? Colors.white : status.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow(BuildContext context, String label, bool isReverse) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isReverse ? Colors.orange : context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Icon(
            isReverse ? Icons.arrow_back : Icons.arrow_forward,
            color: isReverse ? Colors.orange : context.textSecondaryColor,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildReverseTransition(BuildContext context, _WorkflowTransition t) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: t.from!.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            t.from!.displayName,
            style: TextStyle(fontSize: 11, color: t.from!.color),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.label,
                style: TextStyle(fontSize: 9, color: context.textMutedColor),
              ),
              const Icon(Icons.arrow_forward, size: 14, color: Colors.orange),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: t.to.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            t.to.displayName,
            style: TextStyle(fontSize: 11, color: t.to.color),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.workflowLegend,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: StoryStatus.values.map((status) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: status.color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(status.icon, size: 12, color: Colors.white),
                ),
                const SizedBox(width: 6),
                Text(
                  status.displayName,
                  style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
                ),
              ],
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _WorkflowTransition {
  final StoryStatus? from;
  final StoryStatus to;
  final String label;
  final bool isReverse;
  final bool isStart;

  const _WorkflowTransition({
    required this.from,
    required this.to,
    required this.label,
    this.isReverse = false,
    this.isStart = false,
  });
}
