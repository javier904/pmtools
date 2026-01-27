import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_participant_model.dart';
import '../../services/smart_todo_service.dart';
import '../../services/auth_service.dart';
import '../../l10n/app_localizations.dart';
import '../../themes/app_colors.dart';
import 'smart_todo_detail_screen.dart';
import 'smart_todo_global_view.dart';
import '../../widgets/home/favorite_star.dart';
import '../../services/subscription/subscription_limits_service.dart';
import '../../widgets/subscription/limit_reached_dialog.dart';

import 'dart:async'; // Add import

// ... (existing imports, ensure this is at top, but tool replaces contiguous block so handle with care or just add Timer logic if imports are separate)

class SmartTodoDashboard extends StatefulWidget {
  const SmartTodoDashboard({super.key});

  @override
  State<SmartTodoDashboard> createState() => _SmartTodoDashboardState();
}

class _SmartTodoDashboardState extends State<SmartTodoDashboard> {
  final SmartTodoService _todoService = SmartTodoService();
  final AuthService _authService = AuthService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();
  
  String get _currentUserEmail => _authService.currentUser?.email ?? '';
  String _viewMode = 'lists'; // 'lists', 'global'
  String? _filterMode; // Nullable to handle Hot Reload init issues
  String _statusFilter = 'all'; // 'all', 'active', 'completed'
  bool _initialNavigationChecked = false;
  String _searchQuery = '';
  bool _showArchived = false;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

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
    if (args != null && (args.containsKey('id') || args.containsKey('listId'))) {
      final listId = (args['id'] ?? args['listId']) as String;
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
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
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
          IconButton(
            icon: Icon(_viewMode == 'lists' ? Icons.view_module : Icons.list_alt),
            tooltip: _viewMode == 'lists'
                ? (l10n?.smartTodoViewGlobalTasks ?? 'View Global Tasks')
                : (l10n?.smartTodoViewLists ?? 'View Lists'),
            onPressed: () => setState(() {
              if (_viewMode == 'lists') {
                _viewMode = 'global';
                // _filterMode = 'all_my'; // Default to "My Tasks" when entering global view
              } else {
                _viewMode = 'lists';
                _filterMode = null; // Clear filter when going back to lists
              }
            }),
          ),
          const SizedBox(width: 8),
          // Archived toggle
          FilterChip(
            label: Text(
              _showArchived
                  ? (l10n?.archiveHideArchived ?? 'Hide archived')
                  : (l10n?.archiveShowArchived ?? 'Show archived'),
              style: const TextStyle(fontSize: 12),
            ),
            selected: _showArchived,
            onSelected: (value) => setState(() => _showArchived = value),
            avatar: Icon(
              _showArchived ? Icons.visibility_off : Icons.visibility,
              size: 16,
              color: const Color(0xFF00B0FF), // Celeste
            ),
            selectedColor: const Color(0xFF00B0FF).withOpacity(0.2),
            showCheckmark: false,
          ),
          // Home button
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.home_rounded),
            tooltip: l10n?.navHome ?? 'Home',
            color: const Color(0xFF8B5CF6), // Viola come icona app
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
          ),
        ],
      ),
      body: StreamBuilder<List<TodoListModel>>(
        stream: _todoService.streamListsFiltered(
          userEmail: _currentUserEmail,
          includeArchived: _showArchived,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(l10n?.smartTodoError(snapshot.error.toString()) ?? 'Error: ${snapshot.error}'));
          }


          var lists = snapshot.data ?? [];

          // Apply Status Filter (manual filtering because stream with includeArchived=true returns all)
          if (_statusFilter == 'completed') {
             lists = lists.where((l) => l.isArchived).toList();
          } else if (_statusFilter == 'active') {
             // If stream works as expected (includeArchived: false), this might be redundant but safe
             lists = lists.where((l) => !l.isArchived).toList();
          }
          
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

          // Define userLists from filtered lists
          final userLists = lists;

          return Column(
            children: [
              _buildSearchFilterSection(l10n!),
              const SizedBox(height: 12),
              Expanded(
                child: userLists.isEmpty
                    ? (snapshot.data!.isEmpty 
                        ? _buildEmptyState() // No data at all (before filters) -> Empty State
                        : _buildNoResultsState()) // Data exists but filtered out -> No Results
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          // Card compatte - stesso layout di Agile Process Manager
                          final compactCrossAxisCount = constraints.maxWidth > 1400
                  
                        ? 6
                        : constraints.maxWidth > 1100
                            ? 5
                            : constraints.maxWidth > 800
                                ? 4
                                : constraints.maxWidth > 550
                                    ? 3
                                    : constraints.maxWidth > 350
                                        ? 2
                                        : 1;

                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Reverted to 16
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: compactCrossAxisCount,
                        childAspectRatio: 2.5, // Match Eisenhower exact ratio
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: lists.length,
                      itemBuilder: (context, index) {
                        return _buildListCard(lists[index]);
                      },
                    );
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

  Widget _buildSearchFilterSection(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.smartTodoSearchHint ?? 'Search lists...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                setState(() => _searchQuery = value);
              });
            },
          ),
          const SizedBox(height: 12),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStandardFilterChip((l10n?.retroFilterAll ?? 'All'), 'all'),
                const SizedBox(width: 8),
                _buildStandardFilterChip((l10n?.retroFilterActive ?? 'Active'), 'active'),
                const SizedBox(width: 8),
                _buildStandardFilterChip((l10n?.retroFilterCompleted ?? 'Completed'), 'completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStandardFilterChip(String label, String status) {
    final isSelected = _statusFilter == status;
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) {
          setState(() {
            _statusFilter = status;
            
            // Map to _showArchived for service compatibility
            // active -> _showArchived = false
            // all -> _showArchived = true (to fetch them)
            // completed -> _showArchived = true (to fetch them)
            if (_statusFilter == 'active') _showArchived = false;
            else _showArchived = true;
          });
        }
      },
      backgroundColor: Theme.of(context).cardColor,
      selectedColor: const Color(0xFF00B0FF).withOpacity(0.2),
      checkmarkColor: const Color(0xFF00B0FF),
      side: BorderSide(
        color: isSelected ? const Color(0xFF00B0FF) : Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
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
    final doneColumnIds = list.columns
        .where((c) => c.isDone)
        .map((c) => c.id)
        .toSet();

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SmartTodoDetailScreen(list: list),
            ),
          );
        },
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(6), // Reduced padding (was 8)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header: Icona + Titolo + Menu
              Row(
                children: [
                  // Icona lista con stato completamento
                  StreamBuilder<({int total, int completed})>(
                    stream: _todoService.streamTaskCompletionStats(list.id, doneColumnIds: doneColumnIds),
                    builder: (context, snapshot) {
                      final stats = snapshot.data;
                      final total = stats?.total ?? 0;
                      final completed = stats?.completed ?? 0;
                      final allDone = total > 0 && completed == total;

                      return Tooltip(
                        message: total == 0
                            ? (l10n?.smartTodoNoTasks ?? 'No tasks')
                            : '${l10n?.smartTodoCompletionStats(completed, total) ?? '$completed/$total completed'}',
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: (allDone ? Colors.green : Colors.blue).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            allDone ? Icons.check_circle : Icons.checklist,
                            color: allDone ? Colors.green : Colors.blue,
                            size: 14,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 6),
                  // Titolo con tooltip
                  Expanded(
                    child: Tooltip(
                      message: '${list.title}${list.description.isNotEmpty ? '\n${list.description}' : ''}',
                      child: Text(
                        list.title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: list.isArchived ? Colors.grey : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Badge archiviato
                  if (list.isArchived)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Tooltip(
                        message: l10n?.archiveBadge ?? 'Archived',
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.archive, size: 12, color: Colors.orange),
                        ),
                      ),
                    ),
                  FavoriteStar(
                    resourceId: list.id,
                    type: 'todo_list',
                    title: list.title,
                    colorHex: '#2196F3',
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  // Menu compatto
                  if (isOwner)
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _showListMenuAtPosition(context, list, details.globalPosition);
                      },
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Icon(Icons.more_vert, size: 16, color: Colors.grey[600]),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2), // Reduced spacing (was 4)
              // Progress bar
              StreamBuilder<({int total, int completed})>(
                stream: _todoService.streamTaskCompletionStats(list.id, doneColumnIds: doneColumnIds),
                builder: (context, snapshot) {
                  final stats = snapshot.data;
                  final total = stats?.total ?? 0;
                  final completed = stats?.completed ?? 0;
                  final progress = total > 0 ? completed / total : 0.0;

                  return Tooltip(
                    message: l10n?.smartTodoCompletionStats(completed, total) ?? '$completed/$total completed',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progress == 1.0 ? Colors.green : Colors.blue,
                        ),
                        minHeight: 2,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 2), // Reduced spacing (was 4)
              // Stats compatte
              StreamBuilder<({int total, int completed})>(
                stream: _todoService.streamTaskCompletionStats(list.id, doneColumnIds: doneColumnIds),
                builder: (context, statsSnapshot) {
                  final statsData = statsSnapshot.data;
                  final totalTasks = statsData?.total ?? 0;
                  final completedTasks = statsData?.completed ?? 0;
                  final pendingTasks = totalTasks - completedTasks;

                  return Row(
                    children: [
                      if (pendingTasks > 0)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _buildCompactListStat(
                            Icons.radio_button_unchecked,
                            '$pendingTasks',
                            l10n?.smartTodoPendingTasks ?? 'Tasks to complete',
                            iconColor: AppColors.warning,
                          ),
                        ),
                      if (completedTasks > 0)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _buildCompactListStat(
                            Icons.check_circle_outline,
                            '$completedTasks',
                            l10n?.smartTodoCompletedTasks ?? 'Completed tasks',
                            iconColor: AppColors.success,
                          ),
                        ),
                      _buildCompactListStat(
                        Icons.calendar_today,
                        _formatDate(list.createdAt),
                        l10n?.smartTodoCreatedDate ?? 'Created date',
                      ),
                      const SizedBox(width: 10),
                      _buildParticipantListStat(list, l10n),
                    ],
                  );
                },
              ),
              // Tags on a new line (Bottom Left)
              if (list.availableTags.isNotEmpty) ...[
                const SizedBox(height: 2), // Reduced spacing (was 4)
                _buildTagsListStat(list, l10n),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactListStat(IconData icon, String value, String tooltip, {Color? iconColor}) {
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor ?? Colors.grey),
          const SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Costruisce la statistica partecipanti con tooltip dettagliato (owner + partecipanti)
  Widget _buildParticipantListStat(TodoListModel list, AppLocalizations? l10n) {
    final participantLines = <String>[];

    // Owner
    final ownerParticipant = list.participants[list.ownerId];
    final ownerName = ownerParticipant?.displayName?.isNotEmpty == true
        ? ownerParticipant!.displayName!
        : list.ownerId;
    participantLines.add('$ownerName - 👑 Owner');

    // Partecipanti (non-owner)
    for (final entry in list.participants.entries) {
      if (entry.key == list.ownerId) continue;
      final name = entry.value.displayName?.isNotEmpty == true
          ? entry.value.displayName!
          : entry.value.email;
      participantLines.add('$name - 👥 ${l10n?.smartTodoParticipantRole ?? 'Participant'}');
    }

    final tooltipText = '${l10n?.participants ?? 'Participants'}:\n${participantLines.join('\n')}';

    return Tooltip(
      message: tooltipText,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people, size: 18, color: Colors.grey),
          const SizedBox(width: 5),
          Text(
            '${list.participants.length}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Costruisce la statistica tags con tooltip della lista completa
  Widget _buildTagsListStat(TodoListModel list, AppLocalizations? l10n) {
    final tagNames = list.availableTags.map((tag) => '🏷️ ${tag.name}').toList();
    final tooltipText = 'Tags:\n${tagNames.join('\n')}';

    return Tooltip(
      message: tooltipText,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_offer, size: 18, color: Colors.grey),
          const SizedBox(width: 5),
          Text(
            '${list.availableTags.length}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _showCreateListDialog() async {
    // Verifica limite liste prima di mostrare il dialog
    final limitCheck = await _limitsService.canCreateList(_currentUserEmail);
    if (!limitCheck.allowed) {
      if (mounted) {
        LimitReachedDialog.show(
          context: context,
          limitResult: limitCheck,
          entityType: 'smart_todo',
        );
      }
      return;
    }

    // Double-check server-side
    final serverCheck = await _limitsService.validateServerSide('smart_todo');
    if (!serverCheck.allowed) {
      if (mounted) {
        LimitReachedDialog.show(
          context: context,
          limitResult: serverCheck,
          entityType: 'smart_todo',
        );
      }
      return;
    }

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

  void _showListMenuAtPosition(BuildContext context, TodoListModel list, Offset globalPosition) async {
    final l10n = AppLocalizations.of(context);
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromLTRB(
      globalPosition.dx,
      globalPosition.dy,
      overlay.size.width - globalPosition.dx,
      overlay.size.height - globalPosition.dy,
    );

    final result = await showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          value: 'rename',
          child: Row(children: [const Icon(Icons.edit, size: 16), const SizedBox(width: 8), Text(l10n?.smartTodoEdit ?? 'Edit')]),
        ),
        // Archive/Restore option
        PopupMenuItem(
          value: list.isArchived ? 'restore' : 'archive',
          child: Row(children: [
            Icon(
              list.isArchived ? Icons.unarchive : Icons.archive,
              size: 16,
              color: Colors.orange,
            ),
            const SizedBox(width: 8),
            Text(list.isArchived ? (l10n?.archiveRestoreAction ?? 'Restore') : (l10n?.archiveAction ?? 'Archive')),
          ]),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(children: [const Icon(Icons.delete, size: 16, color: Colors.red), const SizedBox(width: 8), Text(l10n?.smartTodoDelete ?? 'Delete', style: const TextStyle(color: Colors.red))]),
        ),
      ],
    );

    if (!mounted || result == null) return;

    if (result == 'rename') {
      _showRenameListDialog(list);
    } else if (result == 'archive') {
      _archiveList(list);
    } else if (result == 'restore') {
      _restoreList(list);
    } else if (result == 'delete') {
      _confirmDeleteList(list);
    }
  }

  Future<void> _archiveList(TodoListModel list) async {
    final l10n = AppLocalizations.of(context);
    final success = await _todoService.archiveList(list.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? (l10n?.archiveSuccessMessage ?? 'Archived') : (l10n?.archiveErrorMessage ?? 'Error')),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Future<void> _restoreList(TodoListModel list) async {
    final l10n = AppLocalizations.of(context);
    final success = await _todoService.restoreList(list.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? (l10n?.archiveRestoreSuccessMessage ?? 'Restored') : (l10n?.archiveRestoreErrorMessage ?? 'Error')),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
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
