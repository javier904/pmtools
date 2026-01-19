
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:agile_tools/widgets/retrospective/action_item_dialog.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ActionItemsTableWidget extends StatelessWidget {
  final List<ActionItem> actionItems;
  final String retroId;
  final bool isFacilitator;
  final List<String> participants;
  final String currentUserEmail;
  final bool readOnly;
  final List<RetroItem> items; // New: For editing context

  const ActionItemsTableWidget({
    Key? key,
    required this.actionItems,
    required this.retroId,
    required this.isFacilitator,
    required this.participants,
    required this.currentUserEmail,
    this.readOnly = false,
    this.items = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (actionItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.assignment_outlined, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              l10n.retroNoActionItems,
              style: TextStyle(color: context.textMutedColor),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 24,
        columns: [
          DataColumn(label: Text(l10n.retroTableRef)),
          DataColumn(label: Text(l10n.retroTableDescription)),
          DataColumn(label: Text(l10n.retroTableOwner)),
          DataColumn(label: Text(l10n.retroActionPriority)),
          DataColumn(label: Text(l10n.retroActionDueDate)),
          DataColumn(label: Text(l10n.retroTableActions)),
        ],
        rows: actionItems.map((item) {
          final String refText = item.sourceRefContent != null && item.sourceRefContent!.isNotEmpty
              ? (item.sourceRefContent!.length > 20 ? '${item.sourceRefContent!.substring(0, 18)}..' : item.sourceRefContent!)
              : '-';
          
          return DataRow(
            cells: [
               DataCell(
                Tooltip(
                  message: item.sourceRefContent ?? '',
                  child: Text(refText, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.description,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (item.resources?.isNotEmpty ?? false)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${l10n.retroActionResourcesShort}: ${item.resources}',
                            style: TextStyle(
                                fontSize: 10, color: context.textMutedColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              DataCell(
                Row(
                  children: [
                    const Icon(Icons.person, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(item.assigneeEmail?.split('@').first ?? l10n.retroUnassigned),
                  ],
                ),
              ),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(item.priority).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _getPriorityColor(item.priority).withOpacity(0.5)),
                  ),
                  child: Text(
                    item.priority.displayName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getPriorityColor(item.priority),
                    ),
                  ),
                ),
              ),
              DataCell(
                Text(
                  item.dueDate != null
                      ? '${item.dueDate!.day}/${item.dueDate!.month}/${item.dueDate!.year}'
                      : '-',
                ),
              ),
              DataCell(
                readOnly
                    ? const SizedBox()
                    : Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            onPressed: () => _editItem(context, item),
                            tooltip: 'Modifica',
                          ),
                          if (isFacilitator)
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  size: 20, color: Colors.red),
                              onPressed: () => _deleteItem(context, item),
                              tooltip: 'Elimina',
                            ),
                        ],
                      ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Color _getPriorityColor(ActionPriority priority) {
    switch (priority) {
      case ActionPriority.critical:
        return Colors.purple;
      case ActionPriority.high:
        return Colors.red;
      case ActionPriority.medium:
        return Colors.orange;
      case ActionPriority.low:
        return Colors.green;
    }
  }

  Future<void> _editItem(BuildContext context, ActionItem item) async {
    final updatedItem = await showDialog<ActionItem>(
      context: context,
      builder: (context) => ActionItemDialog(
        item: item,
        participants: participants,
        currentUserEmail: currentUserEmail,
        availableCards: items, // Pass items
      ),
    );

    if (updatedItem != null) {
      await RetrospectiveFirestoreService().updateActionItem(retroId, updatedItem);
    }
  }

  Future<void> _deleteItem(BuildContext context, ActionItem item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina Action Item'),
        content: const Text('Sei sicuro?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await RetrospectiveFirestoreService().deleteActionItem(retroId, item.id);
    }
  }
}
