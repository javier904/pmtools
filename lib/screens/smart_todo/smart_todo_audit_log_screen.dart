import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/smart_todo/smart_todo_audit_log_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../services/smart_todo_audit_service.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Audit Log - ${widget.list.title}'),
        actions: [
          if (!_filter.isEmpty)
            TextButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.clear, size: 18),
              label: const Text('Pulisci Filtri'),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadLogs(reset: true),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          const Divider(height: 1),
          Expanded(child: _buildLogsList()),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FILTER BAR
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildFilterBar() {
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
            width: 180,
            child: DropdownButtonFormField<String?>(
              value: _filter.performedBy,
              decoration: const InputDecoration(
                labelText: 'Utente',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('Tutti')),
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
            width: 140,
            child: DropdownButtonFormField<TodoAuditEntityType?>(
              value: _filter.entityType,
              decoration: const InputDecoration(
                labelText: 'Tipo',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('Tutti')),
                ...TodoAuditEntityType.values.map((t) => DropdownMenuItem(
                  value: t,
                  child: Text(t.displayName),
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
            width: 140,
            child: DropdownButtonFormField<TodoAuditAction?>(
              value: _filter.action,
              decoration: const InputDecoration(
                labelText: 'Azione',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('Tutte')),
                ...TodoAuditAction.values.map((a) => DropdownMenuItem(
                  value: a,
                  child: Text(a.displayName),
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
            width: 200,
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Cerca',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search, size: 18),
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
              _filter.isEmpty ? 'Nessuna attività registrata' : 'Nessun risultato per i filtri selezionati',
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
                          log.action.displayName,
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
                      log.entityType.displayName,
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
                    log.formattedTimestamp,
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
    if (value == null) return '(vuoto)';
    if (value is List) return value.join(', ');
    return value.toString();
  }

  Widget _buildLoadMoreButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton.icon(
                onPressed: () => _loadLogs(),
                icon: const Icon(Icons.expand_more),
                label: const Text('Carica altri 50...'),
              ),
      ),
    );
  }
}
