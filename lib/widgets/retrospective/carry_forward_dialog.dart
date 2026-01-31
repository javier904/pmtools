import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:flutter/material.dart';

/// Dialog that shows uncompleted action items from previous retrospectives,
/// allowing the user to select which items to carry forward into a new retro.
///
/// Returns a [List<ActionItem>] of selected items on confirm, or null on cancel.
class CarryForwardDialog extends StatefulWidget {
  final List<RetrospectiveModel> retrospectives;

  const CarryForwardDialog({
    super.key,
    required this.retrospectives,
  });

  @override
  State<CarryForwardDialog> createState() => _CarryForwardDialogState();
}

class _CarryForwardDialogState extends State<CarryForwardDialog> {
  late final List<_CarryForwardEntry> _entries;
  late final Set<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _entries = _collectUncompletedItems();
    _selectedIds = _entries.map((e) => e.actionItem.id).toSet();
  }

  /// Collect all action items from retrospectives where status is open or inProgress.
  List<_CarryForwardEntry> _collectUncompletedItems() {
    final entries = <_CarryForwardEntry>[];

    for (final retro in widget.retrospectives) {
      for (final item in retro.actionItems) {
        if (item.status == ActionItemStatus.open ||
            item.status == ActionItemStatus.inProgress) {
          entries.add(_CarryForwardEntry(
            actionItem: item,
            sourceRetro: retro,
          ));
        }
      }
    }

    // Sort by priority (critical first), then by creation date (newest first)
    entries.sort((a, b) {
      final priorityOrder = [
        ActionPriority.critical,
        ActionPriority.high,
        ActionPriority.medium,
        ActionPriority.low,
      ];
      final aPriority = priorityOrder.indexOf(a.actionItem.priority);
      final bPriority = priorityOrder.indexOf(b.actionItem.priority);
      if (aPriority != bPriority) return aPriority.compareTo(bPriority);
      return b.actionItem.createdAt.compareTo(a.actionItem.createdAt);
    });

    return entries;
  }

  bool get _allSelected => _selectedIds.length == _entries.length;

  void _toggleSelectAll() {
    setState(() {
      if (_allSelected) {
        _selectedIds.clear();
      } else {
        _selectedIds = _entries.map((e) => e.actionItem.id).toSet();
      }
    });
  }

  void _toggleItem(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  Color _getPriorityColor(ActionPriority priority) {
    switch (priority) {
      case ActionPriority.critical:
        return Colors.purple;
      case ActionPriority.high:
        return Colors.red.shade700;
      case ActionPriority.medium:
        return Colors.orange.shade900;
      case ActionPriority.low:
        return Colors.green.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primaryColor = Theme.of(context).colorScheme.primary;

    if (_entries.isEmpty) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.forward, color: primaryColor),
            const SizedBox(width: 8),
            Text(l10n.actionTrackerCarryForward),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 48,
              color: Colors.green.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'No pending action items',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: Text(l10n.actionClose),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.forward, color: primaryColor),
          const SizedBox(width: 8),
          Expanded(child: Text(l10n.actionTrackerCarryForward)),
        ],
      ),
      content: SizedBox(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tooltip(
              message: l10n.tooltipCarryForwardDesc,
              child: Text(
                l10n.actionTrackerCarryForwardDesc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color
                      ?.withValues(alpha: 0.7),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Select All / Deselect All toggle
            Tooltip(
              message: l10n.tooltipCarryForwardSelectAll,
              child: InkWell(
                onTap: _toggleSelectAll,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _allSelected,
                        tristate: true,
                        onChanged: (_) => _toggleSelectAll(),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _allSelected ? 'Deselect All' : 'Select All',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${_selectedIds.length}/${_entries.length}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            const SizedBox(height: 4),
            // Item list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  final entry = _entries[index];
                  final item = entry.actionItem;
                  final retro = entry.sourceRetro;
                  final isSelected = _selectedIds.contains(item.id);

                  return InkWell(
                    onTap: () => _toggleItem(item.id),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => _toggleItem(item.id),
                          ),
                          const SizedBox(width: 4),
                          // Status chip
                          _buildStatusChip(item.status, l10n),
                          const SizedBox(width: 8),
                          // Description and source info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.description,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      retro.template.icon,
                                      size: 14,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withValues(alpha: 0.5),
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        '${retro.template.displayName} - ${retro.sprintName}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color
                                              ?.withValues(alpha: 0.5),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Priority chip
                          _buildPriorityChip(item.priority),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(l10n.actionCancel),
        ),
        FilledButton.icon(
          onPressed: _selectedIds.isEmpty
              ? null
              : () {
                  final selectedItems = _entries
                      .where((e) => _selectedIds.contains(e.actionItem.id))
                      .map((e) => e.actionItem)
                      .toList();
                  Navigator.of(context).pop(selectedItems);
                },
          icon: const Icon(Icons.forward, size: 18),
          label: Text(l10n.actionTrackerCarryForwardConfirm),
        ),
      ],
    );
  }

  Widget _buildStatusChip(ActionItemStatus status, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: status.color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 14, color: status.color),
          const SizedBox(width: 4),
          Text(
            status.getLocalizedName(l10n),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityChip(ActionPriority priority) {
    final color = _getPriorityColor(priority);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        priority.displayName.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

/// Internal helper class to pair an action item with its source retrospective.
class _CarryForwardEntry {
  final ActionItem actionItem;
  final RetrospectiveModel sourceRetro;

  const _CarryForwardEntry({
    required this.actionItem,
    required this.sourceRetro,
  });
}
