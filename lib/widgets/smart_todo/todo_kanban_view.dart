import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../l10n/app_localizations.dart';
import 'todo_task_card.dart';

class TodoKanbanView extends StatelessWidget {
  final TodoListModel list;
  final List<TodoTaskModel> tasks;
  final Function(TodoTaskModel) onTaskTap;
  final Function(TodoTaskModel, String, [TodoTaskModel?]) onTaskMoved; // task, newStatusId, insertBeforeTask
  final Function(TodoTaskModel) onTaskDelete;
  final Function(String, String) onColumnAction; // action, columnId
  final Function(String) onQuickAdd; 

  const TodoKanbanView({
    super.key,
    required this.list,
    required this.tasks,
    required this.onTaskTap,
    required this.onTaskMoved,
    required this.onTaskDelete,
    required this.onColumnAction,
    required this.onQuickAdd,
  });

  @override
  Widget build(BuildContext context) {
    // Note: Browser back gesture on macOS trackpad is prevented via CSS
    // overscroll-behavior-x: contain in index.html
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...list.columns.map((col) => _buildColumn(context, col)),
          _buildAddColumnButton(context),
        ],
      ),
    );
  }

  Widget _buildColumn(BuildContext context, TodoColumn col) {
    // Use theme context extensions
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final columnTasks = tasks.where((t) => t.statusId == col.id).toList();
    final color = Color(col.colorValue);
    // Background color: Light blue-grey in light mode, Dark surface variant in dark mode
    final bgColor = isDark 
        ? const Color(0xFF1E2633) // Darker variant of surface
        : const Color(0xFFF7F9FC);

    return DragTarget<TodoTaskModel>(
      onWillAccept: (task) => task != null && task.statusId != col.id,
      onAccept: (task) => onTaskMoved(task, col.id),
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        return Container(
          width: 320, // Slightly wider
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: isHovered ? color.withOpacity(0.1) : bgColor,
            borderRadius: BorderRadius.circular(16),
            border: isHovered 
              ? Border.all(color: color.withOpacity(0.5), width: 2) 
              : Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.transparent, width: 2),
            boxShadow: isDark && !isHovered ? [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))] : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Fill width
            children: [
              // Column Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 12),
                child: Row(
                  children: [
                    Container(
                      width: 12, 
                      height: 12, 
                      decoration: BoxDecoration(
                        color: color, 
                        borderRadius: BorderRadius.circular(4)
                      )
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
                        '${columnTasks.length}',
                        style: TextStyle(
                           fontSize: 12, 
                           fontWeight: FontWeight.bold, 
                           color: isDark ? color.withOpacity(0.9) : color
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_horiz, color: Colors.grey[600]),
                      onSelected: (val) => onColumnAction(val, col.id),
                      itemBuilder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return [
                          const PopupMenuItem(value: 'sort', child: Text('Ordinamento')),
                          PopupMenuItem(value: 'rename', child: Text(l10n.smartTodoRename)),
                          PopupMenuItem(value: 'delete', child: Text(l10n.actionDelete, style: const TextStyle(color: Colors.red))),
                        ];
                      },
                    ),
                  ],
                ),
              ),
              
              // Task List (Scrollable within column) - Flexible to prevent overflow
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.65, 
                  ),
                  child: Builder(
                    builder: (context) {
                      // 1. Sort Tasks Client-Side
                      final sortedTasks = List<TodoTaskModel>.from(columnTasks);
                      sortedTasks.sort((a, b) {
                        switch (col.sortBy) {
                          case TodoColumnSort.manual:
                            return a.position.compareTo(b.position);
                          case TodoColumnSort.priority:
                            // High (index 2) > Low (index 0). Descending.
                            return b.priority.index.compareTo(a.priority.index);
                          case TodoColumnSort.dueDate:
                            if (a.dueDate == null) return 1;
                            if (b.dueDate == null) return -1;
                            return a.dueDate!.compareTo(b.dueDate!);
                          case TodoColumnSort.createdAt:
                            return b.createdAt.compareTo(a.createdAt);
                        }
                      });

                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: sortedTasks.length,
                        itemBuilder: (context, index) {
                          final task = sortedTasks[index];
                          
                          return DragTarget<TodoTaskModel>(
                            onWillAccept: (draggedTask) => draggedTask != null && draggedTask.id != task.id,
                            onAccept: (draggedTask) {
                               // Dropped on 'task'. Insert 'draggedTask' BEFORE 'task'.
                               onTaskMoved(draggedTask, col.id, task);
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
                  final l10n = AppLocalizations.of(context)!;
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextButton.icon(
                       onPressed: () => onQuickAdd(col.id),
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

  Widget _buildAddColumnButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () => onColumnAction('add', ''), // Empty ID for add
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
    return Draggable<TodoTaskModel>(
      data: task,
      feedback: SizedBox(
        width: 320,
        child: Opacity(
          opacity: 0.9,
          child: Transform.scale(
            scale: 1.05,
            child: TodoTaskCard(task: task, list: list),
          ),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: TodoTaskCard(task: task)),
      child: TodoTaskCard(
        task: task,
        list: list,
        isCompleted: col.isDone,
        onTap: () => onTaskTap(task),
        onDelete: onTaskDelete,
      ),
    );
  }
}
