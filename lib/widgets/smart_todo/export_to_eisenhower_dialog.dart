import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../l10n/app_localizations.dart';

/// Data returned from the export dialog
class ExportToEisenhowerResult {
  final List<TodoTaskModel> selectedTasks;
  final EisenhowerMatrixModel? existingMatrix;
  final String? newMatrixTitle;

  const ExportToEisenhowerResult({
    required this.selectedTasks,
    this.existingMatrix,
    this.newMatrixTitle,
  });

  bool get createNewMatrix => newMatrixTitle != null && newMatrixTitle!.isNotEmpty;
}

/// Dialog for selecting tasks to export to Eisenhower matrix
class ExportToEisenhowerDialog extends StatefulWidget {
  final TodoListModel list;
  final List<TodoTaskModel> tasks;
  final List<EisenhowerMatrixModel> availableMatrices;

  const ExportToEisenhowerDialog({
    super.key,
    required this.list,
    required this.tasks,
    required this.availableMatrices,
  });

  @override
  State<ExportToEisenhowerDialog> createState() => _ExportToEisenhowerDialogState();
}

class _ExportToEisenhowerDialogState extends State<ExportToEisenhowerDialog> {
  final Set<String> _selectedTaskIds = {};
  String? _selectedColumnId;
  EisenhowerMatrixModel? _selectedMatrix;
  bool _createNewMatrix = false;
  final _newMatrixController = TextEditingController();

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
    // Suggest new matrix name from list
    _newMatrixController.text = widget.list.title;
    _createNewMatrix = widget.availableMatrices.isEmpty;
  }

  @override
  void dispose() {
    _newMatrixController.dispose();
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
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.grid_view_rounded, color: Colors.orange),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.exportToEisenhower,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.exportToEisenhowerDesc,
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
                      Icon(Icons.grid_4x4, size: 20, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        l10n.selectDestinationMatrix,
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
                          icon: Icons.grid_view,
                          label: l10n.existingMatrix,
                          isSelected: !_createNewMatrix,
                          onTap: () => setState(() => _createNewMatrix = false),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDestinationOption(
                          icon: Icons.add_box,
                          label: l10n.createNewMatrix,
                          isSelected: _createNewMatrix,
                          onTap: () => setState(() => _createNewMatrix = true),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Dropdown or TextField
                  if (_createNewMatrix)
                    TextField(
                      controller: _newMatrixController,
                      decoration: InputDecoration(
                        labelText: l10n.matrixName,
                        hintText: l10n.matrixNameHint,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.edit),
                      ),
                    )
                  else if (widget.availableMatrices.isNotEmpty)
                    DropdownButtonFormField<EisenhowerMatrixModel>(
                      value: _selectedMatrix,
                      decoration: InputDecoration(
                        labelText: l10n.selectMatrix,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.grid_view_rounded),
                      ),
                      hint: Text(l10n.selectMatrixHint),
                      items: widget.availableMatrices.map((matrix) {
                        return DropdownMenuItem(
                          value: matrix,
                          child: Text(matrix.title, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedMatrix = value),
                    )
                  else
                    Container(
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
                              l10n.noMatricesAvailable,
                              style: TextStyle(color: Colors.orange[700]),
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
                      color: _selectedTaskIds.isEmpty ? Colors.red : Colors.orange,
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
                          subtitle: task.description.isNotEmpty
                              ? Text(
                                  task.description,
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : null,
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
                    icon: const Icon(Icons.grid_view_rounded, size: 18),
                    label: Text(l10n.actionExport),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
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
              ? Colors.orange.withOpacity(0.1)
              : (isDark ? const Color(0xFF2D3748) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.orange : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.orange : (isDark ? Colors.white70 : Colors.black87),
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
        selectedColor: Colors.orange.withOpacity(0.2),
        checkmarkColor: Colors.orange,
        labelStyle: TextStyle(
          color: isSelected ? Colors.orange : (isDark ? Colors.white70 : Colors.black87),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  bool _canExport() {
    if (_selectedTaskIds.isEmpty) return false;
    if (_createNewMatrix) {
      return _newMatrixController.text.trim().isNotEmpty;
    } else {
      return _selectedMatrix != null;
    }
  }

  void _export() {
    final selectedTasks = widget.tasks
        .where((t) => _selectedTaskIds.contains(t.id))
        .toList();

    Navigator.pop(
      context,
      ExportToEisenhowerResult(
        selectedTasks: selectedTasks,
        existingMatrix: _createNewMatrix ? null : _selectedMatrix,
        newMatrixTitle: _createNewMatrix ? _newMatrixController.text.trim() : null,
      ),
    );
  }
}
