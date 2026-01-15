import 'package:flutter/material.dart';
import '../../services/smart_todo_service.dart';
import '../../services/auth_service.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_participant_model.dart';
import 'smart_todo_detail_screen.dart';
import 'smart_todo_global_view.dart';

class SmartTodoDashboard extends StatefulWidget {
  const SmartTodoDashboard({super.key});

  @override
  State<SmartTodoDashboard> createState() => _SmartTodoDashboardState();
}

class _SmartTodoDashboardState extends State<SmartTodoDashboard> {
  final SmartTodoService _todoService = SmartTodoService();
  final AuthService _authService = AuthService();
  
  String get _currentUserEmail => _authService.currentUser?.email ?? '';
  String _viewMode = 'lists'; // 'lists', 'global'
  String? _filterMode; // Nullable to handle Hot Reload init issues

  @override
  Widget build(BuildContext context) {
    // Current filter or default
    final currentFilter = _filterMode ?? 'today';

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.check_circle_outline),
            SizedBox(width: 8),
            Text('To-Do'),
          ],
        ),
        actions: [
          _buildFilterChip('Oggi', Icons.today, 'today', currentFilter),
          const SizedBox(width: 8),
          _buildFilterChip('I Miei Task', Icons.person_outline, 'all_my', currentFilter),
          const SizedBox(width: 8),
          _buildFilterChip('Owner', Icons.folder_shared_outlined, 'owner', currentFilter),
          const SizedBox(width: 16),
          Container(width: 1, height: 24, color: Colors.grey[300]), // Divider
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(_viewMode == 'lists' ? Icons.view_module : Icons.list_alt),
            tooltip: _viewMode == 'lists' ? 'Vedi Task Globali' : 'Vedi Liste',
            onPressed: () => setState(() {
              if (_viewMode == 'lists') {
                _viewMode = 'global';
                _filterMode = 'all_my'; // Default to "My Tasks" when entering global view
              } else {
                _viewMode = 'lists';
                _filterMode = null; // Clear filter when going back to lists
              }
            }),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: StreamBuilder<List<TodoListModel>>(
        stream: _todoService.streamLists(_currentUserEmail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          }

          var lists = snapshot.data ?? [];
          
          // Apply "Owner" filter for lists
          if (currentFilter == 'owner') {
             lists = lists.where((l) => l.ownerId == _currentUserEmail).toList();
          }

          if (_viewMode == 'global') {
            return SmartTodoGlobalView(
              userLists: lists, 
              todoService: _todoService,
              filterMode: currentFilter,
            );
          }

          if (lists.isEmpty) {
            return _buildEmptyState();
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240, // Reduced size (~30% less than 350)
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3, // Adjusted for narrower width
            ),
            itemCount: lists.length,
            itemBuilder: (context, index) {
              return _buildListCard(lists[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateListDialog,
        icon: const Icon(Icons.add),
        label: const Text('Nuova Lista'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.checklist, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Nessuna lista presente',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          const Text(
            'Crea la tua prima lista per iniziare',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(TodoListModel list) {
    final isOwner = list.ownerId == _currentUserEmail;
    
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: isDark ? const Color(0xFF2D3748) : Colors.white, // Explicit dark surface
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SmartTodoDetailScreen(list: list),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 6,
              color: isOwner ? Colors.blue : Colors.green,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            list.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isOwner)
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.more_vert, size: 16, color: Colors.grey[600]),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'rename',
                                  child: Row(children: [Icon(Icons.edit, size: 16), SizedBox(width: 8), Text('Modifica')]),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(children: [Icon(Icons.delete, size: 16, color: Colors.red), SizedBox(width: 8), Text('Elimina', style: TextStyle(color: Colors.red))]),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'rename') {
                                  _showRenameListDialog(list);
                                } else if (value == 'delete') {
                                  _confirmDeleteList(list);
                                }
                              },
                            ),
                          )
                        else
                          const Icon(Icons.group, size: 16, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        list.description,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Bottom Row: Date | TaskCount | Members
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 12, color: Colors.grey[400]),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(list.createdAt),
                          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                        ),
                        const SizedBox(width: 12),
                        // Task Count
                        StreamBuilder<int>(
                          stream: _todoService.streamTaskCountRealtime(list.id),
                          builder: (context, snapshot) {
                             final count = snapshot.data ?? 0;
                             if (count == 0) return const SizedBox.shrink();
                             return Row(
                               children: [
                                 Icon(Icons.check_box_outlined, size: 12, color: Colors.grey[400]),
                                 const SizedBox(width: 4),
                                 Text(
                                   '$count',
                                   style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                                 ),
                               ],
                             );
                          },
                        ),
                        const Spacer(),
                        if (list.participants.isNotEmpty)
                           Container(
                             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                             decoration: BoxDecoration(
                               color: Colors.blue.withOpacity(0.1),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Text(
                               '${list.participants.length} membri',
                               style: const TextStyle(fontSize: 10, color: Colors.blue),
                             ),
                           ),
                      ],
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showCreateListDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuova Lista'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Titolo *'),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descrizione'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isEmpty) return;

              final newList = TodoListModel(
                id: '', // Generated by service
                title: titleController.text.trim(),
                description: descriptionController.text.trim(),
                ownerId: _currentUserEmail,
                createdAt: DateTime.now(),
                participants: {
                  _currentUserEmail: TodoParticipant(
                    email: _currentUserEmail,
                    role: TodoParticipantRole.owner,
                    joinedAt: DateTime.now(),
                  )
                },
                columns: [
                  const TodoColumn(id: 'todo', title: 'Da Fare', colorValue: 0xFF2196F3),
                  const TodoColumn(id: 'in_progress', title: 'In Corso', colorValue: 0xFFFF9800),
                  const TodoColumn(id: 'done', title: 'Fatto', colorValue: 0xFF4CAF50, isDone: true),
                ],
              );

              await _todoService.createList(newList, _currentUserEmail);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Crea'),
          ),
        ],
      ),
    );
  }
  void _showRenameListDialog(TodoListModel list) {
    final controller = TextEditingController(text: list.title);
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
                _todoService.updateList(list.copyWith(title: controller.text));
                Navigator.pop(context);
              }
            },
            child: const Text('Salva'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteList(TodoListModel list) {
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
              await _todoService.deleteList(list.id);
            },
            child: const Text('Elimina'),
          ),
        ],
      ),
    );
  }
  Widget _buildFilterChip(String label, IconData icon, String value, String currentValue) {
    bool isSelected = false;
    if (value == 'owner') {
      // Owner filter is active if value matches AND we are in lists view
      isSelected = currentValue == value && _viewMode == 'lists';
    } else {
      // Task filters active if value matches AND we are in global view
      isSelected = currentValue == value && _viewMode == 'global';
    }
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ActionChip(
      avatar: Icon(icon, size: 16, color: isSelected ? Colors.blue : (isDark ? Colors.grey[400] : Colors.grey[700])),
      label: Text(label, style: TextStyle(color: isSelected ? Colors.blue : (isDark ? Colors.grey[300] : Colors.grey[800]), fontSize: 13)),
      backgroundColor: isDark ? const Color(0xFF2D3748) : Colors.white, // Dark surface or white
      side: BorderSide(color: isSelected ? Colors.blue.withOpacity(0.3) : (isDark ? Colors.grey.withOpacity(0.2) : Colors.grey[300]!)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      onPressed: () {
        setState(() {
          if (value == 'owner') {
            _viewMode = 'lists';
            _filterMode = value;
          } else {
            _viewMode = 'global';
            _filterMode = value;
          }
        });
      },
    );
  }
}
