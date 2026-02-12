import 'package:flutter/material.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Dialog che mostra il flusso di lavoro delle stories in stile Jira
/// Layout verticale con nodi, connettori e badge "Da qualunque stato"
/// Responsive per schermi piccoli
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
    final l10n = AppLocalizations.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 500;
    final dialogWidth = isSmallScreen ? screenWidth * 0.95 : 500.0;
    
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 8 : 40,
        vertical: 24,
      ),
      child: Container(
        width: dialogWidth,
        constraints: const BoxConstraints(maxHeight: 780),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(context, l10n, isSmallScreen),
            
            // Body
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMethodologyInfo(context, l10n, isSmallScreen),
                    const SizedBox(height: 16),
                    _buildVerticalWorkflow(context, l10n, isSmallScreen),
                  ],
                ),
              ),
            ),
            
            // Footer
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n?.actionClose ?? 'Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations? l10n, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.route, color: Theme.of(context).primaryColor, size: isSmallScreen ? 20 : 24),
          SizedBox(width: isSmallScreen ? 8 : 12),
          Expanded(
            child: Text(
              l10n?.workflowTitle ?? 'Workflow',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: isSmallScreen ? 16 : 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!isSmallScreen)
            Chip(
              label: Text(framework.displayName, style: const TextStyle(fontSize: 12)),
              avatar: Icon(framework.icon, size: 14),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
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

  Widget _buildMethodologyInfo(BuildContext context, AppLocalizations? l10n, bool isSmallScreen) {
    String description;
    IconData icon;
    Color color;

    switch (framework) {
      case AgileFramework.scrum:
        description = l10n?.workflowScrumDesc ?? 'Scrum flow';
        icon = Icons.loop;
        color = Colors.blue;
        break;
      case AgileFramework.kanban:
        description = l10n?.workflowKanbanDesc ?? 'Kanban flow';
        icon = Icons.view_column;
        color = Colors.purple;
        break;
      case AgileFramework.hybrid:
        description = l10n?.workflowHybridDesc ?? 'Hybrid flow';
        icon = Icons.merge_type;
        color = Colors.orange;
        break;
    }

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 10 : 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: isSmallScreen ? 24 : 32),
          SizedBox(width: isSmallScreen ? 10 : 16),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                color: context.textSecondaryColor,
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the vertical workflow diagram (Jira-style)
  Widget _buildVerticalWorkflow(BuildContext context, AppLocalizations? l10n, bool isSmallScreen) {
    final workflow = _getWorkflowForFramework();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n?.workflowDiagramTitle ?? 'Flow',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 14 : 16,
          ),
        ),
        const SizedBox(height: 12),
        
        // Vertical workflow - centered
        Center(
          child: Column(
            children: [
              // Start node
              _buildStartNode(context, isSmallScreen),
              _buildVerticalConnector(context),
              
              // Status nodes with cycle groups
              ..._buildWorkflowNodes(context, workflow, l10n, isSmallScreen),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        _buildLegend(context, l10n, isSmallScreen),
      ],
    );
  }

  /// Build workflow nodes, grouping cycle pairs together
  List<Widget> _buildWorkflowNodes(
    BuildContext context,
    List<_WorkflowNode> workflow,
    AppLocalizations? l10n,
    bool isSmallScreen,
  ) {
    final widgets = <Widget>[];
    
    for (int i = 0; i < workflow.length; i++) {
      final node = workflow[i];
      
      // Check for sprint group (consecutive nodes marked as isInSprint)
      if (node.isInSprint) {
        final sprintNodes = <_WorkflowNode>[];
        int j = i;
        while (j < workflow.length && workflow[j].isInSprint) {
          sprintNodes.add(workflow[j]);
          j++;
        }
        
        if (sprintNodes.length > 1) {
          widgets.add(_buildSprintGroup(context, sprintNodes, l10n, isSmallScreen));
          i = j - 1; // Update i to the last node in the sprint group
        } else {
          // Single sprint node (shouldn't happen with our current workflows but good to handle)
          widgets.add(_buildStatusRow(context, node, l10n, isSmallScreen));
        }
      } 
      // Check if this node starts a cycle pair (inProgress + inReview)
      // Note: This is now handled within _buildSprintGroup if they are in sprint, 
      // but we keep it here for any cycles outside of sprint if needed.
      else if (node.isCycleStart && i + 1 < workflow.length) {
        final nextNode = workflow[i + 1];
        // Build a grouped cycle block
        widgets.add(_buildCycleGroup(context, node, nextNode, l10n, isSmallScreen));
        i++; // Skip the next node since we included it in the group
      } else {
        widgets.add(_buildStatusRow(context, node, l10n, isSmallScreen));
      }
      
      if (i < workflow.length - 1) {
        widgets.add(_buildVerticalConnector(context));
      }
    }
    
    return widgets;
  }

  /// Build a grouped sprint area showing active development states
  Widget _buildSprintGroup(
    BuildContext context,
    List<_WorkflowNode> nodes,
    AppLocalizations? l10n,
    bool isSmallScreen,
  ) {
    final sprintNodes = <Widget>[];
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      
      // Handle cycle within sprint (In Progress -> In Review)
      if (node.isCycleStart && i + 1 < nodes.length) {
        sprintNodes.add(_buildCycleGroup(context, node, nodes[i+1], l10n, isSmallScreen));
        i++;
      } else {
        sprintNodes.add(_buildStatusRow(context, node, l10n, isSmallScreen));
      }
      
      if (i < nodes.length - 1) {
        sprintNodes.add(_buildVerticalConnector(context));
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15), // Increased alpha
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.8), // Even more prominent
          width: 3.0, // Even thicker
          style: BorderStyle.solid,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Sprint Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  framework == AgileFramework.kanban ? Icons.play_arrow : Icons.directions_run,
                  size: 18, 
                  color: Theme.of(context).colorScheme.primary
                ),
                const SizedBox(width: 8),
                Text(
                  (framework == AgileFramework.kanban 
                    ? (l10n?.filterActive ?? 'Active') 
                    : (l10n?.agileSprint ?? 'Sprint')).toUpperCase(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...sprintNodes,
        ],
      ),
    );
  }

  /// Build a grouped cycle showing two states with bidirectional arrow
  Widget _buildCycleGroup(
    BuildContext context,
    _WorkflowNode node1,
    _WorkflowNode node2,
    AppLocalizations? l10n,
    bool isSmallScreen,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.withValues(alpha: 0.5), width: 2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.orange.withValues(alpha: 0.05),
      ),
      child: Column(
        children: [
          // Cycle label
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.sync, size: 14, color: Colors.orange[700]),
              const SizedBox(width: 4),
              Text(
                l10n?.workflowCycleLabel ?? 'Rework',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildStatusRow(context, node1, l10n, isSmallScreen, inCycle: true),
          _buildBidirectionalConnector(context),
          _buildStatusRow(context, node2, l10n, isSmallScreen, inCycle: true),
        ],
      ),
    );
  }

  /// Bidirectional connector with up/down arrows
  Widget _buildBidirectionalConnector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_upward, size: 14, color: Colors.orange),
          Container(
            width: 2,
            height: 16,
            color: Colors.orange,
          ),
          Icon(Icons.arrow_downward, size: 14, color: Colors.orange),
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
          _WorkflowNode(status: StoryStatus.inSprint, isInSprint: true),
          _WorkflowNode(status: StoryStatus.inProgress, isCycleStart: true, isInSprint: true),
          _WorkflowNode(status: StoryStatus.inReview, isCycleEnd: true, isInSprint: true),
          _WorkflowNode(status: StoryStatus.done, canTransitionFromAny: true, isEndState: true),
        ];

      case AgileFramework.kanban:
        // Kanban: No inSprint, continuous flow with WIP focus
        // We remove isInSprint: true to avoid the grouping container
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
          _WorkflowNode(status: StoryStatus.ready, hasAlternatePath: true, alternateNote: 'Sprint/Pull'),
          _WorkflowNode(status: StoryStatus.inSprint, isOptional: true, isInSprint: true),
          _WorkflowNode(status: StoryStatus.inProgress, isCycleStart: true, isInSprint: true),
          _WorkflowNode(status: StoryStatus.inReview, isCycleEnd: true, isInSprint: true),
          _WorkflowNode(status: StoryStatus.done, canTransitionFromAny: true, isEndState: true),
        ];
    }
  }

  Widget _buildStartNode(BuildContext context, bool isSmallScreen) {
    final size = isSmallScreen ? 44.0 : 56.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 6,
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
            fontSize: isSmallScreen ? 9 : 11,
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalConnector(BuildContext context) {
    return Container(
      width: 2,
      height: 16,
      color: Colors.grey[400],
    );
  }

  Widget _buildStatusRow(
    BuildContext context,
    _WorkflowNode node,
    AppLocalizations? l10n,
    bool isSmallScreen, {
    bool inCycle = false,
  }) {
    final nodeWidth = isSmallScreen ? 130.0 : 160.0;
    
    // Use Stack to keep status node centered and badge to the side
    return SizedBox(
      width: isSmallScreen ? 280 : 350,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Centered: Optional indicator + Status node
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Optional/Alternate indicator (left)
              if (!inCycle && (node.isOptional || node.hasAlternatePath))
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: _buildIndicatorBadge(context, node, isSmallScreen),
                ),
              
              // Status node (fixed width for alignment)
              SizedBox(
                width: nodeWidth,
                child: _buildStatusNode(context, node, isSmallScreen),
              ),
            ],
          ),
          
          // Right side - "From Any" badge (positioned to the right)
          if (node.canTransitionFromAny)
            Positioned(
              right: 0,
              child: _buildAnyBadge(context, l10n, isSmallScreen),
            ),
        ],
      ),
    );
  }

  Widget _buildIndicatorBadge(BuildContext context, _WorkflowNode node, bool isSmallScreen) {
    if (node.isOptional) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 4 : 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'OPT',
          style: TextStyle(fontSize: isSmallScreen ? 8 : 9, color: Colors.grey[600]),
        ),
      );
    } else if (node.hasAlternatePath) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 4 : 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          node.alternateNote ?? '',
          style: TextStyle(fontSize: isSmallScreen ? 7 : 8, color: Colors.blue[700]),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildStatusNode(BuildContext context, _WorkflowNode node, bool isSmallScreen) {
    final status = node.status;
    final isEndState = node.isEndState;
    final isOptional = node.isOptional;
    final nodeWidth = isSmallScreen ? 120.0 : 150.0;
    
    return Container(
      width: nodeWidth,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10 : 14,
        vertical: isSmallScreen ? 8 : 10,
      ),
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
          width: isEndState ? 2.5 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (isOptional ? Colors.grey : status.color).withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status.icon,
            color: isOptional ? Colors.grey[600] : status.color,
            size: isSmallScreen ? 14 : 16,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              status.getDisplayName(framework).toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isSmallScreen ? 9 : 10,
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

  Widget _buildAnyBadge(BuildContext context, AppLocalizations? l10n, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 6 : 8,
        vertical: isSmallScreen ? 3 : 4,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, size: isSmallScreen ? 10 : 12, color: Colors.amber),
          SizedBox(width: isSmallScreen ? 2 : 4),
          Text(
            l10n?.workflowFromAny ?? 'Any',
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 8 : 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(BuildContext context, AppLocalizations? l10n, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 10 : 14),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.workflowLegend ?? 'Legend',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 12 : 14,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 6,
            children: [
              // Any badge explanation
              _buildLegendItem(
                context,
                Icon(Icons.bolt, size: 12, color: Colors.amber),
                l10n?.workflowFromAnyDesc ?? 'From any',
                isSmallScreen,
              ),
              // Cycle explanation
              _buildLegendItem(
                context,
                Icon(Icons.sync, size: 12, color: Colors.orange[700]),
                l10n?.workflowCycleDesc ?? 'Cycle',
                isSmallScreen,
              ),
                if (framework != AgileFramework.kanban)
                  _buildLegendItem(
                    context,
                    Icon(
                      framework == AgileFramework.kanban ? Icons.play_arrow : Icons.directions_run,
                      size: 12, 
                      color: Theme.of(context).colorScheme.primary
                    ),
                    framework == AgileFramework.kanban 
                      ? (l10n?.filterActive ?? 'Active') 
                      : (l10n?.agileSprint ?? 'Sprint'),
                    isSmallScreen,
                  ),
              // Optional state (Hybrid only)
              if (framework == AgileFramework.hybrid)
                _buildLegendItem(
                  context,
                  Text('OPT', style: TextStyle(fontSize: 9, color: Colors.grey[600])),
                  l10n?.workflowOptionalDesc ?? 'Optional',
                  isSmallScreen,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Widget icon, String description, bool isSmallScreen) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          description,
          style: TextStyle(fontSize: isSmallScreen ? 10 : 11, color: context.textSecondaryColor),
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
  final bool isInSprint;

  const _WorkflowNode({
    required this.status,
    this.canTransitionFromAny = false,
    this.isEndState = false,
    this.isCycleStart = false,
    this.isCycleEnd = false,
    this.isOptional = false,
    this.hasAlternatePath = false,
    this.alternateNote,
    this.isInSprint = false,
  });
}
