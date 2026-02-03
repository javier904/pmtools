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
        width: 520,
        constraints: const BoxConstraints(maxHeight: 780),
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
            width: 400,
            child: Column(
              children: [
                // Start node
                _buildStartNode(context, l10n),
                _buildVerticalConnector(context),
                
                // Status nodes with cycle groups
                ..._buildWorkflowNodes(context, workflow, l10n),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        _buildLegend(context, l10n),
      ],
    );
  }

  /// Build workflow nodes, grouping cycle pairs together
  List<Widget> _buildWorkflowNodes(
    BuildContext context,
    List<_WorkflowNode> workflow,
    AppLocalizations l10n,
  ) {
    final widgets = <Widget>[];
    
    for (int i = 0; i < workflow.length; i++) {
      final node = workflow[i];
      
      // Check if this node starts a cycle pair (inProgress + inReview)
      if (node.isCycleStart && i + 1 < workflow.length) {
        final nextNode = workflow[i + 1];
        // Build a grouped cycle block
        widgets.add(_buildCycleGroup(context, node, nextNode, l10n));
        i++; // Skip the next node since we included it in the group
      } else {
        widgets.add(_buildStatusRow(context, node, l10n));
      }
      
      if (i < workflow.length - 1) {
        widgets.add(_buildVerticalConnector(context));
      }
    }
    
    return widgets;
  }

  /// Build a grouped cycle showing two states with bidirectional arrow
  Widget _buildCycleGroup(
    BuildContext context,
    _WorkflowNode node1,
    _WorkflowNode node2,
    AppLocalizations l10n,
  ) {
    return Stack(
      children: [
        // Main column with nodes
        Column(
          children: [
            _buildStatusRow(context, node1, l10n),
            _buildVerticalConnector(context),
            _buildStatusRow(context, node2, l10n),
          ],
        ),
        // Left side cycle bracket
        Positioned(
          left: 20,
          top: 0,
          bottom: 0,
          child: _buildCycleBracket(context, l10n),
        ),
      ],
    );
  }

  /// Build a visual bracket on the left showing bidirectional cycle
  Widget _buildCycleBracket(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: 60,
      child: Stack(
        children: [
          // Vertical bracket line
          Positioned(
            left: 48,
            top: 20,
            bottom: 20,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
          // Top horizontal line
          Positioned(
            left: 48,
            top: 20,
            child: Container(
              width: 12,
              height: 2,
              color: Colors.orange,
            ),
          ),
          // Bottom horizontal line
          Positioned(
            left: 48,
            bottom: 20,
            child: Container(
              width: 12,
              height: 2,
              color: Colors.orange,
            ),
          ),
          // Up arrow (bottom)
          Positioned(
            left: 40,
            bottom: 50,
            child: Icon(Icons.arrow_upward, size: 16, color: Colors.orange),
          ),
          // Down arrow (top)
          Positioned(
            left: 40,
            top: 50,
            child: Icon(Icons.arrow_downward, size: 16, color: Colors.orange),
          ),
          // Cycle label
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: RotatedBox(
                quarterTurns: -1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sync, size: 12, color: Colors.orange[700]),
                      const SizedBox(width: 4),
                      Text(
                        l10n.workflowCycleLabel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<_WorkflowNode> _getWorkflowForFramework() {
    switch (framework) {
      case AgileFramework.scrum:
        return [
          _WorkflowNode(status: StoryStatus.backlog, canTransitionFromAny: true),
          _WorkflowNode(status: StoryStatus.refinement),
          _WorkflowNode(status: StoryStatus.ready),
          _WorkflowNode(status: StoryStatus.inSprint),
          _WorkflowNode(status: StoryStatus.inProgress, isCycleStart: true),
          _WorkflowNode(status: StoryStatus.inReview, isCycleEnd: true),
          _WorkflowNode(status: StoryStatus.done, canTransitionFromAny: true, isEndState: true),
        ];

      case AgileFramework.kanban:
        // Kanban: No inSprint, continuous flow with WIP focus
        return [
          _WorkflowNode(status: StoryStatus.backlog, canTransitionFromAny: true),
          _WorkflowNode(status: StoryStatus.refinement),
          _WorkflowNode(status: StoryStatus.ready),
          _WorkflowNode(status: StoryStatus.inProgress, isCycleStart: true),
          _WorkflowNode(status: StoryStatus.inReview, isCycleEnd: true),
          _WorkflowNode(status: StoryStatus.done, canTransitionFromAny: true, isEndState: true),
        ];

      case AgileFramework.hybrid:
        // Hybrid: Optional inSprint, can skip directly from ready to inProgress
        return [
          _WorkflowNode(status: StoryStatus.backlog, canTransitionFromAny: true),
          _WorkflowNode(status: StoryStatus.refinement),
          _WorkflowNode(status: StoryStatus.ready, hasAlternatePath: true, alternateNote: 'Sprint o Pull'),
          _WorkflowNode(status: StoryStatus.inSprint, isOptional: true),
          _WorkflowNode(status: StoryStatus.inProgress, isCycleStart: true),
          _WorkflowNode(status: StoryStatus.inReview, isCycleEnd: true),
          _WorkflowNode(status: StoryStatus.done, canTransitionFromAny: true, isEndState: true),
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
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(BuildContext context, _WorkflowNode node, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left side spacer for cycle bracket
        const SizedBox(width: 70),
        
        // Optional indicator
        SizedBox(
          width: 50,
          child: node.isOptional
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'OPT',
                    style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                )
              : node.hasAlternatePath
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        node.alternateNote ?? '',
                        style: TextStyle(fontSize: 8, color: Colors.blue[700]),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : null,
        ),
        
        // Status node
        _buildStatusNode(context, node),
        
        // Right side - "Any" badge
        SizedBox(
          width: 130,
          child: node.canTransitionFromAny
              ? _buildAnyBadge(context, l10n)
              : null,
        ),
      ],
    );
  }

  Widget _buildStatusNode(BuildContext context, _WorkflowNode node) {
    final status = node.status;
    final isEndState = node.isEndState;
    final isOptional = node.isOptional;
    
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isEndState 
            ? status.color.withValues(alpha: 0.15) 
            : isOptional 
                ? Colors.grey[100] 
                : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isEndState 
              ? status.color 
              : isOptional 
                  ? Colors.grey[400]! 
                  : Colors.grey[300]!,
          width: isEndState ? 3 : 1.5,
          // Dashed border effect for optional nodes would require custom paint
        ),
        boxShadow: [
          BoxShadow(
            color: (isOptional ? Colors.grey : status.color).withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            status.icon,
            color: isOptional ? Colors.grey[600] : status.color,
            size: 18,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              status.displayName.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: isOptional 
                    ? Colors.grey[600] 
                    : isEndState 
                        ? status.color 
                        : Colors.grey[700],
              ),
              overflow: TextOverflow.ellipsis,
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
          width: 16,
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
            spacing: 16,
            runSpacing: 8,
            children: [
              // Any badge explanation
              _buildLegendItem(
                context,
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
                l10n.workflowFromAnyDesc,
              ),
              // Cycle explanation
              _buildLegendItem(
                context,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sync, size: 10, color: Colors.orange[700]),
                      const SizedBox(width: 2),
                      Text(l10n.workflowCycleLabel, style: TextStyle(color: Colors.orange[700], fontSize: 9)),
                    ],
                  ),
                ),
                l10n.workflowCycleDesc,
              ),
              // Optional state
              if (framework == AgileFramework.hybrid)
                _buildLegendItem(
                  context,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Text('OPT', style: TextStyle(fontSize: 9, color: Colors.grey[600])),
                  ),
                  l10n.workflowOptionalDesc,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Widget icon, String description) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 6),
        Text(
          '= $description',
          style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
        ),
      ],
    );
  }
}

class _WorkflowNode {
  final StoryStatus status;
  final bool canTransitionFromAny;
  final bool isEndState;
  final bool isCycleStart;
  final bool isCycleEnd;
  final bool isOptional;
  final bool hasAlternatePath;
  final String? alternateNote;

  const _WorkflowNode({
    required this.status,
    this.canTransitionFromAny = false,
    this.isEndState = false,
    this.isCycleStart = false,
    this.isCycleEnd = false,
    this.isOptional = false,
    this.hasAlternatePath = false,
    this.alternateNote,
  });
}
