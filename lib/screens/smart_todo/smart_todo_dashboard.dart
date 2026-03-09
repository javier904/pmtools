import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_participant_model.dart';
import '../../services/smart_todo_service.dart';
import '../../services/auth_service.dart';
import '../../services/user_profile_service.dart';
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
  bool _isCreating = false;

  // Cached stream to prevent recreation on setState
  Stream<List<TodoListModel>>? _listsStream;
  bool _lastShowArchived = false;

  Stream<List<TodoListModel>> _getListsStream() {
    if (_listsStream == null || _lastShowArchived != _showArchived) {
      _lastShowArchived = _showArchived;
      _listsStream = _todoService.streamListsFiltered(
        userEmail: _currentUserEmail,
        includeArchived: _showArchived,
      );
    }
    return _listsStream!;
  }

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
        // Aggiorna l'URL del browser con il listId
        SystemNavigator.routeInformationUpdated(uri: Uri.parse('/smart-todo/$listId'));

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
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.blue),
            SizedBox(width: 8),
            Flexible(child: Text('To-Do', overflow: TextOverflow.ellipsis)),
          ],
        ),
        actions: MediaQuery.of(context).size.width < 600
          ? [
              // ═══ MOBILE: compact actions ═══
              // View toggle
              IconButton(
                icon: Icon(_viewMode == 'lists' ? Icons.view_module : Icons.list_alt),
                tooltip: _viewMode == 'lists'
                    ? (l10n?.smartTodoViewGlobalTasks ?? 'View Global Tasks')
                    : (l10n?.smartTodoViewLists ?? 'View Lists'),
                onPressed: () => setState(() {
                  if (_viewMode == 'lists') {
                    _viewMode = 'global';
                    _filterMode = 'all_my';
                  } else {
                    _viewMode = 'lists';
                    _filterMode = null;
                  }
                }),
              ),
              // Overflow menu with filters
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'toggle_archived') {
                    setState(() => _showArchived = !_showArchived);
                  } else if (value == 'home') {
                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                  } else {
                    // Filter modes
                    setState(() => _filterMode = value);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'today',
                    child: Row(children: [
                      Icon(Icons.today, size: 18, color: currentFilter == 'today' ? Colors.blue : Colors.grey),
                      const SizedBox(width: 8),
                      Text(l10n?.smartTodoFilterToday ?? 'Today',
                        style: TextStyle(fontWeight: currentFilter == 'today' ? FontWeight.bold : FontWeight.normal)),
                    ]),
                  ),
                  PopupMenuItem(
                    value: 'all_my',
                    child: Row(children: [
                      Icon(Icons.person_outline, size: 18, color: currentFilter == 'all_my' ? Colors.blue : Colors.grey),
                      const SizedBox(width: 8),
                      Text(l10n?.smartTodoFilterMyTasks ?? 'My Tasks',
                        style: TextStyle(fontWeight: currentFilter == 'all_my' ? FontWeight.bold : FontWeight.normal)),
                    ]),
                  ),
                  PopupMenuItem(
                    value: 'owner',
                    child: Row(children: [
                      Icon(Icons.folder_shared_outlined, size: 18, color: currentFilter == 'owner' ? Colors.blue : Colors.grey),
                      const SizedBox(width: 8),
                      Text(l10n?.smartTodoFilterOwner ?? 'Owner',
                        style: TextStyle(fontWeight: currentFilter == 'owner' ? FontWeight.bold : FontWeight.normal)),
                    ]),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'toggle_archived',
                    child: Row(children: [
                      Icon(_showArchived ? Icons.visibility_off : Icons.visibility, size: 18, color: const Color(0xFF00B0FF)),
                      const SizedBox(width: 8),
                      Text(_showArchived
                          ? (l10n?.archiveHideArchived ?? 'Hide archived')
                          : (l10n?.archiveShowArchived ?? 'Show archived')),
                    ]),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'home',
                    child: Row(children: [
                      const Icon(Icons.home_rounded, size: 18, color: Color(0xFF8B5CF6)),
                      const SizedBox(width: 8),
                      Text(l10n?.navHome ?? 'Home'),
                    ]),
                  ),
                ],
              ),
            ]
          : [
              // ═══ DESKTOP: full actions ═══
              _buildFilterChip(l10n?.smartTodoFilterToday ?? 'Today', Icons.today, 'today', currentFilter),
              const SizedBox(width: 8),
              _buildFilterChip(l10n?.smartTodoFilterMyTasks ?? 'My Tasks', Icons.person_outline, 'all_my', currentFilter),
              const SizedBox(width: 8),
              _buildFilterChip(l10n?.smartTodoFilterOwner ?? 'Owner', Icons.folder_shared_outlined, 'owner', currentFilter),
              const SizedBox(width: 16),
              Container(width: 1, height: 24, color: Colors.grey[600]),
              const SizedBox(width: 16),
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
                  color: const Color(0xFF00B0FF),
                ),
                selectedColor: const Color(0xFF00B0FF).withOpacity(0.2),
                showCheckmark: false,
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(_viewMode == 'lists' ? Icons.view_module : Icons.list_alt),
                tooltip: _viewMode == 'lists'
                    ? (l10n?.smartTodoViewGlobalTasks ?? 'View Global Tasks')
                    : (l10n?.smartTodoViewLists ?? 'View Lists'),
                onPressed: () => setState(() {
                  if (_viewMode == 'lists') {
                    _viewMode = 'global';
                    _filterMode = 'all_my';
                  } else {
                    _viewMode = 'lists';
                    _filterMode = null;
                  }
                }),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.home_rounded),
                tooltip: l10n?.navHome ?? 'Home',
                color: const Color(0xFF8B5CF6),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
              ),
            ],
      ),
      body: StreamBuilder<List<TodoListModel>>(
        stream: _getListsStream(),
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
                          // ═══ MOBILE (<600px): ListView a tutta larghezza ═══
                          if (constraints.maxWidth < 600) {
                            return ListView.separated(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                              itemCount: lists.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 8),
                              itemBuilder: (context, index) => SizedBox(
                                height: 90,
                                child: _buildListCard(lists[index]),
                              ),
                            );
                          }

                          // ═══ DESKTOP (>=600px): GridView originale ═══
                          final compactCrossAxisCount = constraints.maxWidth > 1400
                              ? 6
                              : constraints.maxWidth > 1100
                                  ? 5
                                  : constraints.maxWidth > 800
                                      ? 4
                                      : 3;

                          return GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: compactCrossAxisCount,
                              childAspectRatio: 2.5,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: lists.length,
                            itemBuilder: (context, index) => _buildListCard(lists[index]),
                          );
                        },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: MediaQuery.of(context).size.width < 700
          ? null
          : FloatingActionButton.extended(
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
                if (MediaQuery.of(context).size.width < 700) ...[
                  const SizedBox(width: 8),
                  ActionChip(
                    label: Text(
                      l10n?.smartTodoNewListDialogTitle ?? 'New List',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: _showCreateListDialog,
                  ),
                ],
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
          Navigator.pushNamed(
            context,
            '/smart-todo/${list.id}',
          );
        },
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: StreamBuilder<({int total, int completed})>(
            stream: _todoService.streamTaskCompletionStats(list.id, doneColumnIds: doneColumnIds),
            builder: (context, snapshot) {
              final stats = snapshot.data;
              final total = stats?.total ?? 0;
              final completed = stats?.completed ?? 0;
              final allDone = total > 0 && completed == total;
              final pendingTasks = total - completed;
              final progress = total > 0 ? completed / total : 0.0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header fisso: Icona + Titolo + Favoriti + Menu
                  SizedBox(
                    height: 26,
                    child: Row(
                      children: [
                        Tooltip(
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
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Tooltip(
                            message: '${list.title}${list.description.isNotEmpty ? '\n${list.description}' : ''}',
                            child: Text(
                              list.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: list.isArchived ? Colors.grey : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        FavoriteStar(
                          resourceId: list.id,
                          type: 'todo_list',
                          title: list.title,
                          colorHex: '#2196F3',
                          size: 16,
                        ),
                        const SizedBox(width: 4),
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
                  ),
                  const SizedBox(height: 2),
                  // Badges: ruolo + archiviato
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: isOwner ? Colors.blue.withOpacity(0.1) : Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isOwner ? (l10n?.retroOwner ?? 'Owner') : (l10n?.retroGuest ?? 'Ospite'),
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: isOwner ? Colors.blue : Colors.purple,
                          ),
                        ),
                      ),
                      if (list.isArchived) ...[
                        const SizedBox(width: 4),
                        Tooltip(
                          message: l10n?.archiveBadge ?? 'Archived',
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.archive, size: 10, color: Colors.orange),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Progress bar
                  Tooltip(
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
                  ),
                  const SizedBox(height: 2),
                  // Stats compatte — FittedBox scala proporzionalmente, mai nasconde
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (pendingTasks > 0) ...[
                            _buildCompactListStat(
                              Icons.radio_button_unchecked,
                              '$pendingTasks',
                              l10n?.smartTodoPendingTasks ?? 'Tasks to complete',
                              iconColor: AppColors.warning,
                            ),
                            const SizedBox(width: 12),
                          ],
                          if (completed > 0) ...[
                            _buildCompactListStat(
                              Icons.check_circle_outline,
                              '$completed',
                              l10n?.smartTodoCompletedTasks ?? 'Completed tasks',
                              iconColor: AppColors.success,
                            ),
                            const SizedBox(width: 12),
                          ],
                          _buildCompactListStat(
                            Icons.calendar_today,
                            _formatDate(list.createdAt),
                            l10n?.smartTodoCreatedDate ?? 'Created date',
                          ),
                          const SizedBox(width: 12),
                          _buildParticipantListStat(list, l10n),
                          if (list.availableTags.isNotEmpty) ...[
                            const SizedBox(width: 12),
                            _buildTagsListStat(list, l10n),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
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
    Future<String> buildTooltipText() async {
      final participantLines = <String>[];
      final userProfileService = UserProfileService();
      
      // Owner
      final ownerParticipant = list.participants[list.ownerId];
      final fallbackOwnerName = ownerParticipant?.displayName?.isNotEmpty == true
          ? ownerParticipant!.displayName!
          : list.ownerId;
      final resolvedOwnerName = await userProfileService.tryGetNameByEmail(list.ownerId) ?? fallbackOwnerName;
      participantLines.add('$resolvedOwnerName - 👑 Owner');

      // Partecipanti (non-owner)
      for (final entry in list.participants.entries) {
        if (entry.key == list.ownerId) continue;
        final fallbackName = entry.value.displayName?.isNotEmpty == true
            ? entry.value.displayName!
            : entry.key.split('@').first;
        final resolvedName = await userProfileService.tryGetNameByEmail(entry.key) ?? fallbackName;
        participantLines.add('$resolvedName - 👥 ${l10n?.smartTodoParticipantRole ?? 'Participant'}');
      }

      return '${l10n?.participants ?? 'Participants'}:\n${participantLines.join('\n')}';
    }

    return FutureBuilder<String>(
      future: buildTooltipText(),
      builder: (context, snapshot) {
        final tooltipText = snapshot.data ?? '${l10n?.participants ?? 'Participants'}...';
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
      },
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
    // Prevent duplicate dialogs from rapid tapping
    if (_isCreating) return;
    _isCreating = true;

    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final l10n = AppLocalizations.of(context);

    await showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) {
          bool isSubmitting = false;

          return AlertDialog(
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
              StatefulBuilder(
                builder: (context, setButtonState) {
                  return ElevatedButton(
                    onPressed: isSubmitting ? null : () async {
                      if (titleController.text.isEmpty) return;

                      setDialogState(() => isSubmitting = true);

                      // Fast client-side limit check (instant)
                      final limitCheck = await _limitsService.canCreateList(_currentUserEmail);

                      if (!limitCheck.allowed) {
                        if (dialogContext.mounted) Navigator.pop(dialogContext);
                        if (mounted) {
                          LimitReachedDialog.show(
                            context: this.context,
                            limitResult: limitCheck,
                            entityType: 'smart_todo',
                          );
                        }
                        return;
                      }

                      // Server-side validation fire-and-forget (audit only, non-blocking)
                      _limitsService.validateServerSide('smart_todo');

                      final newList = TodoListModel(
                        id: '',
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
                    child: isSubmitting
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text(l10n?.smartTodoCreate ?? 'Create'),
                  );
                },
              ),
            ],
          );
        },
      ),
    );

    _isCreating = false;
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
          autofocus: MediaQuery.of(dialogContext).size.width > 600,
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
