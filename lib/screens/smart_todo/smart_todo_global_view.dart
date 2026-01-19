import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/smart_todo_service.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../widgets/smart_todo/todo_list_view.dart';
import '../../widgets/smart_todo/todo_task_dialog.dart';

class SmartTodoGlobalView extends StatefulWidget {
  final List<TodoListModel> userLists;
  final SmartTodoService todoService;
  final String filterMode;

  const SmartTodoGlobalView({
    super.key,
    required this.userLists,
    required this.todoService,
    required this.filterMode,
  });

  @override
  State<SmartTodoGlobalView> createState() => _SmartTodoGlobalViewState();
}

class _SmartTodoGlobalViewState extends State<SmartTodoGlobalView> {
  final AuthService _authService = AuthService();
  String get _currentUserEmail => _authService.currentUser?.email ?? '';

  // Filter State - REMOVED (Provided by parent)
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  // _buildFilterBar removed

  Widget _buildBody() {
    Stream<List<TodoTaskModel>> stream;

    if (widget.filterMode == 'owner') {
      final ownedListIds = widget.userLists
          .where((l) => l.ownerId == _currentUserEmail)
          .map((l) => l.id)
          .toList();
      stream = widget.todoService.streamTasksByOwner(ownedListIds);
    } else {
      // Both 'today' and 'all_my' start from streamAssignments
      stream = widget.todoService.streamAssignments(_currentUserEmail);
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: StreamBuilder<List<TodoTaskModel>>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    'Errore caricamento tasks:\n${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            var tasks = snapshot.data ?? [];

            // Apply "Today" filter client-side
            // Apply "Today" filter client-side
            if (widget.filterMode == 'today') {
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);
              final tomorrow = today.add(const Duration(days: 1));
              
              debugPrint('DEBUG: SmartTodo Global Filter: Today');
              debugPrint('DEBUG: Current Time (Now): $now');
              debugPrint('DEBUG: Filter Threshold (Tomorrow 00:00): $tomorrow');
              debugPrint('DEBUG: Total Tasks from stream before filter: ${tasks.length}');

              tasks = tasks.where((t) {
                 if (t.isCompleted) {
                   debugPrint('DEBUG: Task ${t.title} skipped (Completed)');
                   return false;
                 }
                 if (t.dueDate == null) {
                   debugPrint('DEBUG: Task ${t.title} skipped (No Due Date)');
                   return false;
                 }
                 
                 final date = t.dueDate!;
                 // Include Overdue + Today (Before Tomorrow 00:00)
                 final matches = date.isBefore(tomorrow);
                 debugPrint('DEBUG: Task ${t.title} | Due: $date | Matches: $matches');
                 return matches;
              }).toList();
              
              debugPrint('DEBUG: Tasks after filter: ${tasks.length}');
            }

            final listTitles = {for (var l in widget.userLists) l.id: l.title};

            if (tasks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, size: 60, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Text(
                      widget.filterMode == 'today' ? 'Nessun task per oggi' : 'Nessun task trovato',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final listTitle = listTitles[task.listId] ?? 'Unknown List';
                  
                  // 1. Resolve List and Column Info
                  final list = widget.userLists.firstWhere((l) => l.id == task.listId, orElse: () => widget.userLists.first);
                  final statusCol = list.columns.firstWhere(
                    (c) => c.id == task.statusId, 
                    orElse: () => const TodoColumn(id: 'unknown', title: 'Unknown', colorValue: 0xFF9E9E9E)
                  );
                  
                  final isDark = Theme.of(context).brightness == Brightness.dark;

                  return Card(
                    elevation: 0,
                    color: isDark ? const Color(0xFF2D3748) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200]!),
                    ),
                    margin: EdgeInsets.zero,
                    child: InkWell(
                      onTap: () => _showTaskDialog(task),
                      borderRadius: BorderRadius.circular(12),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Status Color Bar
                            Container(
                              width: 6,
                              decoration: BoxDecoration(
                                color: Color(statusCol.colorValue),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                            
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header: Checkbox | Title | Priority
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Completion Checkbox
                                        Tooltip(
                                          message: task.isCompleted ? 'Segna come da fare' : 'Segna come completato',
                                          child: InkWell(
                                            onTap: () => _toggleTaskStatus(task),
                                            borderRadius: BorderRadius.circular(20),
                                            child: Container(
                                              width: 20, height: 20,
                                              margin: const EdgeInsets.only(top: 2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: task.isCompleted ? Colors.green : Colors.transparent,
                                                border: Border.all(
                                                  color: task.isCompleted ? Colors.green : Colors.grey[400]!,
                                                  width: 2,
                                                ),
                                              ),
                                              child: task.isCompleted 
                                                ? const Icon(Icons.check, size: 14, color: Colors.white) 
                                                : null,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        // Title
                                        Expanded(
                                          child: Text(
                                            task.title, 
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500, 
                                              fontSize: 14,
                                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                              color: task.isCompleted ? Colors.grey : (isDark ? Colors.white : Colors.black87),
                                            ),
                                          ),
                                        ),
                                        // Priority
                                        if (task.priority != TodoTaskPriority.low) 
                                           Tooltip(
                                             message: 'Priorità ${task.priority.name.toUpperCase()}',
                                             child: Padding(
                                               padding: const EdgeInsets.only(left: 8),
                                               child: Icon(
                                                 Icons.flag, 
                                                 size: 16, 
                                                 color: task.priority == TodoTaskPriority.high ? Colors.orange : Colors.blue
                                               ),
                                             ),
                                           ),
                                      ],
                                    ),
                                    
                                    const SizedBox(height: 8),

                                    // Metadata Row
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          // Status Chip (Small text)
                                          Tooltip(
                                            message: 'Stato: ${statusCol.title}',
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 8),
                                              child: Text(
                                                statusCol.title.toUpperCase(),
                                                style: TextStyle(fontSize: 9, color: Color(statusCol.colorValue), fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),

                                          // Tags
                                          ...task.tags.map((tag) => Tooltip(
                                            message: 'Tag: ${tag.title}',
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 6),
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Color(tag.colorValue).withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                tag.title,
                                                style: TextStyle(fontSize: 10, color: Color(tag.colorValue), fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          )),

                                          // Subtasks
                                          if (task.subtasks.isNotEmpty) ...[
                                            Tooltip(
                                              message: 'Sotto-attività completate',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.checklist, size: 14, color: isDark ? Colors.grey[400] : Colors.grey[500]),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${task.completedSubtasks}/${task.subtasks.length}',
                                                    style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                                                  ),
                                                ],
                                              )
                                            ),
                                            const SizedBox(width: 12),
                                          ],

                                          // Comments
                                          if (task.comments.isNotEmpty) ...[
                                            Tooltip(
                                              message: 'Commenti',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.chat_bubble_outline, size: 14, color: isDark ? Colors.grey[400] : Colors.grey[500]),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${task.comments.length}',
                                                    style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                                                  ),
                                                ],
                                              )
                                            ),
                                            const SizedBox(width: 12),
                                          ],

                                          // Due Date
                                          if (task.dueDate != null) ...[
                                             Tooltip(
                                               message: 'Scadenza: ${_formatDate(task.dueDate!)}',
                                               child: Row(
                                                 children: [
                                                    Icon(Icons.calendar_today, size: 14, color: isDark ? Colors.grey[400] : Colors.grey[500]),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                     '${task.dueDate!.day}/${task.dueDate!.month}',
                                                     style: TextStyle(
                                                       fontSize: 11, 
                                                       color: task.dueDate!.isBefore(DateTime.now()) && !task.isCompleted 
                                                         ? Colors.red 
                                                         : (isDark ? Colors.grey[400] : Colors.grey[600]),
                                                     ),
                                                   ),
                                                 ],
                                               )
                                             ),
                                            const SizedBox(width: 12),
                                          ],

                                          // List Origin
                                          Tooltip(
                                            message: 'Lista di appartenenza',
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: isDark ? const Color(0xFF1E2633) : Colors.grey[100], // Dark Surface variant
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[300]!)
                                              ),
                                              child: Text(
                                                listTitle.toUpperCase(), 
                                                style: TextStyle(fontSize: 9, color: isDark ? Colors.grey[300] : Colors.grey[600], fontWeight: FontWeight.bold)
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _toggleTaskStatus(TodoTaskModel task) async {
    // Find List to get Columns
    final list = widget.userLists.firstWhere((l) => l.id == task.listId, orElse: () => widget.userLists.first);
    
    String newStatusId;
    if (task.isCompleted) {
      // Uncheck: Move to first non-done column (usually 'todo')
      final todoCol = list.columns.firstWhere((c) => !c.isDone, orElse: () => list.columns.first);
      newStatusId = todoCol.id;
    } else {
      // Check: Move to first done column
      final doneCol = list.columns.firstWhere((c) => c.isDone, orElse: () => list.columns.last);
      newStatusId = doneCol.id;
    }

    final updatedTask = task.copyWith(
      statusId: newStatusId,
      updatedAt: DateTime.now(),
    );

    await widget.todoService.updateTask(task.listId, updatedTask);
  }

  void _showTaskDialog(TodoTaskModel task) async {
    // Get the correct list for this task
    final list = widget.userLists.firstWhere((l) => l.id == task.listId, orElse: () => widget.userLists.first);

    final result = await showDialog<TodoTaskModel>(
      context: context,
      builder: (context) => TodoTaskDialog(
        task: task,
        listId: task.listId,
        // Removed todoService and userEmail as they are not accepted
        listParticipants: list.participants.keys.toList(), 
        listColumns: list.columns,          
        listAvailableTags: list.availableTags, 
      ),
    );

    if (result != null) {
      await widget.todoService.updateTask(task.listId, result);
    }
  }
}
