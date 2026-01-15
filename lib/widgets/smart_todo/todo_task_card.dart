import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../services/auth_service.dart';

class TodoTaskCard extends StatelessWidget {
  final TodoTaskModel task;
  final bool isCompleted; // Passed from parent based on column definition
  final VoidCallback? onTap;
  final Function(TodoTaskModel)? onDelete;
  final Function(String)? onStatusChanged; 

  const TodoTaskCard({
    super.key,
    required this.task,
    this.isCompleted = false,
    this.onTap,
    this.onDelete,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor(task.priority);
    // Use passed isCompleted flag, fallback to legacy 'done' statusId for safety
    final isDone = isCompleted || task.statusId == 'done';
    final isExpired = task.dueDate != null && 
                      task.dueDate!.isBefore(DateTime.now()) && 
                      !isDone;
    
    // Use theme context extensions
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Modern "Premium" Card Design with Theme Support
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D3748) : Colors.white, // Dark surface or white
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04), 
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Top Row: Priority Indicator & Assignee
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Priority Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: priorityColor.withOpacity(isDark ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        task.priority.name.toUpperCase(),
                        style: TextStyle(
                          color: priorityColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Assignee Avatar
                    if (task.assignedTo.isNotEmpty)
                      Tooltip(
                        message: task.assignedTo.join(', '),
                        child: _buildAvatar(task.assignedTo.first, isDark),
                      ),
                  ],
                ),
                
                const SizedBox(height: 12),

                // 2. Title
                Text(
                  task.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    height: 1.3,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    color: isDone 
                      ? (isDark ? Colors.grey[500] : Colors.grey) 
                      : (isDark ? Colors.white : const Color(0xFF2D3748)),
                  ),
                ),

                // 3. Tags
                if (task.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: task.tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Color(tag.colorValue).withOpacity(isDark ? 0.25 : 0.15), // Higher opacity in dark mode
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag.name,
                        style: TextStyle(
                          fontSize: 10, 
                          color: isDark ? Color(tag.colorValue).withOpacity(0.9) : Color(tag.colorValue),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
                
                // 3.5 Images Preview
                Builder(
                  builder: (context) {
                    final List<String> images = [];
                    // Extract from attachments
                    for (var a in task.attachments) {
                      final l = a.url.toLowerCase();
                      if (l.endsWith('.jpg') || l.endsWith('.png') || l.endsWith('.jpeg') || l.endsWith('.webp')) {
                        images.add(a.url);
                      }
                    }
                    // Extract from comments
                    for (var c in task.comments) {
                      if (c.imageUrl != null && c.imageUrl!.isNotEmpty) {
                        images.add(c.imageUrl!);
                      }
                    }
                    
                    if (images.isEmpty) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: SizedBox(
                        height: 60,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length > 4 ? 4 : images.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            if (index == 3 && images.length > 4) {
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.grey[700] : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text('+${images.length - 3}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                              );
                            }
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                images[index], 
                                width: 60, 
                                height: 60, 
                                fit: BoxFit.cover,
                                errorBuilder: (_,__,___) => Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.broken_image, size: 20, color: Colors.grey)),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                ),

                const SizedBox(height: 12),
                
                // 4. Badges / Footer
                Row(
                  children: [
                    // Due Date
                    if (task.dueDate != null) ...[
                       _buildMetaIcon(
                         Icons.calendar_today_rounded, 
                         DateFormat('d MMM').format(task.dueDate!),
                         color: isExpired ? Colors.red : (isDark ? Colors.grey[400]! : Colors.grey[600]!)
                       ),
                       const SizedBox(width: 12),
                    ],

                    // Effort
                    if (task.effort != null) ...[
                      _buildMetaIcon(Icons.bolt_rounded, '${task.effort} pt', color: isDark ? Colors.amber : Colors.orange[700]!), // Highlight effort
                      const SizedBox(width: 12),
                    ],

                    const Spacer(),

                    // Attachments
                    if (task.attachments.isNotEmpty) ...[
                      _buildMetaIcon(Icons.attach_file_rounded, '${task.attachments.length}', color: isDark ? Colors.grey[400]! : Colors.grey[600]!),
                      const SizedBox(width: 8),
                    ],

                    // Comments
                    if (task.comments.isNotEmpty) ...[
                      Tooltip(
                        message: task.comments.map((c) => '${c.authorName}: ${c.text}').join('\n'),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _buildMetaIcon(Icons.chat_bubble_outline_rounded, '${task.comments.length}', color: isDark ? Colors.grey[400]! : Colors.grey[600]!),
                      ),
                      const SizedBox(width: 8),
                    ],
                    
                    // Subtasks
                    if (task.subtasks.isNotEmpty) ...[
                      _buildMetaIcon(
                        Icons.check_circle_outline_rounded, 
                        '${task.completedSubtasks}/${task.subtasks.length}',
                        color: task.completedSubtasks == task.subtasks.length ? Colors.green : (isDark ? Colors.grey[400]! : Colors.grey[600]!)
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(String email, bool isDark) {
    // Generate a consistent color based on email string
    final color = Colors.primaries[email.hashCode % Colors.primaries.length];
    
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.2) : Colors.white, width: 2),
        boxShadow: [
           BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        email[0].toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildMetaIcon(IconData icon, String text, {Color color = const Color(0xFF718096)}) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(TodoTaskPriority priority) {
    switch (priority) {
      case TodoTaskPriority.high: return const Color(0xFFE53E3E); // Red 600
      case TodoTaskPriority.medium: return const Color(0xFFDD6B20); // Orange 600
      case TodoTaskPriority.low: return const Color(0xFF3182CE); // Blue 600
    }
  }
}
