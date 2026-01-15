import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import 'todo_task_row.dart'; // Import the new row widget

class TodoListView extends StatelessWidget {
  final List<TodoTaskModel> tasks;
  final List<TodoColumn> columns;
  final Function(TodoTaskModel) onTaskTap;
  final Function(TodoTaskModel, String)? onTaskMoved; 
  final Function(TodoTaskModel) onTaskDelete;

  const TodoListView({
    super.key,
    required this.tasks,
    required this.columns,
    required this.onTaskTap,
    this.onTaskMoved,
    required this.onTaskDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Sort tasks by column order then by priority/date if needed
    // We map column IDs to their index for sorting
    final columnOrder = {for (var c in columns) c.id: columns.indexOf(c)};
    
    final sortedTasks = List<TodoTaskModel>.from(tasks);
    sortedTasks.sort((a, b) {
      final idxA = columnOrder[a.statusId] ?? 999;
      final idxB = columnOrder[b.statusId] ?? 999;
      if (idxA != idxB) return idxA.compareTo(idxB);
      // Secondary sort: Priority (High before Low)
      return a.priority.index.compareTo(b.priority.index);
    });

    if (sortedTasks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Text('Nessuna attività in questa lista'),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8), // Minimal padding
      itemCount: sortedTasks.length,
      itemBuilder: (context, index) {
        final task = sortedTasks[index];
        final column = columns.firstWhere(
          (c) => c.id == task.statusId, 
          orElse: () => TodoColumn(id: 'unknown', title: '?', colorValue: Colors.grey.value)
        );

        return TodoTaskRow(
          task: task,
          column: column,
          onTap: () => onTaskTap(task),
        );
      },
    );
  }
}
