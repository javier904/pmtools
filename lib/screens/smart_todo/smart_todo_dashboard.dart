import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_participant_model.dart';
import '../../services/smart_todo_service.dart';
import '../../services/auth_service.dart';
import '../../l10n/app_localizations.dart';
import 'smart_todo_detail_screen.dart';
import 'smart_todo_global_view.dart';
import '../../widgets/home/favorite_star.dart';

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
  bool _initialNavigationChecked = false;
  String _searchQuery = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialNavigationChecked) {
      _initialNavigationChecked = true;
      _checkInitialNavigation();
    }
  }

  Future<void> _checkInitialNavigation() async {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('id')) {
      final listId = args['id'] as String;
      // Fetch list and navigate
      try {
        final lists = await _todoService.streamLists(_currentUserEmail).first;
        final targetList = lists.cast<TodoListModel?>().firstWhere(
          (l) => l?.id == listId,
          orElse: () => null,
        );
        
        if (targetList != null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SmartTodoDetailScreen(list: targetList),
            ),
          );
        }
      } catch (e) {
        debugPrint('Error navigating to list: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Current filter or default
    final currentFilter = _filterMode ?? 'today';
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n?.goToHome ?? 'Back',
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          },
        ),
        title: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.blue),
            SizedBox(width: 8),
            Text('To-Do'),
          ],
        ),
        actions: [
          _buildFilterChip(l10n?.smartTodoFilterToday ?? 'Today', Icons.today, 'today', currentFilter),
          const SizedBox(width: 8),
          _buildFilterChip(l10n?.smartTodoFilterMyTasks ?? 'My Tasks', Icons.person_outline, 'all_my', currentFilter),
          const SizedBox(width: 8),
          _buildFilterChip(l10n?.smartTodoFilterOwner ?? 'Owner', Icons.folder_shared_outlined, 'owner', currentFilter),
          const SizedBox(width: 16),
          Container(width: 1, height: 24, color: Colors.grey[300]), // Divider
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(_viewMode == 'lists' ? Icons.view_module : Icons.list_alt),
            tooltip: _viewMode == 'lists'
                ? (l10n?.smartTodoViewGlobalTasks ?? 'View Global Tasks')
                : (l10n?.smartTodoViewLists ?? 'View Lists'),
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
            return Center(child: Text(l10n?.smartTodoError(snapshot.error.toString()) ?? 'Error: ${snapshot.error}'));
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

          // Filter by search query
          if (_searchQuery.isNotEmpty) {
            lists = lists.where((l) =>
                l.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                l.description.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
          }

          if (lists.isEmpty && _searchQuery.isNotEmpty) {
             return Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: _buildSearchBar(),
                 ),
                 Expanded(child: _buildNoResultsState()),
               ],
             );
          }

          if (lists.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _buildSearchBar(),
              ),
              Expanded(
                child: GridView.builder(
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
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateListDialog,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(l10n?.smartTodoNewListDialogTitle ?? 'New List', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildSearchBar() {
    final l10n = AppLocalizations.of(context);
    return TextField(
      decoration: InputDecoration(
        hintText: l10n?.smartTodoSearchHint ?? 'Search lists...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => setState(() => _searchQuery = ''),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onChanged: (value) => setState(() => _searchQuery = value),
    );
  }

  Widget _buildNoResultsState() {
    final l10n = AppLocalizations.of(context);
     return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            l10n?.smartTodoNoSearchResults(_searchQuery) ?? 'No results for "$_searchQuery"',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.checklist, size: 80, color: Colors.blue.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            l10n?.smartTodoNoListsPresent ?? 'No lists available',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            l10n?.smartTodoCreateFirstList ?? 'Create your first list to get started',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(TodoListModel list) {
    final isOwner = list.ownerId == _currentUserEmail;
    final l10n = AppLocalizations.of(context);
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
                        FavoriteStar(
                          resourceId: list.id,
                          type: 'todo_list',
                          title: list.title,
                          colorHex: '#2196F3', // Default color for todo
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        if (isOwner)
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.more_vert, size: 16, color: Colors.grey[600]),
                              itemBuilder: (ctx) => [
                                PopupMenuItem(
                                  value: 'rename',
                                  child: Row(children: [const Icon(Icons.edit, size: 16), const SizedBox(width: 8), Text(l10n?.smartTodoEdit ?? 'Edit')]),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Row(children: [const Icon(Icons.delete, size: 16, color: Colors.red), const SizedBox(width: 8), Text(l10n?.smartTodoDelete ?? 'Delete', style: const TextStyle(color: Colors.red))]),
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
                        const SizedBox(width: 8),
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
                           Flexible(
                             child: Container(
                               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                               decoration: BoxDecoration(
                                 color: Colors.blue.withOpacity(0.1),
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               child: Text(
                                 l10n?.smartTodoMembersCount(list.participants.length) ?? '${list.participants.length} members',
                                 style: const TextStyle(fontSize: 10, color: Colors.blue),
                                 overflow: TextOverflow.ellipsis,
                               ),
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
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n?.smartTodoNewListDialogTitle ?? 'New List'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: l10n?.smartTodoTitleLabel ?? 'Title *'),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: l10n?.smartTodoDescriptionLabel ?? 'Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n?.smartTodoCancel ?? 'Cancel'),
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
                  TodoColumn(id: 'todo', title: l10n?.smartTodoColumnTodo ?? 'To Do', colorValue: 0xFF2196F3),
                  TodoColumn(id: 'in_progress', title: l10n?.smartTodoColumnInProgress ?? 'In Progress', colorValue: 0xFFFF9800),
                  TodoColumn(id: 'done', title: l10n?.smartTodoColumnDone ?? 'Done', colorValue: 0xFF4CAF50, isDone: true),
                ],
              );

              await _todoService.createList(newList, _currentUserEmail);
              if (dialogContext.mounted) Navigator.pop(dialogContext);
            },
            child: Text(l10n?.smartTodoCreate ?? 'Create'),
          ),
        ],
      ),
    );
  }
  void _showRenameListDialog(TodoListModel list) {
    final controller = TextEditingController(text: list.title);
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n?.smartTodoRenameListTitle ?? 'Rename List'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: l10n?.smartTodoNewNameLabel ?? 'New Name'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text(l10n?.smartTodoCancel ?? 'Cancel')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _todoService.updateList(list.copyWith(title: controller.text));
                Navigator.pop(dialogContext);
              }
            },
            child: Text(l10n?.smartTodoSave ?? 'Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteList(TodoListModel list) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n?.smartTodoDeleteListTitle ?? 'Delete List'),
        content: Text(l10n?.smartTodoDeleteListConfirm ?? 'Are you sure you want to delete this list and all its tasks? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text(l10n?.smartTodoCancel ?? 'Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () async {
              Navigator.pop(dialogContext); // Close dialog
              await _todoService.deleteList(list.id);
            },
            child: Text(l10n?.smartTodoDelete ?? 'Delete'),
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
          // If already selected, deselect (toggle off)
          if (isSelected) {
            _viewMode = 'lists';
            _filterMode = null;
          } else {
            // Select the filter
            if (value == 'owner') {
              _viewMode = 'lists';
              _filterMode = value;
            } else {
              _viewMode = 'global';
              _filterMode = value;
            }
          }
        });
      },
    );
  }
}
