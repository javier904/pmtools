import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'dart:ui';
import '../../models/smart_todo/todo_task_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import 'todo_task_row.dart'; // Import the new row widget

class TodoListView extends StatelessWidget {
  final List<TodoTaskModel> tasks;
  final List<TodoColumn> columns;
  final Function(TodoTaskModel) onTaskTap;
  final Function(TodoTaskModel, String, [double?])? onTaskMoved; 
  final Function(TodoTaskModel) onTaskDelete;
  final TodoListModel list; // Added

  const TodoListView({
    super.key,
    required this.tasks,
    required this.columns,
    required this.onTaskTap,
    this.onTaskMoved,
    required this.onTaskDelete,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    // Sort tasks by column order then by priority/date if needed
    // We map column IDs to their index for sorting
    // We map column IDs to their index for sorting
    // final columnOrder = {for (var c in columns) c.id: columns.indexOf(c)};
    
    final sortedTasks = List<TodoTaskModel>.from(tasks);
    // sortedTasks.sort((a, b) {
    //   final idxA = columnOrder[a.statusId] ?? 999;
    //   final idxB = columnOrder[b.statusId] ?? 999;
    //   if (idxA != idxB) return idxA.compareTo(idxB);
    //   // Secondary sort: Priority (High before Low)
    //   return a.priority.index.compareTo(b.priority.index);
    // });

    if (sortedTasks.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Text(l10n.smartTodoNoTasks),
        ),
      );
    }

    // If we are showing "Recent" (sorted by date), drag and drop should be disabled effectively
    // But ReorderableListView always allows dragging if enabled.
    // We can disable it by not wrapping in ReorderableDragStartListener or ignoring callbacks.
    // However, the best UX is to only allow reorder if Manual mode is active? 
    // Actually, user wants reorder to SAVE and switch to manual.
    // So we allow reorder ALWAYS (unless it's a read-only view).
    
    return ReorderableListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      buildDefaultDragHandles: false, // We use custom handle in the Row
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        
        // Safety checks
        if (oldIndex < 0 || oldIndex >= sortedTasks.length) return;
        if (newIndex < 0 || newIndex >= sortedTasks.length) return;

        final task = sortedTasks[oldIndex];
        
        // Calculate new position
        double newPos;
        
        // Construct the new list state locally for calculation
        final tempTasks = List<TodoTaskModel>.from(sortedTasks);
        tempTasks.removeAt(oldIndex);
        tempTasks.insert(newIndex, task);
        
        if (newIndex == 0) {
           final nextPos = tempTasks.length > 1 ? tempTasks[1].position : 0.0;
           newPos = nextPos / 2;
           if (newPos < 1.0) newPos = nextPos - 100.0;
        } else if (newIndex >= tempTasks.length - 1) {
           final prevPos = tempTasks[newIndex - 1].position;
           newPos = prevPos + 10000.0; 
        } else {
           final prev = tempTasks[newIndex - 1];
           final next = tempTasks[newIndex + 1];
           newPos = (prev.position + next.position) / 2;
        }
        
        if (onTaskMoved != null) {
          onTaskMoved!(task, task.statusId, newPos); 
        }
      },
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final double animValue = Curves.easeInOut.transform(animation.value);
            final double elevation = lerpDouble(0, 6, animValue)!;
            return Material(
              elevation: elevation,
              color: Colors.transparent, // Let row handle color
              shadowColor: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              child: child,
            );
          },
          child: child,
        );
      },
      children: sortedTasks.asMap().entries.map((entry) {
        final index = entry.key;
        final task = entry.value;
        
        final column = columns.firstWhere(
          (c) => c.id == task.statusId, 
          orElse: () => TodoColumn(id: 'unknown', title: '?', colorValue: Colors.grey.value)
        );

        return TodoTaskRow(
           key: ValueKey(task.id), // Key is critical for ReorderableListView
           task: task,
           column: column,
           list: list,
           index: index, // Pass global index for handle
           onTap: () => onTaskTap(task),
        );
      }).toList(),
    );
  }
}
