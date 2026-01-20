import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/planning_poker_session_model.dart';
import '../models/planning_poker_story_model.dart';
import '../models/planning_poker_participant_model.dart';
import '../models/planning_poker_invite_model.dart';
import '../models/smart_todo/todo_list_model.dart';
import '../models/smart_todo/todo_task_model.dart';
import '../models/smart_todo/todo_participant_model.dart';
import '../services/planning_poker_firestore_service.dart';
import '../services/planning_poker_invite_service.dart';
import '../services/smart_todo_service.dart';
import '../services/auth_service.dart';
import '../widgets/estimation_room/session_form_dialog.dart';
import '../widgets/estimation_room/story_form_dialog.dart';
import '../widgets/estimation_room/voting_board_widget.dart';
import '../widgets/estimation_room/results_panel_widget.dart';
import '../widgets/estimation_room/participant_list_widget.dart';
import '../widgets/estimation_room/session_search_widget.dart';
import '../widgets/estimation_room/estimation_input_wrapper.dart';
import '../widgets/estimation_room/export_to_smart_todo_dialog.dart';
import '../widgets/estimation_room/export_to_agile_sprint_dialog.dart';
import '../models/estimation_mode.dart';
import '../models/agile_project_model.dart';
import '../models/sprint_model.dart';
import '../models/user_story_model.dart';
import '../models/agile_enums.dart' as agile;
import '../services/agile_firestore_service.dart';
import '../widgets/home/favorite_star.dart';
import 'agile_project_detail_screen.dart';

/// Screen principale per l'Estimation Room
///
/// Implementa:
/// - Lista delle sessioni create dall'utente
/// - Creazione/modifica/eliminazione sessioni
/// - Gestione stories con votazione real-time
/// - Visualizzazione voti e statistiche
class EstimationRoomScreen extends StatefulWidget {
  final String? initialSessionId;

  const EstimationRoomScreen({
    super.key,
    this.initialSessionId,
  });

  @override
  State<EstimationRoomScreen> createState() => _EstimationRoomScreenState();
}

class _EstimationRoomScreenState extends State<EstimationRoomScreen> {
  final PlanningPokerFirestoreService _firestoreService = PlanningPokerFirestoreService();
  final SmartTodoService _todoService = SmartTodoService();
  final AgileFirestoreService _agileService = AgileFirestoreService();
  final AuthService _authService = AuthService();

  // Stato
  PlanningPokerSessionModel? _selectedSession;
  List<PlanningPokerStoryModel> _stories = [];
  PlanningPokerStoryModel? _currentStory;
  String? _myVote;
  bool _isLoading = true;

  // Stream subscription per aggiornamenti real-time delle storie
  StreamSubscription<List<PlanningPokerStoryModel>>? _storiesSubscription;

  bool _isDeepLink = false;

  // Filtri ricerca sessioni
  String _searchQuery = '';
  PlanningPokerSessionStatus? _statusFilter;
  EstimationMode? _modeFilter;

  String get _currentUserEmail => _authService.currentUser?.email ?? '';
  String get _currentUserName => _authService.currentUser?.displayName ?? _currentUserEmail.split('@').first;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _storiesSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkRouteArguments();
  }

  Future<void> _checkRouteArguments() async {
    // If already initialized with a specific session, skip
    if (_selectedSession != null || widget.initialSessionId != null) {
      if (widget.initialSessionId != null && _selectedSession == null) {
        // Handle constraint initialSessionId
         await _initializeWithSession(widget.initialSessionId!);
      }
      return;
    }

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic> && args.containsKey('id')) {
      _isDeepLink = true;
      final sessionId = args['id'] as String;
      await _initializeWithSession(sessionId);
    } else {
      _loadData();
    }
  }

  /// Inizializza con una sessione specifica
  Future<void> _initializeWithSession(String sessionId) async {
    setState(() => _isLoading = true);
    try {
      final session = await _firestoreService.getSession(sessionId);
      if (session != null && mounted) {
        setState(() {
          _selectedSession = session;
        });
        await _loadStories(session.id);
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        _showError('${l10n.errorLoadingSession}: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      if (_selectedSession != null) {
        await _loadStories(_selectedSession!.id);
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      _showError('${l10n.errorLoading}: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadStories(String sessionId) async {
    try {
      final stories = await _firestoreService.getStories(sessionId);
      if (mounted) {
        setState(() {
          _stories = stories;
          _currentStory = stories.currentlyVoting;
          _myVote = _currentStory?.getUserVote(_currentUserEmail)?.value;
        });
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      _showError('${l10n.errorLoadingStories}: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: _selectedSession != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (_isDeepLink && Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    _storiesSubscription?.cancel();
                    setState(() => _selectedSession = null);
                  }
                },
                tooltip: l10n.estimationBackToSessions,
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: l10n.goToHome,
                onPressed: () {
                   if (Navigator.of(context).canPop()) {
                     Navigator.of(context).pop();
                   } else {
                     Navigator.of(context).pushReplacementNamed('/home');
                   }
                },
              ),
        title: Row(
          children: [
            Icon(_selectedSession != null ? Icons.analytics : Icons.casino_rounded),
            const SizedBox(width: 8),
            Text(_selectedSession?.name ?? l10n.estimationTitle),
          ],
        ),
        actions: _buildAppBarActions(),
      ),
      body: _selectedSession == null ? _buildSessionList() : _buildSessionDetail(),
      floatingActionButton: _buildFAB(),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_selectedSession == null) return [];
    final l10n = AppLocalizations.of(context)!;

    return [
      // ═══════════════════════════════════════════════════════════
      // EXPORT/INTEGRATION BUTTONS (left side)
      // ═══════════════════════════════════════════════════════════
      // Export to Smart Todo
      IconButton(
        icon: const Icon(Icons.check_circle_outline_rounded),
        tooltip: l10n.exportFromEstimation,
        onPressed: _stories.any((s) => s.finalEstimate != null)
            ? _showExportToSmartTodoDialog
            : null,
      ),
      // Export to Agile Sprint
      IconButton(
        icon: const Icon(Icons.rocket_launch_rounded),
        tooltip: l10n.exportToAgileSprint,
        onPressed: _stories.any((s) => s.finalEstimate != null)
            ? _showExportToAgileSprintDialog
            : null,
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
      // Status badge
      _buildStatusBadge(),
      const SizedBox(width: 8),
      // Partecipanti
      IconButton(
        icon: Badge(
          label: Text('${_selectedSession!.participantCount}'),
          child: const Icon(Icons.people),
        ),
        tooltip: l10n.participants,
        onPressed: _showParticipantsDialog,
      ),
      // Impostazioni
      IconButton(
        icon: const Icon(Icons.settings),
        tooltip: l10n.estimationSessionSettings,
        onPressed: _showSessionSettings,
      ),
      const SizedBox(width: 8),
      // Torna alla lista
      TextButton.icon(
        icon: const Icon(Icons.arrow_back, size: 18),
        label: Text(l10n.estimationList),
        style: TextButton.styleFrom(foregroundColor: Colors.white),
        onPressed: () {
          _storiesSubscription?.cancel();
          setState(() {
            _selectedSession = null;
            _stories = [];
            _currentStory = null;
            _myVote = null;
          });
        },
      ),
    ];
  }

  Widget _buildStatusBadge() {
    final l10n = AppLocalizations.of(context)!;
    final status = _selectedSession!.status;
    Color color;
    String label;

    switch (status) {
      case PlanningPokerSessionStatus.draft:
        color = Colors.grey;
        label = l10n.sessionStatusDraft;
        break;
      case PlanningPokerSessionStatus.active:
        color = Colors.green;
        label = l10n.sessionStatusActive;
        break;
      case PlanningPokerSessionStatus.completed:
        color = Colors.blue;
        label = l10n.sessionStatusCompleted;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // LISTA SESSIONI
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildSessionList() {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<List<PlanningPokerSessionModel>>(
      stream: _firestoreService.streamSessionsByUser(_currentUserEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('${l10n.stateError}: ${snapshot.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadData,
                  child: Text(l10n.actionRetry),
                ),
              ],
            ),
          );
        }

        final sessions = snapshot.data ?? [];

        if (sessions.isEmpty) {
          return _buildEmptyState();
        }

        // Applica i filtri
        final filteredSessions = sessions.applyFilters(
          searchQuery: _searchQuery,
          statusFilter: _statusFilter,
          modeFilter: _modeFilter,
        );

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Icon(Icons.folder_open, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text(
                    l10n.estimationSessionsCount(filteredSessions.length, sessions.length),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Widget di ricerca e filtri
              SessionSearchWidget(
                onSearchChanged: (query) => setState(() => _searchQuery = query),
                statusFilter: _statusFilter,
                onStatusFilterChanged: (status) => setState(() => _statusFilter = status),
                modeFilter: _modeFilter,
                onModeFilterChanged: (mode) => setState(() => _modeFilter = mode),
                showModeFilter: true,
              ),
              const SizedBox(height: 12),
              // Barra filtri attivi
              ActiveFiltersBar(
                searchQuery: _searchQuery,
                statusFilter: _statusFilter,
                modeFilter: _modeFilter,
                onClearSearch: () => setState(() => _searchQuery = ''),
                onClearStatus: () => setState(() => _statusFilter = null),
                onClearMode: () => setState(() => _modeFilter = null),
                onClearAll: () => setState(() {
                  _searchQuery = '';
                  _statusFilter = null;
                  _modeFilter = null;
                }),
              ),
              const SizedBox(height: 12),
              // Lista filtrata
              Expanded(
                child: filteredSessions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 48, color: context.textMutedColor),
                            const SizedBox(height: 16),
                            Text(
                              l10n.estimationNoSessionFound,
                              style: TextStyle(color: context.textSecondaryColor),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => setState(() {
                                _searchQuery = '';
                                _statusFilter = null;
                                _modeFilter = null;
                              }),
                              child: Text(l10n.filterRemove),
                            ),
                          ],
                        ),
                      )
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
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: compactCrossAxisCount,
                              childAspectRatio: 1.25,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: filteredSessions.length,
                            itemBuilder: (context, index) => _buildSessionCard(filteredSessions[index]),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.style, size: 80, color: context.borderColor),
          const SizedBox(height: 16),
          Text(
            l10n.estimationNoSessions,
            style: TextStyle(
              fontSize: 18,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.estimationCreateFirstSession,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.textTertiaryColor),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showCreateSessionDialog,
            icon: const Icon(Icons.add),
            label: Text(l10n.estimationNewSession),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(PlanningPokerSessionModel session) {
    final l10n = AppLocalizations.of(context)!;
    Color statusColor;
    String statusLabel;
    switch (session.status) {
      case PlanningPokerSessionStatus.draft:
        statusColor = Colors.grey;
        statusLabel = l10n.sessionStatusDraft;
        break;
      case PlanningPokerSessionStatus.active:
        statusColor = Colors.green;
        statusLabel = l10n.sessionStatusActive;
        break;
      case PlanningPokerSessionStatus.completed:
        statusColor = Colors.blue;
        statusLabel = l10n.sessionStatusCompleted;
        break;
    }

    // Calcola percentuale completamento
    final completionPercent = session.storyCount > 0
        ? session.completedStoryCount / session.storyCount
        : 0.0;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => _selectSession(session),
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header: Icona + Titolo + Menu
              Row(
                children: [
                  // Icona verde con status indicator
                  Tooltip(
                    message: '${_getEstimationModeName(session.estimationMode)} - $statusLabel',
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              _getEstimationModeIcon(session.estimationMode),
                              color: Colors.amber,
                              size: 14,
                            ),
                          ),
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: context.surfaceColor, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Titolo con tooltip
                  Expanded(
                    child: Tooltip(
                      message: '${session.name}${session.description.isNotEmpty ? '\n${session.description}' : ''}',
                      child: Text(
                        session.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  FavoriteStar(
                    resourceId: session.id,
                    type: 'planning_poker',
                    title: session.name,
                    colorHex: '#FFC107', // Amber for Planning Poker
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  // Menu compatto
                  GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      _showSessionMenuAtPosition(context, session, details.globalPosition);
                    },
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(Icons.more_vert, size: 16, color: context.textSecondaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Progress bar
              Tooltip(
                message: l10n.estimationProgress(session.completedStoryCount, session.storyCount, (completionPercent * 100).toStringAsFixed(0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: completionPercent,
                    backgroundColor: context.borderColor.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      completionPercent == 1.0 ? Colors.green : Colors.blue,
                    ),
                    minHeight: 2,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Stats compatte su una riga
              Row(
                children: [
                  _buildCompactSessionStat(
                    Icons.list_alt,
                    '${session.storyCount}',
                    l10n.estimationStoriesTotal,
                  ),
                  const SizedBox(width: 6),
                  _buildCompactSessionStat(
                    Icons.check_circle_outline,
                    '${session.completedStoryCount}',
                    l10n.estimationStoriesCompleted,
                  ),
                  const SizedBox(width: 6),
                  _buildCompactSessionStat(
                    Icons.people,
                    '${session.participantCount}',
                    l10n.estimationParticipantsActive,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactSessionStat(IconData icon, String value, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: context.textMutedColor),
          const SizedBox(width: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactIntegrationBadge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
              fontSize: 9,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getEstimationModeName(EstimationMode mode) {
    return mode.displayName;
  }

  /// Restituisce l'icona appropriata per la modalità di stima
  IconData _getEstimationModeIcon(EstimationMode mode) {
    switch (mode) {
      case EstimationMode.fibonacci:
        return Icons.style;
      case EstimationMode.tshirt:
        return Icons.checkroom;
      case EstimationMode.decimal:
        return Icons.calculate;
      case EstimationMode.threePoint:
        return Icons.analytics;
      case EstimationMode.dotVoting:
        return Icons.radio_button_checked;
      case EstimationMode.bucketSystem:
        return Icons.view_column;
      case EstimationMode.fiveFingers:
        return Icons.pan_tool;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DETTAGLIO SESSIONE
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildSessionDetail() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Session stream al livello più alto per sincronizzare tutti i child widget
    // Questo risolve il problema dove facilitatore e votanti vedevano dati diversi
    // dopo il reveal, perché i nested StreamBuilder avevano timing diversi
    return StreamBuilder<PlanningPokerSessionModel?>(
      stream: _firestoreService.streamSession(_selectedSession!.id),
      builder: (context, sessionSnapshot) {
        final session = sessionSnapshot.data ?? _selectedSession!;

        return StreamBuilder<List<PlanningPokerStoryModel>>(
          stream: _firestoreService.streamStories(session.id),
          builder: (context, storiesSnapshot) {
            final stories = storiesSnapshot.data ?? _stories;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Area principale: Story + Votazione
                Expanded(
                  flex: 3,
                  child: _buildMainArea(stories, session),
                ),
                // Sidebar: Lista stories + Partecipanti
                Container(
                  width: 600,
                  decoration: BoxDecoration(
                    color: context.surfaceVariantColor,
                    border: Border(left: BorderSide(color: context.borderColor)),
                  ),
                  child: _buildSidebar(stories),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildMainArea(List<PlanningPokerStoryModel> stories, PlanningPokerSessionModel session) {
    // Usa currentStoryId dalla sessione (più affidabile) per trovare la story corrente
    PlanningPokerStoryModel? currentStory;
    if (session.currentStoryId != null && session.currentStoryId!.isNotEmpty) {
      try {
        currentStory = stories.firstWhere((s) => s.id == session.currentStoryId);
      } catch (e) {
        // Story non trovata nella lista
        currentStory = null;
      }
    }
    // Fallback a currentlyVoting (per compatibilità - include revealed status)
    currentStory ??= stories.currentlyVoting;

    if (currentStory == null) {
      return _buildNoActiveStory(stories);
    }

    // Copia non-nullable per evitare problemi di type promotion
    final activeStory = currentStory;

    return StreamBuilder<PlanningPokerStoryModel?>(
      stream: _firestoreService.streamStory(session.id, activeStory.id),
      builder: (context, storySnapshot) {
        final story = storySnapshot.data ?? activeStory;
        final myVote = story.getUserVote(_currentUserEmail)?.value;
        final canUserVote = session.canVote(_currentUserEmail);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Story corrente
              _buildCurrentStoryCard(story, session),
              const SizedBox(height: 16),
              // Layout bilanciato: votazioni sopra, carte sotto
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tabellone voti (compatto)
                      VotingBoardWidget(
                        story: story,
                        session: session,
                        currentUserEmail: _currentUserEmail,
                        isRevealed: story.isRevealed,
                      ),
                      const SizedBox(height: 16),
                      // Input stima basato sulla modalita' (solo se non rivelato)
                      if (!story.isRevealed)
                        EstimationInputWrapper(
                          mode: session.estimationMode,
                          cardSet: session.cardSet,
                          selectedValue: myVote,
                          enabled: canUserVote,
                          onVoteSubmitted: (vote) => _submitVoteModel(story.id, vote),
                        ),
                      // Pannello risultati (solo se rivelato)
                      if (story.isRevealed)
                        ResultsPanelWidget(
                          story: story,
                          onSetEstimate: (estimate) => _setFinalEstimate(story.id, estimate),
                          onRevote: () => _resetVoting(story.id),
                          isFacilitator: session.isFacilitator(_currentUserEmail),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNoActiveStory(List<PlanningPokerStoryModel> stories) {
    final l10n = AppLocalizations.of(context)!;
    final pendingStories = stories.pending;
    final completedCount = stories.completed.length;
    final totalEstimate = stories.totalEstimate;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            completedCount == stories.length && stories.isNotEmpty
                ? Icons.celebration
                : Icons.style,
            size: 64,
            color: completedCount == stories.length && stories.isNotEmpty
                ? Colors.amber
                : context.borderColor,
          ),
          const SizedBox(height: 16),
          Text(
            completedCount == stories.length && stories.isNotEmpty
                ? l10n.estimationAllStoriesEstimated
                : l10n.estimationNoVotingInProgress,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          if (completedCount > 0)
            Text(
              l10n.estimationCompletedLabel(completedCount, stories.length, totalEstimate.toString()),
              style: TextStyle(color: context.textSecondaryColor),
            ),
          const SizedBox(height: 24),
          if (pendingStories.isNotEmpty &&
              _selectedSession!.isFacilitator(_currentUserEmail))
            ElevatedButton.icon(
              onPressed: () => _startVoting(pendingStories.first.id),
              icon: const Icon(Icons.play_arrow),
              label: Text(l10n.estimationVoteStory(pendingStories.first.title)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          if (stories.isEmpty)
            Text(
              l10n.estimationAddStoriesToStart,
              style: TextStyle(color: context.textTertiaryColor),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentStoryCard(PlanningPokerStoryModel story, PlanningPokerSessionModel session) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icona
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.description, color: Colors.amber),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        l10n.estimationInVoting,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  story.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (story.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      story.description,
                      style: TextStyle(color: context.textSecondaryColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          // Azioni facilitator
          if (session.isFacilitator(_currentUserEmail))
            Row(
              children: [
                if (!story.isRevealed)
                  ElevatedButton.icon(
                    onPressed: story.voteCount > 0 ? () => _revealVotes(story.id) : null,
                    icon: const Icon(Icons.visibility),
                    label: Text(l10n.estimationReveal),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  tooltip: l10n.estimationSkip,
                  onPressed: () => _skipStory(story.id),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSidebar(List<PlanningPokerStoryModel> stories) {
    return Column(
      children: [
        // Header partecipanti
        StreamBuilder<PlanningPokerSessionModel?>(
          stream: _firestoreService.streamSession(_selectedSession!.id),
          builder: (context, snapshot) {
            final session = snapshot.data ?? _selectedSession!;
            return ParticipantListWidget(
              participants: session.participants.values.toList(),
              currentStory: stories.currentlyVoting,
              currentUserEmail: _currentUserEmail,
            );
          },
        ),
        const Divider(height: 1),
        // Lista stories
        Expanded(
          child: _buildStoriesList(stories),
        ),
      ],
    );
  }

  Widget _buildStoriesList(List<PlanningPokerStoryModel> stories) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Row(
          children: [
            const Icon(Icons.list_alt, size: 18, color: Colors.amber),
            const SizedBox(width: 8),
            Text(
              '${l10n.estimationStories} (${stories.length})',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            if (_selectedSession!.isFacilitator(_currentUserEmail)) ...[
              // Aggiungi manualmente
              IconButton(
                icon: const Icon(Icons.add, size: 20),
                onPressed: _showAddStoryDialog,
                tooltip: l10n.estimationAddStory,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        ...stories.sorted.map((story) => _buildStoryListItem(story)),
      ],
    );
  }

  Widget _buildStoryListItem(PlanningPokerStoryModel story) {
    IconData statusIcon;
    Color statusColor;

    switch (story.status) {
      case StoryStatus.pending:
        statusIcon = Icons.radio_button_unchecked;
        statusColor = Colors.grey;
        break;
      case StoryStatus.voting:
        statusIcon = Icons.how_to_vote;
        statusColor = Colors.orange;
        break;
      case StoryStatus.revealed:
        statusIcon = Icons.visibility;
        statusColor = Colors.blue;
        break;
      case StoryStatus.completed:
        statusIcon = Icons.check_circle;
        statusColor = Colors.amber;
        break;
    }

    // Permetti click per avviare/ri-avviare votazione (pending, completed, revealed)
    final canStartOrRevote = _selectedSession!.isFacilitator(_currentUserEmail) &&
        (story.isPending || story.isCompleted || story.isRevealed);

    // Costruisci tooltip con i voti
    final tooltipText = _buildVotesTooltip(story);

    final card = Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: context.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.borderColor),
      ),
      child: InkWell(
        onTap: canStartOrRevote ? () => _startVoting(story.id) : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(statusIcon, size: 20, color: statusColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      style: TextStyle(
                        fontWeight: story.isVoting ? FontWeight.bold : FontWeight.normal,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (story.finalEstimate != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        story.finalEstimate!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              // Menu azioni
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, size: 18, color: context.textMutedColor),
                onSelected: (value) async {
                  switch (value) {
                    case 'vote':
                      _startVoting(story.id);
                      break;
                    case 'view':
                      _viewStoryVotes(story);
                      break;
                    case 'detail':
                      _showStoryDetailDialog(story);
                      break;
                    case 'revote':
                      _startVoting(story.id); // Reset e riavvia votazione
                      break;
                    case 'delete':
                      _confirmDeleteStory(story);
                      break;
                  }
                },
                itemBuilder: (context) {
                  final l10n = AppLocalizations.of(context)!;
                  return [
                  if (story.isPending && _selectedSession!.isFacilitator(_currentUserEmail))
                    PopupMenuItem(
                      value: 'vote',
                      child: Row(
                        children: [
                          const Icon(Icons.play_arrow, size: 18, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(l10n.estimationStartVoting),
                        ],
                      ),
                    ),
                  // Vedi voti - disponibile per tutti per stories con voti
                  if ((story.isCompleted || story.isRevealed) && story.hasVotes)
                    PopupMenuItem(
                      value: 'view',
                      child: Row(
                        children: [
                          const Icon(Icons.visibility, size: 18, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(l10n.estimationViewVotes),
                        ],
                      ),
                    ),
                  // Dettaglio story - disponibile sempre per vedere descrizione e motivazione
                  PopupMenuItem(
                    value: 'detail',
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, size: 18, color: Colors.purple),
                        const SizedBox(width: 8),
                        Text(l10n.estimationViewDetail),
                      ],
                    ),
                  ),
                  // Ri-vota per stories completate o rivelate (solo facilitatori)
                  if ((story.isCompleted || story.isRevealed) && _selectedSession!.isFacilitator(_currentUserEmail))
                    PopupMenuItem(
                      value: 'revote',
                      child: Row(
                        children: [
                          const Icon(Icons.refresh, size: 18, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(l10n.voteRevote, style: const TextStyle(color: Colors.orange)),
                        ],
                      ),
                    ),
                  if (_selectedSession!.isFacilitator(_currentUserEmail))
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          const Icon(Icons.delete, size: 18, color: Colors.red),
                          const SizedBox(width: 8),
                          Text(l10n.actionDelete, style: const TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                ];
                },
              ),
            ],
          ),
        ),
      ),
    );

    // Avvolgi in Tooltip se ci sono voti
    if (tooltipText.isNotEmpty) {
      return Tooltip(
        message: tooltipText,
        preferBelow: false,
        verticalOffset: 20,
        child: card,
      );
    }
    return card;
  }

  /// Costruisce il testo del tooltip con i voti degli utenti
  String _buildVotesTooltip(PlanningPokerStoryModel story) {
    if (!story.hasVotes) return '';
    final l10n = AppLocalizations.of(context)!;

    final lines = <String>[];

    // Stima finale
    if (story.finalEstimate != null) {
      lines.add('${l10n.estimationFinalEstimateLabel} ${story.finalEstimate}');
      lines.add('');
    }

    // Voti degli utenti
    lines.add('${l10n.voteVoters}:');
    for (final entry in story.votes.entries) {
      final email = entry.key;
      final vote = entry.value;
      final participant = _selectedSession?.participants[email];
      final name = participant?.name ?? email.split('@').first;
      lines.add('  - $name: ${vote.value}');
    }

    return lines.join('\n');
  }

  // ══════════════════════════════════════════════════════════════════════════
  // FAB
  // ══════════════════════════════════════════════════════════════════════════

  Widget? _buildFAB() {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedSession == null) {
      return FloatingActionButton.extended(
        onPressed: _showCreateSessionDialog,
        icon: const Icon(Icons.add, color: Colors.black),
        label: Text(l10n.estimationNewSession, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.amber,
      );
    } else if (_selectedSession!.isFacilitator(_currentUserEmail)) {
      return FloatingActionButton.extended(
        onPressed: _showAddStoryDialog,
        icon: const Icon(Icons.add_task, color: Colors.black),
        label: Text(l10n.estimationAddStory, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.amber,
      );
    }
    return null;
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DIALOGS
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _showCreateSessionDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const SessionFormDialog(),
    );

    if (result != null) {
      try {
        await _firestoreService.createSession(
          name: result['name'],
          description: result['description'] ?? '',
          createdBy: _currentUserEmail,
          cardSet: result['cardSet'] ?? PlanningPokerCardSet.fibonacci,
          estimationMode: result['estimationMode'] ?? EstimationMode.fibonacci,
          allowObservers: result['allowObservers'] ?? true,
          autoReveal: result['autoReveal'] ?? true,
          teamId: result['teamId'],
          teamName: result['teamName'],
          businessUnitId: result['businessUnitId'],
          businessUnitName: result['businessUnitName'],
          projectId: result['projectId'],
          projectName: result['projectName'],
          projectCode: result['projectCode'],
        );
        final l10n = AppLocalizations.of(context)!;
        _showSuccess(l10n.sessionCreatedSuccess);
      } catch (e) {
        final l10n = AppLocalizations.of(context)!;
        _showError('${l10n.errorCreatingSession}: $e');
      }
    }
  }

  void _showSessionMenuAtPosition(BuildContext context, PlanningPokerSessionModel session, Offset globalPosition) async {
    final l10n = AppLocalizations.of(context)!;
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
          value: 'edit',
          child: Row(
            children: [
              const Icon(Icons.edit, size: 16),
              const SizedBox(width: 8),
              Text(l10n.actionEdit, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
        if (session.isDraft)
          PopupMenuItem(
            value: 'start',
            child: Row(
              children: [
                const Icon(Icons.play_arrow, size: 16, color: Colors.green),
                const SizedBox(width: 8),
                Text(l10n.estimationStart, style: const TextStyle(fontSize: 13, color: Colors.green)),
              ],
            ),
          ),
        if (session.isActive)
          PopupMenuItem(
            value: 'complete',
            child: Row(
              children: [
                const Icon(Icons.check, size: 16, color: Colors.blue),
                const SizedBox(width: 8),
                Text(l10n.estimationComplete, style: const TextStyle(fontSize: 13, color: Colors.blue)),
              ],
            ),
          ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete, size: 16, color: Colors.red),
              const SizedBox(width: 8),
              Text(l10n.actionDelete, style: const TextStyle(fontSize: 13, color: Colors.red)),
            ],
          ),
        ),
      ],
    );

    if (result != null && mounted) {
      switch (result) {
        case 'edit':
          _showEditSessionDialog(session);
          break;
        case 'start':
          await _startSession(session);
          break;
        case 'complete':
          await _completeSession(session);
          break;
        case 'delete':
          _confirmDeleteSession(session);
          break;
      }
    }
  }

  Future<void> _showEditSessionDialog(PlanningPokerSessionModel session) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => SessionFormDialog(session: session),
    );

    if (result != null) {
      try {
        await _firestoreService.updateSession(
          sessionId: session.id,
          name: result['name'],
          description: result['description'],
          cardSet: result['cardSet'],
          estimationMode: result['estimationMode'],
          allowObservers: result['allowObservers'],
          autoReveal: result['autoReveal'],
          teamId: result['teamId'],
          teamName: result['teamName'],
          businessUnitId: result['businessUnitId'],
          businessUnitName: result['businessUnitName'],
          projectId: result['projectId'],
          projectName: result['projectName'],
          projectCode: result['projectCode'],
          clearProject: result['projectId'] == null && session.projectId != null,
          clearTeam: result['teamId'] == null && session.teamId != null,
          clearBusinessUnit: result['businessUnitId'] == null && session.businessUnitId != null,
        );
        final l10n = AppLocalizations.of(context)!;
        _showSuccess(l10n.sessionUpdated);
      } catch (e) {
        final l10n = AppLocalizations.of(context)!;
        _showError('${l10n.errorUpdatingSession}: $e');
      }
    }
  }

  Future<void> _showSessionSettings() async {
    if (_selectedSession != null) {
      await _showEditSessionDialog(_selectedSession!);
    }
  }

  /// Export estimated stories to a Smart Todo list
  Future<void> _showExportToSmartTodoDialog() async {
    if (_selectedSession == null) return;
    final l10n = AppLocalizations.of(context)!;

    // Get available lists for the user
    final lists = await _todoService.getTodoListsOnce(_currentUserEmail);

    if (!mounted) return;

    final result = await showDialog<ExportToSmartTodoResult>(
      context: context,
      builder: (context) => ExportToSmartTodoDialog(
        stories: _stories,
        availableLists: lists,
        sessionName: _selectedSession!.name,
      ),
    );

    if (result == null || result.selectedStories.isEmpty) return;

    try {
      String listId;

      if (result.createNewList) {
        // Create a new list with default columns
        final newList = TodoListModel(
          id: '',
          title: result.newListTitle!,
          description: '${l10n.importStories}: ${_selectedSession!.name}',
          ownerId: _currentUserEmail,
          createdAt: DateTime.now(),
          participants: {
            _currentUserEmail: TodoParticipant(
              email: _currentUserEmail,
              displayName: _currentUserName,
              role: TodoParticipantRole.owner,
              joinedAt: DateTime.now(),
            ),
          },
          columns: const [
            TodoColumn(id: 'todo', title: 'To Do', colorValue: 0xFF2196F3),
            TodoColumn(id: 'in_progress', title: 'In Progress', colorValue: 0xFFFF9800),
            TodoColumn(id: 'done', title: 'Done', colorValue: 0xFF4CAF50, isDone: true),
          ],
        );
        listId = await _todoService.createList(newList, _currentUserEmail);
      } else {
        listId = result.existingList!.id;
      }

      // Convert stories to tasks
      final tasks = result.selectedStories.map((story) {
        // Parse effort from finalEstimate (can be numeric or T-shirt size)
        int? effort;
        if (story.finalEstimate != null) {
          effort = int.tryParse(story.finalEstimate!);
        }

        return TodoTaskModel(
          id: '',
          listId: listId,
          title: story.title,
          description: story.description,
          statusId: 'todo',
          priority: TodoTaskPriority.medium,
          effort: effort,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }).toList();

      // Create tasks in batch
      await _todoService.batchCreateTasks(listId, tasks);

      if (mounted) {
        _showSuccess(l10n.storiesImportedCount(result.selectedStories.length));

        // Offer to navigate to the list
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.storiesImportedCount(result.selectedStories.length)),
            action: SnackBarAction(
              label: l10n.actionOpen,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/smart-todo',
                  arguments: {'listId': listId},
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showError('${l10n.stateError}: $e');
      }
    }
  }

  /// Export estimated stories to an Agile Sprint
  Future<void> _showExportToAgileSprintDialog() async {
    if (_selectedSession == null) return;
    final l10n = AppLocalizations.of(context)!;

    // Get available projects for the user
    List<AgileProjectModel> projects = [];
    try {
      projects = await _agileService.getUserProjects(_currentUserEmail);
    } catch (e) {
      // Silently continue if no projects
    }

    if (!mounted) return;

    final result = await showDialog<ExportToAgileSprintResult>(
      context: context,
      builder: (context) => ExportToAgileSprintDialog(
        stories: _stories,
        availableProjects: projects,
        sessionName: _selectedSession!.name,
        getProjectSprints: (projectId) => _agileService.getProjectSprints(projectId),
      ),
    );

    if (result == null || result.selectedStories.isEmpty) return;

    try {
      AgileProjectModel targetProject;
      SprintModel? targetSprint;
      int createdCount = 0;
      final List<String> createdStoryIds = [];

      if (result.createNewProject && result.newProjectConfig != null) {
        // Create new project with configured settings
        targetProject = await _agileService.createProject(
          name: result.newProjectConfig!.name,
          description: result.newProjectConfig!.description,
          framework: result.newProjectConfig!.framework,
          createdBy: _currentUserEmail,
          createdByName: _currentUserName,
          sprintDurationDays: result.newProjectConfig!.sprintDurationDays,
          workingHoursPerDay: result.newProjectConfig!.workingHoursPerDay,
        );

        // Create stories directly in the backlog (no sprint assignment for new project)
        for (final story in result.selectedStories) {
          int? storyPoints;
          if (story.finalEstimate != null) {
            storyPoints = _convertEstimateToStoryPoints(story.finalEstimate!);
          }

          final userStory = await _agileService.createStory(
            projectId: targetProject.id,
            title: story.title,
            description: story.description,
            createdBy: _currentUserEmail,
          );

          // Update story with story points
          final updatedStory = UserStoryModel(
            id: userStory.id,
            projectId: targetProject.id,
            title: story.title,
            description: story.description,
            storyPoints: storyPoints,
            finalEstimate: story.finalEstimate,
            estimationType: agile.EstimationType.planningPoker,
            status: agile.StoryStatus.backlog,
            createdAt: userStory.createdAt,
            createdBy: _currentUserEmail,
            order: userStory.order,
          );

          await _agileService.updateStory(targetProject.id, updatedStory);
          createdStoryIds.add(userStory.id);
          createdCount++;
        }
      } else if (result.existingProject != null && result.sprint != null) {
        // Use existing project and sprint
        targetProject = result.existingProject!;
        targetSprint = result.sprint!;

        for (final story in result.selectedStories) {
          int? storyPoints;
          if (story.finalEstimate != null) {
            storyPoints = _convertEstimateToStoryPoints(story.finalEstimate!);
          }

          final userStory = await _agileService.createStory(
            projectId: targetProject.id,
            title: story.title,
            description: story.description,
            createdBy: _currentUserEmail,
          );

          final updatedStory = UserStoryModel(
            id: userStory.id,
            projectId: targetProject.id,
            title: story.title,
            description: story.description,
            storyPoints: storyPoints,
            finalEstimate: story.finalEstimate,
            estimationType: agile.EstimationType.planningPoker,
            sprintId: targetSprint.id,
            status: targetSprint.status == agile.SprintStatus.active
                ? agile.StoryStatus.inSprint
                : agile.StoryStatus.ready,
            createdAt: userStory.createdAt,
            createdBy: _currentUserEmail,
            order: userStory.order,
          );

          await _agileService.updateStory(targetProject.id, updatedStory);
          createdStoryIds.add(userStory.id);
          createdCount++;
        }

        // Update sprint with new story IDs and points
        final totalNewPoints = result.selectedStories.fold<int>(0, (sum, story) {
          return sum + (_convertEstimateToStoryPoints(story.finalEstimate ?? '0'));
        });

        final updatedSprint = targetSprint.copyWith(
          storyIds: [...targetSprint.storyIds, ...createdStoryIds],
          plannedPoints: targetSprint.plannedPoints + totalNewPoints,
        );

        await _agileService.updateSprint(targetProject.id, updatedSprint);
      } else {
        // Invalid state
        return;
      }

      if (mounted) {
        final message = targetSprint != null
            ? l10n.storiesAddedToSprint(createdCount, targetSprint.name)
            : l10n.storiesAddedToProject(createdCount, targetProject.name);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: l10n.actionOpen,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgileProjectDetailScreen(
                      project: targetProject,
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showError('${l10n.stateError}: $e');
      }
    }
  }

  /// Converts estimate string to story points (Fibonacci)
  int _convertEstimateToStoryPoints(String estimate) {
    // Try direct Fibonacci parsing
    final directParse = int.tryParse(estimate);
    if (directParse != null) return directParse;

    // T-Shirt size mapping
    const tshirtMap = {
      'XS': 1,
      'S': 2,
      'M': 3,
      'L': 5,
      'XL': 8,
      'XXL': 13,
    };
    if (tshirtMap.containsKey(estimate.toUpperCase())) {
      return tshirtMap[estimate.toUpperCase()]!;
    }

    // Decimal value parsing
    final decimalParse = double.tryParse(estimate);
    if (decimalParse != null) return decimalParse.round();

    return 0;
  }

  Future<void> _showAddStoryDialog() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const StoryFormDialog(),
    );

    if (result != null && _selectedSession != null) {
      try {
        await _firestoreService.createStory(
          sessionId: _selectedSession!.id,
          title: result['title']!,
          description: result['description'] ?? '',
        );
        await _loadStories(_selectedSession!.id);
        final l10n = AppLocalizations.of(context)!;
        _showSuccess(l10n.storyAdded);
      } catch (e) {
        final l10n = AppLocalizations.of(context)!;
        _showError('${l10n.errorAddingStory}: $e');
      }
    }
  }

  Future<void> _showParticipantsDialog() async {
    if (_selectedSession == null) return;

    await showDialog(
      context: context,
      builder: (context) => _ParticipantsManagementDialog(
        sessionId: _selectedSession!.id,
        firestoreService: _firestoreService,
        currentUserEmail: _currentUserEmail,
        currentUserName: _currentUserName,
        isFacilitator: _selectedSession!.isFacilitator(_currentUserEmail),
      ),
    );
  }

  Future<void> _confirmDeleteSession(PlanningPokerSessionModel session) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteSessionTitle),
        content: Text(l10n.deleteSessionConfirm(session.name, session.storyCount)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _firestoreService.deleteSession(session.id);
        _showSuccess(l10n.sessionDeleted);
      } catch (e) {
        _showError('${l10n.errorDeletingSession}: $e');
      }
    }
  }

  Future<void> _confirmDeleteStory(PlanningPokerStoryModel story) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteStoryTitle),
        content: Text(l10n.deleteStoryConfirm(story.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );

    if (confirmed == true && _selectedSession != null) {
      try {
        await _firestoreService.deleteStory(
          sessionId: _selectedSession!.id,
          storyId: story.id,
        );
        await _loadStories(_selectedSession!.id);
        _showSuccess(l10n.storyDeleted);
      } catch (e) {
        _showError('${l10n.errorDeletingSession}: $e');
      }
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // AZIONI
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _selectSession(PlanningPokerSessionModel session) async {
    // Cancel any existing subscription
    await _storiesSubscription?.cancel();

    setState(() {
      _selectedSession = session;
      _isLoading = true;
    });
    await _loadStories(session.id);

    // Set up stream subscription for real-time updates
    _storiesSubscription = _firestoreService.streamStories(session.id).listen(
      (stories) {
        if (mounted) {
          setState(() {
            _stories = stories;
            _currentStory = stories.currentlyVoting;
            _myVote = _currentStory?.getUserVote(_currentUserEmail)?.value;
          });
        }
      },
      onError: (e) {
        // Silently handle stream errors
      },
    );

    setState(() => _isLoading = false);
  }

  Future<void> _startSession(PlanningPokerSessionModel session) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await _firestoreService.startSession(session.id);
      _showSuccess(l10n.sessionStarted);
    } catch (e) {
      _showError('${l10n.errorStartingSession}: $e');
    }
  }

  Future<void> _completeSession(PlanningPokerSessionModel session) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await _firestoreService.completeSession(session.id);
      _showSuccess(l10n.sessionCompletedSuccess);
    } catch (e) {
      _showError('${l10n.errorCompletingSession}: $e');
    }
  }

  Future<void> _startVoting(String storyId) async {
    if (_selectedSession == null) return;
    try {
      await _firestoreService.startVoting(
        sessionId: _selectedSession!.id,
        storyId: storyId,
      );
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      _showError('${l10n.errorStartingVoting}: $e');
    }
  }

  /// Mostra un dialog con i voti della story (senza modificarli)
  void _viewStoryVotes(PlanningPokerStoryModel story) {
    final l10n = AppLocalizations.of(context)!;
    final stats = story.statistics ?? story.calculateStatistics();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.visibility, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                l10n.estimationVotesOf(story.title),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stima finale (se presente)
                if (story.finalEstimate != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text(l10n.estimationFinalEstimateLabel, style: const TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            story.finalEstimate!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                // Statistiche
                Row(
                  children: [
                    _buildMiniStatCard(l10n.voteAverage, stats.numericAverage?.toStringAsFixed(1) ?? '-', Colors.blue),
                    const SizedBox(width: 8),
                    _buildMiniStatCard(l10n.voteMedian, stats.numericMedian?.toStringAsFixed(1) ?? '-', Colors.green),
                    const SizedBox(width: 8),
                    _buildMiniStatCard(l10n.voteMode, stats.mode ?? '-', Colors.orange),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.estimationParticipantVotes,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                // Lista voti
                ...story.votes.entries.map((entry) {
                  final email = entry.key;
                  final vote = entry.value;
                  final participant = _selectedSession?.participants[email];
                  final name = participant?.name ?? email.split('@').first;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.blue.withOpacity(0.1),
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(name)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getVoteColor(vote.value).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _getVoteColor(vote.value).withOpacity(0.3)),
                          ),
                          child: Text(
                            vote.value,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _getVoteColor(vote.value),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.actionClose),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
            Text(label, style: TextStyle(fontSize: 11, color: color.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }

  Color _getVoteColor(String value) {
    if (value == '?') return Colors.orange;
    if (value == '\u2615') return Colors.brown; // Coffee emoji
    final numValue = int.tryParse(value);
    if (numValue != null) {
      if (numValue <= 3) return Colors.green;
      if (numValue <= 8) return Colors.blue;
      if (numValue <= 20) return Colors.orange;
      return Colors.red;
    }
    return Colors.purple;
  }

  Future<void> _submitVote(String storyId, String value) async {
    if (_selectedSession == null) return;
    try {
      await _firestoreService.submitVote(
        sessionId: _selectedSession!.id,
        storyId: storyId,
        voterEmail: _currentUserEmail,
        value: value,
      );
      setState(() => _myVote = value);
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      _showError('${l10n.errorSubmittingVote}: $e');
    }
  }

  /// Sottomette un voto usando il modello PlanningPokerVote completo
  Future<void> _submitVoteModel(String storyId, PlanningPokerVote vote) async {
    if (_selectedSession == null) return;
    try {
      await _firestoreService.submitVote(
        sessionId: _selectedSession!.id,
        storyId: storyId,
        voterEmail: _currentUserEmail,
        value: vote.value,
        decimalValue: vote.decimalValue,
        optimisticValue: vote.optimisticValue,
        realisticValue: vote.realisticValue,
        pessimisticValue: vote.pessimisticValue,
      );
      setState(() => _myVote = vote.value);
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      _showError('${l10n.errorSubmittingVote}: $e');
    }
  }

  Future<void> _revealVotes(String storyId) async {
    if (_selectedSession == null) return;
    try {
      await _firestoreService.revealVotes(
        sessionId: _selectedSession!.id,
        storyId: storyId,
      );
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      _showError('${l10n.errorRevealingVotes}: $e');
    }
  }

  Future<void> _resetVoting(String storyId) async {
    if (_selectedSession == null) return;
    try {
      await _firestoreService.resetVoting(
        sessionId: _selectedSession!.id,
        storyId: storyId,
      );
      setState(() => _myVote = null);
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      _showError('${l10n.errorResetVoting}: $e');
    }
  }

  Future<void> _setFinalEstimate(String storyId, String estimate) async {
    if (_selectedSession == null) return;
    final l10n = AppLocalizations.of(context)!;

    // Mostra dialog per inserire dettaglio spiegazione
    final result = await _showEstimateExplanationDialog(estimate);
    if (result == null) return; // Utente ha annullato

    try {
      await _firestoreService.setFinalEstimate(
        sessionId: _selectedSession!.id,
        storyId: storyId,
        estimate: result['estimate'],
        explanationDetail: result['explanationDetail'],
      );
      _showSuccess(l10n.estimateSaved(result['estimate']));
    } catch (e) {
      _showError('${l10n.errorSavingEstimate}: $e');
    }
  }

  /// Mostra dialog per confermare stima e aggiungere spiegazione
  Future<Map<String, dynamic>?> _showEstimateExplanationDialog(String suggestedEstimate) async {
    final l10n = AppLocalizations.of(context)!;
    final estimateController = TextEditingController(text: suggestedEstimate);
    final explanationController = TextEditingController();

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.amber),
            const SizedBox(width: 8),
            Text(l10n.estimationConfirmFinalEstimate),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.voteFinalEstimate,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: estimateController,
                decoration: InputDecoration(
                  hintText: l10n.estimationHintEstimate,
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.estimationEstimateRationale,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: explanationController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l10n.estimationExplainRationale,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Icon(Icons.notes),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.surfaceVariantColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.borderColor.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, size: 18, color: Colors.amber[700]),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.estimationRationaleHelp,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textSecondaryColor,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (estimateController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.estimationEnterValidEstimate)),
                );
                return;
              }
              Navigator.of(context).pop({
                'estimate': estimateController.text.trim(),
                'explanationDetail': explanationController.text.trim().isEmpty
                    ? null
                    : explanationController.text.trim(),
              });
            },
            icon: const Icon(Icons.check),
            label: Text(l10n.actionConfirm),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// Mostra dialog con dettaglio completo della story
  void _showStoryDetailDialog(PlanningPokerStoryModel story) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.purple),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                story.title,
                style: const TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Descrizione
                if (story.description.isNotEmpty) ...[
                  Text(
                    l10n.formDescription,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(story.description),
                  ),
                  const SizedBox(height: 16),
                ],

                // Stima finale
                if (story.finalEstimate != null) ...[
                  Text(
                    l10n.voteFinalEstimate,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            story.finalEstimate!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.estimationPointsOrDays,
                          style: TextStyle(color: context.textSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Motivazione della stima
                if (story.explanationDetail != null && story.explanationDetail!.isNotEmpty) ...[
                  Text(
                    l10n.estimationEstimateRationale,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.purple.withOpacity(0.3)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.notes, size: 18, color: Colors.purple),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            story.explanationDetail!,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Info stato
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      _buildDetailInfoRow(l10n.estimationStatus, _getStatusLabel(context, story.status)),
                      _buildDetailInfoRow(l10n.estimationOrder, '#${story.order + 1}'),
                      _buildDetailInfoRow(l10n.estimationVotesReceived, '${story.votes.length}'),
                      if (story.hasVotes) ...[
                        _buildDetailInfoRow(l10n.estimationAverageVotes, story.statistics?.numericAverage?.toStringAsFixed(1) ?? '-'),
                        _buildDetailInfoRow(l10n.estimationConsensus, (story.statistics?.consensus ?? false) ? l10n.yes : l10n.no),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.actionClose),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: context.textSecondaryColor, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  String _getStatusLabel(BuildContext context, StoryStatus status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case StoryStatus.pending:
        return l10n.storyStatusPending;
      case StoryStatus.voting:
        return l10n.storyStatusVoting;
      case StoryStatus.revealed:
        return l10n.storyStatusRevealed;
      case StoryStatus.completed:
        return l10n.sessionStatusCompleted;
    }
  }

  Future<void> _skipStory(String storyId) async {
    if (_selectedSession == null) return;
    final l10n = AppLocalizations.of(context)!;
    try {
      await _firestoreService.skipStory(
        sessionId: _selectedSession!.id,
        storyId: storyId,
      );
    } catch (e) {
      _showError('${l10n.errorSkipping}: $e');
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ══════════════════════════════════════════════════════════════════════════

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.blue),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// DIALOG GESTIONE PARTECIPANTI
// ══════════════════════════════════════════════════════════════════════════════

class _ParticipantsManagementDialog extends StatefulWidget {
  final String sessionId;
  final PlanningPokerFirestoreService firestoreService;
  final String currentUserEmail;
  final String currentUserName;
  final bool isFacilitator;

  const _ParticipantsManagementDialog({
    required this.sessionId,
    required this.firestoreService,
    required this.currentUserEmail,
    required this.currentUserName,
    required this.isFacilitator,
  });

  @override
  State<_ParticipantsManagementDialog> createState() => _ParticipantsManagementDialogState();
}

class _ParticipantsManagementDialogState extends State<_ParticipantsManagementDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _inviteEmailController = TextEditingController();
  ParticipantRole _selectedRole = ParticipantRole.voter;
  ParticipantRole _inviteRole = ParticipantRole.voter;
  bool _isAdding = false;
  bool _isSendingInvite = false;

  late PlanningPokerInviteService _inviteService;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _inviteService = PlanningPokerInviteService();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _inviteEmailController.dispose();
    super.dispose();
  }

  String get _shareableLink {
    // Genera link condivisibile per la sessione
    final baseUrl = Uri.base.origin;
    return '$baseUrl/estimation-room?session=${widget.sessionId}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.people, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(l10n.participantManagement)),
          // Copia link
          IconButton(
            icon: const Icon(Icons.link, size: 20),
            tooltip: l10n.participantCopySessionLink,
            onPressed: _copyShareableLink,
          ),
        ],
      ),
      content: SizedBox(
        width: 550,
        height: 520,
        child: Column(
          children: [
            // TabBar
            if (widget.isFacilitator)
              TabBar(
                controller: _tabController,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.green,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.people, size: 18),
                    text: l10n.participants,
                  ),
                  Tab(
                    icon: const Icon(Icons.mail_outline, size: 18),
                    text: l10n.participantInvitesTab,
                  ),
                ],
              ),
            if (widget.isFacilitator) const SizedBox(height: 16),
            // TabBarView
            Expanded(
              child: widget.isFacilitator
                  ? TabBarView(
                      controller: _tabController,
                      children: [
                        _buildParticipantsTab(),
                        _buildInvitesTab(),
                      ],
                    )
                  : _buildParticipantsTab(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionClose),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // TAB PARTECIPANTI
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildParticipantsTab() {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<PlanningPokerSessionModel?>(
      stream: widget.firestoreService.streamSession(widget.sessionId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final session = snapshot.data;
        if (session == null) {
          return Center(child: Text(l10n.sessionNotFound));
        }

        final participants = session.participants.entries.toList()
          ..sort((a, b) {
            // Facilitator prima, poi votanti, poi osservatori
            final roleOrder = {'facilitator': 0, 'voter': 1, 'observer': 2};
            final orderA = roleOrder[a.value.role.name] ?? 2;
            final orderB = roleOrder[b.value.role.name] ?? 2;
            return orderA.compareTo(orderB);
          });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Link condivisibile
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.link, size: 18, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.participantSessionLink,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _shareableLink,
                          style: const TextStyle(fontSize: 11),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    onPressed: _copyShareableLink,
                    tooltip: l10n.copyLink,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Aggiungi partecipante (solo facilitator)
            if (widget.isFacilitator) ...[
              Text(
                l10n.participantAddDirect,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: l10n.participantEmailRequired,
                        hintText: l10n.participantEmailHint,
                        border: const OutlineInputBorder(),
                        isDense: true,
                        prefixIcon: const Icon(Icons.email, size: 18),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: l10n.formName,
                        hintText: l10n.participantNameHint,
                        border: const OutlineInputBorder(),
                        isDense: true,
                        prefixIcon: const Icon(Icons.person, size: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Ruolo
                  DropdownButton<ParticipantRole>(
                    value: _selectedRole,
                    underline: Container(),
                    items: [
                      DropdownMenuItem(
                        value: ParticipantRole.voter,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.how_to_vote, size: 16, color: Colors.green),
                            const SizedBox(width: 4),
                            Text(l10n.participantVoter),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: ParticipantRole.observer,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.visibility, size: 16, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text(l10n.participantObserver),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedRole = value);
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _isAdding ? null : _addParticipant,
                    icon: _isAdding
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.add),
                    tooltip: l10n.actionAdd,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
            ],

            // Lista partecipanti
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(
                    '${l10n.participants} (${participants.length})',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    l10n.participantVotersAndObservers(session.voterCount, session.observerCount),
                    style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                  ),
                ],
              ),
            ),
            // Lista
            Expanded(
              child: ListView.builder(
                itemCount: participants.length,
                itemBuilder: (context, index) {
                  final entry = participants[index];
                  final email = entry.key;
                  final participant = entry.value;
                  final isCurrentUser = email == widget.currentUserEmail;
                  final isCreator = participant.isFacilitator;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: _getRoleColor(participant.role).withOpacity(0.2),
                        child: Text(
                          participant.name.isNotEmpty
                              ? participant.name[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            color: _getRoleColor(participant.role),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            participant.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          if (isCurrentUser)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                l10n.participantYou,
                                style: const TextStyle(fontSize: 10, color: Colors.green),
                              ),
                            ),
                        ],
                      ),
                      subtitle: Text(
                        email,
                        style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Badge ruolo
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getRoleColor(participant.role).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getRoleIcon(participant.role),
                                  size: 14,
                                  color: _getRoleColor(participant.role),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _getRoleName(context, participant.role),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _getRoleColor(participant.role),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Menu azioni (solo facilitator, non può modificare se stesso)
                          if (widget.isFacilitator && !isCurrentUser && !isCreator)
                            PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert, size: 18, color: context.textMutedColor),
                              onSelected: (value) async {
                                switch (value) {
                                  case 'voter':
                                    await _changeRole(email, ParticipantRole.voter);
                                    break;
                                  case 'observer':
                                    await _changeRole(email, ParticipantRole.observer);
                                    break;
                                  case 'remove':
                                    await _removeParticipant(email, participant.name);
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                if (participant.role != ParticipantRole.voter)
                                  PopupMenuItem(
                                    value: 'voter',
                                    child: Row(
                                      children: [
                                        const Icon(Icons.how_to_vote, size: 18, color: Colors.green),
                                        const SizedBox(width: 8),
                                        Text(l10n.participantMakeVoter),
                                      ],
                                    ),
                                  ),
                                if (participant.role != ParticipantRole.observer)
                                  PopupMenuItem(
                                    value: 'observer',
                                    child: Row(
                                      children: [
                                        const Icon(Icons.visibility, size: 18, color: Colors.blue),
                                        const SizedBox(width: 8),
                                        Text(l10n.participantMakeObserver),
                                      ],
                                    ),
                                  ),
                                PopupMenuItem(
                                  value: 'remove',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.person_remove, size: 18, color: Colors.red),
                                      const SizedBox(width: 8),
                                      Text(l10n.removeParticipant, style: const TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // TAB INVITI
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildInvitesTab() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Form invio invito
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.send, size: 18, color: Colors.purple),
                  const SizedBox(width: 8),
                  Text(
                    l10n.inviteSendNew,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _inviteEmailController,
                      decoration: InputDecoration(
                        labelText: l10n.inviteRecipientEmail,
                        hintText: l10n.participantEmailHint,
                        border: const OutlineInputBorder(),
                        isDense: true,
                        prefixIcon: const Icon(Icons.email, size: 18),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Ruolo invito
                  DropdownButton<ParticipantRole>(
                    value: _inviteRole,
                    underline: Container(),
                    items: [
                      DropdownMenuItem(
                        value: ParticipantRole.voter,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.how_to_vote, size: 16, color: Colors.green),
                            const SizedBox(width: 4),
                            Text(l10n.participantVoter),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: ParticipantRole.observer,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.visibility, size: 16, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text(l10n.participantObserver),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _inviteRole = value);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: _isSendingInvite ? null : _sendInvite,
                    icon: _isSendingInvite
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send, size: 18),
                    label: Text(l10n.inviteCreate),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Lista inviti
        Text(
          l10n.invitesSent,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: StreamBuilder<List<PlanningPokerInviteModel>>(
            stream: _inviteService.streamSessionInvites(widget.sessionId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final invites = snapshot.data ?? [];

              if (invites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mail_outline, size: 48, color: context.borderColor),
                      const SizedBox(height: 8),
                      Text(
                        l10n.inviteNoInvites,
                        style: TextStyle(color: context.textTertiaryColor),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: invites.length,
                itemBuilder: (context, index) {
                  final invite = invites[index];
                  return _buildInviteCard(invite);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInviteCard(PlanningPokerInviteModel invite) {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = _getInviteStatusColor(invite.status);
    final statusIcon = _getInviteStatusIcon(invite.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 18,
              backgroundColor: statusColor.withOpacity(0.2),
              child: Icon(statusIcon, size: 18, color: statusColor),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invite.email,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // Ruolo
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getRoleColor(invite.role).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _getRoleName(context, invite.role),
                          style: TextStyle(
                            fontSize: 10,
                            color: _getRoleColor(invite.role),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Status
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          invite.status.label,
                          style: TextStyle(
                            fontSize: 10,
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Data scadenza
                      if (invite.isPending)
                        Text(
                          l10n.inviteExpiresIn(invite.daysUntilExpiration),
                          style: TextStyle(
                            fontSize: 10,
                            color: invite.daysUntilExpiration <= 2
                                ? Colors.orange
                                : context.textTertiaryColor,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            // Azioni
            if (invite.isPending) ...[
              // Copia link
              IconButton(
                icon: const Icon(Icons.link, size: 18),
                tooltip: l10n.inviteCopyLink,
                onPressed: () => _copyInviteLink(invite),
              ),
              // Revoca
              IconButton(
                icon: const Icon(Icons.cancel, size: 18, color: Colors.red),
                tooltip: l10n.inviteRevokeAction,
                onPressed: () => _revokeInvite(invite),
              ),
            ] else ...[
              // Elimina invito (per inviti non pending)
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                tooltip: l10n.inviteDeleteAction,
                onPressed: () => _deleteInvite(invite),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getInviteStatusColor(InviteStatus status) {
    switch (status) {
      case InviteStatus.pending:
        return Colors.orange;
      case InviteStatus.accepted:
        return Colors.green;
      case InviteStatus.declined:
        return Colors.red;
      case InviteStatus.expired:
        return Colors.grey;
      case InviteStatus.revoked:
        return Colors.red;
    }
  }

  IconData _getInviteStatusIcon(InviteStatus status) {
    switch (status) {
      case InviteStatus.pending:
        return Icons.hourglass_empty;
      case InviteStatus.accepted:
        return Icons.check_circle;
      case InviteStatus.declined:
        return Icons.cancel;
      case InviteStatus.expired:
        return Icons.timer_off;
      case InviteStatus.revoked:
        return Icons.block;
    }
  }

  Future<void> _sendInvite() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _inviteEmailController.text.trim().toLowerCase();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.enterValidEmail),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSendingInvite = true);

    try {
      // Crea invito (senza invio email - funzionalità rimossa per lo spinoff)
      await _inviteService.createInvite(
        sessionId: widget.sessionId,
        email: email,
        role: _inviteRole,
        invitedBy: widget.currentUserEmail,
        invitedByName: widget.currentUserName,
      );

      _inviteEmailController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.inviteCreatedFor(email)),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.stateError}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSendingInvite = false);
      }
    }
  }

  void _copyInviteLink(PlanningPokerInviteModel invite) {
    final l10n = AppLocalizations.of(context)!;
    final baseUrl = Uri.base.origin;
    final link = invite.generateInviteLink(baseUrl);
    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.inviteLinkCopied),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _revokeInvite(PlanningPokerInviteModel invite) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.inviteRevokeTitle),
        content: Text(l10n.inviteRevokeConfirm(invite.email)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.inviteRevoke),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _inviteService.revokeInvite(widget.sessionId, invite.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.inviteRevokedFor(invite.email)),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${l10n.stateError}: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _deleteInvite(PlanningPokerInviteModel invite) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.inviteDeleteTitle),
        content: Text(l10n.inviteDeleteConfirm(invite.email)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _inviteService.deleteInvite(widget.sessionId, invite.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.inviteDeletedFor(invite.email)),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${l10n.stateError}: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Color _getRoleColor(ParticipantRole role) {
    switch (role) {
      case ParticipantRole.facilitator:
        return Colors.amber;
      case ParticipantRole.voter:
        return Colors.green;
      case ParticipantRole.observer:
        return Colors.blue;
    }
  }

  IconData _getRoleIcon(ParticipantRole role) {
    switch (role) {
      case ParticipantRole.facilitator:
        return Icons.star;
      case ParticipantRole.voter:
        return Icons.how_to_vote;
      case ParticipantRole.observer:
        return Icons.visibility;
    }
  }

  String _getRoleName(BuildContext context, ParticipantRole role) {
    final l10n = AppLocalizations.of(context)!;
    switch (role) {
      case ParticipantRole.facilitator:
        return l10n.participantFacilitator;
      case ParticipantRole.voter:
        return l10n.participantVoter;
      case ParticipantRole.observer:
        return l10n.participantObserver;
    }
  }

  void _copyShareableLink() {
    final l10n = AppLocalizations.of(context)!;
    Clipboard.setData(ClipboardData(text: _shareableLink));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.linkCopied),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _addParticipant() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim().toLowerCase();
    final name = _nameController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.enterValidEmail),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isAdding = true);

    try {
      await widget.firestoreService.addParticipant(
        sessionId: widget.sessionId,
        email: email,
        name: name.isEmpty ? email.split('@').first : name,
        role: _selectedRole,
      );

      _emailController.clear();
      _nameController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.participantAddedToSession(email)),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.stateError}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isAdding = false);
      }
    }
  }

  Future<void> _changeRole(String email, ParticipantRole role) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await widget.firestoreService.updateParticipantRole(
        sessionId: widget.sessionId,
        email: email,
        role: role,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.participantRoleUpdated(email)),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.stateError}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _removeParticipant(String email, String name) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.participantRemoveTitle),
        content: Text(l10n.participantRemoveConfirm(name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.removeParticipant),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await widget.firestoreService.removeParticipant(
        sessionId: widget.sessionId,
        email: email,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.participantRemovedFromSession(name)),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.stateError}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
