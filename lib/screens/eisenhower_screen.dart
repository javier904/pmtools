import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/eisenhower_matrix_model.dart';
import '../models/eisenhower_activity_model.dart';
import '../services/eisenhower_firestore_service.dart';
import '../services/eisenhower_invite_service.dart';
import '../services/eisenhower_sheets_export_service.dart';
import '../services/auth_service.dart';
import '../themes/app_theme.dart';
import '../themes/app_colors.dart';
import '../widgets/eisenhower/matrix_grid_widget.dart';
import '../widgets/eisenhower/activity_card_widget.dart';
import '../widgets/eisenhower/vote_collection_dialog.dart';
import '../widgets/eisenhower/scatter_chart_widget.dart';
import '../widgets/eisenhower/matrix_search_widget.dart';
import '../widgets/eisenhower/participant_invite_dialog.dart';
import '../widgets/eisenhower/independent_vote_dialog.dart';
import '../widgets/eisenhower/vote_reveal_widget.dart';
import '../widgets/eisenhower/raci_matrix_widget.dart';

/// Screen principale per la gestione delle Matrici di Eisenhower
///
/// Implementa:
/// - Lista delle matrici create dall'utente
/// - Creazione/modifica/eliminazione matrici
/// - Gestione attività con voti
/// - Visualizzazione griglia 4 quadranti
/// - Grafico scatter plot
class EisenhowerScreen extends StatefulWidget {
  const EisenhowerScreen({super.key});

  @override
  State<EisenhowerScreen> createState() => _EisenhowerScreenState();
}

class _EisenhowerScreenState extends State<EisenhowerScreen> {
  final EisenhowerFirestoreService _firestoreService = EisenhowerFirestoreService();
  final EisenhowerInviteService _inviteService = EisenhowerInviteService();
  final EisenhowerSheetsExportService _sheetsExportService = EisenhowerSheetsExportService();
  final AuthService _authService = AuthService();

  // Stato
  EisenhowerMatrixModel? _selectedMatrix;
  List<EisenhowerActivityModel> _activities = [];
  bool _isLoading = true;
  bool _isExporting = false;

  // Vista: 0 = Griglia, 1 = Grafico, 2 = Lista Priorità, 3 = RACI
  int _viewMode = 0;

  // Filtro ricerca matrici
  String _searchQuery = '';

  String get _currentUserEmail => _authService.currentUser?.email ?? '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // Se c'è una matrice selezionata, ricarica le attività
      if (_selectedMatrix != null) {
        await _loadActivities(_selectedMatrix!.id);
      }
    } catch (e) {
      _showError('Errore caricamento dati: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadActivities(String matrixId) async {
    try {
      final activities = await _firestoreService.getActivities(matrixId);
      if (mounted) {
        setState(() => _activities = activities);
      }
    } catch (e) {
      _showError('Errore caricamento attività: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.grid_4x4, color: context.textPrimaryColor),
            const SizedBox(width: 8),
            Text(_selectedMatrix?.title ?? 'Matrice di Eisenhower'),
          ],
        ),
        actions: [
          if (_selectedMatrix != null) ...[
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
                  _buildViewToggleButton(0, Icons.grid_view, 'Griglia'),
                  _buildViewToggleButton(1, Icons.scatter_plot, 'Grafico'),
                  _buildViewToggleButton(2, Icons.format_list_numbered, 'Lista'),
                  _buildViewToggleButton(3, Icons.table_chart, 'RACI'),
                ],
              ),
            ),
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
              tooltip: 'Esporta su Google Sheets',
              onPressed: _isExporting ? null : _exportToGoogleSheets,
            ),
            // Invita partecipanti
            IconButton(
              icon: const Icon(Icons.person_add),
              tooltip: 'Invita Partecipanti',
              onPressed: _showInviteDialog,
            ),
            // Impostazioni matrice
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Impostazioni Matrice',
              onPressed: _showMatrixSettings,
            ),
            const SizedBox(width: 8),
            // Torna alla lista
            TextButton.icon(
              icon: Icon(Icons.arrow_back, size: 18, color: context.textPrimaryColor),
              label: Text('Lista', style: TextStyle(color: context.textPrimaryColor)),
              onPressed: () => setState(() {
                _selectedMatrix = null;
                _activities = [];
              }),
            ),
          ],
        ],
      ),
      body: _selectedMatrix == null ? _buildMatrixList() : _buildMatrixDetail(),
      floatingActionButton: _buildFAB(),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // LISTA MATRICI
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildMatrixList() {
    return StreamBuilder<List<EisenhowerMatrixModel>>(
      stream: _firestoreService.streamMatricesByUser(_currentUserEmail),
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
                Text('Errore: ${snapshot.error}', style: TextStyle(color: context.textPrimaryColor)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadData,
                  child: const Text('Riprova'),
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
                  const Icon(Icons.folder_open, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  Text(
                    'Le tue matrici (${filteredMatrices.length}/${matrices.length})',
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
                      const Text(
                        'Ricerca:',
                        style: TextStyle(fontSize: 12, color: AppColors.secondary),
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
                        child: const Text('Rimuovi filtro', style: TextStyle(fontSize: 12)),
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
                              'Nessuna matrice trovata',
                              style: TextStyle(color: context.textSecondaryColor),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => setState(() => _searchQuery = ''),
                              child: const Text('Rimuovi filtro'),
                            ),
                          ],
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          // Card compatte - molte per riga
                          final cardWidth = constraints.maxWidth > 1400
                              ? (constraints.maxWidth - 30) / 6 // 6 card
                              : constraints.maxWidth > 1100
                                  ? (constraints.maxWidth - 25) / 5 // 5 card
                                  : constraints.maxWidth > 800
                                      ? (constraints.maxWidth - 18) / 4 // 4 card
                                      : constraints.maxWidth > 550
                                          ? (constraints.maxWidth - 12) / 3 // 3 card
                                          : constraints.maxWidth > 350
                                              ? (constraints.maxWidth - 6) / 2 // 2 card
                                              : constraints.maxWidth; // 1 card

                          return SingleChildScrollView(
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: filteredMatrices.map((matrix) => SizedBox(
                                width: cardWidth,
                                child: _buildMatrixCard(matrix),
                              )).toList(),
                            ),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.grid_4x4, size: 80, color: context.textMutedColor),
          const SizedBox(height: 16),
          Text(
            'Nessuna matrice creata',
            style: TextStyle(
              fontSize: 18,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crea la tua prima Matrice di Eisenhower\nper organizzare le tue priorità',
            textAlign: TextAlign.center,
            style: TextStyle(color: context.textTertiaryColor),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showCreateMatrixDialog,
            icon: const Icon(Icons.add),
            label: const Text('Crea Matrice'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatrixCard(EisenhowerMatrixModel matrix) {
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
                    message: 'Matrice Eisenhower\nClicca per aprire',
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.grid_4x4, color: AppColors.secondary, size: 14),
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
                          color: context.textPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Menu compatto
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      iconSize: 16,
                      onSelected: (value) async {
                        switch (value) {
                          case 'edit':
                            _showEditMatrixDialog(matrix);
                            break;
                          case 'delete':
                            _confirmDeleteMatrix(matrix);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 16, color: context.textSecondaryColor),
                              const SizedBox(width: 8),
                              const Text('Modifica', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 16, color: AppColors.error),
                              SizedBox(width: 8),
                              Text('Elimina', style: TextStyle(fontSize: 13, color: AppColors.error)),
                            ],
                          ),
                        ),
                      ],
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
                    'Attività totali nella matrice',
                  ),
                  const SizedBox(width: 8),
                  _buildCompactMatrixStat(
                    Icons.people,
                    '${matrix.participants.length}',
                    'Partecipanti',
                  ),
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
            color: isSelected ? AppColors.primary : Colors.transparent,
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
                    onVoteTap: _showVoteDialog,
                    onDeleteTap: _confirmDeleteActivity,
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
              const Icon(Icons.format_list_numbered, color: AppColors.secondary),
              const SizedBox(width: 8),
              Text(
                'Lista Priorità',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${_activities.length} attività',
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
                          'Nessuna attività',
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
                      '${activity.voteCount} voti',
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
                  hasVotes ? (quadrant?.title ?? '-') : 'Da votare',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: hasVotes ? color : AppColors.warning,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Azioni
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: context.textTertiaryColor),
                onSelected: (value) {
                  switch (value) {
                    case 'vote':
                      _showVoteDialog(activity);
                      break;
                    case 'delete':
                      _confirmDeleteActivity(activity);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'vote',
                    child: Row(
                      children: [
                        Icon(Icons.how_to_vote, size: 18, color: AppColors.secondary),
                        const SizedBox(width: 8),
                        Text(hasVotes ? 'Modifica voti' : 'Vota'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 18, color: AppColors.error),
                        SizedBox(width: 8),
                        Text('Elimina', style: TextStyle(color: AppColors.error)),
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
                    'Partecipanti (${_selectedMatrix!.participants.length})',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit, size: 16, color: context.textSecondaryColor),
                    onPressed: _showMatrixSettings,
                    tooltip: 'Modifica partecipanti',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _selectedMatrix!.participants.values.map((p) {
                  return Chip(
                    label: Text(p.name, style: const TextStyle(fontSize: 11)),
                    avatar: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.secondary.withOpacity(0.2),
                      child: Text(
                        p.initial,
                        style: const TextStyle(fontSize: 10, color: AppColors.secondary),
                      ),
                    ),
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
              _buildStatBadge('Totali', _activities.length, context.textTertiaryColor),
              const SizedBox(width: 8),
              _buildStatBadge('Votate', votedCount, AppColors.success),
              const SizedBox(width: 8),
              _buildStatBadge('Da votare', unvotedActivities.length, AppColors.warning),
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
                    Icon(Icons.pending_actions, size: 16, color: AppColors.warning),
                    const SizedBox(width: 6),
                    Text(
                      'Da votare (${unvotedActivities.length})',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.warning,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...unvotedActivities.map((activity) {
                  return UnvotedActivityCard(
                    activity: activity,
                    onVoteTap: () => _showVoteDialog(activity),
                    onDeleteTap: () => _confirmDeleteActivity(activity),
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
                    'Tutte le attività (${_activities.length})',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: context.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ..._activities.map((activity) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ActivityCardWidget(
                    activity: activity,
                    onTap: () => _showActivityDetail(activity),
                    onVoteTap: () => _showVoteDialog(activity),
                    onDeleteTap: () => _confirmDeleteActivity(activity),
                    // Parametri per votazione indipendente
                    currentUserEmail: _currentUserEmail,
                    isFacilitator: _isFacilitator,
                    totalVoters: _selectedMatrix?.voterCount ?? 0,
                    onStartIndependentVoting: () => _startIndependentVoting(activity),
                    onSubmitIndependentVote: () => _submitIndependentVote(activity),
                    onRevealVotes: () => _revealVotes(activity),
                    onResetVoting: () => _resetVotingSession(activity),
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
    if (_selectedMatrix == null) {
      return FloatingActionButton.extended(
        onPressed: _showCreateMatrixDialog,
        icon: const Icon(Icons.add),
        label: const Text('Nuova Matrice'),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: _showAddActivityDialog,
        icon: const Icon(Icons.add_task),
        label: const Text('Aggiungi Attività'),
      );
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DIALOGS
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _showCreateMatrixDialog() async {
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
        _showSuccess('Matrice creata con successo');
      } catch (e) {
        _showError('Errore creazione matrice: $e');
      }
    }
  }

  Future<void> _showEditMatrixDialog(EisenhowerMatrixModel matrix) async {
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

        _showSuccess('Matrice aggiornata');
      } catch (e) {
        _showError('Errore aggiornamento: $e');
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
    if (_selectedMatrix == null) return;

    setState(() => _isExporting = true);

    try {
      final url = await _sheetsExportService.exportToGoogleSheets(
        matrix: _selectedMatrix!,
        activities: _activities,
      );

      if (url != null) {
        _showSuccess('Export completato!');

        // Chiedi se aprire il foglio
        if (mounted) {
          final shouldOpen = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Export Completato'),
              content: const Text('Il foglio Google Sheets è stato creato.\nVuoi aprirlo nel browser?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Apri'),
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
        _showError('Errore durante l\'export');
      }
    } catch (e) {
      _showError('Errore export: $e');
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
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
    if (_selectedMatrix == null) return;

    // Verifica che ci siano partecipanti votanti
    if (_selectedMatrix!.voterCount < 2) {
      _showError('Servono almeno 2 votanti per la votazione indipendente');
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Avvia Votazione Indipendente'),
        content: Text(
          'Vuoi avviare una sessione di voto indipendente per "${activity.title}"?\n\n'
          'Ogni partecipante votera\' senza vedere i voti degli altri, '
          'fino a quando tutti avranno votato e i voti verranno rivelati.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.how_to_vote),
            label: const Text('Avvia'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _firestoreService.startVotingSession(_selectedMatrix!.id, activity.id);
        await _loadActivities(_selectedMatrix!.id);
        _showSuccess('Votazione avviata');
      } catch (e) {
        _showError('Errore avvio votazione: $e');
      }
    }
  }

  /// Gestisce il voto dell'utente corrente in una sessione indipendente
  Future<void> _submitIndependentVote(EisenhowerActivityModel activity) async {
    if (_selectedMatrix == null || _currentUserEmail == null) return;

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

      // Ricarica e mostra il dialog con i risultati
      final updated = await _firestoreService.getActivity(_selectedMatrix!.id, activity.id);
      if (updated != null && mounted) {
        await VoteRevealDialog.show(
          context: context,
          activity: updated,
          participants: _selectedMatrix!.participants,
        );
      }

      await _loadActivities(_selectedMatrix!.id);
    } catch (e) {
      _showError('Errore reveal voti: $e');
    }
  }

  /// Resetta una sessione di votazione
  Future<void> _resetVotingSession(EisenhowerActivityModel activity) async {
    if (_selectedMatrix == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resettare Votazione?'),
        content: const Text('Tutti i voti verranno cancellati.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _firestoreService.resetVotingSession(_selectedMatrix!.id, activity.id);
        await _loadActivities(_selectedMatrix!.id);
        _showSuccess('Votazione resettata');
      } catch (e) {
        _showError('Errore reset: $e');
      }
    }
  }

  /// Verifica se l'utente corrente e' facilitatore della matrice
  bool get _isFacilitator {
    if (_selectedMatrix == null || _currentUserEmail == null) return false;
    return _selectedMatrix!.isFacilitator(_currentUserEmail!);
  }

  Future<void> _confirmDeleteMatrix(EisenhowerMatrixModel matrix) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina Matrice'),
        content: Text(
          'Sei sicuro di voler eliminare "${matrix.title}"?\n'
          'Verranno eliminate anche tutte le ${matrix.activityCount} attività.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Elimina'),
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
        _showSuccess('Matrice eliminata');
      } catch (e) {
        _showError('Errore eliminazione: $e');
      }
    }
  }

  Future<void> _showAddActivityDialog() async {
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
        _showSuccess('Attività aggiunta');
      } catch (e) {
        _showError('Errore aggiunta attività: $e');
      }
    }
  }

  Future<void> _showVoteDialog(EisenhowerActivityModel activity) async {
    if (_selectedMatrix == null || !_selectedMatrix!.hasParticipants) {
      _showError('Aggiungi prima dei partecipanti alla matrice');
      return;
    }

    // Usa i nomi dei partecipanti per il dialog di voto rapido
    final votes = await VoteCollectionDialog.show(
      context: context,
      activity: activity,
      participants: _selectedMatrix!.participantNames,
    );

    if (votes != null && _selectedMatrix != null) {
      try {
        await _firestoreService.saveVotes(
          matrixId: _selectedMatrix!.id,
          activityId: activity.id,
          votes: votes,
        );
        await _loadActivities(_selectedMatrix!.id);
        _showSuccess('Voti salvati');
      } catch (e) {
        _showError('Errore salvataggio voti: $e');
      }
    }
  }

  Future<void> _showActivityDetail(EisenhowerActivityModel activity) async {
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
              if (activity.hasVotes) ...[
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  'Quadrante: ${activity.quadrant?.name ?? "-"} - ${activity.quadrant?.title ?? "-"}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Urgenza media: ${activity.aggregatedUrgency.toStringAsFixed(1)}'),
                Text('Importanza media: ${activity.aggregatedImportance.toStringAsFixed(1)}'),
                const SizedBox(height: 12),
                const Text('Voti:', style: TextStyle(fontWeight: FontWeight.w600)),
                ...activity.votes.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '- ${e.key}: U=${e.value.urgency}, I=${e.value.importance}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }),
              ] else
                const Text('Nessun voto ancora raccolto'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Chiudi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showVoteDialog(activity);
            },
            child: Text(activity.hasVotes ? 'Modifica Voti' : 'Vota'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteActivity(EisenhowerActivityModel activity) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina Attività'),
        content: Text('Sei sicuro di voler eliminare "${activity.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Elimina'),
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
        _showSuccess('Attività eliminata');
      } catch (e) {
        _showError('Errore eliminazione: $e');
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
    final isEdit = widget.matrix != null;

    return AlertDialog(
      title: Text(isEdit ? 'Modifica Matrice' : 'Nuova Matrice'),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titolo *',
                  hintText: 'Es: Priorità Q1 2025',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrizione',
                  hintText: 'Descrizione opzionale',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              Text(
                'Partecipanti',
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
                      decoration: const InputDecoration(
                        hintText: 'Nome partecipante',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onSubmitted: (_) => _addParticipant(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppColors.secondary),
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
                    'Aggiungi almeno un partecipante per poter votare',
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
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Inserisci un titolo')),
              );
              return;
            }
            Navigator.pop(context, {
              'title': _titleController.text.trim(),
              'description': _descriptionController.text.trim(),
              'participants': _participants,
            });
          },
          child: Text(isEdit ? 'Salva' : 'Crea'),
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
    return AlertDialog(
      title: const Text('Nuova Attività'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titolo *',
                hintText: 'Es: Completare documentazione API',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrizione',
                hintText: 'Descrizione opzionale',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Inserisci un titolo')),
              );
              return;
            }
            Navigator.pop(context, {
              'title': _titleController.text.trim(),
              'description': _descriptionController.text.trim(),
            });
          },
          child: const Text('Aggiungi'),
        ),
      ],
    );
  }
}
