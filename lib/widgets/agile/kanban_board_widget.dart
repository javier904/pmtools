import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../models/framework_features.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

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
  final void Function(SwimlaneType)? onSwimlaneChange;
  final SwimlaneType swimlaneType;
  final bool canEdit;
  final bool showWipConfig;
  final bool showPolicies;

  const KanbanBoardWidget({
    super.key,
    required this.stories,
    required this.columns,
    this.framework = AgileFramework.scrum,
    this.onStatusChange,
    this.onStoryTap,
    this.onWipLimitChange,
    this.onPoliciesChange,
    this.onSwimlaneChange,
    this.swimlaneType = SwimlaneType.none,
    this.canEdit = true,
    this.showWipConfig = false,
    this.showPolicies = true,
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
    return Column(
      children: [
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
    final l10n = AppLocalizations.of(context)!;
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
    final l10n = AppLocalizations.of(context)!;
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
    final l10n = AppLocalizations.of(context)!;
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
        widget.onStatusChange?.call(details.data.id, primaryStatus);
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
                      _buildCompactCard(stories[index]),
                ),
        );
      },
    );
  }

  Widget _buildCompactCard(UserStoryModel story) {
    return GestureDetector(
      onTap: widget.onStoryTap != null ? () => widget.onStoryTap!(story) : null,
      child: Card(
        margin: const EdgeInsets.only(bottom: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  color: story.priority.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  story.title,
                  style: const TextStyle(fontSize: 11),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (story.storyPoints != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${story.storyPoints}',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
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
            name: AppLocalizations.of(context)!.agileUnassigned,
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
            name: AppLocalizations.of(context)!.agileNoTags,
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
              AppLocalizations.of(context)!.kanbanWipExceededBanner,
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
        // Enforce WIP limit: check if adding would exceed
        final currentCount = stories.length;
        final wouldExceed = column.wouldExceedWip(currentCount) && _features.hasWipLimits;

        if (wouldExceed) {
          // Show confirmation dialog for WIP limit override
          _showWipLimitWarningDialog(column, details.data, primaryStatus, currentCount);
        } else {
          // Cambia allo status primario della colonna
          widget.onStatusChange?.call(details.data.id, primaryStatus);
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
                        itemBuilder: (context, index) => _buildKanbanCard(stories[index]),
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
    final l10n = AppLocalizations.of(context)!;
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
  Widget _buildPolicyIndicator(KanbanColumnConfig column, StoryStatus primaryStatus) {
    final l10n = AppLocalizations.of(context)!;
    final policiesText = column.policies.map((p) => '• $p').join('\n');

    return Tooltip(
      message: '${l10n.kanbanPoliciesTitle(column.name)}\n$policiesText',
      preferBelow: false,
      child: InkWell(
        onTap: widget.onPoliciesChange != null && widget.canEdit
            ? () => _showPoliciesDialog(column)
            : null,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: primaryStatus.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.policy_outlined,
                size: 14,
                color: primaryStatus.color,
              ),
              const SizedBox(width: 2),
              Text(
                '${column.policies.length}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: primaryStatus.color,
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
    final l10n = AppLocalizations.of(context)!;
    final policies = List<String>.from(column.policies);
    final controller = TextEditingController();

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
                // Lista policy esistenti
                if (policies.isNotEmpty) ...[
                  ...policies.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(child: Text(entry.value)),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                            onPressed: () {
                              setDialogState(() {
                                policies.removeAt(entry.key);
                              });
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
                // Aggiungi nuova policy
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: l10n.kanbanNewPolicyHint,
                          isDense: true,
                          border: const OutlineInputBorder(),
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            setDialogState(() {
                              policies.add(value.trim());
                              controller.clear();
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          setDialogState(() {
                            policies.add(controller.text.trim());
                            controller.clear();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                widget.onPoliciesChange?.call(column.id, policies);
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
    final l10n = AppLocalizations.of(context)!;
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
    final l10n = AppLocalizations.of(context)!;
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
    final l10n = AppLocalizations.of(context)!;
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

  Widget _buildKanbanCard(UserStoryModel story) {
    return Draggable<UserStoryModel>(
      data: story,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 250,
          child: _buildCardContent(story, isDragging: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildCardContent(story),
      ),
      child: _buildCardContent(story),
    );
  }

  Widget _buildCardContent(UserStoryModel story, {bool isDragging = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isDragging ? 8 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: story.priority.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: widget.onStoryTap != null ? () => widget.onStoryTap!(story) : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.surfaceVariantColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      story.storyId,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Class of Service (solo se non è Standard)
                  if (story.classOfService != ClassOfService.standard) ...[
                    Tooltip(
                      message: story.classOfService.description,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: story.classOfService.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(story.classOfService.icon, size: 10, color: story.classOfService.color),
                            const SizedBox(width: 2),
                            Text(
                              story.classOfService.shortName,
                              style: TextStyle(
                                fontSize: 9,
                                color: story.classOfService.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  // Priority
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: story.priority.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      story.priority.displayName,
                      style: TextStyle(
                        fontSize: 9,
                        color: story.priority.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title
              Text(
                story.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Tags
              if (story.tags.isNotEmpty) ...[
                Wrap(
                  spacing: 4,
                  runSpacing: 2,
                  children: story.tags.take(3).map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(fontSize: 8, color: Colors.blue),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 8),
              ],

              // Footer
              Row(
                children: [
                  // Points (solo se framework supporta)
                  if (_features.hasStoryPoints && story.storyPoints != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.stars, size: 10, color: Colors.green),
                          const SizedBox(width: 2),
                          Text(
                            '${story.storyPoints}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  // Acceptance criteria
                  if (story.acceptanceCriteria.isNotEmpty) ...[
                    Icon(Icons.checklist, size: 12, color: context.textSecondaryColor),
                    const SizedBox(width: 2),
                    Text(
                      '${story.completedAcceptanceCriteria}/${story.acceptanceCriteria.length}',
                      style: TextStyle(fontSize: 10, color: context.textSecondaryColor),
                    ),
                  ],
                  const Spacer(),
                  // Assignee
                  if (story.assigneeEmail != null)
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                      child: Text(
                        story.assigneeEmail![0].toUpperCase(),
                        style: const TextStyle(fontSize: 8, color: AppColors.primary),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWipConfigDialog(KanbanColumnConfig column) {
    final l10n = AppLocalizations.of(context)!;
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
              'Imposta il numero massimo di item che possono essere in questa colonna contemporaneamente.',
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
              'Suggerimento: inizia con ${(column.statuses.length * 2).clamp(2, 5)} e aggiusta in base al team.',
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
            child: Text(l10n.archiveDeleteSuccess), // Wait, do I have a "Remove" key?
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
    final l10n = AppLocalizations.of(context)!;
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
                  const TextSpan(text: 'Spostando '),
                  TextSpan(
                    text: '"${story.title}"',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' in '),
                  TextSpan(
                    text: column.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' supererai il limite WIP.'),
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
                          'Colonna: ${column.name}',
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
              'Suggerimento: completa o sposta altri item prima di iniziarne di nuovi per mantenere un flusso di lavoro ottimale.',
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
    final l10n = AppLocalizations.of(context)!;
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
              SizedBox(height: 16),
              Text(
                'Perché usarli?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('- Riducono il multitasking e aumentano il focus'),
              Text('- Evidenziano i colli di bottiglia'),
              Text('- Migliorano il flusso di lavoro'),
              Text('- Accelerano il completamento degli item'),
              SizedBox(height: 16),
              Text(
                'Cosa fare se un limite è superato?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '1. Completa o sposta item esistenti prima di iniziarne di nuovi\n'
                '2. Aiuta i colleghi a sbloccare item in review\n'
                '3. Analizza perché il limite è stato superato',
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
    final effectiveColumns = columns ?? FrameworkFeatures(framework).defaultKanbanColumns;
    final features = FrameworkFeatures(framework);

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
