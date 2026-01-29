import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
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
    
    return ReorderableListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      buildDefaultDragHandles: false, // We use custom handle in the Row
      itemCount: sortedTasks.length,
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final task = sortedTasks[oldIndex];
        
        // Calculate new position
        // bound checking
        double newPos;
        if (newIndex == 0) {
           newPos = sortedTasks.first.position / 2;
           if (newPos < 1.0) newPos = sortedTasks.first.position - 100.0;
        } else if (newIndex >= sortedTasks.length - 1) {
           newPos = sortedTasks.last.position + 10000.0; 
        } else {
           // Between two tasks
           final prev = sortedTasks[newIndex - 1]; // Item before insertion point
           final next = sortedTasks[newIndex];     // Item at insertion point (pushed down)
           // Actually, sortedTasks is the OLD list.
           // If we move item 5 to 2.
           // Items: 0, 1, 2, 3, 4, [5], 6
           // Target index 2.
           // New Order: 0, 1, [5], 2, 3, 4, 6
           // Prev is 1, Next is 2. Correct.
           
           // If we move item 1 to 4.
           // Items: 0, [1], 2, 3, 4, 5
           // Target index 4.
           // New Order: 0, 2, 3, [1], 4, 5
           // Prev is 3 (was at index 3), Next is 4 (was at index 4). Correct.
           
           // Wait, ReorderableListView onReorder gives newIndex based on list BEFORE change, but adjusted for removal?
           // "The newIndex is the index where the item will be placed. If the item is moved down, the index needs to be adjusted."
           // I already did newIndex -= 1 for down moves.
           // So now newIndex is the destination index in the FINAL list.
           
           // We need to look at the surrounding items in the OLD list, but treating the moved item as gone.
           // This is complex. Easier:
           // Construct the new list locally.
           final newList = List<TodoTaskModel>.from(sortedTasks);
           final item = newList.removeAt(oldIndex);
           newList.insert(newIndex, item);
           
           // Now get neighbors from newList
           final newPrev = newIndex > 0 ? newList[newIndex - 1] : null;
           final newNext = newIndex < newList.length - 1 ? newList[newIndex + 1] : null;
           
           if (newPrev == null) {
              newPos = (newNext?.position ?? 10000.0) / 2;
           } else if (newNext == null) {
              newPos = newPrev.position + 10000.0;
           } else {
              newPos = (newPrev.position + newNext.position) / 2;
           }
        }
        
        if (onTaskMoved != null) {
          onTaskMoved!(task, task.statusId, newPos); 
        }
      },
      itemBuilder: (context, index) {
        final task = sortedTasks[index];
        final column = columns.firstWhere(
          (c) => c.id == task.statusId, 
          orElse: () => TodoColumn(id: 'unknown', title: '?', colorValue: Colors.grey.value)
        );

        return ReorderableDragStartListener(
           key: ValueKey(task.id),
           index: index,
           child: TodoTaskRow(
             task: task,
             column: column,
             list: list,
             onTap: () => onTaskTap(task),
           ),
        );
      },
    );
  }
}
