import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../models/framework_features.dart';

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
  final bool canEdit;
  final bool showWipConfig;

  const KanbanBoardWidget({
    super.key,
    required this.stories,
    required this.columns,
    this.framework = AgileFramework.scrum,
    this.onStatusChange,
    this.onStoryTap,
    this.onWipLimitChange,
    this.canEdit = true,
    this.showWipConfig = false,
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

        // Board
        Expanded(
          child: LayoutBuilder(
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
          ),
        ),
      ],
    );
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
              'WIP Limit superato! Completa alcuni item prima di iniziarne di nuovi.',
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
        // Warn ma permetti se WIP exceeded
        return true;
      },
      onAcceptWithDetails: (details) {
        // Cambia allo status primario della colonna
        widget.onStatusChange?.call(details.data.id, primaryStatus);
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
                    : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHighlighted
                  ? primaryStatus.color
                  : isWipExceeded
                      ? Colors.red
                      : Colors.grey[300]!,
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
    final hasWipLimit = column.wipLimit != null && _features.hasWipLimits;

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
                    Icon(Icons.settings, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      'Configura WIP',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWipCounter(
    KanbanColumnConfig column,
    int itemCount,
    bool isWipExceeded,
    bool isWipAtLimit,
  ) {
    final hasWipLimit = column.wipLimit != null && _features.hasWipLimits;

    Color bgColor;
    Color textColor;

    if (!hasWipLimit) {
      bgColor = Colors.white;
      textColor = Colors.grey[700]!;
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
          ? 'WIP: $itemCount di ${column.wipLimit} max'
          : 'Nessun limite WIP',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: hasWipLimit ? null : Border.all(color: Colors.grey[300]!),
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
            Icon(Icons.assignment, size: 12, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              '${stories.length} items',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyColumn() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 32, color: Colors.grey[300]),
          const SizedBox(height: 8),
          Text(
            'Vuoto',
            style: TextStyle(
              color: Colors.grey[400],
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
                      color: Colors.grey[200],
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
                    Icon(Icons.checklist, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 2),
                    Text(
                      '${story.completedAcceptanceCriteria}/${story.acceptanceCriteria.length}',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                  const Spacer(),
                  // Assignee
                  if (story.assigneeEmail != null)
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.purple.withValues(alpha: 0.2),
                      child: Text(
                        story.assigneeEmail![0].toUpperCase(),
                        style: const TextStyle(fontSize: 8, color: Colors.purple),
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
            Text('WIP Limit: ${column.name}'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Imposta il numero massimo di item che possono essere in questa colonna contemporaneamente.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'WIP Limit',
                hintText: 'Lascia vuoto per nessun limite',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Suggerimento: inizia con ${(column.statuses.length * 2).clamp(2, 5)} e aggiusta in base al team.',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              widget.onWipLimitChange?.call(column.id, null);
              Navigator.pop(context);
            },
            child: const Text('Rimuovi Limite'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              widget.onWipLimitChange?.call(column.id, value);
              Navigator.pop(context);
            },
            child: const Text('Salva'),
          ),
        ],
      ),
    );
  }

  void _showWipExplanationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            SizedBox(width: 8),
            Text('WIP Limits'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Cosa sono i WIP Limits?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'WIP (Work In Progress) Limits sono limiti sul numero di item che possono '
                'essere in una colonna contemporaneamente.',
              ),
              SizedBox(height: 16),
              Text(
                'Perché usarli?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Riducono il multitasking e aumentano il focus'),
              Text('• Evidenziano i colli di bottiglia'),
              Text('• Migliorano il flusso di lavoro'),
              Text('• Accelerano il completamento degli item'),
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
            child: const Text('Ho capito'),
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
                              color: isExceeded ? Colors.red : Colors.grey[600],
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
