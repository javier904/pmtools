import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/smart_todo/smart_todo_audit_log_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../services/smart_todo_audit_service.dart';
import '../../l10n/app_localizations.dart';

enum AuditViewMode { timeline, columns }

class SmartTodoAuditLogScreen extends StatefulWidget {
  final TodoListModel list;

  const SmartTodoAuditLogScreen({super.key, required this.list});

  @override
  State<SmartTodoAuditLogScreen> createState() => _SmartTodoAuditLogScreenState();
}

class _SmartTodoAuditLogScreenState extends State<SmartTodoAuditLogScreen> {
  final SmartTodoAuditService _auditService = SmartTodoAuditService();

  List<SmartTodoAuditLogModel> _logs = [];
  bool _isLoading = true;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  SmartTodoAuditLogFilter _filter = const SmartTodoAuditLogFilter();

  // View mode toggle
  AuditViewMode _viewMode = AuditViewMode.timeline;

  // Expanded rows tracking
  final Set<String> _expandedRows = {};

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs({bool reset = false}) async {
    if (reset) {
      setState(() {
        _logs = [];
        _lastDocument = null;
        _hasMore = true;
      });
    }

    setState(() => _isLoading = true);

    try {
      final newLogs = await _auditService.getAuditLogs(
        listId: widget.list.id,
        limit: 50,
        startAfter: _lastDocument,
        filter: _filter,
      );

      final lastDoc = await _auditService.getLastDocument(
        listId: widget.list.id,
        limit: 50,
        startAfter: _lastDocument,
        filter: _filter,
      );

      setState(() {
        _logs.addAll(newLogs);
        _lastDocument = lastDoc;
        _hasMore = newLogs.length >= 50;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore caricamento audit: $e')),
        );
      }
    }
  }

  void _applyFilter(SmartTodoAuditLogFilter newFilter) {
    setState(() => _filter = newFilter);
    _loadLogs(reset: true);
  }

  void _clearFilters() {
    _applyFilter(const SmartTodoAuditLogFilter());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.smartTodoAuditLogTitle(widget.list.title) ?? 'Audit Log - ${widget.list.title}'),
        actions: [
          // View mode toggle
          SegmentedButton<AuditViewMode>(
            segments: [
              ButtonSegment(
                value: AuditViewMode.timeline,
                icon: const Icon(Icons.view_list, size: 18),
                tooltip: l10n?.smartTodoAuditViewTimeline ?? 'Timeline View',
              ),
              ButtonSegment(
                value: AuditViewMode.columns,
                icon: const Icon(Icons.view_column, size: 18),
                tooltip: l10n?.smartTodoAuditViewColumns ?? 'Columns View',
              ),
            ],
            selected: {_viewMode},
            onSelectionChanged: (selected) {
              setState(() => _viewMode = selected.first);
            },
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 8),
          if (!_filter.isEmpty)
            TextButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.clear, size: 18),
              label: Text(l10n?.smartTodoAuditClearFilters ?? 'Clear Filters'),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadLogs(reset: true),
          ),
          const SizedBox(width: 8),
          // Home button - sempre ultimo a destra
          IconButton(
            icon: const Icon(Icons.home_rounded),
            tooltip: l10n?.navHome ?? 'Home',
            color: const Color(0xFF8B5CF6), // Viola come icona app
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          const Divider(height: 1),
          Expanded(
            child: _viewMode == AuditViewMode.timeline
                ? _buildLogsList()
                : _buildColumnsView(),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FILTER BAR
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildFilterBar() {
    final l10n = AppLocalizations.of(context);
    final participants = widget.list.participants.entries.toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          // Filter by user
          SizedBox(
            width: 160,
            child: DropdownButtonFormField<String?>(
              value: _filter.performedBy,
              decoration: InputDecoration(
                labelText: l10n?.smartTodoAuditFilterUser ?? 'User',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n?.smartTodoAuditFilterAll ?? 'All')),
                ...participants.map((p) {
                  final displayName = p.value.displayName ?? p.key.split('@').first;
                  return DropdownMenuItem(
                    value: displayName,
                    child: Text(displayName, overflow: TextOverflow.ellipsis),
                  );
                }),
              ],
              onChanged: (val) {
                if (val == null) {
                  _applyFilter(_filter.copyWith(clearPerformedBy: true));
                } else {
                  _applyFilter(_filter.copyWith(performedBy: val));
                }
              },
            ),
          ),

          // Filter by entity type
          SizedBox(
            width: 160,
            child: DropdownButtonFormField<TodoAuditEntityType?>(
              value: _filter.entityType,
              decoration: InputDecoration(
                labelText: l10n?.smartTodoAuditFilterType ?? 'Type',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n?.smartTodoAuditFilterAll ?? 'All')),
                ...TodoAuditEntityType.values.map((t) => DropdownMenuItem(
                  value: t,
                  child: Text(_getLocalizedEntityType(t)),
                )),
              ],
              onChanged: (val) {
                if (val == null) {
                  _applyFilter(_filter.copyWith(clearEntityType: true));
                } else {
                  _applyFilter(_filter.copyWith(entityType: val));
                }
              },
            ),
          ),

          // Filter by action
          SizedBox(
            width: 160,
            child: DropdownButtonFormField<TodoAuditAction?>(
              value: _filter.action,
              decoration: InputDecoration(
                labelText: l10n?.smartTodoAuditFilterAction ?? 'Action',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n?.smartTodoAuditFilterAllFemale ?? 'All')),
                ...TodoAuditAction.values.map((a) => DropdownMenuItem(
                  value: a,
                  child: Text(_getLocalizedAction(a)),
                )),
              ],
              onChanged: (val) {
                if (val == null) {
                  _applyFilter(_filter.copyWith(clearAction: true));
                } else {
                  _applyFilter(_filter.copyWith(action: val));
                }
              },
            ),
          ),

          // Search
          SizedBox(
            width: 160,
            child: TextField(
              decoration: InputDecoration(
                labelText: l10n?.smartTodoAuditFilterSearch ?? 'Search',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search, size: 18),
              ),
              onSubmitted: (val) {
                _applyFilter(_filter.copyWith(searchQuery: val.isEmpty ? '' : val));
              },
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LOGS LIST
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildLogsList() {
    final l10n = AppLocalizations.of(context);
    if (_isLoading && _logs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_logs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              _filter.isEmpty
                  ? (l10n?.smartTodoAuditNoActivity ?? 'No activity recorded')
                  : (l10n?.smartTodoAuditNoResults ?? 'No results for selected filters'),
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _logs.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _logs.length) {
          return _buildLoadMoreButton();
        }
        return _buildLogRow(_logs[index]);
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // COLUMNS VIEW
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildColumnsView() {
    final l10n = AppLocalizations.of(context);
    if (_isLoading && _logs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_logs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              _filter.isEmpty
                  ? (l10n?.smartTodoAuditNoActivity ?? 'No activity recorded')
                  : (l10n?.smartTodoAuditNoResults ?? 'No results for selected filters'),
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
          ],
        ),
      );
    }

    // Get unique participants from the list
    final participants = widget.list.participants.entries.toList();

    // Group logs by performer
    final logsByUser = <String, List<SmartTodoAuditLogModel>>{};
    for (final log in _logs) {
      logsByUser.putIfAbsent(log.performedByName, () => []).add(log);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final columnWidth = 280.0;

    return Column(
      children: [
        // Horizontal scrollable columns
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: participants.map((entry) {
                final email = entry.key;
                final participant = entry.value;
                final displayName = participant.displayName ?? email.split('@').first;
                final userLogs = logsByUser[displayName] ?? [];

                return _buildUserColumn(
                  displayName: displayName,
                  email: email,
                  logs: userLogs,
                  columnWidth: columnWidth,
                  isDark: isDark,
                );
              }).toList(),
            ),
          ),
        ),
        // Load more button at bottom
        if (_hasMore) _buildLoadMoreButton(),
      ],
    );
  }

  Widget _buildUserColumn({
    required String displayName,
    required String email,
    required List<SmartTodoAuditLogModel> logs,
    required double columnWidth,
    required bool isDark,
  }) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: columnWidth,
      margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          // Column header with user info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: _getUserColor(displayName),
                  child: Text(
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        l10n?.smartTodoAuditActivities(logs.length) ?? '${logs.length} activities',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Logs list for this user
          Expanded(
            child: logs.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        l10n?.smartTodoAuditNoUserActivity ?? 'No activity',
                        style: TextStyle(
                          color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: logs.length,
                    itemBuilder: (context, index) => _buildCompactLogEntry(logs[index], isDark),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactLogEntry(SmartTodoAuditLogModel log, bool isDark) {
    final hasChanges = log.changes.isNotEmpty;
    final isExpanded = _expandedRows.contains(log.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      elevation: 0,
      color: isDark ? Colors.grey.shade800 : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        onTap: hasChanges ? () {
          setState(() {
            if (isExpanded) {
              _expandedRows.remove(log.id);
            } else {
              _expandedRows.add(log.id);
            }
          });
        } : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action chip + entity type
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: log.action.color.withOpacity(isDark ? 0.25 : 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(log.action.icon, size: 12, color: log.action.color),
                        const SizedBox(width: 3),
                        Text(
                          _getLocalizedAction(log.action),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: log.action.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _getLocalizedEntityType(log.entityType),
                      style: TextStyle(
                        fontSize: 9,
                        color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (hasChanges)
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 16,
                      color: Colors.grey,
                    ),
                ],
              ),
              const SizedBox(height: 4),
              // Entity name
              Text(
                log.entityName ?? log.entityId,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              // Timestamp
              Text(
                _getLocalizedTimestamp(log.timestamp),
                style: TextStyle(
                  fontSize: 10,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              // Expanded changes
              if (isExpanded && hasChanges) ...[
                const Divider(height: 12),
                _buildCompactChangesDetail(log.changes, isDark),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactChangesDetail(List<TodoAuditFieldChange> changes, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: changes.map((change) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                change.fieldDisplayName,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 2),
              if (change.previousValue != null)
                Text(
                  _formatValue(change.previousValue),
                  style: TextStyle(
                    fontSize: 10,
                    decoration: TextDecoration.lineThrough,
                    color: isDark ? Colors.red.shade300 : Colors.red.shade700,
                  ),
                ),
              Text(
                _formatValue(change.newValue),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.green.shade300 : Colors.green.shade700,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getUserColor(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
    ];
    final hash = name.hashCode.abs();
    return colors[hash % colors.length];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TIMELINE VIEW (existing)
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildLogRow(SmartTodoAuditLogModel log) {
    final isExpanded = _expandedRows.contains(log.id);
    final hasChanges = log.changes.isNotEmpty;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: hasChanges ? () {
          setState(() {
            if (isExpanded) {
              _expandedRows.remove(log.id);
            } else {
              _expandedRows.add(log.id);
            }
          });
        } : null,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main row
              Row(
                children: [
                  // Action chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: log.action.color.withOpacity(isDark ? 0.25 : 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(log.action.icon, size: 14, color: log.action.color),
                        const SizedBox(width: 4),
                        Text(
                          _getLocalizedAction(log.action),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: log.action.color),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Entity type badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getLocalizedEntityType(log.entityType),
                      style: TextStyle(fontSize: 11, color: isDark ? Colors.grey.shade300 : Colors.grey.shade700),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Entity name (target)
                  Expanded(
                    child: Text(
                      log.entityName ?? log.entityId,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Expand icon if has changes
                  if (hasChanges)
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 20,
                      color: Colors.grey,
                    ),
                ],
              ),
              const SizedBox(height: 6),

              // Subtitle row: user + timestamp
              Row(
                children: [
                  Icon(Icons.person_outline, size: 14, color: subtitleColor),
                  const SizedBox(width: 4),
                  Text(
                    log.performedByName,
                    style: TextStyle(fontSize: 12, color: subtitleColor),
                  ),
                  const Spacer(),
                  Icon(Icons.access_time, size: 14, color: subtitleColor),
                  const SizedBox(width: 4),
                  Text(
                    _getLocalizedTimestamp(log.timestamp),
                    style: TextStyle(fontSize: 12, color: subtitleColor),
                  ),
                ],
              ),

              // Description (if different from default)
              if (log.description != null && log.description!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  log.description!,
                  style: TextStyle(fontSize: 12, color: subtitleColor, fontStyle: FontStyle.italic),
                ),
              ],

              // Expanded changes detail
              if (isExpanded && hasChanges) ...[
                const Divider(height: 16),
                _buildChangesDetail(log.changes),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangesDetail(List<TodoAuditFieldChange> changes) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: changes.map((change) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    change.fieldDisplayName,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? Colors.grey.shade300 : null),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 12, color: isDark ? Colors.grey.shade300 : Colors.grey.shade800),
                      children: [
                        if (change.previousValue != null) ...[
                          TextSpan(
                            text: _formatValue(change.previousValue),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: isDark ? Colors.red.shade300 : Colors.red,
                            ),
                          ),
                          const TextSpan(text: ' \u2192 '),
                        ],
                        TextSpan(
                          text: _formatValue(change.newValue),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.green.shade300 : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatValue(dynamic value) {
    final l10n = AppLocalizations.of(context);
    if (value == null) return l10n?.smartTodoAuditEmptyValue ?? '(empty)';
    if (value is List) return value.join(', ');
    return value.toString();
  }

  Widget _buildLoadMoreButton() {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton.icon(
                onPressed: () => _loadLogs(),
                icon: const Icon(Icons.expand_more),
                label: Text(l10n?.smartTodoAuditLoadMore ?? 'Load more 50...'),
              ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LOCALIZATION HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  String _getLocalizedEntityType(TodoAuditEntityType type) {
    final l10n = AppLocalizations.of(context);
    switch (type) {
      case TodoAuditEntityType.list:
        return l10n?.smartTodoAuditEntityList ?? 'List';
      case TodoAuditEntityType.task:
        return l10n?.smartTodoAuditEntityTask ?? 'Task';
      case TodoAuditEntityType.invite:
        return l10n?.smartTodoAuditEntityInvite ?? 'Invite';
      case TodoAuditEntityType.participant:
        return l10n?.smartTodoAuditEntityParticipant ?? 'Participant';
      case TodoAuditEntityType.column:
        return l10n?.smartTodoAuditEntityColumn ?? 'Column';
      case TodoAuditEntityType.tag:
        return l10n?.smartTodoAuditEntityTag ?? 'Tag';
    }
  }

  String _getLocalizedAction(TodoAuditAction action) {
    final l10n = AppLocalizations.of(context);
    switch (action) {
      case TodoAuditAction.create:
        return l10n?.smartTodoAuditActionCreate ?? 'Created';
      case TodoAuditAction.update:
        return l10n?.smartTodoAuditActionUpdate ?? 'Updated';
      case TodoAuditAction.delete:
        return l10n?.smartTodoAuditActionDelete ?? 'Deleted';
      case TodoAuditAction.archive:
        return l10n?.smartTodoAuditActionArchive ?? 'Archived';
      case TodoAuditAction.restore:
        return l10n?.smartTodoAuditActionRestore ?? 'Restored';
      case TodoAuditAction.move:
        return l10n?.smartTodoAuditActionMove ?? 'Moved';
      case TodoAuditAction.assign:
        return l10n?.smartTodoAuditActionAssign ?? 'Assigned';
      case TodoAuditAction.invite:
        return l10n?.smartTodoAuditActionInvite ?? 'Invited';
      case TodoAuditAction.join:
        return l10n?.smartTodoAuditActionJoin ?? 'Joined';
      case TodoAuditAction.revoke:
        return l10n?.smartTodoAuditActionRevoke ?? 'Revoked';
      case TodoAuditAction.reorder:
        return l10n?.smartTodoAuditActionReorder ?? 'Reordered';
      case TodoAuditAction.batchCreate:
        return l10n?.smartTodoAuditActionBatchCreate ?? 'Import';
    }
  }

  String _getLocalizedTimestamp(DateTime timestamp) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return l10n?.smartTodoAuditTimeNow ?? 'Now';
    if (diff.inMinutes < 60) return l10n?.smartTodoAuditTimeMinutesAgo(diff.inMinutes) ?? '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return l10n?.smartTodoAuditTimeHoursAgo(diff.inHours) ?? '${diff.inHours} hours ago';
    if (diff.inDays < 7) return l10n?.smartTodoAuditTimeDaysAgo(diff.inDays) ?? '${diff.inDays} days ago';

    return '${timestamp.day.toString().padLeft(2, '0')}/${timestamp.month.toString().padLeft(2, '0')}/${timestamp.year} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
