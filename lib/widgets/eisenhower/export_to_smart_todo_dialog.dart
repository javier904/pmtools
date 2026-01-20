import 'package:flutter/material.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../l10n/app_localizations.dart';

/// Data returned from the export dialog
class ExportToSmartTodoFromEisenhowerResult {
  final List<EisenhowerActivityModel> selectedActivities;
  final TodoListModel? existingList;
  final String? newListTitle;

  const ExportToSmartTodoFromEisenhowerResult({
    required this.selectedActivities,
    this.existingList,
    this.newListTitle,
  });

  bool get createNewList => newListTitle != null && newListTitle!.isNotEmpty;
}

/// Dialog for selecting activities to export to Smart Todo
class ExportToSmartTodoFromEisenhowerDialog extends StatefulWidget {
  final EisenhowerMatrixModel matrix;
  final List<EisenhowerActivityModel> activities;
  final List<TodoListModel> availableLists;

  const ExportToSmartTodoFromEisenhowerDialog({
    super.key,
    required this.matrix,
    required this.activities,
    required this.availableLists,
  });

  @override
  State<ExportToSmartTodoFromEisenhowerDialog> createState() => _ExportToSmartTodoFromEisenhowerDialogState();
}

class _ExportToSmartTodoFromEisenhowerDialogState extends State<ExportToSmartTodoFromEisenhowerDialog> {
  final Set<String> _selectedActivityIds = {};
  EisenhowerQuadrant? _selectedQuadrant;
  TodoListModel? _selectedList;
  bool _createNewList = false;
  final _newListController = TextEditingController();

  List<EisenhowerActivityModel> get _filteredActivities {
    if (_selectedQuadrant == null) {
      return widget.activities;
    }
    return widget.activities.where((a) => a.quadrant == _selectedQuadrant).toList();
  }

  @override
  void initState() {
    super.initState();
    // Pre-select all activities with votes
    for (final activity in widget.activities) {
      if (activity.hasVotes) {
        _selectedActivityIds.add(activity.id);
      }
    }
    // Suggest new list name from matrix
    _newListController.text = widget.matrix.title;
    _createNewList = widget.availableLists.isEmpty;
  }

  @override
  void dispose() {
    _newListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredActivities = _filteredActivities;

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
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.check_circle_outline_rounded, color: Colors.green),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.exportFromEisenhower,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.exportFromEisenhowerDesc,
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
                      Icon(Icons.checklist, size: 20, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        l10n.selectDestinationList,
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
                          icon: Icons.list_alt,
                          label: l10n.existingList,
                          isSelected: !_createNewList,
                          onTap: () => setState(() => _createNewList = false),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDestinationOption(
                          icon: Icons.add_box,
                          label: l10n.createNewList,
                          isSelected: _createNewList,
                          onTap: () => setState(() => _createNewList = true),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Dropdown or TextField
                  if (_createNewList)
                    TextField(
                      controller: _newListController,
                      decoration: InputDecoration(
                        labelText: l10n.listName,
                        hintText: l10n.listNameHint,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.edit),
                      ),
                    )
                  else if (widget.availableLists.isNotEmpty)
                    DropdownButtonFormField<TodoListModel>(
                      value: _selectedList,
                      decoration: InputDecoration(
                        labelText: l10n.selectList,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.list_alt),
                      ),
                      hint: Text(l10n.selectListHint),
                      items: widget.availableLists.map((list) {
                        return DropdownMenuItem(
                          value: list,
                          child: Text(list.title, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedList = value),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: Colors.blue),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.noListsAvailable,
                              style: TextStyle(color: Colors.blue[700]),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Quadrant filter
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  Icon(Icons.filter_list, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(l10n.filterByQuadrant, style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildQuadrantChip(null, l10n.allActivities, isDark),
                          _buildQuadrantChip(EisenhowerQuadrant.q1, 'Q1', isDark, color: Colors.red),
                          _buildQuadrantChip(EisenhowerQuadrant.q2, 'Q2', isDark, color: Colors.green),
                          _buildQuadrantChip(EisenhowerQuadrant.q3, 'Q3', isDark, color: Colors.orange),
                          _buildQuadrantChip(EisenhowerQuadrant.q4, 'Q4', isDark, color: Colors.grey),
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
                    l10n.activitiesSelectedCount(_selectedActivityIds.length),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: _selectedActivityIds.isEmpty ? Colors.red : Colors.green,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            for (final activity in filteredActivities) {
                              _selectedActivityIds.add(activity.id);
                            }
                          });
                        },
                        child: Text(l10n.selectAll),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            for (final activity in filteredActivities) {
                              _selectedActivityIds.remove(activity.id);
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

            // Activity list
            Flexible(
              child: filteredActivities.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.inbox_outlined, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(l10n.noActivitiesSelected, style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: filteredActivities.length,
                      itemBuilder: (context, index) {
                        final activity = filteredActivities[index];
                        final isSelected = _selectedActivityIds.contains(activity.id);
                        final quadrant = activity.quadrant;

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
                            style: const TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: activity.description.isNotEmpty
                              ? Text(
                                  activity.description,
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : null,
                          secondary: quadrant != null
                              ? Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getQuadrantColor(quadrant).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    quadrant.name.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getQuadrantColor(quadrant),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    l10n.unvoted,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
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
                    icon: const Icon(Icons.check_circle_outline_rounded, size: 18),
                    label: Text(l10n.actionExport),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
              ? Colors.green.withOpacity(0.1)
              : (isDark ? const Color(0xFF2D3748) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.green : (isDark ? Colors.white70 : Colors.black87),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuadrantChip(EisenhowerQuadrant? quadrant, String label, bool isDark, {Color? color}) {
    final isSelected = _selectedQuadrant == quadrant;
    final chipColor = color ?? Colors.blue;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedQuadrant = selected ? quadrant : null;
          });
        },
        backgroundColor: isDark ? const Color(0xFF2D3748) : Colors.grey[100],
        selectedColor: chipColor.withOpacity(0.2),
        checkmarkColor: chipColor,
        labelStyle: TextStyle(
          color: isSelected ? chipColor : (isDark ? Colors.white70 : Colors.black87),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Color _getQuadrantColor(EisenhowerQuadrant quadrant) {
    switch (quadrant) {
      case EisenhowerQuadrant.q1:
        return Colors.red;
      case EisenhowerQuadrant.q2:
        return Colors.green;
      case EisenhowerQuadrant.q3:
        return Colors.orange;
      case EisenhowerQuadrant.q4:
        return Colors.grey;
    }
  }

  bool _canExport() {
    if (_selectedActivityIds.isEmpty) return false;
    if (_createNewList) {
      return _newListController.text.trim().isNotEmpty;
    } else {
      return _selectedList != null;
    }
  }

  void _export() {
    final selectedActivities = widget.activities
        .where((a) => _selectedActivityIds.contains(a.id))
        .toList();

    Navigator.pop(
      context,
      ExportToSmartTodoFromEisenhowerResult(
        selectedActivities: selectedActivities,
        existingList: _createNewList ? null : _selectedList,
        newListTitle: _createNewList ? _newListController.text.trim() : null,
      ),
    );
  }
}
