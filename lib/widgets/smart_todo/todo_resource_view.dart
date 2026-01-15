import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import 'todo_task_card.dart';

class TodoResourceView extends StatelessWidget {
  final TodoListModel list;
  final List<TodoTaskModel> tasks;
  final Function(TodoTaskModel) onTaskTap;
  final Function(TodoTaskModel, String) onTaskMoved; // Moved to status? Or Moved to User?
  // Moving between resource columns implies changing assignee. 
  // For now, let's just display. Moving requires drag target which updates assignee.
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

    final columns = [
      _buildColumn(context, 'unassigned', 'Non Assegnati', groupedTasks['unassigned']!),
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
        // Accept drag if task is coming from a different assignee.
        final currentAssignee = task?.assignedTo.isNotEmpty == true ? task!.assignedTo.first : 'unassigned';
        return currentAssignee != assigneeId;
      },
      onAccept: (task) {
        onAssigneeChanged(task, assigneeId);
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
              Expanded( // Make it fill remaining height for drop area
                child: columnTasks.isEmpty
                  ? Center(
                      child: Text(
                        'Nessun task',
                        style: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400], fontStyle: FontStyle.italic),
                      ),
                    )
                  : ListView.separated(
                      itemCount: columnTasks.length,
                      separatorBuilder: (c, i) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final t = columnTasks[index];
                        return Draggable<TodoTaskModel>(
                          data: t,
                          feedback: Material(
                            elevation: 6,
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: 300, 
                              child: Opacity(
                                opacity: 0.9,
                                child: TodoTaskCard(task: t, onTap: () {}), // Dummy tap
                              ),
                            ), // Use actual card visuals
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.3, 
                            child: TodoTaskCard(task: t, onTap: () {}),
                          ),
                          child: TodoTaskCard(
                            task: t,
                            onTap: () => onTaskTap(t),
                          ),
                        );
                      },
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
