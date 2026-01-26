import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; // Added for attachments
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../services/auth_service.dart';
import '../../l10n/app_localizations.dart';

class TodoTaskCard extends StatelessWidget {
  final TodoTaskModel task;
  final bool isCompleted; // Passed from parent based on column definition
  final VoidCallback? onTap;
  final Function(TodoTaskModel)? onDelete;
  final Function(String)? onStatusChanged;
  final TodoListModel? list; // Added to lookup participant names

  const TodoTaskCard({
    super.key,
    required this.task,
    this.isCompleted = false,
    this.onTap,
    this.onDelete,
    this.onStatusChanged,
    this.list,
    this.showStatus = false, // Default false (Hidden in Kanban)
  });

  final bool showStatus;

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
                // 1. Top Row: Tags, Priority, Status & Assignee
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tags (moved here from below)
                    if (task.tags.isNotEmpty) ...[
                      Flexible(
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: task.tags.map((tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: Color(tag.colorValue).withOpacity(isDark ? 0.25 : 0.15),
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
                      ),
                      const SizedBox(width: 6),
                    ],

                    // Priority Pill (only initial with tooltip)
                    Tooltip(
                      message: _getPriorityLabel(task.priority),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: priorityColor.withOpacity(isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          task.priority.name[0].toUpperCase(),
                          style: TextStyle(
                            color: priorityColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    // Status Pill
                    if (showStatus && list != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(task.statusId).withOpacity(isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _getStatusName(task.statusId).toUpperCase(),
                          style: TextStyle(
                            color: _getStatusColor(task.statusId),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    const Spacer(),
                    // Assignee Avatar
                    if (task.assignedTo.isNotEmpty) ...[
                      Tooltip(
                        message: _getAssigneeName(task.assignedTo.first),
                        child: _buildAvatar(task.assignedTo.first, isDark),
                      ),
                      const SizedBox(width: 4),
                    ],
                    // More options menu (delete)
                    if (onDelete != null)
                      _TaskCardPopupMenu(
                        task: task,
                        onDelete: onDelete!,
                        isDark: isDark,
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

                // 2.5 Description (New)
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Tooltip(
                    message: task.description,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF333333), // Readable dark bg
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(color: Colors.white, fontSize: 13), // Readable text
                    child: Text(
                      task.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],

                // 3. Images Preview
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

                    // Attachments (Clickable Link with menu for multiple)
                    if (task.attachments.isNotEmpty) ...[
                      _AttachmentLinkButton(
                        attachments: task.attachments,
                        isDark: isDark,
                      ),
                      const SizedBox(width: 8),
                    ],

                    // Comments (Improved Tooltip)
                    if (task.comments.isNotEmpty) ...[
                      Tooltip(
                        message: task.comments.map((c) => '${c.authorName}: ${c.text}').join('\n'),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF333333),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                        child: _buildMetaIcon(Icons.chat_bubble_outline_rounded, '${task.comments.length}', color: isDark ? Colors.grey[400]! : Colors.grey[600]!),
                      ),
                      const SizedBox(width: 8),
                    ],
                    
                    // Subtasks (Checklist Tooltip)
                    if (task.subtasks.isNotEmpty) ...[
                      Tooltip(
                        message: task.subtasks.map((s) => '${s.isCompleted ? '✅' : '⬜'} ${s.title}').join('\n'),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF333333),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                        child: _buildMetaIcon(
                          Icons.check_circle_outline_rounded, 
                          '${task.completedSubtasks}/${task.subtasks.length}',
                          color: task.completedSubtasks == task.subtasks.length ? Colors.green : (isDark ? Colors.grey[400]! : Colors.grey[600]!)
                        ),
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

  String _getPriorityLabel(TodoTaskPriority priority) {
    switch (priority) {
      case TodoTaskPriority.high: return 'High';
      case TodoTaskPriority.medium: return 'Medium';
      case TodoTaskPriority.low: return 'Low';
    }
  }

  String _getAssigneeName(String email) {
    if (list == null) return email;
    // Handle potential escaped email if it was already in task
    final cleanEmail = email.replaceAll('_DOT_', '.');
    final participant = list!.participants[cleanEmail];
    return participant?.displayName ?? cleanEmail;
  }

  Color _getStatusColor(String statusId) {
    if (list == null) return Colors.grey;
    final column = list!.columns.firstWhere(
      (c) => c.id == statusId,
      orElse: () => TodoColumn(id: statusId, title: statusId, colorValue: Colors.grey.value)
    );
    return Color(column.colorValue);
  }

  String _getStatusName(String statusId) {
    if (list == null) return statusId;
    final column = list!.columns.firstWhere(
      (c) => c.id == statusId,
      orElse: () => TodoColumn(id: statusId, title: statusId, colorValue: 0)
    );
    return column.title;
  }
}

/// Popup menu for task card actions (delete, etc.)
class _TaskCardPopupMenu extends StatelessWidget {
  final TodoTaskModel task;
  final Function(TodoTaskModel) onDelete;
  final bool isDark;

  const _TaskCardPopupMenu({
    required this.task,
    required this.onDelete,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      width: 24,
      height: 24,
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.more_vert,
          size: 18,
          color: isDark ? Colors.grey[400] : Colors.grey[500],
        ),
        tooltip: '',
        onSelected: (value) {
          if (value == 'delete') {
            _showDeleteConfirmation(context);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Text(
                  l10n?.actionDelete ?? 'Delete',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.smartTodoDeleteTaskTitle ?? 'Delete Task'),
        content: Text(l10n?.smartTodoDeleteTaskContent ?? 'Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n?.actionCancel ?? 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete(task);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n?.actionDelete ?? 'Delete'),
          ),
        ],
      ),
    );
  }
}

/// Attachment link button with menu for multiple attachments
class _AttachmentLinkButton extends StatelessWidget {
  final List<TodoAttachment> attachments;
  final bool isDark;

  const _AttachmentLinkButton({
    required this.attachments,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDark ? Colors.blue[300]! : Colors.blue[600]!;

    // Single attachment: direct click to open
    if (attachments.length == 1) {
      return GestureDetector(
        onTap: () => _openLink(attachments.first.url),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: _buildMetaIcon(Icons.attach_file_rounded, '1', color: color),
        ),
      );
    }

    // Multiple attachments: show menu
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      tooltip: '',
      onSelected: (url) => _openLink(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: _buildMetaIcon(Icons.attach_file_rounded, '${attachments.length}', color: color),
      ),
      itemBuilder: (context) => attachments.map((attachment) {
        IconData icon = _getAttachmentIcon(attachment);
        return PopupMenuItem<String>(
          value: attachment.url,
          child: Row(
            children: [
              Icon(icon, size: 18, color: isDark ? Colors.grey[400] : Colors.grey[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  attachment.name.isNotEmpty ? attachment.name : _getShortUrl(attachment.url),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: isDark ? Colors.white : Colors.black87),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.open_in_new, size: 14, color: Colors.blue.shade400),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMetaIcon(IconData icon, String text, {Color color = const Color(0xFF718096)}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

  IconData _getAttachmentIcon(TodoAttachment attachment) {
    final url = attachment.url.toLowerCase();
    if (url.contains('docs.google.com') || url.contains('drive.google.com')) {
      return Icons.insert_drive_file;
    } else if (url.contains('sheets.google.com')) {
      return Icons.table_chart;
    } else if (url.contains('slides.google.com')) {
      return Icons.slideshow;
    } else if (url.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (url.endsWith('.jpg') || url.endsWith('.png') || url.endsWith('.jpeg')) {
      return Icons.image;
    } else {
      return Icons.link;
    }
  }

  String _getShortUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host + (uri.path.length > 20 ? uri.path.substring(0, 20) + '...' : uri.path);
    } catch (_) {
      return url.length > 30 ? '${url.substring(0, 30)}...' : url;
    }
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
