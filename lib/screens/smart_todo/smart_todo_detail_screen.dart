import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../services/smart_todo_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/smart_todo/todo_list_view.dart';
import '../../widgets/smart_todo/todo_kanban_view.dart';
import '../../widgets/smart_todo/todo_task_dialog.dart';
import '../../widgets/smart_todo/smart_todo_participants_dialog.dart';
import '../../widgets/smart_todo/todo_resource_view.dart';
import '../../widgets/smart_todo/smart_task_import_dialog.dart';
import '../../services/smart_todo_sheets_export_service.dart';

enum TodoViewMode { kanban, list, resource }

class SmartTodoDetailScreen extends StatefulWidget {
  final TodoListModel list;

  const SmartTodoDetailScreen({super.key, required this.list});

  @override
  State<SmartTodoDetailScreen> createState() => _SmartTodoDetailScreenState();
}

class _SmartTodoDetailScreenState extends State<SmartTodoDetailScreen> {
  final SmartTodoService _todoService = SmartTodoService();
  final AuthService _authService = AuthService();
  
  TodoViewMode? _viewMode = TodoViewMode.kanban;
  final TextEditingController _searchController = TextEditingController();
  List<String>? _assigneeFilters;
  bool _filterToday = false; // New state
  
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
                    '${currentList.participants.length} membri', 
                    style: const TextStyle(fontSize: 12, color: Colors.grey)
                  ),
                ],
              ),
              actions: [
                // View Switcher
                Row(
                  children: [
                    _buildViewIcon(TodoViewMode.kanban, Icons.view_kanban, 'Kanban'),
                    _buildViewIcon(TodoViewMode.list, Icons.list, 'Lista'),
                    _buildViewIcon(TodoViewMode.resource, Icons.people_outline, 'Per Risorsa'),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.person_add),
                  tooltip: 'Invita',
                  onPressed: () => _showInviteDialog(currentList),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Altre Opzioni',
                  onSelected: (val) {
                    if (val == 'import') _showImportDialog(currentList);
                    if (val == 'export') _exportToSheets(currentList);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'import', 
                      child: Row(children: [Icon(Icons.upload_file, size: 20), SizedBox(width: 12), Text('Importa Task')])
                    ),
                    const PopupMenuItem(
                      value: 'export', 
                      child: Row(children: [Icon(Icons.table_chart, size: 20), SizedBox(width: 12), Text('Esporta su Sheets')])
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => _showListSettings(currentList),
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
                   return Center(child: Text('Errore: ${snapshot.error}'));
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
  
                // Defensive check for hot reload and null state
                final TodoViewMode safeMode = _viewMode ?? TodoViewMode.kanban; 
                
                // If mode is somehow null (hot reload artifact), force one
                Widget content;
                switch (safeMode) { // Use variable, not field directly
                  case TodoViewMode.list:
                    content = TodoListView(
                      tasks: tasks,
                      columns: currentList.columns,
                      onTaskTap: (t) => _editTask(t, currentList),
                      onTaskMoved: (t, s) => _handleTaskMoved(t, s, currentList),
                      onTaskDelete: (t) => _deleteTask(t, currentList),
                    );
                    break;
                  case TodoViewMode.resource:
                    content = TodoResourceView(
                      list: currentList,
                      tasks: tasks,
                      onTaskTap: (t) => _editTask(t, currentList),
                      onTaskMoved: (t, s) => _handleTaskMoved(t, s, currentList),
                      onAssigneeChanged: (t, u) => _handleAssigneeChanged(t, u, currentList),
                    );
                    break;
                  case TodoViewMode.kanban:
                  default: // Default case handles null
                    content = TodoKanbanView(
                      list: currentList, 
                      tasks: tasks,
                      onTaskMoved: (t, s) => _handleTaskMoved(t, s, currentList),
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
    
    // If userId is 'unassigned', clear the list.
    // Otherwise, set the list to just [userId] (single assignee for drag-drop simplicity).
    // If we wanted to ADD to assignees, logic would be different.
    final newAssignees = userId == 'unassigned' ? <String>[] : [userId];
    
    _todoService.updateTask(currentList.id, task.copyWith(assignedTo: newAssignees));
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
                  hintText: 'Cerca...',
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
                         ? "Tutte le persone" 
                         : "${safeAssigneeFilters.length} persone",
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
                       "Oggi",
                       style: TextStyle(
                         fontSize: 14,
                         color: !_filterToday ? (isDark ? Colors.grey[300] : Colors.black) : Colors.orange[800],
                         fontWeight: !_filterToday ? FontWeight.normal : FontWeight.bold,
                       ),
                     ),
                     if (_filterToday) ...[
                        const SizedBox(width: 6),
                        Icon(Icons.close, size: 14, color: Colors.orange[800]),
                     ],
                   ],
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }

  void _handleTaskMoved(TodoTaskModel task, String newStatusId, TodoListModel currentList) {
    if (!_canEditTask(task, currentList)) return;
    _todoService.updateTask(currentList.id, task.copyWith(statusId: newStatusId));
    // Audit Log could go here
  }

  void _handleColumnAction(String action, String columnId, TodoListModel currentList) async {
    if (action == 'add') {
      _showColumnDialog(currentList: currentList);
    } else if (action == 'rename') {
      final col = currentList.columns.firstWhere((c) => c.id == columnId);
      _showColumnDialog(column: col, currentList: currentList);
    } else if (action == 'delete') {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Elimina Colonna'),
          content: const Text('Sei sicuro? I task in questa colonna non saranno più visibili.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annulla')),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true), 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: const Text('Elimina')
            ),
          ],
        ),
      );
      
      if (confirm == true) {
        final newColumns = List<TodoColumn>.from(currentList.columns)
          ..removeWhere((c) => c.id == columnId);
        await _todoService.updateList(currentList.copyWith(columns: newColumns));
      }
    }
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
                          column == null ? 'Nuova Colonna' : 'Modifica',
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
                             hintText: 'Nome Colonna',
                             hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dialogIsDark ? Colors.grey[500] : Colors.grey[400]),
                             border: InputBorder.none,
                           ),
                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dialogIsDark ? Colors.white : Colors.black87),
                           autofocus: true,
                         ),
                         const SizedBox(height: 24),
                         
                         // Color Picker Section
                         Text('COLORE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: dialogIsDark ? Colors.grey[400] : Colors.grey)),
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
                                      Text('Segna come completato', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: dialogIsDark ? Colors.white : Colors.black87)),
                                      const SizedBox(height: 4),
                                      Text(
                                        'I task in questa colonna saranno considerati "Fatti" (barrati).',
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
                          child: const Text('Annulla'),
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
                            await _todoService.updateList(currentList.copyWith(columns: newColumns));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          child: const Text('Salva'),
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
        title: const Center(child: Text('Impostazioni Lista', style: TextStyle(fontWeight: FontWeight.bold))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.grey),
            title: const Text('Rinomina Lista'),
            onTap: () {
              Navigator.pop(context);
              _showRenameListDialog(currentList); 
            },
          ),
          ListTile(
            leading: const Icon(Icons.label_outline, color: Colors.grey),
            title: const Text('Gestisci Tag'),
            onTap: () {
              Navigator.pop(context);
              _showTagsDialog(currentList);
            },
          ),
          if (currentList.isOwner(_currentUserEmail))
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Elimina Lista', style: TextStyle(color: Colors.red)),
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
        title: const Text('Rinomina Lista'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nuovo Nome'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _todoService.updateList(currentList.copyWith(title: controller.text));
                Navigator.pop(context);
              }
            },
            child: const Text('Salva'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteList(TodoListModel currentList) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina Lista'),
        content: const Text('Sei sicuro di voler eliminare questa lista e tutti i suoi task? Questa azione è irreversibile.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await _todoService.deleteList(currentList.id);
              if (mounted) Navigator.pop(context); // Go back to dashboard
            },
            child: const Text('Elimina'),
          ),
        ],
      ),
    );
  }

  Future<void> _showTaskDialog(TodoListModel currentList, {TodoTaskModel? task, String? initialStatusId}) async {
    // Permission check for editing
    if (task != null && !_canEditTask(task, currentList)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Puoi modificare solo i task a te assegnati')),
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
        listParticipants: currentList.participants.keys.toList(),
        listAvailableTags: currentList.availableTags,
      ),
    );

    if (result != null) {
      if (task == null) {
        await _todoService.createTask(currentList.id, result);
      } else {
        await _todoService.updateTask(currentList.id, result);
      }
    }
  }

  void _showMultiSelectAssigneeDialog(TodoListModel currentList) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
               width: 350,
               padding: EdgeInsets.zero,
               decoration: BoxDecoration(
                  color: Colors.white,
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
                       border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                     ),
                     child: Row(
                       children: [
                         Container(
                           padding: const EdgeInsets.all(8),
                           decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                           child: const Icon(Icons.filter_list_rounded, color: Colors.blue, size: 20),
                         ),
                         const SizedBox(width: 16),
                         const Text(
                           'Filtra per Persona',
                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                         ),
                         const Spacer(),
                         IconButton(
                           icon: const Icon(Icons.close_rounded),
                           onPressed: () => Navigator.pop(context),
                           style: IconButton.styleFrom(backgroundColor: Colors.grey[100]),
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
                              leading: const Icon(Icons.people_outline),
                              title: const Text('Tutte le persone'),
                              trailing: safeAssigneeFilters.isEmpty ? const Icon(Icons.check, color: Colors.blue) : null,
                              onTap: () {
                                 this.setState(() => _assigneeFilters = []); 
                                 Navigator.pop(context);
                              },
                            ),
                            const Divider(height: 1),
                            ...currentList.participants.values.map((p) {
                              final isSelected = safeAssigneeFilters.contains(p.email);
                              return CheckboxListTile(
                                activeColor: Colors.blue,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                                title: Row(
                                   children: [
                                     CircleAvatar(
                                       radius: 12, 
                                       backgroundColor: Colors.blue[100],
                                       child: Text(p.email[0].toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold)),
                                     ),
                                     const SizedBox(width: 12),
                                     Expanded(child: Text(p.displayName ?? p.email.split('@')[0], overflow: TextOverflow.ellipsis)),
                                   ],
                                ),
                                value: isSelected,
                                onChanged: (val) {
                                  setState(() {
                                    // Ensure initialized
                                    if (_assigneeFilters == null) _assigneeFilters = []; 
                                    
                                    if (val == true) {
                                      _assigneeFilters!.add(p.email);
                                    } else {
                                      _assigneeFilters!.remove(p.email);
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
                           style: TextButton.styleFrom(foregroundColor: Colors.grey[600]), 
                           child: const Text('Annulla')
                         ),
                         const SizedBox(width: 12),
                         ElevatedButton(
                           onPressed: () {
                               this.setState(() {}); // Apply
                               Navigator.pop(context);
                           },
                           style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.blue,
                             foregroundColor: Colors.white,
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                             elevation: 0,
                           ),
                           child: const Text('Applica Filtri'),
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
    if (currentList.isOwner(_currentUserEmail)) return true;
    return task.assignedTo.contains(_currentUserEmail);
  }

  void _createTask(TodoListModel currentList, {String? initialStatusId}) async {
    await _showTaskDialog(currentList, initialStatusId: initialStatusId);
  }

  void _editTask(TodoTaskModel task, TodoListModel currentList) {
    _showTaskDialog(currentList, task: task);
  }



  void _deleteTask(TodoTaskModel task, TodoListModel currentList) {
    if (!_canEditTask(task, currentList)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Non hai i permessi per eliminare questo task')),
      );
      return;
    }

    // Show confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina Attività'),
        content: const Text('Sei sicuro di voler eliminare questa attività?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _todoService.deleteTask(currentList.id, task.id); 
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Elimina'),
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Generazione foglio Google Sheets in corso...')),
    );

    try {
      final tasks = await _todoService.streamTasks(list.id).first;
      
      final url = await SmartTodoSheetsExportService().exportTodoListToGoogleSheets(
        list: list,
        tasks: tasks,
      );

      if (url != null && mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Export completato: $url')),
        );
      } else if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Errore durante l\'export (vedi log)')),
        );
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e')),
        );
      }
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
                                await _todoService.updateList(list.copyWith(availableTags: newTags));
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
                  await _todoService.updateList(list.copyWith(availableTags: newTags));
                  
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
}
