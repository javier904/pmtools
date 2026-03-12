import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../l10n/app_localizations.dart';
import 'todo_task_card.dart';

class TodoKanbanView extends StatefulWidget {
  final TodoListModel list;
  final List<TodoTaskModel> tasks;
  final Function(TodoTaskModel) onTaskTap;
  final Function(TodoTaskModel, String, [TodoTaskModel?]) onTaskMoved; // task, newStatusId, insertBeforeTask
  final Function(TodoTaskModel) onTaskDelete;
  final Function(String, String) onColumnAction; // action, columnId
  final Function(String) onQuickAdd;
  final Function(String, String)? onQuickAddInline; // columnId, title
  final Function(int, int)? onColumnReorder; // oldIndex, newIndex

  const TodoKanbanView({
    super.key,
    required this.list,
    required this.tasks,
    required this.onTaskTap,
    required this.onTaskMoved,
    required this.onTaskDelete,
    required this.onColumnAction,
    required this.onQuickAdd,
    this.onQuickAddInline,
    this.onColumnReorder,
  });

  @override
  State<TodoKanbanView> createState() => _TodoKanbanViewState();
}

class _TodoKanbanViewState extends State<TodoKanbanView> {
  String? _quickAddColumnId;
  final TextEditingController _quickAddController = TextEditingController();
  final FocusNode _quickAddFocus = FocusNode();

  @override
  void dispose() {
    _quickAddController.dispose();
    _quickAddFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Note: Browser back gesture on macOS trackpad is prevented via CSS
    // overscroll-behavior-x: contain in index.html
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 22), // Subtract padding
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < widget.list.columns.length; i++)
                  _buildReorderableColumn(context, widget.list.columns[i], i),
                Column(
                  children: [
                    _buildAddColumnButton(context),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  /// Wraps a column in a DragTarget so other columns can be dropped on it
  Widget _buildReorderableColumn(BuildContext context, TodoColumn col, int index) {
    if (widget.onColumnReorder == null) {
      return _buildColumn(context, col);
    }
    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => details.data != index,
      onAcceptWithDetails: (details) {
        widget.onColumnReorder!(details.data, index);
      },
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Insertion indicator (left side)
            if (isHovered)
              Container(
                width: 4,
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            _buildColumn(context, col, columnIndex: index),
          ],
        );
      },
    );
  }

  Widget _buildColumn(BuildContext context, TodoColumn col, {int? columnIndex}) {
    // Use theme context extensions
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final columnTasks = widget.tasks.where((t) => t.statusId == col.id).toList();
    final color = Color(col.colorValue);
    // Background color: Light blue-grey in light mode, Dark surface variant in dark mode
    final bgColor = isDark 
        ? const Color(0xFF1E2633) // Darker variant of surface
        : const Color(0xFFF7F9FC);

    return DragTarget<TodoTaskModel>(
      onWillAccept: (task) => task != null && task.statusId != col.id,
      onAccept: (task) => widget.onTaskMoved(task, col.id),
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        final screenWidth = MediaQuery.of(context).size.width;
        final columnWidth = screenWidth < 600 ? screenWidth - 48 : 320.0;

        return Container(
          width: columnWidth,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: isHovered ? color.withOpacity(0.1) : bgColor,
            borderRadius: BorderRadius.circular(16),
            border: isHovered 
              ? Border.all(color: color.withOpacity(0.5), width: 2) 
              : Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02), width: 1),
            boxShadow: isDark && !isHovered ? [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))] : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Fill width
            children: [
              // Column Header — draggable for reorder
              _buildColumnHeader(context, col, color, isDark, columnTasks.length, columnIndex: columnIndex),
              
              // Task List (Scrollable within column) - Expanded to fill vertical space
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Builder(
                    builder: (context) {
                      // 1. Sort Tasks Client-Side (stable: tiebreaker by ID)
                      final sortedTasks = List<TodoTaskModel>.from(columnTasks);
                      sortedTasks.sort((a, b) {
                        int cmp;
                        switch (col.sortBy) {
                          case TodoColumnSort.manual:
                            cmp = a.position.compareTo(b.position);
                          case TodoColumnSort.priority:
                            cmp = b.priority.index.compareTo(a.priority.index);
                          case TodoColumnSort.dueDate:
                            if (a.dueDate == null && b.dueDate == null) { cmp = 0; break; }
                            if (a.dueDate == null) return 1;
                            if (b.dueDate == null) return -1;
                            cmp = a.dueDate!.compareTo(b.dueDate!);
                          case TodoColumnSort.createdAt:
                            cmp = b.createdAt.compareTo(a.createdAt);
                        }
                        return cmp != 0 ? cmp : a.id.compareTo(b.id);
                      });

                      return ListView.builder(
                        shrinkWrap: false,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: sortedTasks.length,
                        itemBuilder: (context, index) {
                          final task = sortedTasks[index];
                          
                          return KeyedSubtree(
                            key: ValueKey(task.id),
                            child: DragTarget<TodoTaskModel>(
                              onWillAccept: (draggedTask) => draggedTask != null && draggedTask.id != task.id,
                              onAccept: (draggedTask) {
                                 // Dropped on 'task'. Insert 'draggedTask' BEFORE 'task'.
                                 widget.onTaskMoved(draggedTask, col.id, task);
                              },
                              builder: (context, candidateData, rejectedData) {
                                // Visual feedback for insertion point?
                                final isHovered = candidateData.isNotEmpty;
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isHovered) 
                                      Container(height: 4, margin: const EdgeInsets.symmetric(vertical: 4), color: Colors.blue, width: 100),
                                    _buildDraggableCard(task, col, null), 
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                  ),
                ),
              ),
              
              // Add Button (Footer)
              Builder(
                builder: (context) {
                  final l10n = AppLocalizations.of(context);
                  
                  if (_quickAddColumnId == col.id) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2D3748) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.withOpacity(0.5), width: 1.5),
                        ),
                        child: TextField(
                          controller: _quickAddController,
                          focusNode: _quickAddFocus,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).smartTodoAddActivity, 
                            hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          style: TextStyle(fontSize: 14, color: isDark ? Colors.white : Colors.black87),
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty && widget.onQuickAddInline != null) {
                              widget.onQuickAddInline!(col.id, value.trim());
                            }
                            setState(() {
                              _quickAddColumnId = null;
                              _quickAddController.clear();
                            });
                          },
                          onTapOutside: (_) {
                            setState(() {
                              _quickAddColumnId = null;
                              _quickAddController.clear();
                            });
                          },
                        ),
                      ),
                    );
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextButton.icon(
                       onPressed: () {
                         setState(() {
                           _quickAddColumnId = col.id;
                           _quickAddController.clear();
                         });
                         Future.delayed(const Duration(milliseconds: 50), () {
                           _quickAddFocus.requestFocus();
                         });
                       },
                       icon: const Icon(Icons.add_rounded, size: 20),
                       label: Text(l10n.smartTodoAddActivity),
                       style: TextButton.styleFrom(
                         foregroundColor: Colors.grey[600],
                         alignment: Alignment.centerLeft,
                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                         backgroundColor: Colors.transparent, // Ghost button
                       ).copyWith(
                         overlayColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.1)),
                       ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds the column header, optionally wrapped in LongPressDraggable for reordering
  Widget _buildColumnHeader(BuildContext context, TodoColumn col, Color color, bool isDark, int taskCount, {int? columnIndex}) {
    final headerContent = Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 8, 10),
      child: Row(
        children: [
          // Drag handle (only when reorder is enabled)
          if (widget.onColumnReorder != null) ...[
            Icon(Icons.drag_indicator, size: 18, color: Colors.grey[500]),
            const SizedBox(width: 4),
          ],
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              col.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: isDark ? Colors.white : const Color(0xFF2D3748),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
              ],
              border: isDark ? Border.all(color: Colors.white.withOpacity(0.1)) : null,
            ),
            child: Text(
              '$taskCount',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? color.withOpacity(0.9) : color,
              ),
            ),
          ),
          const SizedBox(width: 4),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz, color: Colors.grey[600]),
            onSelected: (val) => widget.onColumnAction(val, col.id),
            itemBuilder: (context) {
              final l10n = AppLocalizations.of(context);
              return [
                const PopupMenuItem(value: 'sort', child: Text('Ordinamento')),
                PopupMenuItem(value: 'rename', child: Text(l10n.smartTodoRename)),
                PopupMenuItem(value: 'delete', child: Text(l10n.actionDelete, style: const TextStyle(color: Colors.red))),
              ];
            },
          ),
        ],
      ),
    );

    // Wrap in LongPressDraggable when reorder is enabled
    if (widget.onColumnReorder != null && columnIndex != null) {
      final screenWidth = MediaQuery.of(context).size.width;
      final feedbackWidth = screenWidth < 600 ? screenWidth - 48 : 320.0;
      return LongPressDraggable<int>(
        data: columnIndex,
        axis: Axis.horizontal,
        feedback: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: feedbackWidth,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D3748) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color, width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.drag_indicator, size: 18, color: Colors.grey[500]),
                const SizedBox(width: 8),
                Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(col.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: isDark ? Colors.white : const Color(0xFF2D3748))),
                ),
                const SizedBox(width: 8),
                Text('$taskCount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              ],
            ),
          ),
        ),
        childWhenDragging: Opacity(opacity: 0.3, child: headerContent),
        child: headerContent,
      );
    }

    return headerContent;
  }

  Widget _buildAddColumnButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    return InkWell(
      onTap: () => widget.onColumnAction('add', ''), // Empty ID for add
      child: Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D3748) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[300]!),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: isDark ? Colors.grey[400] : Colors.grey),
              const SizedBox(width: 8),
              Text(l10n.smartTodoAddColumn, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDraggableCard(TodoTaskModel task, TodoColumn col, Function(TodoTaskModel, String, double?)? onDrop) {
    final screenWidth = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    final feedbackWidth = screenWidth < 600 ? screenWidth - 48 : 320.0;
    return Draggable<TodoTaskModel>(
      data: task,
      feedback: SizedBox(
        width: feedbackWidth,
        child: Opacity(
          opacity: 0.9,
          child: Transform.rotate(
            angle: 0.05, // Slight tilt
            child: Transform.scale(
              scale: 1.05,
              child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(0.2),
                       blurRadius: 12,
                       offset: const Offset(0, 6),
                     ),
                   ],
                 ),
                 child: TodoTaskCard(task: task, list: widget.list),
              ),
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: TodoTaskCard(task: task)),
      child: TodoTaskCard(
        task: task,
        list: widget.list,
        isCompleted: col.isDone,
        onTap: () => widget.onTaskTap(task),
        onDelete: widget.onTaskDelete,
      ),
    );
  }
}
