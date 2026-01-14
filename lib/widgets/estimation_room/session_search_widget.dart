import 'package:flutter/material.dart';
import '../../models/planning_poker_session_model.dart';
import '../../models/estimation_mode.dart';

/// Widget per cercare e filtrare le sessioni di Planning Poker
class SessionSearchWidget extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final PlanningPokerSessionStatus? statusFilter;
  final ValueChanged<PlanningPokerSessionStatus?> onStatusFilterChanged;
  final EstimationMode? modeFilter;
  final ValueChanged<EstimationMode?> onModeFilterChanged;
  final bool showModeFilter;

  const SessionSearchWidget({
    super.key,
    required this.onSearchChanged,
    this.statusFilter,
    required this.onStatusFilterChanged,
    this.modeFilter,
    required this.onModeFilterChanged,
    this.showModeFilter = true,
  });

  @override
  State<SessionSearchWidget> createState() => _SessionSearchWidgetState();
}

class _SessionSearchWidgetState extends State<SessionSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cerca sessioni...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            widget.onSearchChanged('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onChanged: widget.onSearchChanged,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                setState(() => _showFilters = !_showFilters);
              },
              icon: Badge(
                isLabelVisible: widget.statusFilter != null || widget.modeFilter != null,
                child: Icon(
                  Icons.filter_list,
                  color: _showFilters ? Theme.of(context).primaryColor : null,
                ),
              ),
              tooltip: 'Filtri',
            ),
          ],
        ),

        // Filters
        if (_showFilters) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtri',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Status filter
                Row(
                  children: [
                    const Text('Stato: '),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        children: [
                          _buildStatusChip(null, 'Tutti'),
                          _buildStatusChip(PlanningPokerSessionStatus.draft, 'Bozza'),
                          _buildStatusChip(PlanningPokerSessionStatus.active, 'Attiva'),
                          _buildStatusChip(PlanningPokerSessionStatus.completed, 'Completata'),
                        ],
                      ),
                    ),
                  ],
                ),

                // Mode filter
                if (widget.showModeFilter) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('Modalita\': '),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildModeChip(null, 'Tutte'),
                            ...EstimationMode.values.map((mode) {
                              return _buildModeChip(mode, mode.displayName);
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],

                // Clear filters button
                if (widget.statusFilter != null || widget.modeFilter != null) ...[
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        widget.onStatusFilterChanged(null);
                        widget.onModeFilterChanged(null);
                      },
                      icon: const Icon(Icons.clear_all, size: 18),
                      label: const Text('Rimuovi filtri'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatusChip(PlanningPokerSessionStatus? status, String label) {
    final isSelected = widget.statusFilter == status;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        widget.onStatusFilterChanged(selected ? status : null);
      },
    );
  }

  Widget _buildModeChip(EstimationMode? mode, String label) {
    final isSelected = widget.modeFilter == mode;
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: isSelected,
      onSelected: (selected) {
        widget.onModeFilterChanged(selected ? mode : null);
      },
      visualDensity: VisualDensity.compact,
    );
  }
}

/// Extension per filtrare le sessioni
extension SessionListFiltering on List<PlanningPokerSessionModel> {
  /// Filtra le sessioni per testo di ricerca
  List<PlanningPokerSessionModel> searchByText(String query) {
    if (query.isEmpty) return this;
    final lowerQuery = query.toLowerCase();
    return where((session) {
      return session.name.toLowerCase().contains(lowerQuery) ||
          session.description.toLowerCase().contains(lowerQuery) ||
          (session.projectName?.toLowerCase().contains(lowerQuery) ?? false) ||
          (session.projectCode?.toLowerCase().contains(lowerQuery) ?? false) ||
          (session.teamName?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  /// Filtra le sessioni per stato
  List<PlanningPokerSessionModel> filterByStatus(PlanningPokerSessionStatus? status) {
    if (status == null) return this;
    return where((session) => session.status == status).toList();
  }

  /// Filtra le sessioni per modalita' di stima
  List<PlanningPokerSessionModel> filterByMode(EstimationMode? mode) {
    if (mode == null) return this;
    return where((session) => session.estimationMode == mode).toList();
  }

  /// Applica tutti i filtri
  List<PlanningPokerSessionModel> applyFilters({
    String? searchQuery,
    PlanningPokerSessionStatus? statusFilter,
    EstimationMode? modeFilter,
  }) {
    var result = this;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      result = result.searchByText(searchQuery);
    }
    if (statusFilter != null) {
      result = result.filterByStatus(statusFilter);
    }
    if (modeFilter != null) {
      result = result.filterByMode(modeFilter);
    }
    return result;
  }
}

/// Widget compatto per mostrare i filtri attivi
class ActiveFiltersBar extends StatelessWidget {
  final String? searchQuery;
  final PlanningPokerSessionStatus? statusFilter;
  final EstimationMode? modeFilter;
  final VoidCallback onClearSearch;
  final VoidCallback onClearStatus;
  final VoidCallback onClearMode;
  final VoidCallback onClearAll;

  const ActiveFiltersBar({
    super.key,
    this.searchQuery,
    this.statusFilter,
    this.modeFilter,
    required this.onClearSearch,
    required this.onClearStatus,
    required this.onClearMode,
    required this.onClearAll,
  });

  bool get hasFilters =>
      (searchQuery != null && searchQuery!.isNotEmpty) ||
      statusFilter != null ||
      modeFilter != null;

  @override
  Widget build(BuildContext context) {
    if (!hasFilters) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_alt, size: 16, color: Colors.blue),
          const SizedBox(width: 8),
          const Text(
            'Filtri attivi:',
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (searchQuery != null && searchQuery!.isNotEmpty)
                  _buildFilterChip(
                    '"$searchQuery"',
                    onClearSearch,
                  ),
                if (statusFilter != null)
                  _buildFilterChip(
                    statusFilter!.displayName,
                    onClearStatus,
                  ),
                if (modeFilter != null)
                  _buildFilterChip(
                    modeFilter!.displayName,
                    onClearMode,
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: onClearAll,
            child: const Text('Rimuovi tutti', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 11)),
      deleteIcon: const Icon(Icons.close, size: 14),
      onDeleted: onRemove,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
