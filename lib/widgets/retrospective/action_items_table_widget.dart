
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
  final RetroTemplate template; // New: For action type suggestion
  final List<RetroColumn> columns; // New: For column lookup

  const ActionItemsTableWidget({
    Key? key,
    required this.actionItems,
    required this.retroId,
    required this.isFacilitator,
    required this.participants,
    required this.currentUserEmail,
    this.readOnly = false,
    this.items = const [],
    required this.template,
    required this.columns,
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
        dividerThickness: 0, // Remove row dividers
        border: TableBorder.all(color: Colors.transparent, width: 0), // Remove all borders
        headingRowColor: WidgetStateProperty.all(Colors.transparent),
        dataRowColor: WidgetStateProperty.all(Colors.transparent),
        columns: [
            DataColumn(label: Text(l10n.retroTableSourceColumn)), // Source column
            DataColumn(label: Text(l10n.retroTableDescription)), // Context from linked card
            DataColumn(label: Text(l10n.retroActionType)), // Action type badge
            DataColumn(label: Text(l10n.retroTableOwner)),
            DataColumn(label: Text(l10n.retroActionPriority)),
            DataColumn(label: Text(l10n.retroActionDueDate)),
            DataColumn(label: Text(l10n.retroSupportResources)), // Support resources
            DataColumn(label: Text(l10n.retroMonitoringMethod)), // Monitoring method
            DataColumn(label: Text(l10n.retroTableActions)), // What needs to be done
            if (!readOnly) const DataColumn(label: SizedBox(width: 80)), // Edit/delete buttons
          ],
        rows: actionItems.map((item) {
          return DataRow(
            cells: [
              // Source Column - which column the card came from
              DataCell(
                _buildSourceColumnBadge(context, item, l10n),
              ),
              // Description - full context from linked card
              DataCell(
                SizedBox(
                  width: 180,
                  child: Tooltip(
                    message: item.sourceRefContent ?? '',
                    child: Text(
                      item.sourceRefContent ?? '-',
                      style: const TextStyle(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              // Action Type Badge
              DataCell(
                item.actionType != null
                    ? Tooltip(
                        message: item.actionType!.getLocalizedName(l10n),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: item.actionType!.color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: item.actionType!.color.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(item.actionType!.icon, size: 14, color: item.actionType!.color),
                              const SizedBox(width: 4),
                              Text(
                                item.actionType!.getLocalizedName(l10n),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: item.actionType!.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Text('-', style: TextStyle(color: context.textMutedColor)),
              ),
              // Owner
              DataCell(
                Row(
                  children: [
                    const Icon(Icons.person, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(item.assigneeEmail?.split('@').first ?? l10n.retroUnassigned),
                  ],
                ),
              ),
              // Priority
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(item.priority).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _getPriorityColor(item.priority).withValues(alpha: 0.5)),
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
              // Due Date
              DataCell(
                Text(
                  item.dueDate != null
                      ? '${item.dueDate!.day}/${item.dueDate!.month}/${item.dueDate!.year}'
                      : '-',
                ),
              ),
              // Support Resources
              DataCell(
                SizedBox(
                  width: 140,
                  child: item.resources?.isNotEmpty ?? false
                    ? Tooltip(
                        message: item.resources!,
                        child: Row(
                          children: [
                            Icon(Icons.build_outlined, size: 14, color: Colors.blueGrey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item.resources!,
                                style: const TextStyle(fontSize: 12),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text('-', style: TextStyle(color: context.textMutedColor)),
                ),
              ),
              // Monitoring Method
              DataCell(
                SizedBox(
                  width: 140,
                  child: item.monitoring?.isNotEmpty ?? false
                    ? Tooltip(
                        message: item.monitoring!,
                        child: Row(
                          children: [
                            Icon(Icons.visibility_outlined, size: 14, color: Colors.blueGrey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item.monitoring!,
                                style: const TextStyle(fontSize: 12),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text('-', style: TextStyle(color: context.textMutedColor)),
                ),
              ),
              // Actions - what needs to be done
              DataCell(
                SizedBox(
                  width: 180,
                  child: Text(
                    item.description,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Edit/Delete buttons
              if (!readOnly)
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        onPressed: () => _editItem(context, item),
                        tooltip: l10n.actionEdit,
                        visualDensity: VisualDensity.compact,
                      ),
                      if (isFacilitator)
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                          onPressed: () => _deleteItem(context, item),
                          tooltip: l10n.actionDelete,
                          visualDensity: VisualDensity.compact,
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

  /// Builds a badge showing the source column name with its color
  Widget _buildSourceColumnBadge(BuildContext context, ActionItem item, AppLocalizations l10n) {
    if (item.sourceColumnId == null || item.sourceColumnId!.isEmpty) {
      return Text('-', style: TextStyle(color: context.textMutedColor));
    }

    // Find the column by ID
    final column = columns.where((c) => c.id == item.sourceColumnId).firstOrNull;
    if (column == null) {
      return Text(item.sourceColumnId!, style: TextStyle(fontSize: 11, color: context.textMutedColor));
    }

    return Tooltip(
      message: column.title,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: column.color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: column.color.withValues(alpha: 0.5)),
        ),
        child: Text(
          column.title.length > 12 ? '${column.title.substring(0, 10)}...' : column.title,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: column.color,
          ),
        ),
      ),
    );
  }

  Future<void> _editItem(BuildContext context, ActionItem item) async {
    final updatedItem = await showDialog<ActionItem>(
      context: context,
      builder: (context) => ActionItemDialog(
        item: item,
        participants: participants,
        currentUserEmail: currentUserEmail,
        availableCards: items,
        template: template,
        columns: columns,
      ),
    );

    if (updatedItem != null) {
      await RetrospectiveFirestoreService().updateActionItem(retroId, updatedItem);
    }
  }

  Future<void> _deleteItem(BuildContext context, ActionItem item) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.retroDeleteActionItem),
        content: Text(l10n.confirmDeleteMessage),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.no)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await RetrospectiveFirestoreService().deleteActionItem(retroId, item.id);
    }
  }
}
