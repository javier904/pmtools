import 'package:flutter/material.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../models/estimation_mode.dart';
import '../../l10n/app_localizations.dart';

/// Data returned from the Eisenhower export to estimation dialog
class ExportEisenhowerToEstimationResult {
  final List<EisenhowerActivityModel> selectedActivities;
  final String sessionName;
  final String? sessionDescription;
  final EstimationMode estimationMode;

  const ExportEisenhowerToEstimationResult({
    required this.selectedActivities,
    required this.sessionName,
    this.sessionDescription,
    required this.estimationMode,
  });
}

/// Dialog for exporting Eisenhower activities to a new Estimation Room session
class ExportEisenhowerToEstimationDialog extends StatefulWidget {
  final List<EisenhowerActivityModel> activities;
  final EisenhowerMatrixModel matrix;

  const ExportEisenhowerToEstimationDialog({
    super.key,
    required this.activities,
    required this.matrix,
  });

  @override
  State<ExportEisenhowerToEstimationDialog> createState() => _ExportEisenhowerToEstimationDialogState();
}

class _ExportEisenhowerToEstimationDialogState extends State<ExportEisenhowerToEstimationDialog> {
  final Set<String> _selectedActivityIds = {};
  final _sessionNameController = TextEditingController();
  final _sessionDescController = TextEditingController();
  EstimationMode _estimationMode = EstimationMode.fibonacci;
  bool _showQ4 = false; // Q4 hidden by default

  /// Activities with votes (can be exported)
  List<EisenhowerActivityModel> get _votedActivities =>
      widget.activities.where((a) => a.hasVotes).toList();

  /// Displayed activities based on Q4 filter
  List<EisenhowerActivityModel> get _displayedActivities {
    if (_showQ4) {
      return _votedActivities;
    }
    return _votedActivities.where((a) => a.quadrant != EisenhowerQuadrant.q4).toList();
  }

  /// Count of Q4 activities (hidden)
  int get _hiddenQ4Count =>
      _votedActivities.where((a) => a.quadrant == EisenhowerQuadrant.q4).length;

  @override
  void initState() {
    super.initState();
    // Pre-select Q1 and Q2 activities (important work)
    for (final activity in _votedActivities) {
      if (activity.quadrant == EisenhowerQuadrant.q1 ||
          activity.quadrant == EisenhowerQuadrant.q2) {
        _selectedActivityIds.add(activity.id);
      }
    }

    // Suggest session name based on matrix name
    final matrixTitle = widget.matrix.title;
    _sessionNameController.text = matrixTitle.contains('Matrice')
        ? matrixTitle.replaceAll('Matrice', 'Stima')
        : '$matrixTitle - Stima';
  }

  @override
  void dispose() {
    _sessionNameController.dispose();
    _sessionDescController.dispose();
    super.dispose();
  }

  Color _getQuadrantColor(EisenhowerQuadrant? quadrant) {
    if (quadrant == null) return Colors.grey;
    return Color(quadrant.colorValue);
  }

  IconData _getQuadrantIcon(EisenhowerQuadrant? quadrant) {
    switch (quadrant) {
      case EisenhowerQuadrant.q1:
        return Icons.priority_high;
      case EisenhowerQuadrant.q2:
        return Icons.schedule;
      case EisenhowerQuadrant.q3:
        return Icons.person_add;
      case EisenhowerQuadrant.q4:
        return Icons.delete_outline;
      case null:
        return Icons.help_outline;
    }
  }

  String _getEstimationModeLabel(EstimationMode mode, AppLocalizations? l10n) {
    switch (mode) {
      case EstimationMode.fibonacci:
        return l10n?.estimationModeFibonacci ?? 'Fibonacci';
      case EstimationMode.tshirt:
        return l10n?.estimationModeTshirt ?? 'T-Shirt';
      case EstimationMode.decimal:
        return l10n?.estimationModeDecimal ?? 'Decimale';
      case EstimationMode.threePoint:
        return l10n?.estimationModeThreePoint ?? 'PERT';
      case EstimationMode.dotVoting:
        return l10n?.estimationModeDotVoting ?? 'Dot Voting';
      case EstimationMode.bucketSystem:
        return l10n?.estimationModeBucketSystem ?? 'Bucket';
      case EstimationMode.fiveFingers:
        return l10n?.estimationModeFiveFingers ?? 'Five Fingers';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 550,
        constraints: const BoxConstraints(maxHeight: 750),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E2633) : Colors.grey[50],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.casino, color: Colors.purple, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n?.exportToEstimation ?? 'Esporta verso Stima',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n?.exportEisenhowerToEstimationDesc ?? 'Crea una sessione di stima dalle attività',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Session configuration
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Session name
                  TextField(
                    controller: _sessionNameController,
                    decoration: InputDecoration(
                      labelText: l10n?.sessionName ?? 'Nome sessione',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Estimation mode
                  DropdownButtonFormField<EstimationMode>(
                    value: _estimationMode,
                    decoration: InputDecoration(
                      labelText: l10n?.estimationType ?? 'Tipo di stima',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: EstimationMode.values.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(_getEstimationModeLabel(mode, l10n)),
                      );
                    }).toList(),
                    onChanged: (mode) {
                      if (mode != null) {
                        setState(() => _estimationMode = mode);
                      }
                    },
                  ),
                ],
              ),
            ),

            // Q4 Filter toggle
            if (_hiddenQ4Count > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _showQ4
                            ? '${l10n?.showingAllActivities ?? 'Mostrando tutte le attività'}'
                            : '${l10n?.hiddenQ4Activities ?? 'Nascoste'} $_hiddenQ4Count ${l10n?.q4Activities ?? 'attività Q4 (Elimina)'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => setState(() => _showQ4 = !_showQ4),
                      icon: Icon(
                        _showQ4 ? Icons.visibility_off : Icons.visibility,
                        size: 16,
                      ),
                      label: Text(
                        _showQ4
                            ? (l10n?.hideQ4 ?? 'Nascondi Q4')
                            : (l10n?.showQ4 ?? 'Mostra Q4'),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

            const Divider(height: 1),

            // Activities list
            Flexible(
              child: _displayedActivities.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 12),
                          Text(
                            l10n?.noActivitiesToExport ?? 'Nessuna attività da esportare',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _displayedActivities.length,
                      itemBuilder: (context, index) {
                        final activity = _displayedActivities[index];
                        final isSelected = _selectedActivityIds.contains(activity.id);
                        final quadrantColor = _getQuadrantColor(activity.quadrant);

                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selectedActivityIds.add(activity.id);
                              } else {
                                _selectedActivityIds.remove(activity.id);
                              }
                            });
                          },
                          title: Text(
                            activity.title,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Row(
                            children: [
                              // Urgency score
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'U: ${activity.aggregatedUrgency.toStringAsFixed(1)}',
                                  style: const TextStyle(fontSize: 10, color: Colors.red),
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Importance score
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'I: ${activity.aggregatedImportance.toStringAsFixed(1)}',
                                  style: const TextStyle(fontSize: 10, color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                          secondary: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: quadrantColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: quadrantColor.withOpacity(0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getQuadrantIcon(activity.quadrant),
                                  size: 14,
                                  color: quadrantColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  activity.quadrant?.name ?? '?',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: quadrantColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          dense: true,
                        );
                      },
                    ),
            ),

            // Summary & Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E2633) : Colors.grey[50],
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Selection summary
                  Row(
                    children: [
                      Text(
                        '${_selectedActivityIds.length} ${l10n?.selectedActivities ?? 'attività selezionate'}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedActivityIds.clear();
                            for (final a in _displayedActivities) {
                              _selectedActivityIds.add(a.id);
                            }
                          });
                        },
                        child: Text(l10n?.selectAll ?? 'Seleziona tutti'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _selectedActivityIds.clear());
                        },
                        child: Text(l10n?.deselectAll ?? 'Deseleziona tutti'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.purple.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, size: 16, color: Colors.purple),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n?.estimationExportInfo ?? 'Le attività verranno aggiunte come storie da stimare. La priorità Q non verrà trasferita.',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.purple[200] : Colors.purple[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(l10n?.actionCancel ?? 'Annulla'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: _canExport ? _onExport : null,
                        icon: const Icon(Icons.casino),
                        label: Text(l10n?.createSession ?? 'Crea Sessione'),
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
          ],
        ),
      ),
    );
  }

  bool get _canExport {
    return _selectedActivityIds.isNotEmpty &&
           _sessionNameController.text.trim().isNotEmpty;
  }

  void _onExport() {
    final selectedActivities = _votedActivities
        .where((a) => _selectedActivityIds.contains(a.id))
        .toList();

    // Sort by urgency+importance (highest first)
    selectedActivities.sort((a, b) {
      final aScore = (a.aggregatedUrgency + a.aggregatedImportance) / 2;
      final bScore = (b.aggregatedUrgency + b.aggregatedImportance) / 2;
      return bScore.compareTo(aScore);
    });

    Navigator.pop(
      context,
      ExportEisenhowerToEstimationResult(
        selectedActivities: selectedActivities,
        sessionName: _sessionNameController.text.trim(),
        sessionDescription: _sessionDescController.text.trim().isNotEmpty
            ? _sessionDescController.text.trim()
            : null,
        estimationMode: _estimationMode,
      ),
    );
  }
}
