import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';
import '../models/eisenhower_matrix_model.dart';
import '../models/eisenhower_activity_model.dart';
import '../models/eisenhower_participant_model.dart';
import '../models/agile_enums.dart';
import '../services/eisenhower_firestore_service.dart';
import '../services/eisenhower_invite_service.dart';
import '../services/eisenhower_sheets_export_service.dart';
import '../services/auth_service.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_colors.dart';
import '../widgets/eisenhower/matrix_search_widget.dart';
import '../widgets/eisenhower/vote_reveal_widget.dart';
import '../widgets/eisenhower/raci_matrix_widget.dart';
// VoteCollectionDialog rimosso - ora si usa solo votazione indipendente
import '../widgets/eisenhower/activity_card_widget.dart';
import '../widgets/eisenhower/participant_invite_dialog.dart';
import '../widgets/eisenhower/independent_vote_dialog.dart';
import '../widgets/eisenhower/scatter_chart_widget.dart';
import '../widgets/eisenhower/matrix_grid_widget.dart';
import '../widgets/eisenhower/export_to_smart_todo_dialog.dart';
import '../widgets/eisenhower/export_to_sprint_dialog.dart';
import '../widgets/eisenhower/export_to_estimation_dialog.dart';
import '../widgets/home/favorite_star.dart';
import '../models/smart_todo/todo_list_model.dart';
import '../models/smart_todo/todo_task_model.dart';
import '../models/smart_todo/todo_participant_model.dart';
import '../models/agile_project_model.dart';
import '../models/sprint_model.dart';
import '../models/estimation_mode.dart';
import '../models/user_story_model.dart';
import '../services/smart_todo_service.dart';
import '../services/agile_firestore_service.dart';
import '../services/planning_poker_firestore_service.dart';
import 'smart_todo/smart_todo_detail_screen.dart';
import 'estimation_room_screen.dart';

/// Screen principale per la gestione delle Matrici di Eisenhower
///
/// Implementa:
/// - Lista delle matrici create dall'utente
/// - Creazione/modifica/eliminazione matrici
/// - Gestione attività con voti
/// - Visualizzazione griglia 4 quadranti
/// - Grafico scatter plot
class EisenhowerScreen extends StatefulWidget {
  final String? initialMatrixId;

  const EisenhowerScreen({
    super.key,
    this.initialMatrixId,
  });

  @override
  State<EisenhowerScreen> createState() => _EisenhowerScreenState();
}

class _EisenhowerScreenState extends State<EisenhowerScreen> with WidgetsBindingObserver {
  final EisenhowerFirestoreService _firestoreService = EisenhowerFirestoreService();
  final SmartTodoService _todoService = SmartTodoService();
  final EisenhowerInviteService _inviteService = EisenhowerInviteService();
  final EisenhowerSheetsExportService _sheetsExportService = EisenhowerSheetsExportService();
  final AuthService _authService = AuthService();

  // Stato
  EisenhowerMatrixModel? _selectedMatrix;
  List<EisenhowerActivityModel> _activities = [];
  bool _isLoading = true;
  bool _isExporting = false;
  bool _isInit = false;

  bool _isDeepLink = false;

  // Vista: 0 = Griglia, 1 = Grafico, 2 = Lista Priorità, 3 = RACI
  int _viewMode = 0;

  // Filtro ricerca matrici
  String _searchQuery = '';

  // Filtro archivio
  bool _showArchived = false;

  // ═══════════════════════════════════════════════════════════════════════════
  // REAL-TIME STREAMS & PRESENCE
  // ═══════════════════════════════════════════════════════════════════════════
  StreamSubscription<List<EisenhowerActivityModel>>? _activitiesSubscription;
  StreamSubscription<EisenhowerMatrixModel?>? _matrixSubscription;
  Timer? _presenceHeartbeat;

  /// Intervallo heartbeat per aggiornare lo stato online (30 secondi)
  static const _heartbeatInterval = Duration(seconds: 30);

  /// Soglia per considerare un utente offline (2 minuti senza heartbeat)
  static const _offlineThreshold = Duration(minutes: 2);

  String get _currentUserEmail => _authService.currentUser?.email ?? '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupWebBeforeUnload();
    // _loadData sarà chiamato in didChangeDependencies se non ci sono argomenti
  }

  /// Setup listener per beforeunload (web) - forza aggiornamento offline
  void _setupWebBeforeUnload() {
    if (kIsWeb) {
      html.window.onBeforeUnload.listen((event) {
        _setOfflineImmediately();
      });
    }
  }

  /// Imposta lo stato offline immediatamente (sincrono per beforeunload)
  void _setOfflineImmediately() {
    if (_selectedMatrix != null && _currentUserEmail.isNotEmpty) {
      _firestoreService.updateParticipantOnlineStatus(
        _selectedMatrix!.id,
        _currentUserEmail,
        false,
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_selectedMatrix == null || _currentUserEmail.isEmpty) return;

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // App in background o chiusa - imposta offline
        _setOfflineImmediately();
        _presenceHeartbeat?.cancel();
        break;
      case AppLifecycleState.resumed:
        // App tornata in primo piano - riavvia heartbeat
        _startPresenceHeartbeat();
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _checkArguments();
      _isInit = true;
    }
  }

  Future<void> _checkArguments() async {
    // First check if initialMatrixId was passed directly
    if (widget.initialMatrixId != null) {
      _isDeepLink = true;
      await _loadMatrixById(widget.initialMatrixId!);
      return;
    }

    // Then check route arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic> && args.containsKey('id')) {
      _isDeepLink = true;
      final matrixId = args['id'] as String;
      await _loadMatrixById(matrixId);
    } else {
      _loadData();
    }
  }

  Future<void> _loadMatrixById(String id) async {
    setState(() => _isLoading = true);
    try {
      final matrix = await _firestoreService.getMatrix(id);
      if (matrix != null && mounted) {
        setState(() {
          _selectedMatrix = matrix;
        });
        await _loadActivities(id);
      } else {
        // Fallback se non trovato
        await _loadData();
      }
    } catch (e) {
      _showError('Errore caricamento matrice: $e');
      await _loadData();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cancelSubscriptions();
    _stopPresenceHeartbeat();
    super.dispose();
  }

  /// Cancella tutte le subscription attive
  void _cancelSubscriptions() {
    _activitiesSubscription?.cancel();
    _activitiesSubscription = null;
    _matrixSubscription?.cancel();
    _matrixSubscription = null;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PRESENCE MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════

  /// Avvia il tracking della presenza per la matrice corrente
  void _startPresenceTracking() {
    if (_selectedMatrix == null || _currentUserEmail.isEmpty) return;

    // Avvia il tracking della presenza
    _startPresenceHeartbeat();
  }

  /// Avvia il tracking della presenza (estratto per riutilizzo in didChangeAppLifecycleState)
  void _startPresenceHeartbeat() {
    if (_selectedMatrix == null || _currentUserEmail.isEmpty) return;

    // Imposta subito online
    _firestoreService.updateParticipantOnlineStatus(
      _selectedMatrix!.id,
      _currentUserEmail,
      true,
    );

    // Avvia heartbeat periodico
    _presenceHeartbeat?.cancel();
    _presenceHeartbeat = Timer.periodic(_heartbeatInterval, (_) {
      if (_selectedMatrix != null && mounted) {
        _firestoreService.updateParticipantOnlineStatus(
          _selectedMatrix!.id,
          _currentUserEmail,
          true,
        );
      }
    });

    print('🟢 Presence tracking started for ${_currentUserEmail}');
  }

  /// Ferma il tracking della presenza
  void _stopPresenceHeartbeat() {
    _presenceHeartbeat?.cancel();
    _presenceHeartbeat = null;

    // Imposta offline quando lascia la matrice
    if (_selectedMatrix != null && _currentUserEmail.isNotEmpty) {
      _firestoreService.updateParticipantOnlineStatus(
        _selectedMatrix!.id,
        _currentUserEmail,
        false,
      );
      print('🔴 Presence tracking stopped for ${_currentUserEmail}');
    }
  }

  /// Conta i partecipanti online (lastActivity < 2 minuti)
  int _countOnlineParticipants() {
    if (_selectedMatrix == null) return 0;
    final now = DateTime.now();
    return _selectedMatrix!.participants.values.where((p) {
      if (p.lastActivity == null) return p.isOnline;
      return now.difference(p.lastActivity!).inMinutes < _offlineThreshold.inMinutes;
    }).length;
  }

  /// Gestisce l'uscita dalla matrice: ferma presenza e cancella subscription
  void _leaveMatrix() {
    _stopPresenceHeartbeat();
    _cancelSubscriptions();
    setState(() {
      _selectedMatrix = null;
      _activities = [];
    });
    print('👋 Left matrix - presence stopped, subscriptions cancelled');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // REAL-TIME STREAMS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Sottoscrive allo stream delle attività per aggiornamenti real-time
  void _subscribeToActivities(String matrixId) {
    _activitiesSubscription?.cancel();
    _activitiesSubscription = _firestoreService.streamActivities(matrixId).listen(
      (activities) {
        if (mounted) {
          setState(() => _activities = activities);
        }
      },
      onError: (e) {
        print('❌ Errore stream attività: $e');
      },
    );
    print('📡 Subscribed to activities stream for matrix: $matrixId');
  }

  /// Sottoscrive allo stream della matrice per aggiornamenti partecipanti real-time
  void _subscribeToMatrix(String matrixId) {
    _matrixSubscription?.cancel();
    _matrixSubscription = _firestoreService.streamMatrix(matrixId).listen(
      (matrix) {
        if (mounted && matrix != null) {
          setState(() => _selectedMatrix = matrix);
        }
      },
      onError: (e) {
        print('❌ Errore stream matrice: $e');
      },
    );
    print('📡 Subscribed to matrix stream: $matrixId');
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // Se c'è una matrice selezionata, sottoscrivi agli stream
      if (_selectedMatrix != null) {
        _subscribeToActivities(_selectedMatrix!.id);
        _subscribeToMatrix(_selectedMatrix!.id);
        _startPresenceTracking();
      }
    } catch (e) {
      _showError('Errore caricamento dati: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Carica le attività una volta (per compatibilità)
  /// Preferire _subscribeToActivities per real-time
  Future<void> _loadActivities(String matrixId) async {
    // Usa lo stream invece del load one-shot
    _subscribeToActivities(matrixId);
    _subscribeToMatrix(matrixId);
    _startPresenceTracking();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PopScope(
      canPop: _selectedMatrix == null || _isDeepLink,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _leaveMatrix();
      },
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            // tooltip: l10n.goToHome, // Removed to prevent RenderBox layout error during OpenContainer transition
            onPressed: () {
               // Se deep link o se nulla selezionato (e sono nello stato 1), pop
               if ((_isDeepLink || _selectedMatrix == null) && Navigator.of(context).canPop()) {
                 Navigator.of(context).pop();
               } else if (_selectedMatrix != null) {
                 // Chiudi dettaglio - ferma presence e subscription
                 _leaveMatrix();
               } else {
                 Navigator.of(context).pushReplacementNamed('/home');
               }
            },
          ),
          title: Row(
            children: [
              Icon(Icons.grid_4x4, color: context.textPrimaryColor),
              const SizedBox(width: 8),
              Text(_selectedMatrix?.title ?? l10n.eisenhowerTitle),
            ],
          ),
          actions: [
            // Toggle archivio - sempre visibile nella lista
            if (_selectedMatrix == null) ...[
              FilterChip(
                label: Text(
                  _showArchived ? l10n.archiveHideArchived : l10n.archiveShowArchived,
                  style: const TextStyle(fontSize: 12),
                ),
                selected: _showArchived,
                onSelected: (value) => setState(() => _showArchived = value),
                avatar: Icon(
                  _showArchived ? Icons.visibility_off : Icons.visibility,
                  size: 16,
                ),
                selectedColor: AppColors.warning.withValues(alpha: 0.2),
                showCheckmark: false,
              ),
              const SizedBox(width: 16),
            ],
            if (_selectedMatrix != null) ...[
              // ═══════════════════════════════════════════════════════════
              // ONLINE PARTICIPANTS COUNTER
              // ═══════════════════════════════════════════════════════════
              _buildOnlineCounter(),
              const SizedBox(width: 12),
              // ═══════════════════════════════════════════════════════════
              // EXPORT/INTEGRATION BUTTONS (solo Facilitatore)
              // ═══════════════════════════════════════════════════════════
              if (_isFacilitator) ...[
                // Export to Smart Todo
                IconButton(
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  tooltip: l10n.exportFromEisenhower,
                  onPressed: _activities.isNotEmpty ? _showExportToSmartTodoDialog : null,
                ),
                // Export to Sprint (Agile Process Manager)
                IconButton(
                  icon: const Icon(Icons.rocket_launch),
                  tooltip: l10n.exportToSprint,
                  onPressed: _activities.isNotEmpty ? _showExportToSprintDialog : null,
                ),
                // Export to Estimation Room
                IconButton(
                  icon: const Icon(Icons.casino),
                  tooltip: l10n.exportToEstimation,
                  onPressed: _activities.isNotEmpty ? _showExportToEstimationDialog : null,
                ),
                // Separator
                const SizedBox(width: 8),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
              ],
              // ═══════════════════════════════════════════════════════════
              // PAGE FUNCTIONALITY BUTTONS (tutti i ruoli)
              // ═══════════════════════════════════════════════════════════
              // Toggle viste (Griglia / Grafico / Lista)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: context.surfaceVariantColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildViewToggleButton(0, Icons.grid_view, l10n.eisenhowerViewGrid),
                    _buildViewToggleButton(1, Icons.scatter_plot, l10n.eisenhowerViewChart),
                    _buildViewToggleButton(2, Icons.format_list_numbered, l10n.eisenhowerViewList),
                    _buildViewToggleButton(3, Icons.table_chart, l10n.eisenhowerViewRaci),
                  ],
                ),
              ),
              // ═══════════════════════════════════════════════════════════
              // MANAGEMENT BUTTONS (solo Facilitatore)
              // ═══════════════════════════════════════════════════════════
              if (_isFacilitator) ...[
                // Export Google Sheets
                IconButton(
                  icon: _isExporting
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.textPrimaryColor,
                          ),
                        )
                      : const Icon(Icons.upload_file),
                  tooltip: l10n.eisenhowerExportSheets,
                  onPressed: _isExporting ? null : _exportToGoogleSheets,
                ),
                // Invita partecipanti
                IconButton(
                  icon: const Icon(Icons.person_add),
                  tooltip: l10n.eisenhowerInviteParticipants,
                  onPressed: _showInviteDialog,
                ),
                // Impostazioni matrice
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: l10n.eisenhowerMatrixSettings,
                  onPressed: _showMatrixSettings,
                ),
              ],
              const SizedBox(width: 8),
              // Torna alla lista
              if (!_isDeepLink) // Mostra solo se NON è deep link, altrimenti è back generale
              TextButton.icon(
                icon: Icon(Icons.arrow_back, size: 18, color: context.textPrimaryColor),
                label: Text(l10n.eisenhowerBackToList, style: TextStyle(color: context.textPrimaryColor)),
                onPressed: _leaveMatrix,
              ),
            ],
          ],
        ),
        body: _selectedMatrix == null ? _buildMatrixList() : _buildMatrixDetail(),
        floatingActionButton: _buildFAB(),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // LISTA MATRICI
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildMatrixList() {
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<List<EisenhowerMatrixModel>>(
      stream: _firestoreService.streamMatricesFiltered(
        userEmail: _currentUserEmail,
        includeArchived: _showArchived,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                const SizedBox(height: 16),
                Text('${l10n.stateError}: ${snapshot.error}', style: TextStyle(color: context.textPrimaryColor)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadData,
                  child: Text(l10n.actionRetry),
                ),
              ],
            ),
          );
        }

        final matrices = snapshot.data ?? [];

        if (matrices.isEmpty) {
          return _buildEmptyState();
        }

        // Applica i filtri
        final filteredMatrices = matrices.applyFilters(
          searchQuery: _searchQuery,
        );

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Icon(Icons.folder_open, color: AppColors.success),
                  const SizedBox(width: 8),
                  Text(
                    l10n.eisenhowerYourMatricesCount(filteredMatrices.length, matrices.length),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Widget di ricerca
              MatrixSearchWidget(
                onSearchChanged: (query) => setState(() => _searchQuery = query),
              ),
              const SizedBox(height: 12),
              // Barra filtri attivi
              if (_searchQuery.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_alt, size: 16, color: AppColors.secondary),
                      const SizedBox(width: 8),
                      Text(
                        l10n.eisenhowerSearchLabel,
                        style: const TextStyle(fontSize: 12, color: AppColors.secondary),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text('"$_searchQuery"', style: const TextStyle(fontSize: 11)),
                        deleteIcon: const Icon(Icons.close, size: 14),
                        onDeleted: () => setState(() => _searchQuery = ''),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => setState(() => _searchQuery = ''),
                        child: Text(l10n.filterRemove, style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              // Lista filtrata
              Expanded(
                child: filteredMatrices.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 48, color: context.textTertiaryColor),
                            const SizedBox(height: 16),
                            Text(
                              l10n.eisenhowerNoMatrixFound,
                              style: TextStyle(color: context.textSecondaryColor),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => setState(() => _searchQuery = ''),
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
                            itemCount: filteredMatrices.length,
                            itemBuilder: (context, index) => _buildMatrixCard(filteredMatrices[index]),
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
          Icon(Icons.grid_4x4, size: 80, color: context.textMutedColor),
          const SizedBox(height: 16),
          Text(
            l10n.eisenhowerNoMatrices,
            style: TextStyle(
              fontSize: 18,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.eisenhowerCreateFirstMatrix,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.textTertiaryColor),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showCreateMatrixDialog,
            icon: const Icon(Icons.add),
            label: Text(l10n.eisenhowerCreateMatrix),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatrixCard(EisenhowerMatrixModel matrix) {
    final l10n = AppLocalizations.of(context)!;
    final activityCount = matrix.activityCount;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => _selectMatrix(matrix),
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
                  // Icona matrice
                  Tooltip(
                    message: l10n.eisenhowerClickToOpen,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.grid_4x4, color: AppColors.success, size: 14),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Titolo con tooltip
                  Expanded(
                    child: Tooltip(
                      message: '${matrix.title}${matrix.description.isNotEmpty ? '\n${matrix.description}' : ''}',
                      child: Text(
                        matrix.title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: matrix.isArchived ? context.textMutedColor : context.textPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Badge archiviato
                  if (matrix.isArchived)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Tooltip(
                        message: l10n.archiveBadge,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.archive, size: 12, color: AppColors.warning),
                        ),
                      ),
                    ),
                  FavoriteStar(
                    resourceId: matrix.id,
                    type: 'eisenhower_matrix',
                    title: matrix.title,
                    colorHex: '#4CAF50', // Default color for matrices
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  // Menu compatto
                  GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      _showMatrixMenuAtPosition(context, matrix, details.globalPosition);
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
              // Stats compatte
              Row(
                children: [
                  _buildCompactMatrixStat(
                    Icons.task_alt,
                    '$activityCount',
                    l10n.eisenhowerTotalActivities,
                  ),
                  const SizedBox(width: 12),
                  _buildParticipantStat(matrix, l10n),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactMatrixStat(IconData icon, String value, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: context.textMutedColor),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Costruisce la statistica partecipanti con tooltip dettagliato (nomi e ruoli)
  Widget _buildParticipantStat(EisenhowerMatrixModel matrix, AppLocalizations l10n) {
    // Costruisci tooltip con nomi e ruoli
    final participantLines = matrix.participants.values.map((p) {
      final roleLabel = switch (p.role) {
        EisenhowerParticipantRole.facilitator => '👑 Facilitator',
        EisenhowerParticipantRole.voter => '🗳️ Voter',
        EisenhowerParticipantRole.observer => '👁️ Observer',
      };
      return '${p.name} - $roleLabel';
    }).toList();

    final tooltipText = participantLines.isNotEmpty
        ? '${l10n.participants}:\n${participantLines.join('\n')}'
        : l10n.participants;

    return Tooltip(
      message: tooltipText,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people, size: 14, color: context.textMutedColor),
          const SizedBox(width: 4),
          Text(
            '${matrix.participants.length}',
            style: TextStyle(
              fontSize: 12,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: context.textSecondaryColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DETTAGLIO MATRICE
  // ══════════════════════════════════════════════════════════════════════════

  /// Widget che mostra il contatore dei partecipanti online
  Widget _buildOnlineCounter() {
    final onlineCount = _countOnlineParticipants();
    final totalCount = _selectedMatrix?.participants.length ?? 0;
    final l10n = AppLocalizations.of(context)!;

    return Tooltip(
      message: l10n.eisenhowerOnlineParticipants(onlineCount, totalCount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: onlineCount > 0
              ? AppColors.success.withOpacity(0.15)
              : context.surfaceVariantColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: onlineCount > 0
                ? AppColors.success.withOpacity(0.3)
                : Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pallino verde/grigio animato
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: onlineCount > 0 ? AppColors.success : Colors.grey,
                boxShadow: onlineCount > 0 ? [
                  BoxShadow(
                    color: AppColors.success.withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ] : null,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '$onlineCount/$totalCount',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: onlineCount > 0
                    ? AppColors.success
                    : context.textSecondaryColor,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.people,
              size: 14,
              color: onlineCount > 0
                  ? AppColors.success
                  : context.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewToggleButton(int mode, IconData icon, String tooltip) {
    final isSelected = _viewMode == mode;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => setState(() => _viewMode = mode),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.success : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isSelected ? Colors.white : context.textSecondaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildMatrixDetail() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Vista Lista Priorità (a schermo intero senza pannello laterale)
    if (_viewMode == 2) {
      return _buildPriorityListView();
    }

    // Vista RACI (a schermo intero)
    if (_viewMode == 3) {
      return RaciMatrixWidget(
        matrix: _selectedMatrix!,
        activities: _activities,
        onActivityTap: _showActivityDetail,
        onMatrixUpdate: (updatedMatrix) {
          setState(() => _selectedMatrix = updatedMatrix);
        },
        onDataChanged: () => _loadActivities(_selectedMatrix!.id),
        onAddActivity: _showAddActivityDialog,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pannello sinistro: Griglia o Grafico
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _viewMode == 1
                ? EisenhowerScatterChartWidget(
                    activities: _activities,
                    onActivityTap: _showActivityDetail,
                  )
                : MatrixGridWidget(
                    activities: _activities,
                    onActivityTap: _showActivityDetail,
                    // Solo voter/facilitator possono votare su attività non rivelate
                    onVoteTap: _canVote ? (activity) {
                      if (_canVoteOnActivity(activity)) {
                        _submitIndependentVote(activity);
                      } else {
                        _showError('Questa attività è già stata votata. Il facilitatore deve riaprire la votazione.');
                      }
                    } : null,
                    // Solo facilitator puo' cancellare
                    onDeleteTap: _isFacilitator ? _confirmDeleteActivity : null,
                  ),
          ),
        ),
        // Pannello destro: Attività e partecipanti
        Container(
          width: 600,
          decoration: BoxDecoration(
            color: context.surfaceColor,
            border: Border(left: BorderSide(color: context.borderColor)),
          ),
          child: _buildSidePanel(),
        ),
      ],
    );
  }

  /// Vista lista ordinata per priorità (Q1 → Q2 → Q3 → Q4 → Non votate)
  Widget _buildPriorityListView() {
    final l10n = AppLocalizations.of(context)!;

    // Ordina le attività per priorità
    final sortedActivities = List<EisenhowerActivityModel>.from(_activities);
    sortedActivities.sort((a, b) {
      // Prima per quadrante (Q1 > Q2 > Q3 > Q4 > null)
      final aQuadrant = a.quadrant;
      final bQuadrant = b.quadrant;

      if (aQuadrant == null && bQuadrant == null) return 0;
      if (aQuadrant == null) return 1; // Non votate in fondo
      if (bQuadrant == null) return -1;

      final quadrantOrder = {
        EisenhowerQuadrant.q1: 0,
        EisenhowerQuadrant.q2: 1,
        EisenhowerQuadrant.q3: 2,
        EisenhowerQuadrant.q4: 3,
      };

      final aOrder = quadrantOrder[aQuadrant] ?? 4;
      final bOrder = quadrantOrder[bQuadrant] ?? 4;

      if (aOrder != bOrder) return aOrder.compareTo(bOrder);

      // Se stesso quadrante, ordina per punteggio combinato (urgenza + importanza) decrescente
      final aScore = a.aggregatedUrgency + a.aggregatedImportance;
      final bScore = b.aggregatedUrgency + b.aggregatedImportance;
      return bScore.compareTo(aScore);
    });

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.format_list_numbered, color: AppColors.success),
              const SizedBox(width: 8),
              Text(
                l10n.eisenhowerPriorityList,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                l10n.eisenhowerActivityCountLabel(_activities.length),
                style: TextStyle(color: context.textSecondaryColor),
              ),
              const Spacer(),
              // Legenda compatta
              _buildPriorityLegend(),
            ],
          ),
          const SizedBox(height: 16),
          // Lista
          Expanded(
            child: sortedActivities.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 64, color: context.textMutedColor),
                        const SizedBox(height: 16),
                        Text(
                          l10n.eisenhowerNoActivities,
                          style: TextStyle(color: context.textTertiaryColor, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: sortedActivities.length,
                    itemBuilder: (context, index) {
                      final activity = sortedActivities[index];
                      return _buildPriorityListItem(activity, index + 1);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityLegend() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLegendChip('Q1', AppColors.q1Color),
        const SizedBox(width: 8),
        _buildLegendChip('Q2', AppColors.q2Color),
        const SizedBox(width: 8),
        _buildLegendChip('Q3', AppColors.q3Color),
        const SizedBox(width: 8),
        _buildLegendChip('Q4', AppColors.q4Color),
      ],
    );
  }

  Widget _buildLegendChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildPriorityListItem(EisenhowerActivityModel activity, int position) {
    final l10n = AppLocalizations.of(context)!;
    final quadrant = activity.quadrant;
    final hasVotes = activity.hasVotes;
    final color = quadrant != null
        ? _getQuadrantColor(quadrant)
        : context.textTertiaryColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => _showActivityDetail(activity),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Posizione
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Center(
                  child: Text(
                    '#$position',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Info attività
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    if (activity.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          activity.description,
                          style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              // Punteggi
              if (hasVotes) ...[
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'U: ${activity.aggregatedUrgency.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'I: ${activity.aggregatedImportance.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.eisenhowerVoteCountLabel(activity.voteCount),
                      style: TextStyle(fontSize: 10, color: context.textTertiaryColor),
                    ),
                  ],
                ),
              ],
              const SizedBox(width: 12),
              // Badge quadrante
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.5)),
                ),
                child: Text(
                  hasVotes ? (quadrant?.title ?? '-') : l10n.eisenhowerToVote,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: hasVotes ? color : AppColors.warning,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Azioni (mostra solo se ci sono azioni disponibili)
              if (_canVote || _isFacilitator)
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: context.textTertiaryColor),
                  onSelected: (value) {
                    switch (value) {
                      case 'vote':
                        _submitIndependentVote(activity);
                        break;
                      case 'delete':
                        _confirmDeleteActivity(activity);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    // Voto solo per voter/facilitator
                    if (_canVote)
                      PopupMenuItem(
                        value: 'vote',
                        child: Row(
                          children: [
                            const Icon(Icons.how_to_vote, size: 18, color: AppColors.secondary),
                            const SizedBox(width: 8),
                            Text(hasVotes ? l10n.eisenhowerModifyVotes : l10n.eisenhowerVote),
                          ],
                        ),
                      ),
                    // Delete solo per facilitator
                    if (_isFacilitator)
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(Icons.delete, size: 18, color: AppColors.error),
                            const SizedBox(width: 8),
                            Text(l10n.actionDelete, style: const TextStyle(color: AppColors.error)),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getQuadrantColor(EisenhowerQuadrant quadrant) {
    switch (quadrant) {
      case EisenhowerQuadrant.q1:
        return AppColors.q1Color;
      case EisenhowerQuadrant.q2:
        return AppColors.q2Color;
      case EisenhowerQuadrant.q3:
        return AppColors.q3Color;
      case EisenhowerQuadrant.q4:
        return AppColors.q4Color;
    }
  }

  Widget _buildSidePanel() {
    final l10n = AppLocalizations.of(context)!;
    final unvotedActivities = _activities.unvoted;
    final votedCount = _activities.length - unvotedActivities.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header partecipanti
        Container(
          padding: const EdgeInsets.all(12),
          color: context.surfaceColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.people, size: 18, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  Text(
                    '${l10n.participants} (${_selectedMatrix!.participants.length})',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  const Spacer(),
                  // Solo facilitatore puo' modificare i partecipanti
                  if (_isFacilitator)
                    IconButton(
                      icon: Icon(Icons.edit, size: 16, color: context.textSecondaryColor),
                      onPressed: _showMatrixSettings,
                      tooltip: l10n.eisenhowerEditParticipants,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _selectedMatrix!.participants.entries.map((entry) {
                  final p = entry.value;
                  final email = entry.key;
                  final isFacilitator = _selectedMatrix!.isFacilitator(email);

                  return Chip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(p.name, style: const TextStyle(fontSize: 11)),
                        if (isFacilitator) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                        ],
                      ],
                    ),
                    avatar: CircleAvatar(
                      radius: 10,
                      backgroundColor: isFacilitator
                          ? Colors.amber.withOpacity(0.3)
                          : AppColors.secondary.withOpacity(0.2),
                      child: Text(
                        p.initial,
                        style: TextStyle(
                          fontSize: 10,
                          color: isFacilitator ? Colors.amber.shade800 : AppColors.secondary,
                        ),
                      ),
                    ),
                    side: isFacilitator
                        ? const BorderSide(color: Colors.amber, width: 1.5)
                        : BorderSide.none,
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: context.borderColor),
        // Statistiche
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: context.surfaceColor,
          child: Row(
            children: [
              _buildStatBadge(l10n.eisenhowerTotal, _activities.length, context.textTertiaryColor),
              const SizedBox(width: 8),
              _buildStatBadge(l10n.eisenhowerVoted, votedCount, AppColors.success),
              const SizedBox(width: 8),
              _buildStatBadge(l10n.eisenhowerToVote, unvotedActivities.length, AppColors.warning),
            ],
          ),
        ),
        Divider(height: 1, color: context.borderColor),
        // Lista attività non votate
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              // Sezione attività non votate
              if (unvotedActivities.isNotEmpty) ...[
                Row(
                  children: [
                    const Icon(Icons.pending_actions, size: 16, color: AppColors.warning),
                    const SizedBox(width: 6),
                    Text(
                      '${l10n.eisenhowerToVote} (${unvotedActivities.length})',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.warning,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    // Pulsante Avvia Votazione (solo facilitatore, se ci sono attività da votare)
                    if (_isFacilitator && unvotedActivities.isNotEmpty)
                      ElevatedButton.icon(
                        onPressed: () => _startSequentialVoting(unvotedActivities),
                        icon: const Icon(Icons.play_circle_outline, size: 16),
                        label: Text(l10n.eisenhowerStartVoting),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      ),
                    // Pulsante aggiungi attività (solo facilitator e voter)
                    if (_canAddActivity) ...[
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: _showAddActivityDialog,
                        icon: const Icon(Icons.add_task, size: 16),
                        label: Text(l10n.eisenhowerAddActivity),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                ...unvotedActivities.map((activity) {
                  return UnvotedActivityCard(
                    activity: activity,
                    // Solo voter/facilitator possono votare su attività non rivelate
                    onVoteTap: _canVoteOnActivity(activity) ? () => _submitIndependentVote(activity) : null,
                    onDeleteTap: _isFacilitator ? () => _confirmDeleteActivity(activity) : null,
                  );
                }),
                const SizedBox(height: 16),
              ],
              // Tutte le attività
              Row(
                children: [
                  const Icon(Icons.list, size: 16, color: AppColors.secondary),
                  const SizedBox(width: 6),
                  Text(
                    '${l10n.eisenhowerAllActivities} (${_activities.length})',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  const Spacer(),
                  // Pulsante aggiungi attività (se non mostrato sopra, solo facilitator e voter)
                  if (unvotedActivities.isEmpty && _canAddActivity)
                    ElevatedButton.icon(
                      onPressed: _showAddActivityDialog,
                      icon: const Icon(Icons.add_task, size: 16),
                      label: Text(l10n.eisenhowerAddActivity),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              // Ordina: attività non votate/non rivelate prima, poi le altre
              ...(() {
                final sortedActivities = List<EisenhowerActivityModel>.from(_activities);
                sortedActivities.sort((a, b) {
                  // Non rivelate vengono prima delle rivelate
                  if (!a.isRevealed && b.isRevealed) return -1;
                  if (a.isRevealed && !b.isRevealed) return 1;
                  // Tra le non rivelate, quelle senza voti vengono prima
                  if (!a.isRevealed && !b.isRevealed) {
                    if (!a.hasVotes && b.hasVotes) return -1;
                    if (a.hasVotes && !b.hasVotes) return 1;
                  }
                  // Per il resto, mantieni ordine originale (createdAt)
                  return 0;
                });
                return sortedActivities;
              })().map((activity) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ActivityCardWidget(
                    activity: activity,
                    onTap: () => _showActivityDetail(activity),
                    // Voter/Facilitator: vota per se stesso su attività non rivelate
                    onVoteTap: _canVoteOnActivity(activity) ? () => _submitIndependentVote(activity) : null,
                    // Solo facilitatore puo' cancellare
                    onDeleteTap: _isFacilitator ? () => _confirmDeleteActivity(activity) : null,
                    // Parametri per votazione collettiva
                    currentUserEmail: _currentUserEmail,
                    isFacilitator: _isFacilitator,
                    isObserver: _isObserver,
                    totalVoters: _selectedMatrix?.voterCount ?? 0,
                    onStartIndependentVoting: _isFacilitator ? () => _startIndependentVoting(activity) : null,
                    onSubmitIndependentVote: _canVoteOnActivity(activity) ? () => _submitIndependentVote(activity) : null,
                    onRevealVotes: _isFacilitator ? () => _revealVotes(activity) : null,
                    onResetVoting: _isFacilitator ? () => _resetVotingSession(activity) : null,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatBadge(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // FAB
  // ══════════════════════════════════════════════════════════════════════════

  Widget? _buildFAB() {
    final l10n = AppLocalizations.of(context)!;

    // FAB solo per creare nuova matrice (quando nessuna è selezionata)
    // Il pulsante "Aggiungi attività" è ora nell'header della lista
    if (_selectedMatrix == null) {
      return FloatingActionButton.extended(
        onPressed: _showCreateMatrixDialog,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(l10n.eisenhowerNewMatrix, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.success,
      );
    }
    return null;
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DIALOGS
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _showCreateMatrixDialog() async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _MatrixFormDialog(),
    );

    if (result != null) {
      try {
        // Il creatore viene automaticamente aggiunto come facilitatore
        await _firestoreService.createMatrix(
          title: result['title'],
          description: result['description'] ?? '',
          createdBy: _currentUserEmail,
          creatorName: _currentUserEmail?.split('@').first,
        );
        _showSuccess(l10n.eisenhowerMatrixCreated);
      } catch (e) {
        _showError('${l10n.errorCreatingMatrix}: $e');
      }
    }
  }

  void _showMatrixMenuAtPosition(BuildContext context, EisenhowerMatrixModel matrix, Offset globalPosition) async {
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
              Icon(Icons.edit, size: 16, color: context.textSecondaryColor),
              const SizedBox(width: 8),
              Text(l10n.actionEdit, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
        // Archive/Restore option
        PopupMenuItem(
          value: matrix.isArchived ? 'restore' : 'archive',
          child: Row(
            children: [
              Icon(
                matrix.isArchived ? Icons.unarchive : Icons.archive,
                size: 16,
                color: AppColors.warning,
              ),
              const SizedBox(width: 8),
              Text(
                matrix.isArchived ? l10n.archiveRestoreAction : l10n.archiveAction,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete, size: 16, color: AppColors.error),
              const SizedBox(width: 8),
              Text(l10n.actionDelete, style: const TextStyle(fontSize: 13, color: AppColors.error)),
            ],
          ),
        ),
      ],
    );

    if (result != null && mounted) {
      switch (result) {
        case 'edit':
          _showEditMatrixDialog(matrix);
          break;
        case 'archive':
          _archiveMatrix(matrix);
          break;
        case 'restore':
          _restoreMatrix(matrix);
          break;
        case 'delete':
          _confirmDeleteMatrix(matrix);
          break;
      }
    }
  }

  Future<void> _archiveMatrix(EisenhowerMatrixModel matrix) async {
    final l10n = AppLocalizations.of(context)!;
    final success = await _firestoreService.archiveMatrix(matrix.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? l10n.archiveSuccessMessage : l10n.archiveErrorMessage),
          backgroundColor: success ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _restoreMatrix(EisenhowerMatrixModel matrix) async {
    final l10n = AppLocalizations.of(context)!;
    final success = await _firestoreService.restoreMatrix(matrix.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? l10n.archiveRestoreSuccessMessage : l10n.archiveRestoreErrorMessage),
          backgroundColor: success ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _showEditMatrixDialog(EisenhowerMatrixModel matrix) async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _MatrixFormDialog(matrix: matrix),
    );

    if (result != null) {
      try {
        // Per i partecipanti, usa updateAllParticipants separatamente
        await _firestoreService.updateMatrix(
          matrixId: matrix.id,
          title: result['title'],
          description: result['description'],
        );

        if (_selectedMatrix?.id == matrix.id) {
          // Ricarica la matrice selezionata
          final updated = await _firestoreService.getMatrix(matrix.id);
          if (updated != null && mounted) {
            setState(() => _selectedMatrix = updated);
          }
        }

        _showSuccess(l10n.eisenhowerMatrixUpdated);
      } catch (e) {
        _showError('${l10n.errorUpdatingMatrix}: $e');
      }
    }
  }

  Future<void> _showMatrixSettings() async {
    if (_selectedMatrix != null) {
      await _showEditMatrixDialog(_selectedMatrix!);
    }
  }

  // ============================================================
  // EXPORT GOOGLE SHEETS
  // ============================================================

  /// Esporta la matrice corrente su Google Sheets
  Future<void> _exportToGoogleSheets() async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedMatrix == null) return;

    setState(() => _isExporting = true);

    try {
      final url = await _sheetsExportService.exportToGoogleSheets(
        matrix: _selectedMatrix!,
        activities: _activities,
      );

      if (url != null) {
        _showSuccess(l10n.eisenhowerExportCompleted);

        // Chiedi se aprire il foglio
        if (mounted) {
          final shouldOpen = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(l10n.eisenhowerExportCompletedDialog),
              content: Text(l10n.eisenhowerExportDialogContent),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(l10n.no),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(l10n.eisenhowerOpen),
                ),
              ],
            ),
          );

          if (shouldOpen == true) {
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          }
        }
      } else {
        _showError(l10n.errorExport);
      }
    } catch (e) {
      _showError('${l10n.errorExport}: $e');
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  /// Show dialog to export activities to Smart Todo
  Future<void> _showExportToSmartTodoDialog() async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedMatrix == null || _currentUserEmail == null) return;

    final userEmail = _currentUserEmail!;

    // Get available lists for current user
    List<TodoListModel> availableLists = [];
    try {
      availableLists = await _todoService.streamLists(userEmail).first;
    } catch (e) {
      print('Error fetching lists: $e');
    }

    if (!mounted) return;

    // Show export dialog
    final result = await showDialog<ExportToSmartTodoFromEisenhowerResult>(
      context: context,
      builder: (context) => ExportToSmartTodoFromEisenhowerDialog(
        matrix: _selectedMatrix!,
        activities: _activities,
        availableLists: availableLists,
      ),
    );

    if (result == null || result.selectedActivities.isEmpty || !mounted) return;

    try {
      String listId;
      TodoListModel? targetList;

      if (result.createNewList) {
        // Create new list model
        final newList = TodoListModel(
          id: '',
          title: result.newListTitle!,
          description: 'Imported from: ${_selectedMatrix!.title}',
          ownerId: userEmail,
          createdAt: DateTime.now(),
          participants: {
            userEmail: TodoParticipant(
              email: userEmail,
              role: TodoParticipantRole.owner,
              joinedAt: DateTime.now(),
            ),
          },
          columns: [
            const TodoColumn(id: 'todo', title: 'To Do', colorValue: 0xFF2196F3),
            const TodoColumn(id: 'in_progress', title: 'In Progress', colorValue: 0xFFFF9800),
            const TodoColumn(id: 'done', title: 'Done', colorValue: 0xFF4CAF50, isDone: true),
          ],
        );
        listId = await _todoService.createList(newList, userEmail);
        // Fetch the created list
        targetList = await _todoService.streamLists(userEmail).first.then(
          (lists) => lists.firstWhere((l) => l.id == listId),
        );
      } else {
        // Use existing list
        listId = result.existingList!.id;
        targetList = result.existingList!;
      }

      // Create tasks for each selected activity
      final now = DateTime.now();
      int createdCount = 0;
      for (final activity in result.selectedActivities) {
        // Map quadrant to priority
        final priority = _mapQuadrantToPriority(activity.quadrant);

        final task = TodoTaskModel(
          id: '',
          listId: listId,
          title: activity.title,
          description: activity.description,
          priority: priority,
          createdAt: now,
          updatedAt: now,
        );

        await _todoService.createTask(listId, task);
        createdCount++;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.tasksCreated(createdCount)),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: l10n.actionOpen,
              textColor: Colors.white,
              onPressed: () {
                if (mounted && targetList != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SmartTodoDetailScreen(list: targetList!),
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

  /// Map Eisenhower quadrant to task priority
  TodoTaskPriority _mapQuadrantToPriority(EisenhowerQuadrant? quadrant) {
    switch (quadrant) {
      case EisenhowerQuadrant.q1: // Urgent & Important
        return TodoTaskPriority.high;
      case EisenhowerQuadrant.q2: // Not Urgent & Important
        return TodoTaskPriority.high;
      case EisenhowerQuadrant.q3: // Urgent & Not Important
        return TodoTaskPriority.medium;
      case EisenhowerQuadrant.q4: // Not Urgent & Not Important
      case null: // Unvoted
        return TodoTaskPriority.low;
    }
  }

  /// Show dialog to export activities to Agile Sprint
  Future<void> _showExportToSprintDialog() async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedMatrix == null || _currentUserEmail == null) return;

    final userEmail = _currentUserEmail!;
    final agileService = AgileFirestoreService();

    // Get available projects for current user
    List<AgileProjectModel> availableProjects = [];
    try {
      availableProjects = await agileService.streamUserProjects(userEmail).first;
    } catch (e) {
      print('Error fetching projects: $e');
    }

    if (!mounted) return;

    // Show export dialog
    final result = await showDialog<ExportEisenhowerToSprintResult>(
      context: context,
      builder: (context) => ExportEisenhowerToSprintDialog(
        activities: _activities,
        matrix: _selectedMatrix!,
        availableProjects: availableProjects,
        getProjectSprints: (projectId) => agileService.streamProjectSprints(projectId).first,
      ),
    );

    if (result == null || result.selectedActivities.isEmpty || !mounted) return;

    try {
      String projectId;
      SprintModel? targetSprint;

      if (result.createNewProject && result.newProjectConfig != null) {
        // Create new project
        final createdProject = await agileService.createProject(
          name: result.newProjectConfig!.name,
          description: result.newProjectConfig!.description,
          createdBy: userEmail,
          createdByName: userEmail.split('@').first,
          framework: result.newProjectConfig!.framework,
          sprintDurationDays: result.newProjectConfig!.sprintDurationDays,
          workingHoursPerDay: result.newProjectConfig!.workingHoursPerDay,
          productOwnerEmail: result.newProjectConfig!.productOwnerEmail,
          scrumMasterEmail: result.newProjectConfig!.scrumMasterEmail,
        );
        projectId = createdProject.id;

        // Create new sprint in the project
        final createdSprint = await agileService.createSprint(
          projectId: projectId,
          name: 'Sprint 1',
          goal: 'Stories imported from ${_selectedMatrix!.title}',
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(days: result.newProjectConfig!.sprintDurationDays)),
          createdBy: userEmail,
        );
        targetSprint = createdSprint;
      } else if (result.existingProject != null) {
        // Use existing project
        projectId = result.existingProject!.id;
        targetSprint = result.sprint;
      } else {
        return; // No valid configuration
      }

      // Create stories for each selected activity
      int createdCount = 0;
      for (final activity in result.selectedActivities) {
        // Map quadrant to priority using the function from the dialog
        final priority = priorityFromQuadrant(activity.quadrant);

        // Map importance to business value (1-10 scale)
        final businessValue = activity.aggregatedImportance.round().clamp(1, 10);

        await agileService.createStory(
          projectId: projectId,
          title: activity.title,
          description: activity.description ?? '',
          createdBy: userEmail,
          priority: priority,
          businessValue: businessValue,
        );
        createdCount++;
      }

      if (mounted) {
        final sprintName = targetSprint?.name ?? 'Backlog';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.activitiesExportedToSprint(createdCount, sprintName)),
            backgroundColor: Colors.green,
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

  /// Show dialog to export activities to Estimation Room
  Future<void> _showExportToEstimationDialog() async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedMatrix == null || _currentUserEmail == null) return;

    final userEmail = _currentUserEmail!;

    if (!mounted) return;

    // Show export dialog
    final result = await showDialog<ExportEisenhowerToEstimationResult>(
      context: context,
      builder: (context) => ExportEisenhowerToEstimationDialog(
        activities: _activities,
        matrix: _selectedMatrix!,
      ),
    );

    if (result == null || result.selectedActivities.isEmpty || !mounted) return;

    try {
      final pokerService = PlanningPokerFirestoreService();

      // Create new estimation session
      final sessionId = await pokerService.createSession(
        name: result.sessionName,
        description: result.sessionDescription ?? '',
        createdBy: userEmail,
        estimationMode: result.estimationMode,
      );

      // Create stories for each selected activity
      int createdCount = 0;
      for (final activity in result.selectedActivities) {
        await pokerService.createStory(
          sessionId: sessionId,
          title: activity.title,
          description: activity.description ?? '',
        );
        createdCount++;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.activitiesExportedToEstimation(createdCount, result.sessionName)),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: l10n.actionOpen,
              textColor: Colors.white,
              onPressed: () {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EstimationRoomScreen(initialSessionId: sessionId),
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

  // ============================================================
  // INVITI E VOTAZIONE INDIPENDENTE
  // ============================================================

  /// Mostra il dialog per invitare partecipanti
  Future<void> _showInviteDialog() async {
    if (_selectedMatrix == null) return;

    final pendingInvites = await _inviteService.getInvitesForMatrix(_selectedMatrix!.id);

    if (!mounted) return;

    final result = await ParticipantInviteDialog.show(
      context: context,
      matrixId: _selectedMatrix!.id,
      matrixTitle: _selectedMatrix!.title,
      pendingInvites: pendingInvites,
    );

    // Se ci sono stati cambiamenti, ricarica la matrice
    if (result == true) {
      final updated = await _firestoreService.getMatrix(_selectedMatrix!.id);
      if (updated != null && mounted) {
        setState(() => _selectedMatrix = updated);
      }
    }
  }

  /// Avvia una sessione di votazione indipendente su un'attivita'
  Future<void> _startIndependentVoting(EisenhowerActivityModel activity) async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedMatrix == null) return;

    // Verifica che ci siano partecipanti votanti
    if (_selectedMatrix!.voterCount < 2) {
      _showError(l10n.eisenhowerMinVotersRequired);
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.eisenhowerStartVoting),
        content: Text(l10n.eisenhowerStartVotingDesc(activity.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.how_to_vote),
            label: Text(l10n.eisenhowerStart),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _firestoreService.startVotingSession(_selectedMatrix!.id, activity.id);
        await _loadActivities(_selectedMatrix!.id);
        _showSuccess(l10n.eisenhowerVotingStarted);
      } catch (e) {
        _showError('${l10n.errorStartingVoting}: $e');
      }
    }
  }

  /// Avvia una sessione di votazione sequenziale su più attività
  ///
  /// Questo metodo:
  /// 1. Avvia la votazione sulla prima attività della lista
  /// 2. Mostra un dialog per votare
  /// 3. Quando rivelata, passa automaticamente alla successiva
  Future<void> _startSequentialVoting(List<EisenhowerActivityModel> activities) async {
    if (_selectedMatrix == null || activities.isEmpty) return;
    final l10n = AppLocalizations.of(context)!;

    // Verifica che ci siano partecipanti votanti
    if (_selectedMatrix!.voterCount < 2) {
      _showError(l10n.eisenhowerMinVotersRequired);
      return;
    }

    // Prendi la prima attività non rivelata
    final currentActivity = activities.first;

    // Avvia la votazione se non è già attiva
    if (!currentActivity.isVotingInProgress) {
      try {
        await _firestoreService.startVotingSession(_selectedMatrix!.id, currentActivity.id);
        await _loadActivities(_selectedMatrix!.id);
      } catch (e) {
        _showError('${l10n.errorStartingVoting}: $e');
        return;
      }
    }

    // Mostra il dialog di votazione sequenziale
    if (mounted) {
      await _showSequentialVotingDialog(activities, 0);
    }
  }

  /// Mostra il dialog per la votazione sequenziale
  Future<void> _showSequentialVotingDialog(List<EisenhowerActivityModel> activities, int currentIndex) async {
    if (_selectedMatrix == null || currentIndex >= activities.length) return;
    final l10n = AppLocalizations.of(context)!;

    // Ricarica l'attività corrente per avere i dati aggiornati
    final currentActivity = await _firestoreService.getActivity(
      _selectedMatrix!.id,
      activities[currentIndex].id,
    );
    if (currentActivity == null || !mounted) return;

    final hasNextActivity = currentIndex + 1 < activities.length;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => _SequentialVotingDialog(
        activity: currentActivity,
        matrix: _selectedMatrix!,
        currentIndex: currentIndex,
        totalActivities: activities.length,
        currentUserEmail: _currentUserEmail,
        isFacilitator: _isFacilitator,
        firestoreService: _firestoreService,
        onVoteSubmitted: () async {
          // Ricarica le attività
          await _loadActivities(_selectedMatrix!.id);
        },
        onRevealed: () async {
          // Chiudi il dialog corrente
          Navigator.of(dialogContext).pop();

          // Ricarica le attività
          await _loadActivities(_selectedMatrix!.id);

          // Mostra il riepilogo dei voti
          final currentActivity = activities[currentIndex];
          final updatedActivity = await _firestoreService.getActivity(_selectedMatrix!.id, currentActivity.id);

          if (updatedActivity != null && mounted) {
            await VoteRevealDialog.show(
              context: context,
              activity: updatedActivity,
              participants: _selectedMatrix!.participants,
              hasNextActivity: hasNextActivity,
              onNextActivity: hasNextActivity ? () async {
                final nextActivity = activities[currentIndex + 1];
                try {
                  await _firestoreService.startVotingSession(_selectedMatrix!.id, nextActivity.id);
                  await _loadActivities(_selectedMatrix!.id);
                  await _showSequentialVotingDialog(activities, currentIndex + 1);
                } catch (e) {
                  _showError('Errore avvio prossima votazione: $e');
                }
              } : null,
            );
          } else if (!hasNextActivity) {
            _showSuccess(l10n.eisenhowerAllActivitiesVoted);
          }
        },
        onClose: () {
          Navigator.of(dialogContext).pop();
        },
      ),
    );
  }

  /// Verifica se l'utente corrente può votare su una specifica attività
  ///
  /// Condizioni:
  /// - L'utente ha il ruolo di facilitatore o voter (non observer)
  /// - L'attività NON è già stata rivelata (a meno che non sia stata riaperta)
  /// - Se l'utente ha già votato, solo il facilitatore può modificare
  bool _canVoteOnActivity(EisenhowerActivityModel activity) {
    if (!_canVote) return false;
    // Non si può votare su attività già rivelate
    if (activity.isRevealed) return false;
    // Se l'utente ha già votato e NON è facilitatore, non può modificare
    if (!_isFacilitator && _currentUserEmail != null) {
      final escapedEmail = EisenhowerParticipantModel.escapeEmail(_currentUserEmail!);
      final hasVoted = activity.votes.containsKey(escapedEmail) ||
                       activity.votes.containsKey(_currentUserEmail!);
      if (hasVoted) return false;
    }
    return true;
  }

  /// Gestisce il voto dell'utente corrente
  ///
  /// Il voter può votare liberamente su qualsiasi attività non ancora rivelata,
  /// senza dover aspettare che il facilitatore avvii una sessione di voto.
  Future<void> _submitIndependentVote(EisenhowerActivityModel activity) async {
    if (_selectedMatrix == null || _currentUserEmail == null) return;

    // Blocca il voto su attività già rivelate
    if (activity.isRevealed) {
      _showError('Questa attività è già stata votata. Il facilitatore deve riaprire la votazione.');
      return;
    }

    // Ottieni il voto esistente se c'e'
    final existingVote = activity.getVote(_currentUserEmail!);

    final vote = await IndependentVoteDialog.show(
      context: context,
      activity: activity,
      voterEmail: _currentUserEmail!,
      voterName: _currentUserEmail!.split('@').first,
      existingVote: existingVote,
    );

    if (vote != null) {
      try {
        // Salva il voto
        await _firestoreService.submitBlindedVote(
          matrixId: _selectedMatrix!.id,
          activityId: activity.id,
          voterEmail: _currentUserEmail!,
          vote: vote,
        );

        // Marca come pronto
        await _firestoreService.markVoterReady(
          matrixId: _selectedMatrix!.id,
          activityId: activity.id,
          voterEmail: _currentUserEmail!,
        );

        await _loadActivities(_selectedMatrix!.id);
        _showSuccess('Voto registrato');
      } catch (e) {
        _showError('Errore salvataggio voto: $e');
      }
    }
  }

  /// Rivela i voti di una sessione indipendente
  Future<void> _revealVotes(EisenhowerActivityModel activity) async {
    if (_selectedMatrix == null) return;

    try {
      await _firestoreService.revealVotes(_selectedMatrix!.id, activity.id);

      // Ricarica le attività per trovare la prossima da votare
      await _loadActivities(_selectedMatrix!.id);

      // Trova la prossima attività non rivelata (per il pulsante "Prossima Attività")
      final nextActivity = _activities.where((a) =>
        a.id != activity.id &&
        !a.isRevealed &&
        a.hasVotes
      ).firstOrNull;

      // Ricarica e mostra il dialog con i risultati
      final updated = await _firestoreService.getActivity(_selectedMatrix!.id, activity.id);
      if (updated != null && mounted) {
        await VoteRevealDialog.show(
          context: context,
          activity: updated,
          participants: _selectedMatrix!.participants,
          hasNextActivity: nextActivity != null,
          onNextActivity: nextActivity != null ? () {
            // Quando l'utente clicca "Prossima Attività", rivela quella
            _revealVotes(nextActivity);
          } : null,
        );
      }
    } catch (e) {
      _showError('Errore reveal voti: $e');
    }
  }

  /// Resetta una sessione di votazione
  Future<void> _resetVotingSession(EisenhowerActivityModel activity) async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedMatrix == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.eisenhowerResetVoting),
        content: Text(l10n.eisenhowerResetVotingDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
            child: Text(l10n.actionReset),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _firestoreService.resetVotingSession(_selectedMatrix!.id, activity.id);
        await _loadActivities(_selectedMatrix!.id);
        _showSuccess(l10n.eisenhowerVotingReset);
      } catch (e) {
        _showError('${l10n.errorResetVoting}: $e');
      }
    }
  }

  /// Verifica se l'utente corrente e' facilitatore della matrice
  bool get _isFacilitator {
    if (_selectedMatrix == null || _currentUserEmail == null) return false;
    return _selectedMatrix!.isFacilitator(_currentUserEmail!);
  }

  /// Verifica se l'utente corrente puo' votare (facilitator o voter)
  bool get _canVote {
    if (_selectedMatrix == null || _currentUserEmail == null) return false;
    return _selectedMatrix!.canUserVote(_currentUserEmail!);
  }

  /// Verifica se l'utente corrente puo' aggiungere attività (facilitator o voter)
  bool get _canAddActivity {
    // canVote include sia facilitator che voter, escludendo observer
    return _canVote;
  }

  /// Verifica se l'utente corrente e' un observer (solo visualizzazione)
  bool get _isObserver {
    if (_selectedMatrix == null || _currentUserEmail == null) return false;
    return _selectedMatrix!.isObserver(_currentUserEmail!);
  }

  Future<void> _confirmDeleteMatrix(EisenhowerMatrixModel matrix) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.eisenhowerDeleteMatrix),
        content: Text(
          '${l10n.eisenhowerDeleteActivityConfirm(matrix.title)}\n'
          '${l10n.eisenhowerDeleteMatrixWithActivities(matrix.activityCount)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _firestoreService.deleteMatrix(matrix.id);
        if (_selectedMatrix?.id == matrix.id) {
          setState(() {
            _selectedMatrix = null;
            _activities = [];
          });
        }
        _showSuccess(l10n.eisenhowerMatrixDeleted);
      } catch (e) {
        _showError('${l10n.errorDeletingMatrix}: $e');
      }
    }
  }

  Future<void> _showAddActivityDialog() async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => _ActivityFormDialog(),
    );

    if (result != null && _selectedMatrix != null) {
      try {
        await _firestoreService.createActivity(
          matrixId: _selectedMatrix!.id,
          title: result['title']!,
          description: result['description'] ?? '',
        );
        await _loadActivities(_selectedMatrix!.id);
        _showSuccess(l10n.eisenhowerActivityAdded);
      } catch (e) {
        _showError('${l10n.errorAddingActivity}: $e');
      }
    }
  }

  Future<void> _showActivityDetail(EisenhowerActivityModel activity) async {
    final l10n = AppLocalizations.of(context)!;
    final myVote = _currentUserEmail != null ? activity.getVote(_currentUserEmail!) : null;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(activity.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (activity.description.isNotEmpty) ...[
                Text(activity.description),
                const SizedBox(height: 16),
              ],
              // Se l'attività è stata rivelata, mostra tutti i voti e il quadrante
              if (activity.isRevealed && activity.hasVotes) ...[
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  '${l10n.eisenhowerQuadrant}: ${activity.quadrant?.name ?? "-"} - ${activity.quadrant?.title ?? "-"}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('${l10n.eisenhowerUrgencyAvg}: ${activity.aggregatedUrgency.toStringAsFixed(1)}'),
                Text('${l10n.eisenhowerImportanceAvg}: ${activity.aggregatedImportance.toStringAsFixed(1)}'),
                const SizedBox(height: 12),
                Text(l10n.eisenhowerVotesLabel, style: const TextStyle(fontWeight: FontWeight.w600)),
                ...activity.votes.entries.map((e) {
                  // Unescape l'email e cerca il partecipante
                  final unescapedEmail = EisenhowerParticipantModel.unescapeEmail(e.key).toLowerCase();
                  final participant = _selectedMatrix?.participants[unescapedEmail];
                  final voterName = participant?.name ?? unescapedEmail.split('@').first;
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '- $voterName: U=${e.value.urgency}, I=${e.value.importance}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }),
              ]
              // Se non rivelata, mostra solo il proprio voto (se esiste)
              else if (myVote != null) ...[
                const Divider(),
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
                      const Icon(Icons.check_circle, color: Colors.green, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Il tuo voto: U=${myVote.urgency}, I=${myVote.importance}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'I voti saranno visibili quando il facilitatore farà "Rivela voti"',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
                ),
              ]
              else ...[
                Text(l10n.eisenhowerNoVotesYet),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionClose),
          ),
          // Pulsante voto solo per voter/facilitator su attività non rivelate
          if (_canVoteOnActivity(activity))
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _submitIndependentVote(activity);
              },
              child: Text(myVote != null ? l10n.eisenhowerModifyVotes : l10n.eisenhowerVote),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteActivity(EisenhowerActivityModel activity) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.eisenhowerDeleteActivity),
        content: Text(l10n.eisenhowerDeleteActivityConfirm(activity.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );

    if (confirmed == true && _selectedMatrix != null) {
      try {
        await _firestoreService.deleteActivity(
          matrixId: _selectedMatrix!.id,
          activityId: activity.id,
        );
        await _loadActivities(_selectedMatrix!.id);
        _showSuccess(l10n.eisenhowerActivityDeleted);
      } catch (e) {
        _showError('${l10n.errorDeletingMatrix}: $e');
      }
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _selectMatrix(EisenhowerMatrixModel matrix) async {
    setState(() {
      _selectedMatrix = matrix;
      _isLoading = true;
    });
    await _loadActivities(matrix.id);
    setState(() => _isLoading = false);
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// DIALOGS AUSILIARI
// ══════════════════════════════════════════════════════════════════════════════

class _MatrixFormDialog extends StatefulWidget {
  final EisenhowerMatrixModel? matrix;

  const _MatrixFormDialog({this.matrix});

  @override
  State<_MatrixFormDialog> createState() => _MatrixFormDialogState();
}

class _MatrixFormDialogState extends State<_MatrixFormDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _participantController;
  late List<String> _participants;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.matrix?.title ?? '');
    _descriptionController = TextEditingController(text: widget.matrix?.description ?? '');
    _participantController = TextEditingController();
    // Usa i nomi dei partecipanti per la lista nel form
    _participants = List.from(widget.matrix?.participantNames ?? []);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _participantController.dispose();
    super.dispose();
  }

  void _addParticipant() {
    final name = _participantController.text.trim();
    if (name.isNotEmpty && !_participants.contains(name)) {
      setState(() {
        _participants.add(name);
        _participantController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = widget.matrix != null;

    return AlertDialog(
      title: Text(isEdit ? l10n.eisenhowerEditMatrix : l10n.eisenhowerNewMatrix),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '${l10n.formTitle} *',
                  hintText: l10n.formTitleHint,
                  border: const OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.formDescription,
                  hintText: l10n.formDescriptionHint,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              Text(
                l10n.participants,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _participantController,
                      decoration: InputDecoration(
                        hintText: l10n.formParticipantHint,
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      onSubmitted: (_) => _addParticipant(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: AppColors.secondary),
                    onPressed: _addParticipant,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _participants.map((p) {
                  return Chip(
                    label: Text(p),
                    onDeleted: () {
                      setState(() => _participants.remove(p));
                    },
                  );
                }).toList(),
              ),
              if (_participants.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    l10n.formAddParticipantHint,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textSecondaryColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.formTitleRequired)),
              );
              return;
            }
            Navigator.pop(context, {
              'title': _titleController.text.trim(),
              'description': _descriptionController.text.trim(),
              'participants': _participants,
            });
          },
          child: Text(isEdit ? l10n.actionSave : l10n.actionCreate),
        ),
      ],
    );
  }
}

class _ActivityFormDialog extends StatefulWidget {
  @override
  State<_ActivityFormDialog> createState() => _ActivityFormDialogState();
}

class _ActivityFormDialogState extends State<_ActivityFormDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.eisenhowerNewActivity),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '${l10n.formTitle} *',
                hintText: l10n.formActivityTitleHint,
                border: const OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l10n.formDescription,
                hintText: l10n.formDescriptionHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.formTitleRequired)),
              );
              return;
            }
            Navigator.pop(context, {
              'title': _titleController.text.trim(),
              'description': _descriptionController.text.trim(),
            });
          },
          child: Text(l10n.actionAdd),
        ),
      ],
    );
  }
}

/// Dialog per la votazione sequenziale di attività
class _SequentialVotingDialog extends StatefulWidget {
  final EisenhowerActivityModel activity;
  final EisenhowerMatrixModel matrix;
  final int currentIndex;
  final int totalActivities;
  final String? currentUserEmail;
  final bool isFacilitator;
  final EisenhowerFirestoreService firestoreService;
  final VoidCallback onVoteSubmitted;
  final VoidCallback onRevealed;
  final VoidCallback onClose;

  const _SequentialVotingDialog({
    required this.activity,
    required this.matrix,
    required this.currentIndex,
    required this.totalActivities,
    required this.currentUserEmail,
    required this.isFacilitator,
    required this.firestoreService,
    required this.onVoteSubmitted,
    required this.onRevealed,
    required this.onClose,
  });

  @override
  State<_SequentialVotingDialog> createState() => _SequentialVotingDialogState();
}

class _SequentialVotingDialogState extends State<_SequentialVotingDialog> {
  EisenhowerActivityModel? _currentActivity;
  StreamSubscription<EisenhowerActivityModel?>? _activitySubscription;
  bool _isRevealing = false;

  @override
  void initState() {
    super.initState();
    _currentActivity = widget.activity;
    _subscribeToActivity();
  }

  void _subscribeToActivity() {
    _activitySubscription?.cancel();
    _activitySubscription = widget.firestoreService
        .streamActivity(widget.matrix.id, widget.activity.id)
        .listen((activity) {
      if (mounted && activity != null) {
        setState(() => _currentActivity = activity);
      }
    });
  }

  @override
  void dispose() {
    _activitySubscription?.cancel();
    super.dispose();
  }

  bool get _hasCurrentUserVoted {
    if (widget.currentUserEmail == null || _currentActivity == null) return false;
    final escapedEmail = EisenhowerParticipantModel.escapeEmail(widget.currentUserEmail!);
    return _currentActivity!.votes.containsKey(escapedEmail) ||
           _currentActivity!.votes.containsKey(widget.currentUserEmail!);
  }

  EisenhowerVote? get _currentUserVote {
    if (widget.currentUserEmail == null || _currentActivity == null) return null;
    final escapedEmail = EisenhowerParticipantModel.escapeEmail(widget.currentUserEmail!);
    return _currentActivity!.votes[escapedEmail] ?? _currentActivity!.votes[widget.currentUserEmail!];
  }

  int get _totalExpectedVoters => widget.matrix.voterCount;

  bool get _areAllVotersReady {
    if (_currentActivity == null) return false;
    return _currentActivity!.readyVoters.length >= _totalExpectedVoters;
  }

  Future<void> _submitVote() async {
    if (_currentActivity == null || widget.currentUserEmail == null) return;

    final vote = await IndependentVoteDialog.show(
      context: context,
      activity: _currentActivity!,
      voterEmail: widget.currentUserEmail!,
      voterName: widget.currentUserEmail!.split('@').first,
      existingVote: _currentUserVote,
    );

    if (vote != null) {
      await widget.firestoreService.submitBlindedVote(
        matrixId: widget.matrix.id,
        activityId: _currentActivity!.id,
        voterEmail: widget.currentUserEmail!,
        vote: vote,
      );
      await widget.firestoreService.markVoterReady(
        matrixId: widget.matrix.id,
        activityId: _currentActivity!.id,
        voterEmail: widget.currentUserEmail!,
      );
      widget.onVoteSubmitted();
    }
  }

  Future<void> _revealVotes() async {
    if (_currentActivity == null || !widget.isFacilitator) return;

    setState(() => _isRevealing = true);

    try {
      await widget.firestoreService.revealVotes(widget.matrix.id, _currentActivity!.id);
      widget.onRevealed();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore reveal: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isRevealing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final readyCount = _currentActivity?.readyVoters.length ?? 0;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.how_to_vote, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentActivity?.title ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${l10n.eisenhowerVoting} (${widget.currentIndex + 1}/${widget.totalActivities})',
                  style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600], fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Descrizione attività
            if (_currentActivity?.description.isNotEmpty ?? false) ...[
              Text(
                _currentActivity!.description,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
            ],

            // Progress bar
            Row(
              children: [
                Text(
                  l10n.eisenhowerVotedParticipants(readyCount, _totalExpectedVoters),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const Spacer(),
                if (_areAllVotersReady)
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _totalExpectedVoters > 0 ? readyCount / _totalExpectedVoters : 0.0,
                minHeight: 8,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(
                  _areAllVotersReady ? Colors.green : Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stato del voto dell'utente
            if (_hasCurrentUserVoted) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.eisenhowerVotedSuccess,
                            style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w600),
                          ),
                          if (_currentUserVote != null)
                            Text(
                              'U:${_currentUserVote!.urgency} I:${_currentUserVote!.importance}',
                              style: TextStyle(fontSize: 12, color: Colors.green[600]),
                            ),
                        ],
                      ),
                    ),
                    // Pulsante per modificare il voto - SOLO facilitatore
                    if (widget.isFacilitator)
                      TextButton(
                        onPressed: _submitVote,
                        child: Text(l10n.actionEdit),
                      ),
                  ],
                ),
              ),
            ] else ...[
              // Pulsante per votare
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitVote,
                  icon: const Icon(Icons.how_to_vote),
                  label: Text(l10n.eisenhowerVoteSubmit),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ],

            // Messaggio per il facilitatore
            if (widget.isFacilitator && !_areAllVotersReady) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.hourglass_empty, color: Colors.orange, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.eisenhowerWaitingForAllVotes,
                        style: TextStyle(color: Colors.orange[700], fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.onClose,
          child: Text(l10n.actionClose),
        ),
        // Pulsante Rivela (solo facilitatore, solo se tutti hanno votato)
        if (widget.isFacilitator)
          ElevatedButton.icon(
            onPressed: _areAllVotersReady && !_isRevealing ? _revealVotes : null,
            icon: _isRevealing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.visibility),
            label: Text(l10n.eisenhowerRevealVotes),
            style: ElevatedButton.styleFrom(
              backgroundColor: _areAllVotersReady ? Colors.green : Colors.grey,
              foregroundColor: Colors.white,
            ),
          ),
      ],
    );
  }
}
