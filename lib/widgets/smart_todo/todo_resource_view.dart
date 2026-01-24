import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import 'todo_task_card.dart';

class TodoResourceView extends StatelessWidget {
  final TodoListModel list;
  final List<TodoTaskModel> tasks;
  final Function(TodoTaskModel) onTaskTap;
  final Function(TodoTaskModel, String, [double?]) onTaskMoved; // Updated to include optional position 
  final Function(TodoTaskModel, String) onAssigneeChanged; 

  const TodoResourceView({
    super.key,
    required this.list,
    required this.tasks,
    required this.onTaskTap,
    required this.onAssigneeChanged,
    required this.onTaskMoved,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Group tasks by Assignee
    // "Unassigned" -> []
    // "email1" -> []
    // "email2" -> []
    final Map<String, List<TodoTaskModel>> groupedTasks = {
      'unassigned': [],
    };
    
    // Initialize groups for all participants
    for (var p in list.participants.keys) {
      groupedTasks[p] = [];
    }

    for (var t in tasks) {
      if (t.assignedTo.isEmpty) {
        groupedTasks['unassigned']!.add(t);
      } else {
        // Multi-assignee? Put in all relevant columns? Or just first?
        // Usually primarily assigned. Let's put in all or just first? 
        // For simplicity: First Assignee determines column.
        final assignee = t.assignedTo.first;
        if (groupedTasks.containsKey(assignee)) {
          groupedTasks[assignee]!.add(t);
        } else {
          // Assignee might not be in participant list anymore?
          // Fallback or add ad-hoc?
          groupedTasks[assignee] = [t];
        }
      }
    }

    final l10n = AppLocalizations.of(context)!;
    final columns = [
      _buildColumn(context, 'unassigned', l10n.smartTodoUnassigned, groupedTasks['unassigned']!),
      ...list.participants.entries.map((e) {
        return _buildColumn(context, e.key, e.value.displayName ?? e.key.split('@')[0], groupedTasks[e.key]!);
      }),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns.map((c) => Padding(
          padding: const EdgeInsets.only(right: 16),
          child: c,
        )).toList(),
      ),
    );
  }

  Widget _buildColumn(BuildContext context, String assigneeId, String title, List<TodoTaskModel> columnTasks) {
    // Use theme
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DragTarget<TodoTaskModel>(
      onWillAccept: (task) {
        // Accept always, logic inside onAccept handles reorder vs move
        return task != null;
      },
      onAccept: (task) {
        // Drop on empty column or general column area -> Append to end if moved from other column
        // If same column, do nothing (handled by item targets usually, but here fallback)
        final currentAssignee = task.assignedTo.isNotEmpty ? task.assignedTo.first : 'unassigned';
        if (currentAssignee != assigneeId) {
             onAssigneeChanged(task, assigneeId);
        } else {
             // Moved to same column background - maybe move to end?
             // Let's rely on item drag targets for precise reordering.
        }
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        
        return Container(
          width: 320,
          decoration: BoxDecoration(
            color: isHovering 
                ? (isDark ? Colors.blue.withOpacity(0.1) : Colors.blue[50]) 
                : (isDark ? const Color(0xFF1E2633) : Colors.grey[100]), // Darker column bg in dark mode
            borderRadius: BorderRadius.circular(16),
            border: isHovering 
                ? Border.all(color: Colors.blue, width: 2)
                : Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.transparent, width: 2),
            boxShadow: isDark && !isHovering ? [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))] : null,
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    if (assigneeId != 'unassigned')
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.blue[100],
                          child: Text(title[0].toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.blue)),
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.person_off_rounded, size: 24, color: Colors.grey),
                      ),
                    
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[300], 
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text(
                        '${columnTasks.length}', 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white70 : Colors.black87,
                        )
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tasks List
              Expanded(
                child: columnTasks.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.smartTodoNoTasksInColumn,
                        style: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400], fontStyle: FontStyle.italic),
                      ),
                    )
                  : ListView.builder( // Builder allows better context for index
                      itemCount: columnTasks.length,
                      itemBuilder: (context, index) {
                        final t = columnTasks[index];
                        return _buildDraggableTask(context, t, index, columnTasks, assigneeId);
                      },
                    ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDraggableTask(
      BuildContext context, 
      TodoTaskModel task, 
      int index, 
      List<TodoTaskModel> columnTasks,
      String assigneeId) {
      
    return DragTarget<TodoTaskModel>(
      onWillAccept: (incoming) {
        // Accept if not self
        return incoming != null && incoming.id != task.id;
      },
      onAccept: (incoming) {
        _handleReorder(incoming, index, columnTasks, assigneeId);
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        return Column(
          children: [
            // Drop zone indicator (top)
            if (isHovering)
               Container(height: 2, color: Colors.blue, margin: const EdgeInsets.symmetric(vertical: 4)),
               
            Draggable<TodoTaskModel>(
              data: task,
              feedback: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 300,
                  child: Opacity(
                    opacity: 0.9,
                    child: TodoTaskCard(task: task, list: list, showStatus: true, onTap: () {}),
                  ),
                ),
              ),
              childWhenDragging: Opacity(
                opacity: 0.3,
                child: TodoTaskCard(task: task, list: list, showStatus: true, onTap: () {}),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TodoTaskCard(
                  task: task,
                  list: list,
                  showStatus: true,
                  onTap: () => onTaskTap(task),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleReorder(TodoTaskModel incoming, int targetIndex, List<TodoTaskModel> tasks, String targetAssigneeId) {
     final incomingAssignee = incoming.assignedTo.isNotEmpty ? incoming.assignedTo.first : 'unassigned';
     
     // 1. If changing assignee
     if (incomingAssignee != targetAssigneeId) {
        // First change assignee
        onAssigneeChanged(incoming, targetAssigneeId);
        // Then we usually need to wait for update? 
        // For simplicity: The Position update is separate. 
        // But if we change assignee it will disappear from old column and appear in new.
        // We also want to set correct position.
        // Calculate new position based on targetIndex
        _calculateAndSetPosition(incoming, targetIndex, tasks);
     } else {
        // 2. Just Reordering in same column
        _calculateAndSetPosition(incoming, targetIndex, tasks);
     }
  }

  void _calculateAndSetPosition(TodoTaskModel incoming, int targetIndex, List<TodoTaskModel> tasks) {
    // Tasks are already sorted by position asc (from Service)
    
    double newPos;
    if (targetIndex == 0) {
      // Top of list: slightly less than first
      // Or half of first if > 0?
      // If list empty (not possible here as we dropped on task), 
      // If tasks[0] is not incoming (it shouldn't be), 
      final firstPos = tasks.first.position;
      newPos = firstPos - 1000; // Arbitrary gap
    } else {
      // Between targetIndex-1 and targetIndex
      // Wait, if I drop ON targetIndex, do I insert BEFORE or AFTER?
      // UI indicator suggests Before usually. 
      // Let's assume Before.
      
      // But wait, if I drag downwards, targetIndex might be the one BELOW.
      // Let's simple strategy: Insertion triggers "Insert BEFORE target".
      
      final prevPos = tasks[targetIndex - 1].position;
      final nextPos = tasks[targetIndex].position;
      newPos = (prevPos + nextPos) / 2;
    }
    
    // Call Position Update Callback (we need to add this to widget props!)
    // Since we don't have it in props yet, we must either add it or hack it.
    // The prompt execution plan says "Update TodoResourceView". 
    // I should add `onTaskReordered` callback property.
    onTaskMoved(incoming, '', newPos); 
    // I am reusing onTaskMoved signature: (Task, StatusId, [pos]).
    // But wait, onTaskMoved signature in file is `Function(TodoTaskModel, String)`.
    // I need to update the signature to support position.
  }
}
