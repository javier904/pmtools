import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:flutter/material.dart';

/// Helper to pair an action item with its source retrospective.
class _ActionItemWithRetro {
  final ActionItem item;
  final RetrospectiveModel retro;
  _ActionItemWithRetro({required this.item, required this.retro});
}

/// Shows ALL action items from ALL retrospectives in a project,
/// with filters and status management.
class ActionItemsTrackerWidget extends StatefulWidget {
  final List<RetrospectiveModel> retrospectives;
  final String currentUserEmail;
  final String currentUserName;
  final Function(String retroId, String actionItemId, ActionItemStatus newStatus)?
      onStatusChanged;

  const ActionItemsTrackerWidget({
    super.key,
    required this.retrospectives,
    required this.currentUserEmail,
    required this.currentUserName,
    this.onStatusChanged,
  });

  @override
  State<ActionItemsTrackerWidget> createState() =>
      _ActionItemsTrackerWidgetState();
}

class _ActionItemsTrackerWidgetState extends State<ActionItemsTrackerWidget> {
  ActionItemStatus? _selectedStatus;
  String? _selectedAssignee;
  String? _selectedRetroId;

  /// Flattens all action items across retrospectives into paired objects.
  List<_ActionItemWithRetro> get _allItems {
    final result = <_ActionItemWithRetro>[];
    for (final retro in widget.retrospectives) {
      for (final item in retro.actionItems) {
        result.add(_ActionItemWithRetro(item: item, retro: retro));
      }
    }
    // Sort by creation date descending (newest first).
    result.sort((a, b) => b.item.createdAt.compareTo(a.item.createdAt));
    return result;
  }

  /// Applies active filters.
  List<_ActionItemWithRetro> get _filteredItems {
    var items = _allItems;
    if (_selectedStatus != null) {
      items = items.where((e) => e.item.status == _selectedStatus).toList();
    }
    if (_selectedAssignee != null) {
      items = items
          .where((e) => (e.item.assigneeEmail ?? e.item.ownerEmail) == _selectedAssignee)
          .toList();
    }
    if (_selectedRetroId != null) {
      items = items.where((e) => e.retro.id == _selectedRetroId).toList();
    }
    return items;
  }

  /// Unique assignee emails across all items.
  List<String> get _uniqueAssignees {
    final emails = <String>{};
    for (final pair in _allItems) {
      emails.add(pair.item.assigneeEmail ?? pair.item.ownerEmail);
    }
    final sorted = emails.toList()..sort();
    return sorted;
  }

  String _displayNameForEmail(String email) {
    if (email.isEmpty) return 'Unassigned';
    final parts = email.split('@');
    return parts.first;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final allItems = _allItems;
    final filteredItems = _filteredItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            l10n.actionTrackerTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Summary counters
        _buildSummaryRow(context, allItems),

        const SizedBox(height: 8),

        // Filter row
        _buildFilterRow(context, l10n),

        const Divider(height: 1),

        // Items list
        if (filteredItems.isEmpty)
          _buildEmptyState(context, l10n)
        else
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: filteredItems.length,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (context, index) =>
                  _buildActionItemTile(context, filteredItems[index], l10n),
            ),
          ),
      ],
    );
  }

  Widget _buildSummaryRow(BuildContext context, List<_ActionItemWithRetro> allItems) {
    final l10n = AppLocalizations.of(context)!;

    int countByStatus(ActionItemStatus status) =>
        allItems.where((e) => e.item.status == status).length;

    final total = allItems.length;
    final openCount = countByStatus(ActionItemStatus.open);
    final inProgressCount = countByStatus(ActionItemStatus.inProgress);
    final completedCount = countByStatus(ActionItemStatus.completed);
    final deferredCount = countByStatus(ActionItemStatus.deferred);

    final completionRate = total > 0 ? (completedCount / total * 100).round() : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _buildCountChip(
            label: 'Total',
            count: total,
            color: Theme.of(context).colorScheme.primary,
          ),
          _buildCountChip(
            label: l10n.actionStatusOpen,
            count: openCount,
            color: ActionItemStatus.open.color,
          ),
          _buildCountChip(
            label: l10n.actionStatusInProgress,
            count: inProgressCount,
            color: ActionItemStatus.inProgress.color,
          ),
          _buildCountChip(
            label: l10n.actionStatusCompleted,
            count: completedCount,
            color: ActionItemStatus.completed.color,
          ),
          _buildCountChip(
            label: l10n.actionStatusDeferred,
            count: deferredCount,
            color: ActionItemStatus.deferred.color,
          ),
          Tooltip(
            message: l10n.tooltipTrackerCompletionRate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: ActionItemStatus.completed.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: ActionItemStatus.completed.color.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                '${l10n.actionTrackerCompletionRate}: $completionRate%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: ActionItemStatus.completed.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountChip({
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$count',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        children: [
          // Status filter
          Tooltip(
            message: l10n.tooltipTrackerFilterStatus,
            child: _buildDropdownFilter<ActionItemStatus?>(
              hint: l10n.actionTrackerFilterByStatus,
              value: _selectedStatus,
              items: [
                DropdownMenuItem<ActionItemStatus?>(
                  value: null,
                  child: Text(l10n.actionTrackerFilterByStatus),
                ),
                ...ActionItemStatus.values.map(
                  (s) => DropdownMenuItem<ActionItemStatus?>(
                    value: s,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(s.icon, size: 16, color: s.color),
                        const SizedBox(width: 6),
                        Text(s.getLocalizedName(l10n)),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) => setState(() => _selectedStatus = value),
            ),
          ),

          // Assignee filter
          Tooltip(
            message: l10n.tooltipTrackerFilterAssignee,
            child: _buildDropdownFilter<String?>(
              hint: l10n.actionTrackerFilterByAssignee,
              value: _selectedAssignee,
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(l10n.actionTrackerFilterByAssignee),
                ),
                ..._uniqueAssignees.map(
                  (email) => DropdownMenuItem<String?>(
                    value: email,
                    child: Text(
                      _displayNameForEmail(email),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
              onChanged: (value) => setState(() => _selectedAssignee = value),
            ),
          ),

          // Retro filter
          Tooltip(
            message: l10n.tooltipTrackerFilterRetro,
            child: _buildDropdownFilter<String?>(
              hint: l10n.actionTrackerFilterByRetro,
              value: _selectedRetroId,
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(l10n.actionTrackerFilterByRetro),
                ),
                ...widget.retrospectives.map(
                  (r) => DropdownMenuItem<String?>(
                    value: r.id,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(r.template.icon, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          r.sprintName.isNotEmpty
                              ? r.sprintName
                              : r.template.displayName,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) => setState(() => _selectedRetroId = value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter<T>({
    required String hint,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down, size: 20),
          style: Theme.of(context).textTheme.bodySmall,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.actionTrackerEmpty,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItemTile(
    BuildContext context,
    _ActionItemWithRetro pair,
    AppLocalizations l10n,
  ) {
    final item = pair.item;
    final retro = pair.retro;
    final theme = Theme.of(context);
    final assigneeDisplay = item.assigneeName ??
        _displayNameForEmail(item.assigneeEmail ?? item.ownerEmail);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status chip (clickable if callback provided)
          _buildStatusChip(context, pair, l10n),
          const SizedBox(width: 12),

          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 14,
                    decoration: item.status == ActionItemStatus.completed
                        ? TextDecoration.lineThrough
                        : null,
                    color: item.status == ActionItemStatus.completed
                        ? Colors.grey
                        : theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 6),

                // Metadata row
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Priority chip
                    _buildPriorityBadge(item.priority, l10n),

                    // Assignee
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person_outline, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          assigneeDisplay,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ],
                    ),

                    // Source retro info
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(retro.template.icon, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          retro.title.isNotEmpty
                              ? '${retro.template.displayName} - ${retro.title}'
                              : retro.sprintName.isNotEmpty
                                  ? '${retro.template.displayName} - ${retro.sprintName}'
                              : retro.template.displayName,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),

                    // Due date
                    if (item.dueDate != null)
                      _isDueDateOverdue(item)
                          ? Tooltip(
                              message: l10n.tooltipTrackerOverdue,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatDate(item.dueDate!),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _formatDate(item.dueDate!),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(
    BuildContext context,
    _ActionItemWithRetro pair,
    AppLocalizations l10n,
  ) {
    final status = pair.item.status;

    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: status.color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 14, color: status.color),
          const SizedBox(width: 4),
          Text(
            status.getLocalizedName(l10n),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: status.color,
            ),
          ),
        ],
      ),
    );

    if (widget.onStatusChanged == null) return chip;

    return Tooltip(
      message: l10n.tooltipTrackerStatusClick,
      child: PopupMenuButton<ActionItemStatus>(
        onSelected: (newStatus) {
          widget.onStatusChanged!(pair.retro.id, pair.item.id, newStatus);
        },
        itemBuilder: (context) => ActionItemStatus.values.map((s) {
          return PopupMenuItem<ActionItemStatus>(
            value: s,
            child: Row(
              children: [
                Icon(s.icon, size: 18, color: s.color),
                const SizedBox(width: 8),
                Text(s.getLocalizedName(l10n)),
              ],
            ),
          );
        }).toList(),
        child: chip,
      ),
    );
  }

  String _priorityTooltip(AppLocalizations l10n, ActionPriority priority) {
    switch (priority) {
      case ActionPriority.critical:
        return l10n.tooltipPriorityCritical;
      case ActionPriority.high:
        return l10n.tooltipPriorityHigh;
      case ActionPriority.medium:
        return l10n.tooltipPriorityMedium;
      case ActionPriority.low:
        return l10n.tooltipPriorityLow;
    }
  }

  Widget _buildPriorityBadge(ActionPriority priority, AppLocalizations l10n) {
    final color = _priorityColor(priority);
    return Tooltip(
      message: _priorityTooltip(l10n, priority),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Text(
          priority.displayName.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Color _priorityColor(ActionPriority priority) {
    switch (priority) {
      case ActionPriority.critical:
        return const Color(0xFFF44336);
      case ActionPriority.high:
        return const Color(0xFFFF9800);
      case ActionPriority.medium:
        return const Color(0xFF2196F3);
      case ActionPriority.low:
        return const Color(0xFF9E9E9E);
    }
  }

  bool _isDueDateOverdue(ActionItem item) {
    if (item.dueDate == null) return false;
    if (item.status == ActionItemStatus.completed ||
        item.status == ActionItemStatus.deferred) return false;
    return item.dueDate!.isBefore(DateTime.now());
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
