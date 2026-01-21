import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../models/agile_project_model.dart';
import '../../l10n/app_localizations.dart';
import '../agile/agile_project_form_dialog.dart';

/// Data returned from the export dialog
class ExportToUserStoriesResult {
  final List<TodoTaskModel> selectedTasks;
  final AgileProjectModel? existingProject;
  final AgileProjectFormResult? newProjectConfig;

  const ExportToUserStoriesResult({
    required this.selectedTasks,
    this.existingProject,
    this.newProjectConfig,
  });

  bool get createNewProject => newProjectConfig != null;
}

/// Dialog for selecting tasks to export to User Stories
class ExportToUserStoriesDialog extends StatefulWidget {
  final TodoListModel list;
  final List<TodoTaskModel> tasks;
  final List<AgileProjectModel> availableProjects;

  const ExportToUserStoriesDialog({
    super.key,
    required this.list,
    required this.tasks,
    required this.availableProjects,
  });

  @override
  State<ExportToUserStoriesDialog> createState() => _ExportToUserStoriesDialogState();
}

class _ExportToUserStoriesDialogState extends State<ExportToUserStoriesDialog> {
  final Set<String> _selectedTaskIds = {};
  String? _selectedColumnId;
  AgileProjectModel? _selectedProject;
  bool _createNewProject = false;
  AgileProjectFormResult? _newProjectConfig;

  List<TodoTaskModel> get _filteredTasks {
    if (_selectedColumnId == null) {
      return widget.tasks.where((t) => t.statusId != 'done' && t.statusId != 'completed').toList();
    }
    return widget.tasks.where((t) =>
      t.statusId == _selectedColumnId &&
      t.statusId != 'done' &&
      t.statusId != 'completed'
    ).toList();
  }

  @override
  void initState() {
    super.initState();
    // Pre-select all non-done tasks
    for (final task in widget.tasks) {
      if (task.statusId != 'done' && task.statusId != 'completed') {
        _selectedTaskIds.add(task.id);
      }
    }
    _createNewProject = widget.availableProjects.isEmpty;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredTasks = _filteredTasks;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 550,
        constraints: const BoxConstraints(maxHeight: 650),
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
                    child: const Icon(Icons.auto_stories_rounded, color: Colors.purple),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.exportToUserStories,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.exportToUserStoriesDesc,
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

            // Destination selection
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  // Toggle: existing or new
                  Row(
                    children: [
                      Expanded(
                        child: _buildDestinationOption(
                          icon: Icons.folder_open,
                          label: l10n.existingProject,
                          isSelected: !_createNewProject,
                          onTap: () => setState(() => _createNewProject = false),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDestinationOption(
                          icon: Icons.create_new_folder,
                          label: l10n.createNewProject,
                          isSelected: _createNewProject,
                          onTap: () => setState(() => _createNewProject = true),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Dropdown or New Project Configuration
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
                          child: Text(project.name, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedProject = value),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.purple.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: Colors.purple),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.noProjectsAvailable,
                              style: TextStyle(color: Colors.purple[700]),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Column filter
            if (widget.list.columns.length > 1)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Row(
                  children: [
                    Icon(Icons.filter_list, size: 20, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(l10n.filterByColumn, style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildColumnChip(null, l10n.allTasks, isDark),
                            ...widget.list.columns
                              .where((c) => !c.isDone)
                              .map((c) => _buildColumnChip(c.id, c.title, isDark)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const Divider(height: 24),

            // Select/Deselect all
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.tasksSelectedCount(_selectedTaskIds.length),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: _selectedTaskIds.isEmpty ? Colors.red : Colors.purple,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            for (final task in filteredTasks) {
                              _selectedTaskIds.add(task.id);
                            }
                          });
                        },
                        child: Text(l10n.selectAll),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            for (final task in filteredTasks) {
                              _selectedTaskIds.remove(task.id);
                            }
                          });
                        },
                        child: Text(l10n.deselectAll),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Task list
            Flexible(
              child: filteredTasks.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.inbox_outlined, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(l10n.noTasksSelected, style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        final isSelected = _selectedTaskIds.contains(task.id);
                        final column = widget.list.columns.firstWhere(
                          (c) => c.id == task.statusId,
                          orElse: () => widget.list.columns.first,
                        );

                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selectedTaskIds.add(task.id);
                              } else {
                                _selectedTaskIds.remove(task.id);
                              }
                            });
                          },
                          title: Text(
                            task.title,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Row(
                            children: [
                              if (task.effort != null) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${task.effort}h',
                                    style: TextStyle(fontSize: 10, color: Colors.blue[700]),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              if (task.description.isNotEmpty)
                                Expanded(
                                  child: Text(
                                    task.description,
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                          secondary: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(column.colorValue).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              column.title,
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(column.colorValue),
                                fontWeight: FontWeight.w500,
                              ),
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
                      l10n.userStoryFieldMappingInfo,
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
                    icon: const Icon(Icons.auto_stories_rounded, size: 18),
                    label: Text(l10n.actionExport),
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

  Widget _buildColumnChip(String? columnId, String label, bool isDark) {
    final isSelected = _selectedColumnId == columnId;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedColumnId = selected ? columnId : null;
          });
        },
        backgroundColor: isDark ? const Color(0xFF2D3748) : Colors.grey[100],
        selectedColor: Colors.purple.withOpacity(0.2),
        checkmarkColor: Colors.purple,
        labelStyle: TextStyle(
          color: isSelected ? Colors.purple : (isDark ? Colors.white70 : Colors.black87),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        visualDensity: VisualDensity.compact,
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
                  label: l10n.smartTodoSprintDays(_newProjectConfig!.sprintDurationDays),
                ),
                _buildConfigChip(
                  icon: Icons.access_time,
                  label: l10n.smartTodoHoursPerDay(_newProjectConfig!.workingHoursPerDay),
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
      suggestedName: widget.list.title,
    );

    if (result != null) {
      setState(() {
        _newProjectConfig = result;
      });
    }
  }

  bool _canExport() {
    if (_selectedTaskIds.isEmpty) return false;
    if (_createNewProject) {
      return _newProjectConfig != null;
    } else {
      return _selectedProject != null;
    }
  }

  void _export() {
    final selectedTasks = widget.tasks
        .where((t) => _selectedTaskIds.contains(t.id))
        .toList();

    Navigator.pop(
      context,
      ExportToUserStoriesResult(
        selectedTasks: selectedTasks,
        existingProject: _createNewProject ? null : _selectedProject,
        newProjectConfig: _createNewProject ? _newProjectConfig : null,
      ),
    );
  }
}
