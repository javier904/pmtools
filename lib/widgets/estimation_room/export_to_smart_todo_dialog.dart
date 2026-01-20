import 'package:flutter/material.dart';
import '../../models/planning_poker_story_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../l10n/app_localizations.dart';

/// Data returned from the export dialog
class ExportToSmartTodoResult {
  final List<PlanningPokerStoryModel> selectedStories;
  final TodoListModel? existingList;
  final String? newListTitle;

  const ExportToSmartTodoResult({
    required this.selectedStories,
    this.existingList,
    this.newListTitle,
  });

  bool get createNewList => newListTitle != null && newListTitle!.isNotEmpty;
}

/// Dialog for selecting stories to export to Smart Todo
class ExportToSmartTodoDialog extends StatefulWidget {
  final List<PlanningPokerStoryModel> stories;
  final List<TodoListModel> availableLists;
  final String sessionName;

  const ExportToSmartTodoDialog({
    super.key,
    required this.stories,
    required this.availableLists,
    required this.sessionName,
  });

  @override
  State<ExportToSmartTodoDialog> createState() => _ExportToSmartTodoDialogState();
}

class _ExportToSmartTodoDialogState extends State<ExportToSmartTodoDialog> {
  final Set<String> _selectedStoryIds = {};
  TodoListModel? _selectedList;
  bool _createNewList = false;
  final _newListController = TextEditingController();

  List<PlanningPokerStoryModel> get _estimatedStories =>
      widget.stories.where((s) => s.finalEstimate != null).toList();

  @override
  void initState() {
    super.initState();
    // Pre-select all estimated stories
    for (final story in _estimatedStories) {
      _selectedStoryIds.add(story.id);
    }
    // Suggest new list name from session
    _newListController.text = widget.sessionName;
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
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.check_circle_outline_rounded, color: Colors.blue),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.exportFromEstimation,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.exportFromEstimationDesc,
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
                      Icon(Icons.folder_open, size: 20, color: Colors.grey[600]),
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
                          icon: Icons.folder,
                          label: l10n.existingList,
                          isSelected: !_createNewList,
                          onTap: () => setState(() => _createNewList = false),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDestinationOption(
                          icon: Icons.create_new_folder,
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
                              l10n.noListsAvailable,
                              style: TextStyle(color: Colors.orange[700]),
                            ),
                          ),
                        ],
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
                    l10n.storiesSelectedCount(_selectedStoryIds.length),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: _selectedStoryIds.isEmpty ? Colors.red : Colors.blue,
                    ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              story.finalEstimate ?? '-',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
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
                      backgroundColor: Colors.blue,
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
              ? Colors.blue.withOpacity(0.1)
              : (isDark ? const Color(0xFF2D3748) : Colors.grey[100]),
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
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : (isDark ? Colors.white70 : Colors.black87),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canExport() {
    if (_selectedStoryIds.isEmpty) return false;
    if (_createNewList) {
      return _newListController.text.trim().isNotEmpty;
    } else {
      return _selectedList != null;
    }
  }

  void _export() {
    final selectedStories = _estimatedStories
        .where((s) => _selectedStoryIds.contains(s.id))
        .toList();

    Navigator.pop(
      context,
      ExportToSmartTodoResult(
        selectedStories: selectedStories,
        existingList: _createNewList ? null : _selectedList,
        newListTitle: _createNewList ? _newListController.text.trim() : null,
      ),
    );
  }
}
