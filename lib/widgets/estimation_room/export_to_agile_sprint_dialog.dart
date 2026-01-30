import 'package:flutter/material.dart';
import '../../models/planning_poker_story_model.dart';
import '../../models/agile_project_model.dart';
import '../../models/sprint_model.dart';
import '../../models/agile_enums.dart';
import '../../l10n/app_localizations.dart';
import '../agile/agile_project_form_dialog.dart';

/// Data returned from the export to sprint dialog
class ExportToAgileSprintResult {
  final List<PlanningPokerStoryModel> selectedStories;
  final AgileProjectModel? existingProject;
  final SprintModel? sprint;
  final AgileProjectFormResult? newProjectConfig;

  const ExportToAgileSprintResult({
    required this.selectedStories,
    this.existingProject,
    this.sprint,
    this.newProjectConfig,
  });

  bool get createNewProject => newProjectConfig != null;
}

/// Dialog for selecting stories to export to an Agile Sprint
class ExportToAgileSprintDialog extends StatefulWidget {
  final List<PlanningPokerStoryModel> stories;
  final List<AgileProjectModel> availableProjects;
  final String sessionName;
  final Future<List<SprintModel>> Function(String projectId) getProjectSprints;

  const ExportToAgileSprintDialog({
    super.key,
    required this.stories,
    required this.availableProjects,
    required this.sessionName,
    required this.getProjectSprints,
  });

  @override
  State<ExportToAgileSprintDialog> createState() => _ExportToAgileSprintDialogState();
}

class _ExportToAgileSprintDialogState extends State<ExportToAgileSprintDialog> {
  final Set<String> _selectedStoryIds = {};
  AgileProjectModel? _selectedProject;
  SprintModel? _selectedSprint;
  List<SprintModel> _availableSprints = [];
  bool _loadingSprints = false;
  bool _createNewProject = false;
  AgileProjectFormResult? _newProjectConfig;

  List<PlanningPokerStoryModel> get _estimatedStories =>
      widget.stories.where((s) => s.finalEstimate != null).toList();

  /// Calculates total story points from selected stories
  int get _selectedTotalPoints {
    int total = 0;
    for (final story in _estimatedStories) {
      if (_selectedStoryIds.contains(story.id)) {
        total += _convertEstimateToPoints(story.finalEstimate);
      }
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    // Pre-select all estimated stories
    for (final story in _estimatedStories) {
      _selectedStoryIds.add(story.id);
    }
    _createNewProject = widget.availableProjects.isEmpty;
  }

  /// Converts estimate string to story points
  int _convertEstimateToPoints(String? estimate) {
    if (estimate == null) return 0;

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

  Future<void> _onProjectChanged(AgileProjectModel? project) async {
    setState(() {
      _selectedProject = project;
      _selectedSprint = null;
      _availableSprints = [];
    });

    if (project != null) {
      setState(() => _loadingSprints = true);
      try {
        final sprints = await widget.getProjectSprints(project.id);
        if (mounted) {
          setState(() {
            // Filter to sprints that can accept stories (planning or active)
            _availableSprints = sprints.where((s) =>
              s.status == SprintStatus.planning ||
              s.status == SprintStatus.active
            ).toList();
            _loadingSprints = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() => _loadingSprints = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 550,
        constraints: const BoxConstraints(maxHeight: 700),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.rocket_launch_rounded, color: Colors.purple),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.exportToAgileSprint,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.exportToAgileSprintDesc,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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

            // Destination selection (Project + Sprint)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project selector header
                  Row(
                    children: [
                      Icon(Icons.folder_special, size: 20, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        l10n.selectDestinationProject,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Toggle: existing or new project
                  Row(
                    children: [
                      Expanded(
                        child: _buildDestinationOption(
                          icon: Icons.folder_open,
                          label: l10n.existingProject,
                          isSelected: !_createNewProject,
                          onTap: () => setState(() {
                            _createNewProject = false;
                            _newProjectConfig = null;
                          }),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDestinationOption(
                          icon: Icons.create_new_folder,
                          label: l10n.createNewProject,
                          isSelected: _createNewProject,
                          onTap: () => setState(() {
                            _createNewProject = true;
                            _selectedProject = null;
                            _selectedSprint = null;
                            _availableSprints = [];
                          }),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Project dropdown or New Project Configuration
                  if (_createNewProject)
                    _buildNewProjectSection(l10n, isDark)
                  else if (widget.availableProjects.isNotEmpty)
                    DropdownButtonFormField<AgileProjectModel>(
                      value: _selectedProject,
                      decoration: InputDecoration(
                        labelText: l10n.selectProject,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.folder_special),
                      ),
                      hint: Text(l10n.selectProjectHint),
                      items: widget.availableProjects.map((project) {
                        return DropdownMenuItem(
                          value: project,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                project.framework.icon,
                                size: 16,
                                color: _getFrameworkColor(project.framework),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  project.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: _onProjectChanged,
                    )
                  else
                    _buildNoProjectsMessage(l10n, isDark),

                  // Sprint selector (shown after project selection, only for existing projects)
                  if (!_createNewProject && _selectedProject != null) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.directions_run, size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          l10n.selectSprint,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (_loadingSprints)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_availableSprints.isEmpty)
                      _buildNoSprintsMessage(l10n, isDark)
                    else
                      DropdownButtonFormField<SprintModel>(
                        value: _selectedSprint,
                        decoration: InputDecoration(
                          labelText: l10n.selectSprint,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.directions_run),
                        ),
                        hint: Text(l10n.selectSprintHint),
                        items: _availableSprints.map((sprint) {
                          return DropdownMenuItem(
                            value: sprint,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildSprintStatusBadge(sprint.status),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    sprint.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '(${sprint.plannedPoints} pts)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedSprint = value),
                      ),

                    // Sprint info card
                    if (_selectedSprint != null)
                      _buildSprintInfoCard(_selectedSprint!, isDark),
                  ],
                ],
              ),
            ),

            const Divider(height: 24),

            // Points summary
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.storiesSelectedCount(_selectedStoryIds.length),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: _selectedStoryIds.isEmpty ? Colors.red : Colors.purple,
                        ),
                      ),
                      Text(
                        l10n.totalStoryPoints(_selectedTotalPoints),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            for (final story in _estimatedStories) {
                              _selectedStoryIds.add(story.id);
                            }
                          });
                        },
                        child: Text(l10n.selectAll),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedStoryIds.clear();
                          });
                        },
                        child: Text(l10n.deselectAll),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Story list
            Flexible(
              child: _estimatedStories.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.hourglass_empty, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              l10n.noEstimatedStories,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: _estimatedStories.length,
                      itemBuilder: (context, index) {
                        final story = _estimatedStories[index];
                        final isSelected = _selectedStoryIds.contains(story.id);
                        final storyPoints = _convertEstimateToPoints(story.finalEstimate);

                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selectedStoryIds.add(story.id);
                              } else {
                                _selectedStoryIds.remove(story.id);
                              }
                            });
                          },
                          title: Text(
                            story.title,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: story.description.isNotEmpty
                              ? Text(
                                  story.description,
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : null,
                          secondary: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  story.finalEstimate ?? '-',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '($storyPoints pts)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.purple[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          dense: true,
                        );
                      },
                    ),
            ),

            // Field mapping info
            Container(
              margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.purple[400]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.sprintExportFieldMappingInfo,
                      style: TextStyle(fontSize: 11, color: Colors.purple[700]),
                    ),
                  ),
                ],
              ),
            ),

            // Actions
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.actionCancel),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _canExport() ? _export : null,
                    icon: const Icon(Icons.rocket_launch_rounded, size: 18),
                    label: Text(l10n.actionSend),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationOption({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.purple.withOpacity(0.1)
              : (isDark ? const Color(0xFF2D3748) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.purple : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.purple : (isDark ? Colors.white70 : Colors.black87),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewProjectSection(AppLocalizations l10n, bool isDark) {
    if (_newProjectConfig != null) {
      // Show configured project summary
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.purple.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.folder, color: Colors.purple[700], size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _newProjectConfig!.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[700],
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: _openProjectFormDialog,
                  tooltip: l10n.actionEdit,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  color: Colors.purple[700],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _buildConfigChip(
                  icon: _newProjectConfig!.framework.icon,
                  label: _newProjectConfig!.framework.displayName,
                ),
                _buildConfigChip(
                  icon: Icons.calendar_today,
                  label: '${_newProjectConfig!.sprintDurationDays}gg sprint',
                ),
                _buildConfigChip(
                  icon: Icons.access_time,
                  label: '${_newProjectConfig!.workingHoursPerDay}h/giorno',
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Show button to configure new project
    return InkWell(
      onTap: _openProjectFormDialog,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D3748) : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.purple.withOpacity(0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: Colors.purple[400]),
            const SizedBox(width: 12),
            Text(
              l10n.configureNewProject,
              style: TextStyle(
                color: Colors.purple[400],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.purple[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.purple[700]),
          ),
        ],
      ),
    );
  }

  Future<void> _openProjectFormDialog() async {
    final result = await AgileProjectFormDialog.show(
      context,
      suggestedName: widget.sessionName,
    );

    if (result != null) {
      setState(() {
        _newProjectConfig = result;
      });
    }
  }

  Widget _buildNoProjectsMessage(AppLocalizations l10n, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.noProjectsAvailable,
              style: TextStyle(color: Colors.orange[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoSprintsMessage(AppLocalizations l10n, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.noSprintsAvailable,
              style: TextStyle(color: Colors.orange[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSprintInfoCard(SprintModel sprint, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D3748) : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sprint.goal.isNotEmpty ? sprint.goal : 'Sprint ${sprint.number}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${_formatDate(sprint.startDate)} - ${_formatDate(sprint.endDate)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _buildSprintMetric(
            label: 'Stories',
            value: '${sprint.storyIds.length}',
            color: Colors.blue,
          ),
          const SizedBox(width: 12),
          _buildSprintMetric(
            label: 'Points',
            value: '${sprint.plannedPoints}',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildSprintMetric({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
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
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSprintStatusBadge(SprintStatus status) {
    Color color;
    IconData icon;
    switch (status) {
      case SprintStatus.planning:
        color = Colors.blue;
        icon = Icons.edit_calendar;
        break;
      case SprintStatus.active:
        color = Colors.green;
        icon = Icons.play_circle;
        break;
      case SprintStatus.review:
        color = Colors.orange;
        icon = Icons.rate_review;
        break;
      case SprintStatus.completed:
        color = Colors.grey;
        icon = Icons.check_circle;
        break;
    }
    return Icon(icon, size: 16, color: color);
  }

  Color _getFrameworkColor(AgileFramework framework) {
    switch (framework) {
      case AgileFramework.scrum:
        return Colors.blue;
      case AgileFramework.kanban:
        return Colors.teal;
      case AgileFramework.hybrid:
        return Colors.purple;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
  }

  bool _canExport() {
    if (_selectedStoryIds.isEmpty) return false;
    if (_createNewProject) {
      return _newProjectConfig != null;
    } else {
      return _selectedProject != null;
    }
  }

  void _export() {
    final selectedStories = _estimatedStories
        .where((s) => _selectedStoryIds.contains(s.id))
        .toList();

    // Wrap pop in microtask to avoid MouseTracker crash on Web
    Future.microtask(() {
      if (mounted) {
        Navigator.pop(
          context,
          ExportToAgileSprintResult(
            selectedStories: selectedStories,
            existingProject: _createNewProject ? null : _selectedProject,
            sprint: _createNewProject ? null : _selectedSprint,
            newProjectConfig: _createNewProject ? _newProjectConfig : null,
          ),
        );
      }
    });
  }
}
