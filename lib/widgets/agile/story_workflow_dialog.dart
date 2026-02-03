import 'package:flutter/material.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Dialog che mostra il flusso di lavoro delle stories in stile Jira
/// Layout verticale con nodi, connettori e badge "Da qualunque stato"
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
        width: 500,
        constraints: const BoxConstraints(maxHeight: 750),
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
                    _buildVerticalWorkflow(context, l10n),
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

  /// Build the vertical workflow diagram (Jira-style)
  Widget _buildVerticalWorkflow(BuildContext context, AppLocalizations l10n) {
    final workflow = _getWorkflowForFramework();
    
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
        
        // Vertical workflow
        Center(
          child: SizedBox(
            width: 380,
            child: Column(
              children: [
                // Start node
                _buildStartNode(context, l10n),
                _buildVerticalConnector(context),
                
                // Status nodes
                for (int i = 0; i < workflow.length; i++) ...[
                  _buildStatusRow(context, workflow[i], l10n),
                  if (i < workflow.length - 1)
                    _buildVerticalConnector(context),
                ],
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        _buildLegend(context, l10n),
      ],
    );
  }

  List<_WorkflowNode> _getWorkflowForFramework() {
    switch (framework) {
      case AgileFramework.scrum:
        return [
          _WorkflowNode(
            status: StoryStatus.backlog,
            canTransitionFromAny: true,
          ),
          _WorkflowNode(
            status: StoryStatus.refinement,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.ready,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.inSprint,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.inProgress,
            canTransitionFromAny: false,
            hasCycleBack: true,
            cycleBackTo: 'inReview ↔ inProgress',
          ),
          _WorkflowNode(
            status: StoryStatus.inReview,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.done,
            canTransitionFromAny: true,
            isEndState: true,
          ),
        ];

      case AgileFramework.kanban:
        return [
          _WorkflowNode(
            status: StoryStatus.backlog,
            canTransitionFromAny: true,
          ),
          _WorkflowNode(
            status: StoryStatus.refinement,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.ready,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.inProgress,
            canTransitionFromAny: false,
            hasCycleBack: true,
            cycleBackTo: 'inReview ↔ inProgress',
          ),
          _WorkflowNode(
            status: StoryStatus.inReview,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.done,
            canTransitionFromAny: true,
            isEndState: true,
          ),
        ];

      case AgileFramework.hybrid:
        return [
          _WorkflowNode(
            status: StoryStatus.backlog,
            canTransitionFromAny: true,
          ),
          _WorkflowNode(
            status: StoryStatus.refinement,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.ready,
            canTransitionFromAny: false,
            hasCycleBack: true,
            cycleBackTo: 'Pull o Sprint',
          ),
          _WorkflowNode(
            status: StoryStatus.inSprint,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.inProgress,
            canTransitionFromAny: false,
            hasCycleBack: true,
            cycleBackTo: 'inReview ↔ inProgress',
          ),
          _WorkflowNode(
            status: StoryStatus.inReview,
            canTransitionFromAny: false,
          ),
          _WorkflowNode(
            status: StoryStatus.done,
            canTransitionFromAny: true,
            isEndState: true,
          ),
        ];
    }
  }

  Widget _buildStartNode(BuildContext context, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'START',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalConnector(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 2,
          height: 24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey[400]!,
                Colors.grey[500]!,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(BuildContext context, _WorkflowNode node, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left side spacer
        const SizedBox(width: 40),
        
        // Cycle indicator (left side)
        SizedBox(
          width: 60,
          child: node.hasCycleBack
              ? _buildCycleIndicator(context, node.cycleBackTo ?? '')
              : null,
        ),
        
        // Status node
        _buildStatusNode(context, node),
        
        // Right side - "Any" badge
        SizedBox(
          width: 120,
          child: node.canTransitionFromAny
              ? _buildAnyBadge(context, l10n)
              : null,
        ),
      ],
    );
  }

  Widget _buildCycleIndicator(BuildContext context, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.sync, size: 10, color: Colors.orange[700]),
              const SizedBox(width: 2),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 8, color: Colors.orange[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusNode(BuildContext context, _WorkflowNode node) {
    final status = node.status;
    final isEndState = node.isEndState;
    
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isEndState ? status.color.withValues(alpha: 0.2) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isEndState ? status.color : Colors.grey[300]!,
          width: isEndState ? 3 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: status.color.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            status.icon,
            color: status.color,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            status.displayName.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: isEndState ? status.color : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnyBadge(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        // Arrow pointing to node
        Container(
          width: 20,
          height: 2,
          color: Colors.grey[400],
        ),
        Icon(Icons.arrow_back, size: 12, color: Colors.grey[400]),
        const SizedBox(width: 4),
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bolt, size: 12, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                l10n.workflowFromAny,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
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
            spacing: 12,
            runSpacing: 8,
            children: [
              // Any badge explanation
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bolt, size: 10, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(l10n.workflowFromAny, style: const TextStyle(color: Colors.white, fontSize: 9)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '= ${l10n.workflowFromAnyDesc}',
                    style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                  ),
                ],
              ),
              // Cycle explanation
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.sync, size: 10, color: Colors.orange[700]),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '= ${l10n.workflowCycleDesc}',
                    style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WorkflowNode {
  final StoryStatus status;
  final bool canTransitionFromAny;
  final bool isEndState;
  final bool hasCycleBack;
  final String? cycleBackTo;

  const _WorkflowNode({
    required this.status,
    required this.canTransitionFromAny,
    this.isEndState = false,
    this.hasCycleBack = false,
    this.cycleBackTo,
  });
}
