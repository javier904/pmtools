import 'package:flutter/material.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../models/agile_project_model.dart';
import '../../models/sprint_model.dart';
import '../../models/agile_enums.dart';
import '../../l10n/app_localizations.dart';
import '../agile/agile_project_form_dialog.dart';

/// Data returned from the Eisenhower export to sprint dialog
class ExportEisenhowerToSprintResult {
  final List<EisenhowerActivityModel> selectedActivities;
  final AgileProjectModel? existingProject;
  final SprintModel? sprint;
  final AgileProjectFormResult? newProjectConfig;

  const ExportEisenhowerToSprintResult({
    required this.selectedActivities,
    this.existingProject,
    this.sprint,
    this.newProjectConfig,
  });

  bool get createNewProject => newProjectConfig != null;
}

/// Maps Eisenhower quadrant to Agile priority
StoryPriority priorityFromQuadrant(EisenhowerQuadrant? quadrant) {
  switch (quadrant) {
    case EisenhowerQuadrant.q1:
      return StoryPriority.must; // DO → Must Have
    case EisenhowerQuadrant.q2:
      return StoryPriority.should; // SCHEDULE → Should Have
    case EisenhowerQuadrant.q3:
      return StoryPriority.could; // DELEGATE → Could Have
    case EisenhowerQuadrant.q4:
    case null:
      return StoryPriority.wont; // DELETE → Won't Have
  }
}

/// Maps urgency score (1-10) to business value (1-10)
int businessValueFromActivity(EisenhowerActivityModel activity) {
  // Use importance as business value
  return activity.aggregatedImportance.round().clamp(1, 10);
}

/// Dialog for exporting Eisenhower activities to an Agile Sprint
class ExportEisenhowerToSprintDialog extends StatefulWidget {
  final List<EisenhowerActivityModel> activities;
  final EisenhowerMatrixModel matrix;
  final List<AgileProjectModel> availableProjects;
  final Future<List<SprintModel>> Function(String projectId) getProjectSprints;

  const ExportEisenhowerToSprintDialog({
    super.key,
    required this.activities,
    required this.matrix,
    required this.availableProjects,
    required this.getProjectSprints,
  });

  @override
  State<ExportEisenhowerToSprintDialog> createState() => _ExportEisenhowerToSprintDialogState();
}

class _ExportEisenhowerToSprintDialogState extends State<ExportEisenhowerToSprintDialog> {
  final Set<String> _selectedActivityIds = {};
  AgileProjectModel? _selectedProject;
  SprintModel? _selectedSprint;
  List<SprintModel> _availableSprints = [];
  bool _loadingSprints = false;
  bool _createNewProject = false;
  AgileProjectFormResult? _newProjectConfig;
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
    _createNewProject = widget.availableProjects.isEmpty;

    // If matrix has a linked project, pre-select it
    if (widget.matrix.projectId != null) {
      final linkedProject = widget.availableProjects
          .where((p) => p.id == widget.matrix.projectId)
          .firstOrNull;
      if (linkedProject != null) {
        _selectedProject = linkedProject;
        _onProjectChanged(linkedProject);
      }
    }
  }

  Future<void> _onProjectChanged(AgileProjectModel? project) async {
    setState(() {
      _selectedProject = project;
      _selectedSprint = null;
      _availableSprints = [];
    });

  }

  void _openProjectFormDialog() async {
    final result = await showDialog<AgileProjectFormResult>(
      context: context,
      builder: (context) => const AgileProjectFormDialog(),
    );
    if (result != null && mounted) {
      setState(() {
        _newProjectConfig = result;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

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
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.grid_view, color: Colors.blue, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n?.exportToSprint ?? 'Esporta verso Sprint',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n?.exportEisenhowerToSprintDesc ?? 'Trasforma le attività Eisenhower in User Stories',
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

            // Destination selection
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: _buildDestinationSection(l10n, isDark, theme),
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
                        style: const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF)),
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
                          subtitle: activity.description.isNotEmpty
                              ? Text(
                                  activity.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                                  ),
                                )
                              : null,
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
                        child: Text(l10n?.selectAll ?? 'Seleziona tutti', style: const TextStyle(color: Color(0xFFFFFFFF))),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _selectedActivityIds.clear());
                        },
                        child: Text(l10n?.deselectAll ?? 'Deseleziona tutti', style: const TextStyle(color: Color(0xFFFFFFFF))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Mapping info
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
                            l10n?.eisenhowerMappingInfo ?? 'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Importanza→Business Value.',
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
                        icon: const Icon(Icons.rocket_launch),
                        label: Text(l10n?.actionExport ?? 'Esporta'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
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

  Widget _buildDestinationSection(AppLocalizations? l10n, bool isDark, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Toggle buttons
        Row(
          children: [
            _buildDestinationOption(
              l10n?.existingProject ?? 'Progetto esistente',
              Icons.folder_open,
              !_createNewProject,
              () => setState(() {
                _createNewProject = false;
                _newProjectConfig = null;
              }),
              isDark,
            ),
            const SizedBox(width: 12),
            _buildDestinationOption(
              l10n?.createNewProject ?? 'Crea nuovo progetto',
              Icons.add_circle_outline,
              _createNewProject,
              () => setState(() => _createNewProject = true),
              isDark,
            ),
          ],
        ),
        const SizedBox(height: 16),

        if (_createNewProject) ...[
          _buildNewProjectSection(l10n, isDark, theme),
        ] else ...[
          // Project dropdown
          DropdownButtonFormField<AgileProjectModel>(
            value: _selectedProject,
            decoration: InputDecoration(
              labelText: l10n?.selectProject ?? 'Seleziona progetto',
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            items: widget.availableProjects.map((project) {
              return DropdownMenuItem(
                value: project,
                child: Text(project.name, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: _onProjectChanged,
          ),
          const SizedBox(height: 12),


        ],
      ],
    );
  }

  Widget _buildDestinationOption(
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
    bool isDark,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.withOpacity(0.1)
                : (isDark ? Colors.grey[800] : Colors.grey[100]),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.blue : Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.blue : (isDark ? Colors.grey[300] : Colors.grey[700]),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewProjectSection(AppLocalizations? l10n, bool isDark, ThemeData theme) {
    if (_newProjectConfig != null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _newProjectConfig!.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildConfigChip(_newProjectConfig!.framework.displayName, Colors.blue),
                      _buildConfigChip('${_newProjectConfig!.sprintDurationDays}d', Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 18),
              onPressed: _openProjectFormDialog,
              tooltip: l10n?.actionEdit ?? 'Modifica',
            ),
          ],
        ),
      );
    }

    return OutlinedButton.icon(
      onPressed: _openProjectFormDialog,
      icon: const Icon(Icons.add),
      label: Text(l10n?.configureNewProject ?? 'Configura nuovo progetto'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        side: BorderSide(color: Colors.blue.withOpacity(0.5)),
      ),
    );
  }

  Widget _buildConfigChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
      ),
    );
  }

  bool get _canExport {
    if (_selectedActivityIds.isEmpty) return false;
    if (_createNewProject) {
      return _newProjectConfig != null;
    }
    return _selectedProject != null;
  }

  void _onExport() {
    final selectedActivities = _votedActivities
        .where((a) => _selectedActivityIds.contains(a.id))
        .toList();

    Navigator.pop(
      context,
      ExportEisenhowerToSprintResult(
        selectedActivities: selectedActivities,
        existingProject: _createNewProject ? null : _selectedProject,
        sprint: _createNewProject ? null : _selectedSprint,
        newProjectConfig: _createNewProject ? _newProjectConfig : null,
      ),
    );
  }
}
