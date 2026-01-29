import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import 'package:intl/intl.dart';

class TodoTaskRow extends StatelessWidget {
  final TodoTaskModel task;
  final TodoColumn? column; // To display status color/name
  final VoidCallback? onTap;
  final TodoListModel? list; // Added
  
  const TodoTaskRow({
    super.key,
    required this.task,
    this.column,
    this.onTap,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    // Use theme
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Status Color
    final statusColor = Color(column?.colorValue ?? 0xFF9E9E9E); // Default grey
    final isDone = column?.isDone ?? false;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D3748) : Colors.white,
          border: Border(bottom: BorderSide(color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1))),
        ),
        child: Row(
          children: [
            // Drag Handle (Added for reorder)
            // Only show if list is not null (implies we are in a list view context)
             if (list != null) ...[
               ReorderableDragStartListener(
                 index: -1, // Will be overridden by ListView builder context if valid, but we use wrapping usually
                 // Actually ReorderableListView needs this to be the direct child or we use a key.
                 // Better pattern: ReorderableDragStartListener in the item builder of the list.
                 // But wait, we are inside the Row widget. We need to pass the index or just be the listener.
                 // ReorderableListView by default makes the whole tile draggable unless we use buildDefaultDragHandles: false.
                 // We want specific handle.
                 child: Icon(Icons.drag_indicator, color: isDark ? Colors.grey[700] : Colors.grey[300]),
               ),
               const SizedBox(width: 8),
             ],

            // Status Indicator (Fixed Width for Alignment)
            if (column != null) ...[
              SizedBox(
                width: 85, // Fixed width to align all rows perfectly
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(isDark ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    column!.title.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 16), // Slightly more space
            ],

            // Priority Dot (Minimalist)
            Icon(Icons.circle, size: 8, color: _getPriorityColor(task.priority)),
            const SizedBox(width: 12),

            // Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDone ? Colors.grey : (isDark ? Colors.white : Colors.black87),
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (task.tags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Wrap(
                        spacing: 4,
                        children: task.tags.map((t) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(t.colorValue).withOpacity(isDark ? 0.25 : 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            t.name,
                            style: TextStyle(
                              fontSize: 9, 
                              color: isDark ? Color(t.colorValue).withOpacity(0.9) : Color(t.colorValue),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(width: 12),

            // Metadata Row (Condensed)
            
            // 1. Assignee (Tiny Avatar)
            if (task.assignedTo.isNotEmpty) ...[
              _buildTinyAvatar(task.assignedTo.first, isDark),
              const SizedBox(width: 8),
            ],

            // 2. Date 
            if (task.dueDate != null) ...[
              Text(
                DateFormat('d MMM').format(task.dueDate!),
                style: TextStyle(
                  fontSize: 12,
                  color: task.dueDate!.isBefore(DateTime.now()) && !isDone 
                      ? Colors.red 
                      : (isDark ? Colors.grey[400] : Colors.grey),
                ),
              ),
               const SizedBox(width: 8),
            ],

            // 3. Subtasks or Attachments count (Icons)
            if (task.subtasks.isNotEmpty) ...[
               Icon(Icons.check_circle_outline, size: 14, color: isDark ? Colors.grey[400] : Colors.grey[400]),
               const SizedBox(width: 2),
               Text('${task.completedSubtasks}/${task.subtasks.length}', style: TextStyle(fontSize: 10, color: isDark ? Colors.grey[500] : Colors.grey[600])),
                const SizedBox(width: 8),
            ],
            
            if (task.attachments.isNotEmpty)
              Icon(Icons.attach_file, size: 14, color: isDark ? Colors.grey[400] : Colors.grey[400]),
            
            // Chevron
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, size: 16, color: isDark ? Colors.grey[600] : Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(TodoTaskPriority priority) {
    switch (priority) {
      case TodoTaskPriority.high: return const Color(0xFFE53E3E); 
      case TodoTaskPriority.medium: return const Color(0xFFDD6B20); 
      case TodoTaskPriority.low: return const Color(0xFF3182CE); 
    }
  }

  Widget _buildTinyAvatar(String email, bool isDark) {
    final color = Colors.primaries[email.hashCode % Colors.primaries.length];
    return Tooltip(
      message: _getAssigneeName(email),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
          border: Border.all(color: isDark ? Colors.white.withOpacity(0.2) : Colors.white, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          email[0].toUpperCase(),
          style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String _getAssigneeName(String email) {
    if (list == null) return email;
    final cleanEmail = email.replaceAll('_DOT_', '.');
    final participant = list!.participants[cleanEmail];
    return participant?.displayName ?? cleanEmail;
  }
}
