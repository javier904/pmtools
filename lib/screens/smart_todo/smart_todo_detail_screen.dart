import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_participant_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../services/smart_todo_service.dart';
import '../../services/auth_service.dart';
import '../../services/planning_poker_firestore_service.dart';
import '../../services/eisenhower_firestore_service.dart';
import '../../widgets/smart_todo/todo_list_view.dart';
import '../../widgets/smart_todo/todo_kanban_view.dart';
import '../../widgets/smart_todo/todo_task_dialog.dart';
import '../../widgets/smart_todo/smart_todo_participants_dialog.dart';
import '../../widgets/smart_todo/todo_resource_view.dart';
import '../../widgets/smart_todo/smart_task_import_dialog.dart';
import '../../widgets/smart_todo/export_to_estimation_dialog.dart';
import '../../widgets/smart_todo/export_to_eisenhower_dialog.dart';
import '../../widgets/smart_todo/export_to_user_stories_dialog.dart';
import '../../widgets/estimation_room/session_form_dialog.dart';
import '../../services/smart_todo_sheets_export_service.dart';
import '../../services/agile_firestore_service.dart';
import '../../models/agile_project_model.dart';
import '../../models/agile_enums.dart';
import '../../l10n/app_localizations.dart';
import '../estimation_room_screen.dart';
import '../eisenhower_screen.dart';
import '../agile_project_detail_screen.dart';
import 'smart_todo_audit_log_screen.dart';

enum TodoViewMode { kanban, list, resource }

class SmartTodoDetailScreen extends StatefulWidget {
  final TodoListModel list;

  const SmartTodoDetailScreen({super.key, required this.list});

  @override
  State<SmartTodoDetailScreen> createState() => _SmartTodoDetailScreenState();
}

class _SmartTodoDetailScreenState extends State<SmartTodoDetailScreen> {
  final SmartTodoService _todoService = SmartTodoService();
  final EisenhowerFirestoreService _eisenhowerService = EisenhowerFirestoreService();
  final AgileFirestoreService _agileService = AgileFirestoreService();
  final AuthService _authService = AuthService();
  
  TodoViewMode? _viewMode = TodoViewMode.kanban;
  final TextEditingController _searchController = TextEditingController();
  List<String>? _assigneeFilters;
  bool _filterToday = false; 
  bool _sortByDate = false; // Default: Manual/Global Rank
  
  String get _currentUserEmail => _authService.currentUser?.email ?? '';

  bool _allowPop = false;

  List<String> get safeAssigneeFilters => _assigneeFilters ?? [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TodoListModel?>(
      stream: _todoService.streamList(widget.list.id),
      initialData: widget.list,
      builder: (context, listSnapshot) {
        final currentList = listSnapshot.data ?? widget.list;
        
        // Check if current user is pending and needs promotion (to capture DisplayName)
        _checkAndPromoteUser(currentList);
        
        return PopScope(
          canPop: _allowPop,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
               // Swipe blocked.
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() => _allowPop = true);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.maybePop(context);
                  });
                },
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currentList.title, style: const TextStyle(fontSize: 18)),
                  Text(
                    AppLocalizations.of(context)?.smartTodoMembersCount(currentList.participants.length) ?? '${currentList.participants.length} members',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)
                  ),
                ],
              ),
              actions: [
                // ═══════════════════════════════════════════════════════════
                // EXPORT/INTEGRATION BUTTONS (left side)
                // ═══════════════════════════════════════════════════════════
                // Export to Estimation button
                StreamBuilder<List<TodoTaskModel>>(
                  stream: _todoService.streamTasks(currentList.id),
                  builder: (context, taskSnapshot) {
                    final tasks = taskSnapshot.data ?? [];
                    final hasNonDoneTasks = tasks.any((t) => t.statusId != 'done' && t.statusId != 'completed');
                    return IconButton(
                      icon: const Icon(Icons.casino_rounded),
                      tooltip: AppLocalizations.of(context)?.exportToEstimation ?? 'Send to Estimation',
                      onPressed: hasNonDoneTasks
                          ? () => _showExportToEstimationDialog(currentList, tasks)
                          : null,
                    );
                  },
                ),
                // Export to Eisenhower button
                StreamBuilder<List<TodoTaskModel>>(
                  stream: _todoService.streamTasks(currentList.id),
                  builder: (context, taskSnapshot) {
                    final tasks = taskSnapshot.data ?? [];
                    final hasNonDoneTasks = tasks.any((t) => t.statusId != 'done' && t.statusId != 'completed');
                    return IconButton(
                      icon: const Icon(Icons.grid_view_rounded),
                      tooltip: AppLocalizations.of(context)?.exportToEisenhower ?? 'Send to Eisenhower',
                      onPressed: hasNonDoneTasks
                          ? () => _showExportToEisenhowerDialog(currentList, tasks)
                          : null,
                    );
                  },
                ),
                // Export to User Stories button
                StreamBuilder<List<TodoTaskModel>>(
                  stream: _todoService.streamTasks(currentList.id),
                  builder: (context, taskSnapshot) {
                    final tasks = taskSnapshot.data ?? [];
                    final hasNonDoneTasks = tasks.any((t) => t.statusId != 'done' && t.statusId != 'completed');
                    return IconButton(
                      icon: const Icon(Icons.auto_stories_rounded),
                      tooltip: AppLocalizations.of(context)?.exportToUserStories ?? 'Send to User Stories',
                      onPressed: hasNonDoneTasks
                          ? () => _showExportToUserStoriesDialog(currentList, tasks)
                          : null,
                    );
                  },
                ),
                // ═══════════════════════════════════════════════════════════
                // SEPARATOR
                // ═══════════════════════════════════════════════════════════
                const SizedBox(width: 8),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                // ═══════════════════════════════════════════════════════════
                // PAGE FUNCTIONALITY BUTTONS (right side)
                // ═══════════════════════════════════════════════════════════
                // View Switcher
                Row(
                  children: [
                    _buildViewIcon(TodoViewMode.kanban, Icons.view_kanban, AppLocalizations.of(context)?.smartTodoViewKanban ?? 'Kanban'),
                    _buildViewIcon(TodoViewMode.list, Icons.list, AppLocalizations.of(context)?.smartTodoViewList ?? 'Lista'),
                    _buildViewIcon(TodoViewMode.resource, Icons.people_outline, AppLocalizations.of(context)?.smartTodoViewResource ?? 'Per Risorsa'),
                  ],
                ),
                if (currentList.isOwner(_currentUserEmail))
                  IconButton(
                    icon: const Icon(Icons.history),
                    tooltip: 'Audit Log',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SmartTodoAuditLogScreen(list: currentList)),
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.person_add),
                  tooltip: AppLocalizations.of(context)?.smartTodoInviteTooltip ?? 'Invita',
                  onPressed: () => _showInviteDialog(currentList),
                ),
                // ═══════════════════════════════════════════════════════════
                // SEPARATOR - Import/Export section
                // ═══════════════════════════════════════════════════════════
                const SizedBox(width: 4),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                // Import button
                IconButton(
                  icon: const Icon(Icons.upload_file),
                  tooltip: AppLocalizations.of(context)?.smartTodoActionImport ?? 'Importa Task',
                  onPressed: () => _showImportDialog(currentList),
                ),
                // Export button
                IconButton(
                  icon: const Icon(Icons.table_chart),
                  tooltip: AppLocalizations.of(context)?.smartTodoActionExportSheets ?? 'Esporta su Sheets',
                  onPressed: () => _exportToSheets(currentList),
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => _showListSettings(currentList),
                ),
                const SizedBox(width: 8),
                // Home button - sempre ultimo a destra
                IconButton(
                  icon: const Icon(Icons.home_rounded),
                  tooltip: AppLocalizations.of(context)?.navHome ?? 'Home',
                  color: const Color(0xFF8B5CF6), // Viola come icona app
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: _buildFilterBar(currentList),
              ),
            ),
            body: StreamBuilder<List<TodoTaskModel>>(
              stream: _todoService.streamTasks(currentList.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (snapshot.hasError) {
                   return Center(child: Text(AppLocalizations.of(context)?.errorGeneric(snapshot.error.toString()) ?? 'Error: ${snapshot.error}'));
                }
  
                var tasks = snapshot.data ?? [];
  
                // Apply Filters
                if (_searchController.text.isNotEmpty) {
                  final query = _searchController.text.toLowerCase();
                  tasks = tasks.where((t) => 
                    t.title.toLowerCase().contains(query) || 
                    t.description.toLowerCase().contains(query)
                  ).toList();
                }
  
                if (safeAssigneeFilters.isNotEmpty) {
                  // Filter: Show task if ANY of its assignees is in the filter list
                  tasks = tasks.where((t) {
                    if (t.assignedTo.isEmpty) return false; // Or should we have a "Unassigned" filter? 
                    // For now, simple intersection
                    return t.assignedTo.any((a) => safeAssigneeFilters.contains(a));
                  }).toList();
                }

                // Today Filter
                if (_filterToday) {
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  tasks = tasks.where((t) {
                     if (t.dueDate == null) return false;
                     // Due Date is just a date usually, but might store time. 
                     // Let's assume we want due <= today (overdue included)
                     final due = t.dueDate!;
                     final dueDay = DateTime(due.year, due.month, due.day);
                     return dueDay.isAtSameMomentAs(today) || dueDay.isBefore(today);
                  }).toList();
                }

                // Sorting (Client-side override)
                if (_sortByDate) {
                  tasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
                }
                // Else: Service already provides 'position' sort by default

  
                // Defensive check for hot reload and null state
                final TodoViewMode safeMode = _viewMode ?? TodoViewMode.kanban; 
                
                // If mode is somehow null (hot reload artifact), force one
                Widget content;
                switch (safeMode) { // Use variable, not field directly
                  case TodoViewMode.list:
                    content = TodoListView(
                      tasks: tasks,
                      columns: currentList.columns,
                      list: currentList,
                      onTaskTap: (t) => _editTask(t, currentList),
                      onTaskMoved: (t, s) => _handleTaskMoved(t, s, currentList, tasks),
                      onTaskDelete: (t) => _deleteTask(t, currentList),
                    );
                    break;
                  case TodoViewMode.resource:
                    content = TodoResourceView(
                      list: currentList,
                      tasks: tasks,
                      onTaskTap: (t) => _editTask(t, currentList),
                      onTaskMoved: (t, s, [pos]) => _handleTaskMoved(t, s, currentList, tasks, pos), // Supports reorder
                      onAssigneeChanged: (t, u) => _handleAssigneeChanged(t, u, currentList),
                    );
                    break;
                  case TodoViewMode.kanban:
                  default: // Default case handles null
                    content = TodoKanbanView(
                      list: currentList,
                      tasks: tasks,
                      onTaskMoved: (t, s, [TodoTaskModel? prev]) => _handleTaskMoved(t, s, currentList, tasks, prev),
                      onTaskTap: (t) => _editTask(t, currentList),
                      onTaskDelete: (t) => _deleteTask(t, currentList),
                      onColumnAction: (a, c) => _handleColumnAction(a, c, currentList),
                      onQuickAdd: (statusId) => _showTaskDialog(currentList, initialStatusId: statusId),
                    );
                    break;
                }
                
                return content;
              },
            ),
            floatingActionButton: _viewMode == TodoViewMode.kanban ? null : FloatingActionButton(
              onPressed: () => _createTask(currentList), 
              child: const Icon(Icons.add),
            ),
          ),
        );
      }
    );
  }

  Widget _buildViewIcon(TodoViewMode mode, IconData icon, String tooltip) {
    // Determine if this is the active mode.
    // _viewMode might be null initially (although we default it),
    // but if it is null, we treat kanban as active (matches default switch case).
    final currentMode = _viewMode ?? TodoViewMode.kanban;
    final isActive = currentMode == mode;
    
    return IconButton(
      icon: Icon(icon),
      color: isActive ? Colors.blue : Colors.grey,
      tooltip: tooltip,
      onPressed: () => setState(() => _viewMode = mode),
    );
  }

  void _handleAssigneeChanged(TodoTaskModel task, String userId, TodoListModel currentList) {
    if (!_canEditTask(task, currentList)) return;

    final newAssignees = userId == 'unassigned' ? <String>[] : [userId];

    _todoService.updateTask(
      currentList.id,
      task.copyWith(assignedTo: newAssignees),
      previousTask: task,
      performedBy: _currentUserEmail,
      performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
    );
  }



  void _checkAndPromoteUser(TodoListModel list) {
    if (_currentUserEmail.isEmpty) return;
    
    // Check if user is in pending list
    if (list.pendingEmails.contains(_currentUserEmail)) {
      // User is pending. Promote to active and update DisplayName!
      final displayName = _authService.currentUserName ?? _currentUserEmail.split('@').first;
      
      final participant = TodoParticipant(
        email: _currentUserEmail,
        displayName: displayName,
        role: TodoParticipantRole.editor, // Default role for promoted users? Or Viewer? User requested "same as owner permissions".
        joinedAt: DateTime.now(),
      );
      
      _todoService.promotePendingToActive(list.id, participant).then((_) {
        print('✅ User promoted to active: $_currentUserEmail with name: $displayName');
      }).catchError((e) {
        print('❌ Error promoting user: $e');
      });
    }
    
    // Also check if user is already active but missing DisplayName (Legacy fix)
    // Only if it's ME (I can only update my own name ideally, or system does it)
    else if (list.participants.containsKey(_currentUserEmail)) {
       final me = list.participants[_currentUserEmail]!;
       // If display name is null or empty, and we have a name now, update it.
       if ((me.displayName == null || me.displayName!.isEmpty) && _authService.currentUserName != null) {
          // We need a method to just update participant details. 
          // Re-using promotePendingToActive logic partially or just manual update?
          // promotePendingToActive handles participant map update correctly.
          // Let's use it? No, it removes from pending. 
          // But pending remove is safe if not present.
          // Actually, let's create a specific update or just use promote (it does upsert on participants map).
          
          final updatedMe = me.copyWith(displayName: _authService.currentUserName);
           _todoService.promotePendingToActive(list.id, updatedMe); // Updates map and ensures consistency
       }
    }
  }

  Widget _buildFilterBar(TodoListModel currentList) {
    // Use theme
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Search Pill
            Container(
              width: 240,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E2633) : Colors.grey[100], // Dark Surface or Light Grey
                borderRadius: BorderRadius.circular(20),
                border: isDark ? Border.all(color: Colors.white.withOpacity(0.1)) : null,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.smartTodoSearchTasksHint ?? 'Search...',
                  hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[500], fontSize: 14),
                  prefixIcon: Icon(Icons.search, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[500]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10), // Center vertically
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 14),
                onChanged: (val) => setState(() {}),
              ),
            ),
            const SizedBox(width: 12),
            // Assignee Pill (Multi-select)
             InkWell(
               onTap: () => _showMultiSelectAssigneeDialog(currentList),
               borderRadius: BorderRadius.circular(20),
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 height: 40,
                 decoration: BoxDecoration(
                   color: safeAssigneeFilters.isEmpty ? (isDark ? const Color(0xFF1E2633) : Colors.white) : Colors.blue.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(
                     color: safeAssigneeFilters.isEmpty ? (isDark ? Colors.grey.withOpacity(0.2) : Colors.grey.withOpacity(0.3)) : Colors.blue.withOpacity(0.3)
                   ),
                 ),
                 child: Row(
                   children: [
                     Icon(
                       Icons.person_outline, 
                       size: 18, 
                       color: safeAssigneeFilters.isEmpty ? (isDark ? Colors.grey[400] : Colors.grey) : Colors.blue
                     ),
                     const SizedBox(width: 8),
                     Text(
                       safeAssigneeFilters.isEmpty
                         ? (AppLocalizations.of(context)?.smartTodoAllPeople ?? "All people")
                         : (AppLocalizations.of(context)?.smartTodoPeopleCount(safeAssigneeFilters.length) ?? "${safeAssigneeFilters.length} people"),
                       style: TextStyle(
                         fontSize: 14,
                         color: safeAssigneeFilters.isEmpty ? (isDark ? Colors.grey[300] : Colors.black) : Colors.blue,
                         fontWeight: safeAssigneeFilters.isEmpty ? FontWeight.normal : FontWeight.bold,
                       ),
                     ),
                     const SizedBox(width: 8),
                     Icon(
                       Icons.keyboard_arrow_down, 
                       size: 18, 
                       color: safeAssigneeFilters.isEmpty ? (isDark ? Colors.grey[400] : Colors.grey) : Colors.blue
                     ),
                   ],
                 ),
               ),
             ),
             
             const SizedBox(width: 12),
             
              // Today Filter Toggle
              InkWell(
                onTap: () => setState(() => _filterToday = !_filterToday),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  decoration: BoxDecoration(
                    color: !_filterToday ? (isDark ? const Color(0xFF1E2633) : Colors.white) : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: !_filterToday ? (isDark ? Colors.grey.withOpacity(0.2) : Colors.grey.withOpacity(0.3)) : Colors.orange.withOpacity(0.3)
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today, 
                        size: 16, 
                        color: !_filterToday ? (isDark ? Colors.grey[400] : Colors.grey) : Colors.orange[800]
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)?.smartTodoFilterToday ?? "Today",
                        style: TextStyle(
                          fontSize: 14,
                          color: !_filterToday ? (isDark ? Colors.grey[300] : Colors.black) : Colors.orange[800],
                          fontWeight: !_filterToday ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

             const SizedBox(width: 12),
             
             // Sort Toggle (Manual / Date)
             InkWell(
               onTap: () => setState(() => _sortByDate = !_sortByDate),
               borderRadius: BorderRadius.circular(20),
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 height: 40,
                 decoration: BoxDecoration(
                   color: isDark ? const Color(0xFF1E2633) : Colors.white,
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(color: isDark ? Colors.grey.withOpacity(0.2) : Colors.grey.withOpacity(0.3)),
                 ),
                 child: Row(
                   children: [
                     Icon(
                       _sortByDate ? Icons.access_time : Icons.sort, 
                       size: 16, 
                       color: isDark ? Colors.grey[400] : Colors.grey
                     ),
                     const SizedBox(width: 8),
                     Text(
                       _sortByDate 
                         ? (AppLocalizations.of(context)?.smartTodoSortDate ?? "Recent")
                         : (AppLocalizations.of(context)?.smartTodoSortManual ?? "Manual"),
                       style: TextStyle(
                         fontSize: 14,
                         color: isDark ? Colors.grey[300] : Colors.black,
                       ),
                     ),
                   ],
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }

  void _handleTaskMoved(TodoTaskModel task, String newStatusId, TodoListModel currentList, List<TodoTaskModel> allTasks, [dynamic positionContext]) {
    if (!_canEditTask(task, currentList)) return;

    // Handle Resource View / Simple Position Update (positionContext is double)
    if (positionContext is double) {
       _todoService.updateTaskPosition(currentList.id, task.id, positionContext);
       // Also update status if changed
       if (newStatusId.isNotEmpty && newStatusId != task.statusId) {
          _todoService.updateTask(
            currentList.id,
            task.copyWith(statusId: newStatusId, position: positionContext),
            previousTask: task,
            performedBy: _currentUserEmail,
            performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
          );
       }
       return;
    }
    
    // Handle Kanban Drop (positionContext is TodoTaskModel? insertBeforeTask)
    final insertBeforeTask = positionContext as TodoTaskModel?;
    
    // 1. Get Target Column
    final targetCol = currentList.columns.firstWhere((c) => c.id == newStatusId, 
        orElse: () => TodoColumn(id: newStatusId, title: 'Unknown', colorValue: 0));
        
    // 2. Needs explicit manual switch?
    bool needsManualSwitch = targetCol.sortBy != TodoColumnSort.manual;
    
    if (needsManualSwitch) {
       // IMPLICIT SWITCH: Freeze current order
       // A. Get all tasks in this column from passed list
       final tasksInCol = allTasks
           .where((t) => t.statusId == newStatusId && t.id != task.id) // Exclude moving task
           .toList();
           
       // B. Sort them by CURRENT sort criteria
       tasksInCol.sort((a, b) {
          switch (targetCol.sortBy) {
            case TodoColumnSort.priority: return b.priority.index.compareTo(a.priority.index);
            case TodoColumnSort.dueDate: 
               if (a.dueDate == null) return 1;
               if (b.dueDate == null) return -1;
               return a.dueDate!.compareTo(b.dueDate!);
            case TodoColumnSort.createdAt: return b.createdAt.compareTo(a.createdAt);
            default: return 0;
          }
       });
       
       // C. Assign frozen positions (spaced by 10000)
       double currentPos = 10000.0;
       for (var t in tasksInCol) {
          _todoService.updateTaskPosition(currentList.id, t.id, currentPos);
          currentPos += 10000.0;
       }
       
       // D. Update Column to Manual
       final newColumns = List<TodoColumn>.from(currentList.columns);
       final colIndex = newColumns.indexWhere((c) => c.id == newStatusId);
       if (colIndex != -1) {
          newColumns[colIndex] = newColumns[colIndex].copyWith(sortBy: TodoColumnSort.manual);
          _todoService.updateList(currentList.copyWith(columns: newColumns));
       }
       
       // E. Calculate New Position for Moved Task
       double newTaskPos;
       if (insertBeforeTask == null) {
          // Append to end
          newTaskPos = currentPos + 10000.0; 
       } else {
          // Find insertBeforeTask's new frozen position?
          // Since we just renamed positions, we need to infer based on index in simple sorted list
          final index = tasksInCol.indexWhere((t) => t.id == insertBeforeTask.id);
          if (index == -1) {
             newTaskPos = currentPos; 
          } else if (index == 0) {
             newTaskPos = 5000.0; 
          } else {
             final posAfter = (index + 1) * 10000.0;
             final posBefore = index * 10000.0;
             newTaskPos = (posBefore + posAfter) / 2;
          }
       }
       
       _todoService.updateTask(
          currentList.id,
          task.copyWith(statusId: newStatusId, position: newTaskPos),
          previousTask: task,
          performedBy: _currentUserEmail,
          performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
       );

    } else {
       // ALREADY MANUAL: Standard Insert Logic
       // Use passed allTasks instead of fetching
       final tasksInCol = allTasks
           .where((t) => t.statusId == newStatusId && t.id != task.id)
           .toList();
       tasksInCol.sort((a, b) => a.position.compareTo(b.position));
       
       double newPos;
       if (insertBeforeTask == null) {
          final last = tasksInCol.isNotEmpty ? tasksInCol.last.position : 0.0;
          newPos = last + 10000.0;
       } else {
          final afterTask = tasksInCol.firstWhere((t) => t.id == insertBeforeTask.id, orElse: () => insertBeforeTask!);
          final index = tasksInCol.indexOf(afterTask); 
          
          if (index == -1) {
             newPos = (tasksInCol.lastOrNull?.position ?? 0) + 10000.0;
          } else if (index == 0) {
             newPos = afterTask.position / 2;
             if (newPos < 1) newPos = afterTask.position - 100.0; 
          } else {
             final prev = tasksInCol[index - 1];
             newPos = (prev.position + afterTask.position) / 2;
          }
       }
       
       _todoService.updateTask(
          currentList.id,
          task.copyWith(statusId: newStatusId, position: newPos),
          previousTask: task,
          performedBy: _currentUserEmail,
          performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
       );
    }
  }

  void _handleColumnAction(String action, String columnId, TodoListModel currentList) async {
    if (action == 'add') {
      _showColumnDialog(currentList: currentList);
    } else if (action == 'rename') {
      final col = currentList.columns.firstWhere((c) => c.id == columnId);
      _showColumnDialog(column: col, currentList: currentList);
    } else if (action == 'sort') {
      final col = currentList.columns.firstWhere((c) => c.id == columnId);
      _showColumnSortDialog(col, currentList);
    } else if (action == 'delete') {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)?.smartTodoDeleteColumnTitle ?? 'Elimina Colonna'),
          content: Text(AppLocalizations.of(context)?.smartTodoDeleteColumnContent ?? 'Sei sicuro? I task in questa colonna non saranno più visibili.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(AppLocalizations.of(context)?.actionCancel ?? 'Annulla')),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true), 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: Text(AppLocalizations.of(context)?.actionDelete ?? 'Elimina')
            ),
          ],
        ),
      );
      
      if (confirm == true) {
        final newColumns = List<TodoColumn>.from(currentList.columns)
          ..removeWhere((c) => c.id == columnId);
        await _todoService.updateList(
          currentList.copyWith(columns: newColumns),
          previousList: currentList,
          performedBy: _currentUserEmail,
          performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
        );
      }
    }
  }

  void _showColumnSortDialog(TodoColumn col, TodoListModel currentList) {
    final sortOptions = TodoColumnSort.values;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Ordinamento Colonna'),
        children: sortOptions.map((sort) {
          final isSelected = col.sortBy == sort;
          return SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              final newColumns = List<TodoColumn>.from(currentList.columns);
              final index = newColumns.indexWhere((c) => c.id == col.id);
              if (index != -1) {
                newColumns[index] = TodoColumn(
                  id: col.id,
                  title: col.title,
                  colorValue: col.colorValue,
                  isDone: col.isDone,
                  sortBy: sort,
                  sortAscending: col.sortAscending,
                );
                await _todoService.updateList(
                  currentList.copyWith(columns: newColumns),
                  previousList: currentList,
                  performedBy: _currentUserEmail,
                  performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
                );
              }
            },
            child: Row(
              children: [
                if (isSelected) const Icon(Icons.check, size: 18, color: Colors.blue),
                if (!isSelected) const SizedBox(width: 18),
                const SizedBox(width: 8),
                Text(sort.name[0].toUpperCase() + sort.name.substring(1)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showColumnDialog({TodoColumn? column, required TodoListModel currentList}) {
    final titleCtrl = TextEditingController(text: column?.title ?? '');
    int selectedColor = column?.colorValue ?? Colors.blue.value;
    bool isDone = column?.isDone ?? false;
    
    final List<Color> colors = [
      Colors.blue, Colors.red, Colors.green, Colors.orange, 
      Colors.purple, Colors.teal, Colors.indigo, Colors.pink, Colors.grey
    ];

    final dialogIsDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              width: 500,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                 color: dialogIsDark ? const Color(0xFF1E2633) : Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 5)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Modern Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: dialogIsDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]!)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                          child: Icon(column == null ? Icons.view_column_rounded : Icons.edit_rounded, color: Colors.blue),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          column == null ? (AppLocalizations.of(context)?.smartTodoNewColumn ?? 'Nuova Colonna') : (AppLocalizations.of(context)?.actionEdit ?? 'Modifica'),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dialogIsDark ? Colors.white : Colors.black87),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(Icons.close_rounded, color: dialogIsDark ? Colors.grey[400] : null),
                          onPressed: () => Navigator.pop(context),
                          style: IconButton.styleFrom(backgroundColor: dialogIsDark ? Colors.white.withOpacity(0.1) : Colors.grey[100]),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         // Main Title Input (Big)
                         TextField(
                           controller: titleCtrl, 
                           decoration: InputDecoration(
                             hintText: AppLocalizations.of(context)?.smartTodoColumnNameHint ?? 'Nome Colonna',
                             hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dialogIsDark ? Colors.grey[500] : Colors.grey[400]),
                             border: InputBorder.none,
                           ),
                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dialogIsDark ? Colors.white : Colors.black87),
                           autofocus: true,
                         ),
                         const SizedBox(height: 24),
                         
                         // Color Picker Section
                         Text((AppLocalizations.of(context)?.smartTodoColorLabel ?? 'COLORE'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: dialogIsDark ? Colors.grey[400] : Colors.grey)),
                         const SizedBox(height: 12),
                         Wrap(
                           spacing: 12,
                           runSpacing: 12,
                           children: colors.map((c) {
                             final isSelected = c.value == selectedColor;
                             return GestureDetector(
                               onTap: () => setState(() => selectedColor = c.value),
                               child: Container(
                                 width: 36,
                                 height: 36,
                                 decoration: BoxDecoration(
                                   color: c,
                                   shape: BoxShape.circle,
                                   border: isSelected ? Border.all(color: Colors.black, width: 2) : Border.all(color: Colors.transparent, width: 2),
                                   boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))
                                   ],
                                 ),
                                 child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
                               ),
                             );
                           }).toList(),
                         ),
                         
                         const SizedBox(height: 32),
                         
                         // "Mark as Done" Switch - Styled better
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                           decoration: BoxDecoration(
                             color: dialogIsDark ? const Color(0xFF2D3748) : Colors.grey[50],
                             borderRadius: BorderRadius.circular(12),
                             border: Border.all(color: dialogIsDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]!),
                           ),
                           child: Row(
                             children: [
                               Expanded(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(AppLocalizations.of(context)?.smartTodoMarkAsDone ?? 'Segna come completato', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: dialogIsDark ? Colors.white : Colors.black87)),
                                      const SizedBox(height: 4),
                                      Text(
                                        AppLocalizations.of(context)?.smartTodoColumnDoneDescription ?? 'I task in questa colonna saranno considerati "Fatti" (barrati).',
                                        style: TextStyle(fontSize: 12, color: dialogIsDark ? Colors.grey[400] : Colors.grey[600]),
                                      ),
                                   ],
                                 ),
                               ),
                               Transform.scale(
                                 scale: 0.8,
                                 child: Switch(
                                   value: isDone,
                                   onChanged: (val) => setState(() => isDone = val),
                                   activeColor: Colors.blue,
                                 ),
                               ),
                             ],
                           ),
                         ),
                      ],
                    ),
                  ),

                  // Footer Actions
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: Text(AppLocalizations.of(context)?.actionCancel ?? 'Annulla'),
                          style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () async {
                            if (titleCtrl.text.isEmpty) return;
                            Navigator.pop(context);
                            
                            List<TodoColumn> newColumns = List.from(currentList.columns);
                            if (column == null) {
                              // Add
                              newColumns.add(TodoColumn(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                title: titleCtrl.text,
                                colorValue: selectedColor,
                                isDone: isDone,
                              ));
                            } else {
                              // Rename / Update
                              final index = newColumns.indexWhere((c) => c.id == column.id);
                              if (index != -1) {
                                newColumns[index] = TodoColumn(
                                  id: column.id,
                                  title: titleCtrl.text,
                                  colorValue: selectedColor,
                                  isDone: isDone,
                                );
                              }
                            }
                            await _todoService.updateList(
                              currentList.copyWith(columns: newColumns),
                              previousList: currentList,
                              performedBy: _currentUserEmail,
                              performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          child: Text(AppLocalizations.of(context)?.actionSave ?? 'Salva'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  
  void _showListSettings(TodoListModel currentList) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Center(child: Text(AppLocalizations.of(context)?.smartTodoListSettingsTitle ?? 'Impostazioni Lista', style: const TextStyle(fontWeight: FontWeight.bold))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.grey),
            title: Text(AppLocalizations.of(context)?.smartTodoRenameList ?? 'Rinomina Lista'),
            onTap: () {
              Navigator.pop(context);
              _showRenameListDialog(currentList); 
            },
          ),
          ListTile(
            leading: const Icon(Icons.label_outline, color: Colors.grey),
            title: Text(AppLocalizations.of(context)?.smartTodoManageTags ?? 'Gestisci Tag'),
            onTap: () {
              Navigator.pop(context);
              _showTagsDialog(currentList);
            },
          ),
          if (currentList.canEdit(_currentUserEmail))
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(AppLocalizations.of(context)?.smartTodoDeleteList ?? 'Elimina Lista', style: const TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmDeleteList(currentList);
              },
            ),
        ],
      ),
    );
  }

  void _showRenameListDialog(TodoListModel currentList) {
    final controller = TextEditingController(text: currentList.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.smartTodoRenameList ?? 'Rinomina Lista'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: AppLocalizations.of(context)?.smartTodoNewNameLabel ?? 'Nuovo Nome'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)?.actionCancel ?? 'Annulla')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _todoService.updateList(
                  currentList.copyWith(title: controller.text),
                  previousList: currentList,
                  performedBy: _currentUserEmail,
                  performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
                );
                Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations.of(context)?.actionSave ?? 'Salva'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteList(TodoListModel currentList) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.smartTodoDeleteList ?? 'Elimina Lista'),
        content: Text(AppLocalizations.of(context)?.smartTodoDeleteListConfirm ?? 'Sei sicuro di voler eliminare questa lista e tutti i suoi task? Questa azione è irreversibile.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)?.actionCancel ?? 'Annulla')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await _todoService.deleteList(
                currentList.id,
                listTitle: currentList.title,
                performedBy: _currentUserEmail,
                performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
              );
              if (mounted) Navigator.pop(context); // Go back to dashboard
            },
            child: Text(AppLocalizations.of(context)?.actionDelete ?? 'Elimina'),
          ),
        ],
      ),
    );
  }

  Future<void> _showTaskDialog(TodoListModel currentList, {TodoTaskModel? task, String? initialStatusId}) async {
    // Permission check for editing
    if (task != null && !_canEditTask(task, currentList)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)?.smartTodoEditPermissionError ?? 'Puoi modificare solo i task a te assegnati')),
      );
      return;
    }

    final result = await showDialog<TodoTaskModel>(
      context: context,
      builder: (context) => TodoTaskDialog(
        listId: currentList.id,
        listColumns: currentList.columns,
        task: task,
        initialStatusId: initialStatusId,
        participants: currentList.participants,
        listAvailableTags: currentList.availableTags,
      ),
    );

    if (result != null) {
      final userName = _authService.currentUserName ?? _currentUserEmail.split('@').first;
      if (task == null) {
        await _todoService.createTask(
          currentList.id,
          result,
          performedBy: _currentUserEmail,
          performedByName: userName,
        );
      } else {
        await _todoService.updateTask(
          currentList.id,
          result,
          previousTask: task,
          performedBy: _currentUserEmail,
          performedByName: userName,
        );
      }
    }
  }

  void _showMultiSelectAssigneeDialog(TodoListModel currentList) {
    // Current Selection
    var safeAssigneeFilters = List<String>.from(_assigneeFilters ?? []);
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final bgColor = isDark ? const Color(0xFF1E2633) : Colors.white;
          final textColor = isDark ? Colors.white : Colors.black87;
          final dividerColor = isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200];
          
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
               width: 350,
               padding: EdgeInsets.zero,
               decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                     BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.4 : 0.12), 
                        blurRadius: 20, 
                        spreadRadius: 5
                     )
                  ],
                  border: isDark ? Border.all(color: Colors.white.withOpacity(0.1)) : null,
               ),
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   // Modern Header
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                     decoration: BoxDecoration(
                       border: Border(bottom: BorderSide(color: dividerColor!)),
                     ),
                     child: Row(
                       children: [
                         Container(
                           padding: const EdgeInsets.all(8),
                           decoration: BoxDecoration(
                              color: isDark ? Colors.blue.withOpacity(0.2) : Colors.blue[50], 
                              borderRadius: BorderRadius.circular(8)
                           ),
                           child: const Icon(Icons.filter_list_rounded, color: Colors.blue, size: 20),
                         ),
                         const SizedBox(width: 16),
                         Text(
                           AppLocalizations.of(context)?.smartTodoFilterByPerson ?? 'Filter by Person',
                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                         ),
                         const Spacer(),
                         IconButton(
                           icon: Icon(Icons.close_rounded, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                           onPressed: () => Navigator.pop(context),
                           style: IconButton.styleFrom(backgroundColor: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100]),
                         ),
                       ],
                     ),
                   ),

                   // Content
                   Flexible(
                     child: SingleChildScrollView(
                       padding: const EdgeInsets.symmetric(vertical: 8),
                       child: Column(
                         children: [
                            ListTile(
                              leading: Icon(Icons.people_outline, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                              title: Text(
                                AppLocalizations.of(context)?.smartTodoAllPeople ?? 'All people',
                                style: TextStyle(color: textColor),
                              ),
                              // Visual feedback: If clicked, it clears filters.
                              // If no filters are selected, show a checkmark to indicate "Everyone is shown"
                              trailing: safeAssigneeFilters.isEmpty 
                                  ? const Icon(Icons.check, color: Colors.blue) 
                                  : (isDark ? Icon(Icons.refresh, size: 18, color: Colors.grey[600]) : Icon(Icons.refresh, size: 18, color: Colors.grey[400])),
                              onTap: () {
                                 setState(() => safeAssigneeFilters.clear());
                              },
                            ),
                            Divider(height: 1, color: dividerColor),
                            ...currentList.participants.values.map((p) {
                              final isSelected = safeAssigneeFilters.contains(p.email);
                              
                              // Correctly resolve Display Name
                              // If p.displayName is corrupted (e.g. from partial invite), try to use "Me" logic or split email
                              // But logic provided in prompt was "Non vengono mostrati i display name".
                              // We use the same logic as elsewhere: p.displayName ?? split
                              final displayName = (p.displayName != null && p.displayName!.isNotEmpty) 
                                                  ? p.displayName! 
                                                  : p.email.split('@')[0];
                              
                              // Color for avatar
                              final avatarColor = Colors.primaries[p.email.hashCode % Colors.primaries.length];
                              
                              return CheckboxListTile(
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                                title: Row(
                                   children: [
                                     Container(
                                       width: 24, height: 24,
                                       decoration: BoxDecoration(
                                          color: avatarColor.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                          border: Border.all(color: isDark ? Colors.white.withOpacity(0.2) : Colors.transparent),
                                       ),
                                       alignment: Alignment.center,
                                       child: Text(
                                         p.email[0].toUpperCase(), 
                                         style: TextStyle(fontSize: 10, color: avatarColor, fontWeight: FontWeight.bold)
                                       ),
                                     ),
                                     const SizedBox(width: 12),
                                     Expanded(
                                       child: Text(
                                         displayName, 
                                         overflow: TextOverflow.ellipsis,
                                         style: TextStyle(color: textColor),
                                       )
                                     ),
                                   ],
                                ),
                                value: isSelected,
                                side: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey[400]!),
                                onChanged: (val) {
                                  setState(() {
                                    if (val == true) {
                                      safeAssigneeFilters.add(p.email);
                                    } else {
                                      safeAssigneeFilters.remove(p.email);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                         ],
                       ),
                     ),
                   ),

                   // Footer
                   Padding(
                     padding: const EdgeInsets.all(24),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         TextButton(
                           onPressed: () => Navigator.pop(context),
                           style: TextButton.styleFrom(foregroundColor: isDark ? Colors.grey[400] : Colors.grey[600]),
                           child: Text(AppLocalizations.of(context)?.smartTodoCancel ?? 'Cancel')
                         ),
                         const SizedBox(width: 12),
                         ElevatedButton(
                           onPressed: () {
                               // Apply Logic
                               this.setState(() {
                                 _assigneeFilters = safeAssigneeFilters.isEmpty ? null : safeAssigneeFilters;
                               });
                               
                               // Persistence Logic
                               // Update the list model's assigneeFilters map for this user
                               final newFiltersMap = Map<String, List<String>>.from(currentList.assigneeFilters);
                               if (safeAssigneeFilters.isEmpty) {
                                 newFiltersMap.remove(_currentUserEmail);
                               } else {
                                 newFiltersMap[_currentUserEmail] = safeAssigneeFilters;
                               }
                               
                               _todoService.updateList(currentList.copyWith(assigneeFilters: newFiltersMap));
                               
                               Navigator.pop(context);
                           },
                           style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.blue,
                             foregroundColor: Colors.white,
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                             elevation: 0,
                           ),
                           child: Text(AppLocalizations.of(context)?.smartTodoApplyFilters ?? 'Apply Filters'),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
            ),
          );
        }
      ),
    );
  }

  bool _canEditTask(TodoTaskModel task, TodoListModel currentList) {
    // Allow any participant (Owner, Editor, Viewer-if-allowed) to edit.
    // The model's canEdit() now returns true for any participant.
    return currentList.canEdit(_currentUserEmail);
  }

  void _createTask(TodoListModel currentList, {String? initialStatusId}) async {
    await _showTaskDialog(currentList, initialStatusId: initialStatusId);
  }

  void _editTask(TodoTaskModel task, TodoListModel currentList) {
    _showTaskDialog(currentList, task: task);
  }



  void _deleteTask(TodoTaskModel task, TodoListModel currentList) {
    final l10n = AppLocalizations.of(context);

    if (!_canEditTask(task, currentList)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n?.smartTodoDeleteNoPermission ?? "You don't have permission to delete this task")),
      );
      return;
    }

    // Show confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.smartTodoDeleteTaskTitle ?? 'Delete Task'),
        content: Text(l10n?.smartTodoDeleteTaskContent ?? 'Are you sure you want to delete this task?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n?.actionCancel ?? 'Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _todoService.deleteTask(
                currentList.id,
                task.id,
                taskTitle: task.title,
                performedBy: _currentUserEmail,
                performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: Text(l10n?.actionDelete ?? 'Delete'),
          ),
        ],
      ),
    );
  }
  


  void _showInviteDialog(TodoListModel currentList) {
    showDialog(
      context: context,
      builder: (context) => SmartTodoParticipantsDialog(list: currentList),
    );
  }

  void _showImportDialog(TodoListModel list) {
    showDialog(
      context: context,
      builder: (context) => SmartTaskImportDialog(
        listId: list.id,
        availableColumns: list.columns,
        todoService: _todoService,
      ),
    );
  }

  Future<void> _exportToSheets(TodoListModel list) async {
    final l10n = AppLocalizations.of(context);
    final existingUrl = list.googleSheetsUrl;

    // Se esiste già un URL, mostra dialog con opzioni
    if (existingUrl != null && existingUrl.isNotEmpty) {
      final action = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n?.smartTodoSheetsExportTitle ?? 'Google Sheets Export'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n?.smartTodoSheetsExportExists ?? 'A Google Sheets document already exists for this list.'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.table_chart, color: Colors.green.shade700, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        existingUrl,
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n?.actionCancel ?? 'Cancel'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.open_in_new, size: 18),
              label: Text(l10n?.smartTodoSheetsOpen ?? 'Open'),
              onPressed: () => Navigator.pop(context, 'open'),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(l10n?.smartTodoSheetsUpdate ?? 'Update'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, 'update'),
            ),
          ],
        ),
      );

      if (action == null) return;

      if (action == 'open') {
        await _openSheetsUrl(existingUrl);
        return;
      }

      // action == 'update' - continua con l'export/aggiornamento
    }

    // Mostra snackbar di caricamento
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(existingUrl != null
          ? (l10n?.smartTodoSheetsUpdating ?? 'Updating Google Sheets...')
          : (l10n?.smartTodoSheetsCreating ?? 'Creating Google Sheets...')),
        duration: const Duration(seconds: 30),
      ),
    );

    try {
      final tasks = await _todoService.streamTasks(list.id).first;

      final url = await SmartTodoSheetsExportService().exportTodoListToGoogleSheets(
        list: list,
        tasks: tasks,
        existingUrl: existingUrl,
      );

      if (url != null && mounted) {
        // Salva l'URL nel modello se è nuovo
        if (existingUrl == null || existingUrl.isEmpty) {
          await _todoService.updateList(
            list.copyWith(googleSheetsUrl: url),
            previousList: list,
            performedBy: _currentUserEmail,
            performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
          );
        }

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(existingUrl != null
              ? (l10n?.smartTodoSheetsUpdated ?? 'Google Sheets updated!')
              : (l10n?.smartTodoSheetsCreated ?? 'Google Sheets created!')),
            action: SnackBarAction(
              label: l10n?.smartTodoSheetsOpen ?? 'Open',
              onPressed: () => _openSheetsUrl(url),
            ),
          ),
        );

        // Apri automaticamente il link in una nuova scheda
        await _openSheetsUrl(url);
      } else if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n?.smartTodoSheetsError ?? 'Error during export (see log)')),
        );
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n?.error ?? "Error"}: $e')),
        );
      }
    }
  }

  Future<void> _openSheetsUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showTagsDialog(TodoListModel list) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text('Gestisci Tag', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 16),
                   
                   // List of existing tags
                   if (list.availableTags.isEmpty)
                     const Padding(
                       padding: EdgeInsets.all(16.0),
                       child: Center(child: Text('Nessun tag creato.', style: TextStyle(color: Colors.grey))),
                     ),
                   
                   Flexible(
                     child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: list.availableTags.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final tag = list.availableTags[index];
                          return ListTile(
                            leading: CircleAvatar(
                               radius: 8, 
                               backgroundColor: Color(tag.colorValue),
                            ),
                            title: Text(tag.title),
                            contentPadding: EdgeInsets.zero,
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, size: 20),
                              onPressed: () async {
                                final newTags = List<TodoLabel>.from(list.availableTags)..removeAt(index);
                                await _todoService.updateList(
                                  list.copyWith(availableTags: newTags),
                                  previousList: list,
                                  performedBy: _currentUserEmail,
                                  performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
                                );
                                Navigator.pop(context);
                                _showTagsDialog(list.copyWith(availableTags: newTags));
                              },
                            ),
                          );
                        },
                     ),
                   ),

                   const SizedBox(height: 16),
                   ElevatedButton.icon(
                     onPressed: () => _showAddTagDialog(list),
                     icon: const Icon(Icons.add),
                     label: const Text('Nuovo Tag'),
                     style: ElevatedButton.styleFrom(
                       minimumSize: const Size(double.infinity, 44),
                       backgroundColor: Colors.grey[100],
                       foregroundColor: Colors.blue,
                       elevation: 0,
                     ),
                   )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void _showAddTagDialog(TodoListModel list) {
    final textCtrl = TextEditingController();
    int selectedColor = Colors.blue.value;
    final List<Color> colors = [Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple, Colors.pink, Colors.grey, Colors.black];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Nuovo Tag'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textCtrl,
                  decoration: const InputDecoration(labelText: 'Nome Tag'),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: colors.map((c) => GestureDetector(
                    onTap: () => setState(() => selectedColor = c.value),
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: selectedColor == c.value ? Border.all(width: 2, color: Colors.black) : null,
                      ),
                    ),
                  )).toList(),
                )
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
              ElevatedButton(
                onPressed: () async {
                  if (textCtrl.text.isEmpty) return;
                  final newTag = TodoLabel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: textCtrl.text,
                    colorValue: selectedColor,
                  );
                  final newTags = List<TodoLabel>.from(list.availableTags)..add(newTag);
                  await _todoService.updateList(
                    list.copyWith(availableTags: newTags),
                    previousList: list,
                    performedBy: _currentUserEmail,
                    performedByName: _authService.currentUserName ?? _currentUserEmail.split('@').first,
                  );

                  if (context.mounted) {
                     Navigator.pop(context); // Close Add Dialog
                     Navigator.pop(context); // Close List Dialog (to refresh)
                     _showTagsDialog(list.copyWith(availableTags: newTags)); // Reopen
                  }
                },
                child: const Text('Crea'),
              ),
            ],
          );
        }
      ),
    );
  }

  /// Show dialog to select tasks and export to Estimation Room
  Future<void> _showExportToEstimationDialog(TodoListModel list, List<TodoTaskModel> tasks) async {
    final l10n = AppLocalizations.of(context);

    // Show task selection dialog
    final selectedTasks = await showDialog<List<TodoTaskModel>>(
      context: context,
      builder: (context) => ExportToEstimationDialog(
        list: list,
        tasks: tasks,
      ),
    );

    if (selectedTasks == null || selectedTasks.isEmpty || !mounted) return;

    // Convert tasks to preloaded stories
    final preloadedStories = selectedTasks.map((task) => PreloadedStory(
      title: task.title,
      description: task.description,
      sourceTaskId: task.id,
      sourceListId: list.id,
    )).toList();

    // Show session creation dialog with preloaded stories
    final sessionData = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => SessionFormDialog(
        preloadedStories: preloadedStories,
        suggestedName: '${list.title} - Estimation',
      ),
    );

    if (sessionData == null || !mounted) return;

    // Create the session
    try {
      final pokerService = PlanningPokerFirestoreService();
      final sessionId = await pokerService.createSession(
        name: sessionData['name'],
        description: sessionData['description'] ?? '',
        createdBy: _currentUserEmail,
        cardSet: sessionData['cardSet'],
        estimationMode: sessionData['estimationMode'],
        allowObservers: sessionData['allowObservers'],
        autoReveal: sessionData['autoReveal'],
      );

      // Add stories to the session
      for (int i = 0; i < preloadedStories.length; i++) {
        final story = preloadedStories[i];
        await pokerService.createStory(
          sessionId: sessionId,
          title: story.title,
          description: story.description,
          order: i,
          linkedTaskId: story.sourceTaskId,
          linkedTaskTitle: story.title,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n?.exportSuccess ?? 'Exported successfully'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'Open',
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EstimationRoomScreen(initialSessionId: sessionId),
                  ),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Show dialog to select tasks and export to Eisenhower Matrix
  Future<void> _showExportToEisenhowerDialog(TodoListModel list, List<TodoTaskModel> tasks) async {
    final l10n = AppLocalizations.of(context);

    // Get available matrices for current user
    List<EisenhowerMatrixModel> availableMatrices = [];
    try {
      availableMatrices = await _eisenhowerService.streamMatrices().first;
    } catch (e) {
      print('Error fetching matrices: $e');
    }

    if (!mounted) return;

    // Show export dialog
    final result = await showDialog<ExportToEisenhowerResult>(
      context: context,
      builder: (context) => ExportToEisenhowerDialog(
        list: list,
        tasks: tasks,
        availableMatrices: availableMatrices,
      ),
    );

    if (result == null || result.selectedTasks.isEmpty || !mounted) return;

    try {
      String? matrixId;

      if (result.createNewMatrix) {
        // Create new matrix
        matrixId = await _eisenhowerService.createMatrix(
          title: result.newMatrixTitle!,
          description: 'Imported from: ${list.title}',
        );
        if (matrixId == null) {
          throw Exception('Failed to create matrix');
        }
      } else {
        // Use existing matrix
        matrixId = result.existingMatrix!.id;
      }

      // Create activities for each selected task
      // Note: Activities in Eisenhower are voted on for urgency/importance
      int createdCount = 0;
      for (final task in result.selectedTasks) {
        await _eisenhowerService.createActivity(
          matrixId: matrixId,
          title: task.title,
          description: task.description,
        );
        createdCount++;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n?.activitiesCreated(createdCount) ?? '$createdCount activities created'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: l10n?.actionOpen ?? 'Open',
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EisenhowerScreen(initialMatrixId: matrixId),
                  ),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Show dialog to select tasks and export to User Stories
  Future<void> _showExportToUserStoriesDialog(TodoListModel list, List<TodoTaskModel> tasks) async {
    final l10n = AppLocalizations.of(context);

    // Get available Agile projects for current user
    List<AgileProjectModel> availableProjects = [];
    try {
      availableProjects = await _agileService.getUserProjects(_currentUserEmail);
    } catch (e) {
      print('Error fetching projects: $e');
    }

    if (!mounted) return;

    // Show export dialog
    final result = await showDialog<ExportToUserStoriesResult>(
      context: context,
      builder: (context) => ExportToUserStoriesDialog(
        list: list,
        tasks: tasks,
        availableProjects: availableProjects,
      ),
    );

    if (result == null || result.selectedTasks.isEmpty || !mounted) return;

    try {
      String projectId;
      AgileProjectModel? targetProject;

      if (result.createNewProject) {
        // Create new Agile project with full configuration
        final userName = _authService.currentUser?.displayName ?? _currentUserEmail.split('@').first;
        final config = result.newProjectConfig!;
        targetProject = await _agileService.createProject(
          name: config.name,
          description: config.description.isNotEmpty
              ? config.description
              : 'Imported from: ${list.title}',
          createdBy: _currentUserEmail,
          createdByName: userName,
          framework: config.framework,
          sprintDurationDays: config.sprintDurationDays,
          workingHoursPerDay: config.workingHoursPerDay,
          productOwnerEmail: config.productOwnerEmail,
          scrumMasterEmail: config.scrumMasterEmail,
        );
        projectId = targetProject.id;
      } else {
        // Use existing project
        projectId = result.existingProject!.id;
        targetProject = result.existingProject;
      }

      // Create stories for each selected task
      int createdCount = 0;
      for (final task in result.selectedTasks) {
        // Map priority to business value
        final businessValue = _mapPriorityToBusinessValue(task.priority);

        await _agileService.createStory(
          projectId: projectId,
          title: task.title,
          description: task.description,
          createdBy: _currentUserEmail,
          priority: _mapPriorityToStoryPriority(task.priority),
          businessValue: businessValue,
          tags: task.tags.map((t) => t.title).toList(),
        );
        createdCount++;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n?.storiesCreated(createdCount) ?? '$createdCount stories created'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: l10n?.actionOpen ?? 'Open',
              textColor: Colors.white,
              onPressed: () {
                if (targetProject != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgileProjectDetailScreen(
                        project: targetProject!,
                        onBack: () => Navigator.pop(context),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Map task priority to business value (1-10)
  int _mapPriorityToBusinessValue(TodoTaskPriority priority) {
    switch (priority) {
      case TodoTaskPriority.high:
        return 8;
      case TodoTaskPriority.medium:
        return 5;
      case TodoTaskPriority.low:
        return 3;
    }
  }

  /// Map task effort (hours) to story points (Fibonacci)
  int _mapEffortToStoryPoints(int hours) {
    // Using a simple mapping: 1h = 1 point, then Fibonacci scale
    if (hours <= 1) return 1;
    if (hours <= 2) return 2;
    if (hours <= 4) return 3;
    if (hours <= 8) return 5;
    if (hours <= 16) return 8;
    if (hours <= 24) return 13;
    return 21;
  }

  /// Map task priority to story priority
  StoryPriority _mapPriorityToStoryPriority(TodoTaskPriority priority) {
    switch (priority) {
      case TodoTaskPriority.high:
        return StoryPriority.must;
      case TodoTaskPriority.medium:
        return StoryPriority.should;
      case TodoTaskPriority.low:
        return StoryPriority.could;
    }
  }
}
