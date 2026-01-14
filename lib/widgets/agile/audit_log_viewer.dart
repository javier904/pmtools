import 'package:flutter/material.dart';
import '../../models/audit_log_model.dart';
import '../../models/agile_enums.dart';
import '../../services/agile_audit_service.dart';

/// Widget per visualizzare i log di audit del progetto
class AuditLogViewer extends StatefulWidget {
  final String projectId;

  const AuditLogViewer({
    super.key,
    required this.projectId,
  });

  static Future<void> show(BuildContext context, String projectId) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 800,
          height: 600,
          child: AuditLogViewer(projectId: projectId),
        ),
      ),
    );
  }

  @override
  State<AuditLogViewer> createState() => _AuditLogViewerState();
}

class _AuditLogViewerState extends State<AuditLogViewer> {
  final AgileAuditService _auditService = AgileAuditService();
  List<AuditLogModel> _logs = [];
  bool _isLoading = true;

  // Filtri
  AuditEntityType? _filterEntityType;
  AuditAction? _filterAction;
  String? _filterUser;
  DateTime? _filterFromDate;
  DateTime? _filterToDate;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    setState(() => _isLoading = true);
    try {
      final filter = AuditLogFilter(
        entityTypes: _filterEntityType != null ? [_filterEntityType!] : null,
        actions: _filterAction != null ? [_filterAction!] : null,
        performedBy: _filterUser,
        fromDate: _filterFromDate,
        toDate: _filterToDate,
      );

      final logs = await _auditService.getProjectLogs(
        widget.projectId,
        limit: 100,
        filter: filter,
      );
      setState(() {
        _logs = logs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore caricamento log: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.history, color: Colors.teal),
              const SizedBox(width: 8),
              const Text(
                'Audit Log',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '${_logs.length} eventi',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _loadLogs,
                tooltip: 'Aggiorna',
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                tooltip: 'Chiudi',
              ),
            ],
          ),
        ),
        // Filtri
        _buildFilters(),
        const Divider(height: 1),
        // Lista log
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _logs.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _logs.length,
                      itemBuilder: (context, index) => _buildLogItem(_logs[index]),
                    ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        children: [
          // Filtro tipo entità
          SizedBox(
            width: 140,
            child: DropdownButtonFormField<AuditEntityType?>(
              value: _filterEntityType,
              decoration: const InputDecoration(
                labelText: 'Tipo',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('Tutti')),
                ...AuditEntityType.values.map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                )),
              ],
              onChanged: (value) {
                setState(() => _filterEntityType = value);
                _loadLogs();
              },
            ),
          ),
          // Filtro azione
          SizedBox(
            width: 140,
            child: DropdownButtonFormField<AuditAction?>(
              value: _filterAction,
              decoration: const InputDecoration(
                labelText: 'Azione',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('Tutte')),
                ...AuditAction.values.map((action) => DropdownMenuItem(
                  value: action,
                  child: Text(action.displayName),
                )),
              ],
              onChanged: (value) {
                setState(() => _filterAction = value);
                _loadLogs();
              },
            ),
          ),
          // Filtro data da
          SizedBox(
            width: 150,
            child: InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _filterFromDate ?? DateTime.now().subtract(const Duration(days: 7)),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _filterFromDate = date);
                  _loadLogs();
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Da',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: Text(
                  _filterFromDate != null
                      ? '${_filterFromDate!.day}/${_filterFromDate!.month}/${_filterFromDate!.year}'
                      : '-',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),
          // Reset filtri
          TextButton.icon(
            onPressed: () {
              setState(() {
                _filterEntityType = null;
                _filterAction = null;
                _filterUser = null;
                _filterFromDate = null;
                _filterToDate = null;
              });
              _loadLogs();
            },
            icon: const Icon(Icons.clear_all, size: 18),
            label: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(AuditLogModel log) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: log.action.color.withValues(alpha: 0.1),
          child: Icon(
            log.action.icon,
            color: log.action.color,
            size: 20,
          ),
        ),
        title: Row(
          children: [
            _buildEntityBadge(log.entityType),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                log.description ?? _buildDefaultDescription(log),
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              log.performedBy,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(width: 12),
            Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              _formatTimestamp(log.timestamp),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: (log.previousValue?.isNotEmpty ?? false) || (log.newValue?.isNotEmpty ?? false)
            ? IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => _showLogDetails(log),
                tooltip: 'Dettagli',
              )
            : null,
      ),
    );
  }

  Widget _buildEntityBadge(AuditEntityType entityType) {
    final colorMap = {
      AuditEntityType.story: Colors.blue,
      AuditEntityType.sprint: Colors.purple,
      AuditEntityType.team: Colors.orange,
      AuditEntityType.project: Colors.teal,
      AuditEntityType.retrospective: Colors.pink,
    };
    final color = colorMap[entityType] ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        entityType.displayName.toUpperCase(),
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  String _buildDefaultDescription(AuditLogModel log) {
    return '${log.action.displayName} ${log.entityType.displayName} ${log.entityName ?? log.entityId}';
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return 'Ora';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min fa';
    if (diff.inHours < 24) return '${diff.inHours} ore fa';
    if (diff.inDays < 7) return '${diff.inDays} giorni fa';

    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  void _showLogDetails(AuditLogModel log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(log.action.icon, color: log.action.color),
            const SizedBox(width: 8),
            const Text('Dettagli Modifica'),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (log.previousValue?.isNotEmpty ?? false) ...[
                  const Text(
                    'Valore precedente:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      log.previousValue.toString(),
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (log.newValue?.isNotEmpty ?? false) ...[
                  const Text(
                    'Nuovo valore:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      log.newValue.toString(),
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Nessun evento registrato',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Le attività sul progetto verranno registrate qui',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget compatto per mostrare attività recenti
class RecentActivityWidget extends StatelessWidget {
  final List<AuditLogModel> recentLogs;
  final VoidCallback? onViewAll;

  const RecentActivityWidget({
    super.key,
    required this.recentLogs,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.update, color: Colors.teal),
                const SizedBox(width: 8),
                const Text(
                  'Attività Recente',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (onViewAll != null)
                  TextButton(
                    onPressed: onViewAll,
                    child: const Text('Vedi tutto'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (recentLogs.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Nessuna attività recente',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ...recentLogs.take(5).map((log) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: log.action.color.withValues(alpha: 0.1),
                  child: Icon(
                    log.action.icon,
                    size: 16,
                    color: log.action.color,
                  ),
                ),
                title: Text(
                  log.description ?? '${log.action.displayName} ${log.entityType.displayName}',
                  style: const TextStyle(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${log.performedBy.split('@').first} - ${_formatTime(log.timestamp)}',
                  style: const TextStyle(fontSize: 11),
                ),
              )),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}min fa';
    if (diff.inHours < 24) return '${diff.inHours}h fa';
    return '${diff.inDays}g fa';
  }
}
