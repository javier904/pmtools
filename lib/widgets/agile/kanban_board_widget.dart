import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../models/sprint_model.dart';
import '../../models/framework_features.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import '../../services/secure_storage_service.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'story_card_widget.dart';
import 'story_workflow_dialog.dart';
import 'package:agile_tools/services/agile/kanban_policy_service.dart';

/// Kanban Board con drag & drop tra colonne e supporto WIP limits
///
/// Supporta tre modalità in base al framework:
/// - SCRUM: Colonne base senza WIP limits
/// - KANBAN: Colonne con WIP limits obbligatori
/// - HYBRID: Colonne con WIP limits configurabili
class KanbanBoardWidget extends StatefulWidget {
  final List<UserStoryModel> stories;
  final List<KanbanColumnConfig> columns;
  final AgileFramework framework;
  final void Function(String storyId, StoryStatus newStatus)? onStatusChange;
  final void Function(UserStoryModel story)? onStoryTap;
  final void Function(String columnId, int? newLimit)? onWipLimitChange;
  final void Function(String columnId, List<String> policies)? onPoliciesChange;
  final void Function(String columnId, Map<String, bool> activePolicies)? onActivePoliciesChange;
  final void Function(SwimlaneType)? onSwimlaneChange;
  final void Function(UserStoryModel story, String? email)? onAssigneeChange;
  final void Function(UserStoryModel story, int? points)? onStoryPointsChange;
  final void Function(String storyId, String newTitle)? onTitleChange;
  final void Function(String storyId, StoryPriority newPriority)? onPriorityChange;
  final void Function(String storyId)? onStoryDelete; // NEW
  final SwimlaneType swimlaneType;
  final bool canEdit;
  final bool showWipConfig;
  final bool showPolicies;
  final List<String> teamMembers;
  final List<SprintModel> sprints;
  final bool canMoveToBacklog;
  final bool canMarkAsReady;

  const KanbanBoardWidget({
    super.key,
    required this.stories,
    required this.columns,
    this.framework = AgileFramework.scrum,
    this.onStatusChange,
    this.onStoryTap,
    this.onWipLimitChange,
    this.onPoliciesChange,
    this.onActivePoliciesChange,
    this.onSwimlaneChange,
    this.onAssigneeChange,
    this.onStoryPointsChange,
    this.onTitleChange,
    this.onPriorityChange,
    this.onStoryDelete,
    this.swimlaneType = SwimlaneType.none,
    this.canEdit = true,
    this.showWipConfig = false,
    this.showPolicies = true,
    this.teamMembers = const [],
    this.sprints = const [],
    this.canMoveToBacklog = true, // Default true for backward compatibility
    this.canMarkAsReady = false,
  });

  @override
  State<KanbanBoardWidget> createState() => _KanbanBoardWidgetState();
}

class _KanbanBoardWidgetState extends State<KanbanBoardWidget> {
  late FrameworkFeatures _features;

  @override
  void initState() {
    super.initState();
    _features = FrameworkFeatures(widget.framework);
  }

  @override
  void didUpdateWidget(KanbanBoardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.framework != widget.framework) {
      _features = FrameworkFeatures(widget.framework);
    }
  }

  /// Raggruppa le stories per colonna in base agli status mappati
  Map<String, List<UserStoryModel>> get _storiesByColumn {
    final map = <String, List<UserStoryModel>>{};

    for (final column in widget.columns) {
      final columnStories = widget.stories.where((story) {
        return column.statuses.contains(story.status);
      }).toList();
      map[column.id] = columnStories;
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        // Workflow button (top-right)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => StoryWorkflowDialog.show(context, widget.framework),
                icon: const Icon(Icons.route, size: 18),
                label: Text(l10n.workflowShowButton),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        
        // Header con info framework
        if (_features.hasWipLimits) _buildWipInfoBanner(),

        // Swimlane selector (solo per Kanban/Hybrid)
        if (_features.hasWipLimits && widget.onSwimlaneChange != null)
          _buildSwimlaneSelector(),

        // Board
        Expanded(
          child: widget.swimlaneType == SwimlaneType.none
              ? _buildStandardBoard()
              : _buildSwimlanedBoard(),
        ),
      ],
    );
  }

  Widget _buildSwimlaneSelector() {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: context.surfaceColor,
      child: Row(
        children: [
          Icon(Icons.view_agenda, size: 16, color: context.textSecondaryColor),
          const SizedBox(width: 8),
          Text(l10n.kanbanSwimlanes, style: TextStyle(fontSize: 12, color: context.textSecondaryColor)),
          const SizedBox(width: 8),
          ...SwimlaneType.values.map((type) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(type.icon, size: 14),
                  const SizedBox(width: 4),
                  Text(type.displayName, style: const TextStyle(fontSize: 11)),
                ],
              ),
              selected: widget.swimlaneType == type,
              onSelected: (_) => widget.onSwimlaneChange?.call(type),
              tooltip: type.description,
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildStandardBoard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnCount = widget.columns.length;
        final columnWidth = ((constraints.maxWidth - 32) / columnCount - 8)
            .clamp(200.0, 350.0);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.columns.map((column) {
              final stories = _storiesByColumn[column.id] ?? [];
              return _buildColumn(column, stories, columnWidth);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildSwimlanedBoard() {
    final swimlanes = _getSwimlanes();

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnCount = widget.columns.length;
        final columnWidth = ((constraints.maxWidth - 32 - 150) / columnCount - 8)
            .clamp(180.0, 300.0);

        return SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row con nomi colonne
                _buildSwimlaneHeader(columnWidth),
                const SizedBox(height: 8),
                // Swimlane rows
                ...swimlanes.map((lane) =>
                    _buildSwimlaneRow(lane, columnWidth)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSwimlaneHeader(double columnWidth) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        // Spazio per label swimlane
        SizedBox(
          width: 140,
          child: Text(l10n.kanbanSwimlaneLabel, style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.textSecondaryColor,
            fontSize: 12,
          )),
        ),
        const SizedBox(width: 8),
        // Nomi colonne
        ...widget.columns.map((column) => Container(
          width: columnWidth,
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: column.statuses.first.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            column.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: column.statuses.first.color,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildSwimlaneRow(_SwimlaneData lane, double columnWidth) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: lane.color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lane.color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Swimlane label
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(lane.icon, size: 16, color: lane.color),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lane.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: lane.color,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        l10n.agileItemsCount(lane.stories.length),
                        style: TextStyle(
                          fontSize: 10,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Colonne per questa swimlane
          ...widget.columns.map((column) {
            final columnStories = lane.stories
                .where((s) => column.statuses.contains(s.status))
                .toList();

            return _buildSwimlaneColumnCell(column, columnStories, columnWidth, lane);
          }),
        ],
      ),
    );
  }

  Widget _buildSwimlaneColumnCell(
    KanbanColumnConfig column,
    List<UserStoryModel> stories,
    double width,
    _SwimlaneData lane,
  ) {
    final primaryStatus = column.statuses.isNotEmpty
        ? column.statuses.first
        : StoryStatus.backlog;

    return DragTarget<UserStoryModel>(
      onWillAcceptWithDetails: (details) {
        if (!widget.canEdit) return false;
        if (column.statuses.contains(details.data.status)) return false;
        return true;
      },
      onAcceptWithDetails: (details) {
        final l10n = AppLocalizations.of(context);
        final story = details.data;
        final targetStatus = primaryStatus;
        final currentCount = stories.length;
        final wouldExceedWip = column.wouldExceedWip(currentCount) && _features.hasWipLimits;

        // 1. Validazione Policy
        final policyService = KanbanPolicyService(l10n);
        final violations = policyService.validateMove(
          story,
          column,
          stories, // stories in the target column
        );

        if (violations.isNotEmpty) {
          _showPolicyViolationDialog(
            story,
            column,
            violations.map((v) => v.message).toList(),
            () {
              // Procedi comunque (Logica originale di spostamento)
              if (wouldExceedWip) {
                _showWipLimitWarningDialog(column, story, targetStatus, currentCount);
              } else {
                widget.onStatusChange?.call(story.id, targetStatus);
              }
            }
          );
          return;
        }

        // 2. Logica Originale (se no violations)
        if (wouldExceedWip) {
          _showWipLimitWarningDialog(column, story, targetStatus, currentCount);
        } else {
          widget.onStatusChange?.call(story.id, targetStatus);
        }
      },
      builder: (context, candidateData, rejectedData) {
        final isHighlighted = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          margin: const EdgeInsets.only(right: 8),
          constraints: BoxConstraints(
            minHeight: 80,
            maxHeight: stories.isEmpty ? 80 : (stories.length * 70.0 + 16).clamp(80.0, 300.0),
          ),
          decoration: BoxDecoration(
            color: isHighlighted
                ? primaryStatus.color.withValues(alpha: 0.1)
                : context.surfaceVariantColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHighlighted ? primaryStatus.color : context.borderColor,
              width: isHighlighted ? 2 : 1,
            ),
          ),
          child: stories.isEmpty
              ? Center(
                  child: Icon(
                    Icons.inbox_outlined,
                    size: 20,
                    color: context.textMutedColor,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4),
                  itemCount: stories.length,
                  itemBuilder: (context, index) =>
                      _buildKanbanCard(stories[index], column, stories),
                ),
        );
      },
    );
  }



  List<_SwimlaneData> _getSwimlanes() {
    switch (widget.swimlaneType) {
      case SwimlaneType.none:
        return [];

      case SwimlaneType.classOfService:
        return ClassOfService.values.map((cos) {
          final stories = widget.stories
              .where((s) => s.classOfService == cos)
              .toList();
          return _SwimlaneData(
            id: cos.name,
            name: cos.displayName,
            icon: cos.icon,
            color: cos.color,
            stories: stories,
          );
        }).where((lane) => lane.stories.isNotEmpty).toList()
          ..sort((a, b) {
            final aOrder = ClassOfService.values.firstWhere((c) => c.name == a.id).sortOrder;
            final bOrder = ClassOfService.values.firstWhere((c) => c.name == b.id).sortOrder;
            return aOrder.compareTo(bOrder);
          });

      case SwimlaneType.assignee:
        final assignees = <String>{};
        for (final story in widget.stories) {
          if (story.assigneeEmail != null) {
            assignees.add(story.assigneeEmail!);
          }
        }

        final lanes = assignees.map((email) {
          final stories = widget.stories
              .where((s) => s.assigneeEmail == email)
              .toList();
          return _SwimlaneData(
            id: email,
            name: email.split('@').first,
            icon: Icons.person,
            color: Colors.blue,
            stories: stories,
          );
        }).toList();

        // Add unassigned
        final unassigned = widget.stories
            .where((s) => s.assigneeEmail == null)
            .toList();
        if (unassigned.isNotEmpty) {
          lanes.add(_SwimlaneData(
            id: '_unassigned',
            name: AppLocalizations.of(context).agileUnassigned,
            icon: Icons.person_outline,
            color: Colors.grey,
            stories: unassigned,
          ));
        }

        return lanes;

      case SwimlaneType.priority:
        return StoryPriority.values.map((priority) {
          final stories = widget.stories
              .where((s) => s.priority == priority)
              .toList();
          return _SwimlaneData(
            id: priority.name,
            name: priority.displayName,
            icon: Icons.flag,
            color: priority.color,
            stories: stories,
          );
        }).where((lane) => lane.stories.isNotEmpty).toList();

      case SwimlaneType.tag:
        final tags = <String>{};
        for (final story in widget.stories) {
          tags.addAll(story.tags);
        }

        final lanes = tags.map((tag) {
          final stories = widget.stories
              .where((s) => s.tags.contains(tag))
              .toList();
          return _SwimlaneData(
            id: tag,
            name: tag,
            icon: Icons.label,
            color: Colors.purple,
            stories: stories,
          );
        }).toList();

        // Add untagged
        final untagged = widget.stories
            .where((s) => s.tags.isEmpty)
            .toList();
        if (untagged.isNotEmpty) {
          lanes.add(_SwimlaneData(
            id: '_untagged',
            name: AppLocalizations.of(context).agileNoTags,
            icon: Icons.label_off,
            color: Colors.grey,
            stories: untagged,
          ));
        }

        return lanes;
    }
  }

  Widget _buildWipInfoBanner() {
    final hasViolations = widget.columns.any((col) {
      final count = (_storiesByColumn[col.id] ?? []).length;
      return col.isWipExceeded(count);
    });

    if (!hasViolations) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber, color: Colors.red, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppLocalizations.of(context).kanbanWipExceededBanner,
              style: TextStyle(
                color: Colors.red[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _showWipExplanationDialog(),
            child: const Text('Info'),
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(
    KanbanColumnConfig column,
    List<UserStoryModel> stories,
    double width,
  ) {
    final totalPoints = stories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
    final isWipExceeded = column.isWipExceeded(stories.length);
    final isWipAtLimit = column.isWipAtLimit(stories.length);
    final primaryStatus = column.statuses.isNotEmpty
        ? column.statuses.first
        : StoryStatus.backlog;

    return DragTarget<UserStoryModel>(
      onWillAcceptWithDetails: (details) {
        if (!widget.canEdit) return false;
        // Non accettare se non è un cambio di stato
        if (column.statuses.contains(details.data.status)) return false;
        return true;
      },
      onAcceptWithDetails: (details) {
        final l10n = AppLocalizations.of(context);
        final story = details.data;
        final targetStatus = primaryStatus;
        final currentCount = stories.length;
        final wouldExceedWip = column.wouldExceedWip(currentCount) && _features.hasWipLimits;

        // 1. Validazione Policy
        final policyService = KanbanPolicyService(l10n);
        final violations = policyService.validateMove(
          story,
          column,
          stories, // stories in the target column
        );

        if (violations.isNotEmpty) {
          _showPolicyViolationDialog(
            story,
            column,
            violations.map((v) => v.message).toList(),
            () {
              // Procedi comunque (Logica originale di spostamento)
              if (wouldExceedWip) {
                _showWipLimitWarningDialog(column, story, targetStatus, currentCount);
              } else {
                widget.onStatusChange?.call(story.id, targetStatus);
              }
            }
          );
          return;
        }

        // 2. Logica Originale (se no violations)
        if (wouldExceedWip) {
          _showWipLimitWarningDialog(column, story, targetStatus, currentCount);
        } else {
          widget.onStatusChange?.call(story.id, targetStatus);
        }
      },
      builder: (context, candidateData, rejectedData) {
        final isHighlighted = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: isHighlighted
                ? primaryStatus.color.withValues(alpha: 0.1)
                : isWipExceeded
                    ? Colors.red.withValues(alpha: 0.05)
                    : context.surfaceVariantColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHighlighted
                  ? primaryStatus.color
                  : isWipExceeded
                      ? Colors.red
                      : context.borderColor,
              width: isHighlighted || isWipExceeded ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              // Header con WIP
              _buildColumnHeader(column, stories.length, primaryStatus, isWipExceeded, isWipAtLimit),

              // Stats
              _buildColumnStats(stories, totalPoints),

              const Divider(height: 1),

              // Cards
              Expanded(
                child: stories.isEmpty
                    ? _buildEmptyColumn()
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: stories.length,
                        itemBuilder: (context, index) =>
                      _buildKanbanCard(stories[index], column, stories),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColumnHeader(
    KanbanColumnConfig column,
    int itemCount,
    StoryStatus primaryStatus,
    bool isWipExceeded,
    bool isWipAtLimit,
  ) {
    final l10n = AppLocalizations.of(context);
    final hasWipLimit = column.wipLimit != null && _features.hasWipLimits;
    final hasPolicies = column.hasPolicies && widget.showPolicies;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isWipExceeded
            ? Colors.red.withValues(alpha: 0.15)
            : primaryStatus.color.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(11),
          topRight: Radius.circular(11),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                primaryStatus.icon,
                size: 18,
                color: isWipExceeded ? Colors.red : primaryStatus.color,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  column.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isWipExceeded ? Colors.red : primaryStatus.color,
                  ),
                ),
              ),
              // Policy indicator
              if (hasPolicies)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _buildPolicyIndicator(column, primaryStatus),
                ),
              // WIP Counter
              _buildWipCounter(column, itemCount, isWipExceeded, isWipAtLimit),
            ],
          ),
          // WIP Config button (if enabled)
          if (hasWipLimit && widget.showWipConfig && widget.onWipLimitChange != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: InkWell(
                onTap: () => _showWipConfigDialog(column),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, size: 12, color: context.textSecondaryColor),
                    const SizedBox(width: 4),
                    Text(
                      l10n.kanbanConfigWip,
                      style: TextStyle(fontSize: 10, color: context.textSecondaryColor),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Indicatore policy con tooltip che mostra le policy della colonna
  /// Indicatore policy con tooltip che mostra le policy ATTIVE della colonna
  Widget _buildPolicyIndicator(KanbanColumnConfig column, StoryStatus primaryStatus) {
    // Conta le policy attive (valore true)
    final activeCount = column.activePolicies?.values.where((v) => v).length ?? 0;
    
    // Se non ci sono policy attive, non mostrare nulla o mostra 0
    // Meglio nascondere se 0 per pulizia? O mostrare grigio?
    // Mostriamo sempre per permettere il click per aprire il dialog
    
    final l10n = AppLocalizations.of(context);
    
    // Costruisci il testo del tooltip basato sulle policy attive
    final List<String> tooltipLines = [];
    if (column.activePolicies != null) {
      column.activePolicies!.forEach((key, isActive) {
        if (isActive) {
           // Cerchiamo l'etichetta localizzata corretta
           String label = key;
           if (key == 'kanbanPolicyReqAcceptance') label = l10n.kanbanPolicyReqAcceptance;
           else if (key == 'kanbanPolicyEstimationsDone') label = l10n.kanbanPolicyEstimationsDone;
           else if (key == 'kanbanPolicyMax1PerPerson') label = l10n.kanbanPolicyMax1PerPerson;
           else if (key == 'kanbanPolicyAllAcceptanceMet') label = l10n.kanbanPolicyAllAcceptanceMet;
           else if (key == 'kanbanPolicyMax2Days') label = l10n.kanbanPolicyMax2Days;
           else if (key == 'kanbanPolicyMax24h') label = l10n.kanbanPolicyMax24h;
           
           tooltipLines.add('• $label');
        }
      });
    }
    
    final tooltipText = tooltipLines.join('\n');

    return Tooltip(
      message: '${l10n.kanbanPoliciesTitle(column.name)}\n$tooltipText',
      preferBelow: false,
      child: InkWell(
        onTap: widget.onPoliciesChange != null && widget.canEdit
            ? () => _showPoliciesDialog(column)
            : null,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: activeCount > 0 
                ? primaryStatus.color.withValues(alpha: 0.2)
                : Colors.transparent, // Meno invasivo se 0
            borderRadius: BorderRadius.circular(4),
            border: activeCount == 0 ? Border.all(color: context.borderColor) : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.policy_outlined,
                size: 14,
                color: activeCount > 0 ? primaryStatus.color : context.textSecondaryColor,
              ),
              const SizedBox(width: 2),
              Text(
                '$activeCount',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: activeCount > 0 ? primaryStatus.color : context.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dialog per modificare le policy di una colonna
  Future<void> _showPoliciesDialog(KanbanColumnConfig column) async {
    final l10n = AppLocalizations.of(context);
    // Legacy policies list is ignored/cleared in new version
    final activePolicies = Map<String, bool>.from(column.activePolicies ?? {});

    // Definizioni delle policy disponibili con descrizioni
    final allPolicies = [
      {'id': 'kanbanPolicyReqAcceptance', 'label': l10n.kanbanPolicyReqAcceptance},
      {'id': 'kanbanPolicyEstimationsDone', 'label': l10n.kanbanPolicyEstimationsDone},
      {'id': 'kanbanPolicyMax1PerPerson', 'label': l10n.kanbanPolicyMax1PerPerson},
      {'id': 'kanbanPolicyAllAcceptanceMet', 'label': l10n.kanbanPolicyAllAcceptanceMet},
      {'id': 'kanbanPolicyMax2Days', 'label': l10n.kanbanPolicyMax2Days},
      {'id': 'kanbanPolicyMax24h', 'label': l10n.kanbanPolicyMax24h},
    ];

    // Mappa delle policy pertinenti per ogni tipo di colonna
    // Usa l'ID della colonna per determinare quali policy mostrare
    List<String> validPolicyIds;
    final cid = column.id.toLowerCase();
    
    if (cid.contains('backlog') || cid.contains('todo')) {
      validPolicyIds = ['kanbanPolicyReqAcceptance', 'kanbanPolicyEstimationsDone'];
    } else if (cid.contains('ready') || cid.contains('refine')) {
      validPolicyIds = ['kanbanPolicyReqAcceptance', 'kanbanPolicyEstimationsDone', 'kanbanPolicyMax2Days'];
    } else if (cid.contains('progress') || cid.contains('doing')) {
      validPolicyIds = ['kanbanPolicyMax1PerPerson', 'kanbanPolicyMax2Days'];
    } else if (cid.contains('review') || cid.contains('verify') || cid.contains('testing')) {
      validPolicyIds = ['kanbanPolicyMax24h'];
    } else if (cid.contains('done') || cid.contains('completed')) {
      validPolicyIds = ['kanbanPolicyAllAcceptanceMet'];
    } else {
      // Fallback per colonne custom: mostra quelle generiche di tempo/limite
      validPolicyIds = ['kanbanPolicyMax1PerPerson', 'kanbanPolicyMax2Days', 'kanbanPolicyMax24h'];
    }

    final availablePolicies = allPolicies.where((p) => validPolicyIds.contains(p['id'])).toList();

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.policy, color: Theme.of(ctx).primaryColor),
              const SizedBox(width: 8),
              Text(l10n.kanbanPoliciesTitle(column.name)),
            ],
          ),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.kanbanPoliciesDesc,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  if (availablePolicies.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'Nessuna policy automatica disponibile per questa colonna.', // Fallback hardcoded if l10n missing for this specific string, or use existing generic
                          style: TextStyle(color: context.textSecondaryColor, fontStyle: FontStyle.italic),
                        ),
                      ),
                    )
                  else
                    ...availablePolicies.map((p) {
                      final id = p['id']!;
                      final label = p['label']!;
                      final isActive = activePolicies[id] ?? false;
                      
                      return CheckboxListTile(
                        title: Text(label, style: const TextStyle(fontSize: 13)),
                        value: isActive,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (val) {
                          setDialogState(() {
                            activePolicies[id] = val ?? false;
                          });
                        },
                      );
                    }),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                // Rimuoviamo le policy testuali legacy passando una lista vuota
                widget.onPoliciesChange?.call(column.id, []);
                widget.onActivePoliciesChange?.call(column.id, activePolicies);
                Navigator.pop(ctx);
              },
              child: Text(l10n.agileActionSave),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWipCounter(
    KanbanColumnConfig column,
    int itemCount,
    bool isWipExceeded,
    bool isWipAtLimit,
  ) {
    final l10n = AppLocalizations.of(context);
    final hasWipLimit = column.wipLimit != null && _features.hasWipLimits;

    Color bgColor;
    Color textColor;

    if (!hasWipLimit) {
      bgColor = context.surfaceColor;
      textColor = context.textSecondaryColor;
    } else if (isWipExceeded) {
      bgColor = Colors.red;
      textColor = Colors.white;
    } else if (isWipAtLimit) {
      bgColor = Colors.orange;
      textColor = Colors.white;
    } else {
      bgColor = Colors.green;
      textColor = Colors.white;
    }

    return Tooltip(
      message: hasWipLimit
          ? l10n.kanbanWipLimitOf(itemCount, column.wipLimit!)
          : l10n.kanbanNoWipLimit,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: hasWipLimit ? null : Border.all(color: context.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$itemCount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: 13,
              ),
            ),
            if (hasWipLimit) ...[
              Text(
                ' / ${column.wipLimit}',
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.8),
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildColumnStats(List<UserStoryModel> stories, int totalPoints) {
    final l10n = AppLocalizations.of(context);
    final features = FrameworkFeatures(widget.framework);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Story Points (solo se il framework li supporta)
          if (features.hasStoryPoints) ...[
            const Icon(Icons.stars, size: 12, color: Colors.green),
            const SizedBox(width: 4),
            Text(
              '$totalPoints pts',
              style: const TextStyle(fontSize: 11, color: Colors.green),
            ),
          ] else ...[
            // Per Kanban mostra conteggio
            Icon(Icons.assignment, size: 12, color: context.textSecondaryColor),
            const SizedBox(width: 4),
            Text(
              l10n.agileItemsCount(stories.length),
              style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyColumn() {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 32, color: context.textMutedColor),
          const SizedBox(height: 8),
          Text(
            l10n.kanbanEmpty,
            style: TextStyle(
              color: context.textMutedColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanCard(UserStoryModel story, KanbanColumnConfig column, List<UserStoryModel> columnStories) {
    final l10n = AppLocalizations.of(context);
    final sprint = widget.sprints.where((s) => s.id == story.sprintId).firstOrNull;
    final policyService = KanbanPolicyService(l10n);
    
    // Unified policy calculation for all states
    final timeViolation = policyService.checkTimePolicy(story, column);
    final logicViolations = policyService.validateMove(story, column, columnStories);
    
    final policyWarnings = [
      if (timeViolation != null) timeViolation.message,
      ...logicViolations.map((v) => v.message),
    ];

    return Draggable<UserStoryModel>(
      key: ValueKey('drag_${story.id}'),
      data: story,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 280,
          child: Opacity(
            opacity: 0.9,
               child: StoryCardWidget(
                  key: ValueKey('feedback_${story.id}'),
                  story: story,
                  sprintName: sprint?.name,
                  isSprintCompleted: sprint?.status == SprintStatus.completed,
                  teamMembers: widget.teamMembers,
                  policyWarnings: policyWarnings,
                  onDelete: widget.onStoryDelete != null ? () => widget.onStoryDelete!(story.id) : null,
                  framework: widget.framework,
                  isBoardContext: true,
                  canMarkAsReady: widget.canMarkAsReady,
                  compactMode: true,
                ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: StoryCardWidget(
          key: ValueKey('dragging_${story.id}'),
          story: story,
          sprintName: sprint?.name,
          isSprintCompleted: sprint?.status == SprintStatus.completed,
          teamMembers: widget.teamMembers,
          policyWarnings: policyWarnings,
          onDelete: widget.onStoryDelete != null ? () => widget.onStoryDelete!(story.id) : null,
          framework: widget.framework,
          isBoardContext: true,
          canMarkAsReady: widget.canMarkAsReady,
          compactMode: true,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: StoryCardWidget(
          key: ValueKey(story.id),
          story: story,
          sprintName: sprint?.name,
          isSprintCompleted: sprint?.status == SprintStatus.completed,
          teamMembers: widget.teamMembers,
          policyWarnings: policyWarnings,
          onTap: widget.onStoryTap != null ? () => widget.onStoryTap!(story) : null,
          framework: widget.framework,
          canMoveToBacklog: widget.canMoveToBacklog,
          isBoardContext: true,
          canMarkAsReady: widget.canMarkAsReady,
          onStatusChange: widget.onStatusChange != null 
              ? (status) => widget.onStatusChange!(story.id, status) 
              : null,
          onPriorityChange: widget.onPriorityChange != null 
              ? (priority) => widget.onPriorityChange!(story.id, priority) 
              : null,
          onTitleChange: widget.onTitleChange != null 
              ? (title) => widget.onTitleChange!(story.id, title) 
              : null,
          onStoryPointsChange: widget.onStoryPointsChange != null
              ? (points) => widget.onStoryPointsChange!(story, points)
              : null,
          onAssigneeChange: widget.onAssigneeChange != null
              ? (email) => widget.onAssigneeChange!(story, email)
              : null,
          onDelete: widget.onStoryDelete != null ? () => widget.onStoryDelete!(story.id) : null,
          compactMode: true,
        ),
      ),
    );
  }


  void _showWipConfigDialog(KanbanColumnConfig column) {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController(
      text: column.wipLimit?.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.tune, color: Colors.blue),
            const SizedBox(width: 8),
            Text('${l10n.kanbanConfigWip}: ${column.name}'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.kanbanWipLimitDesc,
              style: TextStyle(color: context.textMutedColor),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.kanbanConfigWip,
                hintText: l10n.kanbanNoWipLimit,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.numbers),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.kanbanWipLimitSuggestion((column.statuses.length * 2).clamp(2, 5)),
              style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              widget.onWipLimitChange?.call(column.id, null);
              Navigator.pop(context);
            },
            child: Text(l10n.kanbanRemoveLimit),
          ),
          ElevatedButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              widget.onWipLimitChange?.call(column.id, value);
              Navigator.pop(context);
            },
            child: Text(l10n.agileActionSave),
          ),
        ],
      ),
    );
  }

  /// Dialog di conferma quando si supera il WIP limit
  void _showWipLimitWarningDialog(
    KanbanColumnConfig column,
    UserStoryModel story,
    StoryStatus targetStatus,
    int currentCount,
  ) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.warning_amber, color: Colors.orange, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.kanbanWipExceededTitle,
                style: TextStyle(color: Colors.orange[800]),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: context.textPrimaryColor, fontSize: 14),
                children: [
                  TextSpan(text: l10n.kanbanWipExceededMessage),
                  TextSpan(
                    text: '"${story.title}"',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: l10n.kanbanWipExceededIn),
                  TextSpan(
                    text: column.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: l10n.kanbanWipExceededWillExceed),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.kanbanColumnLabel(column.name),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Attuale: $currentCount | Limite: ${column.wipLimit}',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textSecondaryColor,
                          ),
                        ),
                        Text(
                          'Dopo lo spostamento: ${currentCount + 1}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.kanbanWipMovingTip,
              style: TextStyle(
                fontSize: 12,
                color: context.textSecondaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              // Procedi comunque con lo spostamento
              widget.onStatusChange?.call(story.id, targetStatus);
            },
            child: Text(l10n.kanbanMoveAnyway),
          ),
        ],
      ),
    );
  }

  void _showWipExplanationDialog() {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blue),
            const SizedBox(width: 8),
            Text(l10n.kanbanConfigWip),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.kanbanWipExplanationTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(l10n.kanbanWipExplanationDesc),
              Text(
                l10n.kanbanWipWhyTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('- ${l10n.kanbanWipReasonFocus}'),
              Text('- ${l10n.kanbanWipReasonBottlenecks}'),
              Text('- ${l10n.kanbanWipReasonFlow}'),
              Text('- ${l10n.kanbanWipReasonSpeed}'),
              const SizedBox(height: 16),
              Text(
                l10n.kanbanWipOverLimitTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${l10n.kanbanWipOverLimitStep1}\n'
                '${l10n.kanbanWipOverLimitStep2}\n'
                '${l10n.kanbanWipOverLimitStep3}',
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.kanbanUnderstand),
          ),
        ],
      ),
    );
  }

  void _showPolicyViolationDialog(
    UserStoryModel story,
    KanbanColumnConfig column,
    List<String> violations,
    VoidCallback onProceedAnyway,
  ) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.policy_outlined, color: Colors.red, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.kanbanPolicyViolationTitle,
                style: TextStyle(color: Colors.red[800]),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: context.textPrimaryColor, fontSize: 14),
                children: [
                  TextSpan(text: l10n.kanbanPolicyViolationMessage),
                  TextSpan(
                    text: '"${story.title}"',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: l10n.kanbanPolicyViolationTo),
                  TextSpan(
                    text: column.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: l10n.kanbanPolicyViolationViolations),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: violations.map((v) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          v,
                          style: const TextStyle(fontSize: 13, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.kanbanPolicyMovingTip,
              style: TextStyle(
                fontSize: 12,
                color: context.textSecondaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              onProceedAnyway();
            },
            child: Text(l10n.kanbanMoveAnyway),
          ),
        ],
      ),
    );
  }
}

/// Versione compatta del Kanban per dashboard
class KanbanSummaryWidget extends StatelessWidget {
  final List<UserStoryModel> stories;
  final List<KanbanColumnConfig>? columns;
  final AgileFramework framework;
  final VoidCallback? onTap;

  const KanbanSummaryWidget({
    super.key,
    required this.stories,
    this.columns,
    this.framework = AgileFramework.scrum,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final features = FrameworkFeatures(framework);
    final effectiveColumns = columns ?? features.getLocalizedDefaultKanbanColumns(l10n);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.view_kanban, color: features.primaryColor),
                  const SizedBox(width: 8),
                  const Text(
                    'Kanban Board',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  if (features.hasWipLimits)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'WIP',
                        style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: effectiveColumns.map((column) {
                  final count = stories.where((s) =>
                    column.statuses.contains(s.status)
                  ).length;
                  final primaryStatus = column.statuses.isNotEmpty
                      ? column.statuses.first
                      : StoryStatus.backlog;
                  final isExceeded = column.isWipExceeded(count);

                  return Expanded(
                    child: Tooltip(
                      message: column.wipLimit != null
                          ? '${column.name}: $count / ${column.wipLimit}'
                          : '${column.name}: $count',
                      child: Column(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isExceeded
                                  ? Colors.red.withValues(alpha: 0.2)
                                  : primaryStatus.color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: isExceeded
                                  ? Border.all(color: Colors.red, width: 2)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                '$count',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isExceeded ? Colors.red : primaryStatus.color,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getShortName(column.name),
                            style: TextStyle(
                              fontSize: 9,
                              color: isExceeded ? Colors.red : context.textSecondaryColor,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getShortName(String name) {
    if (name.length <= 8) return name;
    return name.substring(0, 7);
  }
}

/// Dati per una swimlane
class _SwimlaneData {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final List<UserStoryModel> stories;

  const _SwimlaneData({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.stories,
  });
}
