import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/smart_todo/smart_todo_audit_log_model.dart';
import '../models/smart_todo/todo_task_model.dart';
import '../models/smart_todo/todo_list_model.dart';

/// Servizio per gestire l'audit log delle Todo List.
/// Tutte le scritture sono fire-and-forget (non bloccano l'operazione principale).
class SmartTodoAuditService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final SmartTodoAuditService _instance = SmartTodoAuditService._internal();
  factory SmartTodoAuditService() => _instance;
  SmartTodoAuditService._internal();

  static const String _listsCollection = 'smart_todo_lists';
  static const String _auditSubcollection = 'audit_logs';

  // ═══════════════════════════════════════════════════════════════════════════
  // WRITE (fire-and-forget)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Logga un'azione. Non-blocking: errori di scrittura non propagano.
  void log({
    required String listId,
    required TodoAuditEntityType entityType,
    required String entityId,
    String? entityName,
    required TodoAuditAction action,
    required String performedBy,
    required String performedByName,
    List<TodoAuditFieldChange>? changes,
    Map<String, dynamic>? metadata,
    String? description,
  }) {
    final entry = SmartTodoAuditLogModel(
      id: '',
      listId: listId,
      entityType: entityType,
      entityId: entityId,
      entityName: entityName,
      action: action,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      changes: changes ?? [],
      metadata: metadata,
      description: description,
    );

    // Fire-and-forget: non attendiamo il risultato
    _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_auditSubcollection)
        .add(entry.toFirestore())
        .catchError((e) {
      print('⚠️ Audit log write failed: $e');
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DELTA DETECTION - TASK
  // ═══════════════════════════════════════════════════════════════════════════

  /// Rileva le differenze tra due versioni di un task.
  /// Ritorna lista vuota se non ci sono cambiamenti significativi.
  List<TodoAuditFieldChange> detectTaskChanges(TodoTaskModel oldTask, TodoTaskModel newTask) {
    final changes = <TodoAuditFieldChange>[];

    if (oldTask.title != newTask.title) {
      changes.add(TodoAuditFieldChange(
        field: 'title',
        previousValue: oldTask.title,
        newValue: newTask.title,
      ));
    }

    if (oldTask.description != newTask.description) {
      changes.add(TodoAuditFieldChange(
        field: 'description',
        previousValue: oldTask.description.isNotEmpty ? oldTask.description : null,
        newValue: newTask.description.isNotEmpty ? newTask.description : null,
      ));
    }

    if (oldTask.statusId != newTask.statusId) {
      changes.add(TodoAuditFieldChange(
        field: 'statusId',
        previousValue: oldTask.statusId,
        newValue: newTask.statusId,
      ));
    }

    if (oldTask.priority != newTask.priority) {
      changes.add(TodoAuditFieldChange(
        field: 'priority',
        previousValue: oldTask.priority.name,
        newValue: newTask.priority.name,
      ));
    }

    // Compare assignedTo lists
    final oldAssigned = Set<String>.from(oldTask.assignedTo);
    final newAssigned = Set<String>.from(newTask.assignedTo);
    if (!_setsEqual(oldAssigned, newAssigned)) {
      changes.add(TodoAuditFieldChange(
        field: 'assignedTo',
        previousValue: oldTask.assignedTo.isNotEmpty ? oldTask.assignedTo : null,
        newValue: newTask.assignedTo.isNotEmpty ? newTask.assignedTo : null,
      ));
    }

    // Compare tags by ID set
    final oldTagIds = oldTask.tags.map((t) => t.id).toSet();
    final newTagIds = newTask.tags.map((t) => t.id).toSet();
    if (!_setsEqual(oldTagIds, newTagIds)) {
      changes.add(TodoAuditFieldChange(
        field: 'tags',
        previousValue: oldTask.tags.map((t) => t.title).toList(),
        newValue: newTask.tags.map((t) => t.title).toList(),
      ));
    }

    // Compare dates
    if (_datesDiffer(oldTask.startDate, newTask.startDate)) {
      changes.add(TodoAuditFieldChange(
        field: 'startDate',
        previousValue: oldTask.startDate?.toIso8601String(),
        newValue: newTask.startDate?.toIso8601String(),
      ));
    }

    if (_datesDiffer(oldTask.dueDate, newTask.dueDate)) {
      changes.add(TodoAuditFieldChange(
        field: 'dueDate',
        previousValue: oldTask.dueDate?.toIso8601String(),
        newValue: newTask.dueDate?.toIso8601String(),
      ));
    }

    if (oldTask.effort != newTask.effort) {
      changes.add(TodoAuditFieldChange(
        field: 'effort',
        previousValue: oldTask.effort,
        newValue: newTask.effort,
      ));
    }

    // Compare subtasks by count and completion
    final oldCompleted = oldTask.subtasks.where((s) => s.isCompleted).length;
    final newCompleted = newTask.subtasks.where((s) => s.isCompleted).length;
    if (oldTask.subtasks.length != newTask.subtasks.length || oldCompleted != newCompleted) {
      changes.add(TodoAuditFieldChange(
        field: 'subtasks',
        previousValue: '${oldCompleted}/${oldTask.subtasks.length}',
        newValue: '${newCompleted}/${newTask.subtasks.length}',
      ));
    }

    // Compare comments count
    if (oldTask.comments.length != newTask.comments.length) {
      changes.add(TodoAuditFieldChange(
        field: 'comments',
        previousValue: oldTask.comments.length,
        newValue: newTask.comments.length,
      ));
    }

    // Compare attachments count
    if (oldTask.attachments.length != newTask.attachments.length) {
      changes.add(TodoAuditFieldChange(
        field: 'attachments',
        previousValue: oldTask.attachments.length,
        newValue: newTask.attachments.length,
      ));
    }

    return changes;
  }

  /// Determina l'azione audit specifica in base ai cambiamenti rilevati.
  TodoAuditAction determineTaskAction(List<TodoAuditFieldChange> changes) {
    if (changes.any((c) => c.field == 'statusId')) return TodoAuditAction.move;
    if (changes.any((c) => c.field == 'assignedTo')) return TodoAuditAction.assign;
    return TodoAuditAction.update;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DELTA DETECTION - LIST
  // ═══════════════════════════════════════════════════════════════════════════

  /// Rileva le differenze tra due versioni di una lista.
  List<TodoAuditFieldChange> detectListChanges(TodoListModel oldList, TodoListModel newList) {
    final changes = <TodoAuditFieldChange>[];

    if (oldList.title != newList.title) {
      changes.add(TodoAuditFieldChange(
        field: 'title',
        previousValue: oldList.title,
        newValue: newList.title,
      ));
    }

    if (oldList.description != newList.description) {
      changes.add(TodoAuditFieldChange(
        field: 'description',
        previousValue: oldList.description.isNotEmpty ? oldList.description : null,
        newValue: newList.description.isNotEmpty ? newList.description : null,
      ));
    }

    // Compare columns
    final oldColIds = oldList.columns.map((c) => c.id).toSet();
    final newColIds = newList.columns.map((c) => c.id).toSet();
    if (!_setsEqual(oldColIds, newColIds)) {
      changes.add(TodoAuditFieldChange(
        field: 'columns',
        previousValue: oldList.columns.map((c) => c.title).toList(),
        newValue: newList.columns.map((c) => c.title).toList(),
      ));
    } else {
      // Check if column properties changed (title, color, sort)
      for (final newCol in newList.columns) {
        final oldCol = oldList.columns.firstWhere((c) => c.id == newCol.id, orElse: () => newCol);
        if (oldCol.title != newCol.title || oldCol.colorValue != newCol.colorValue || oldCol.sortBy != newCol.sortBy) {
          changes.add(TodoAuditFieldChange(
            field: 'columns',
            previousValue: '${oldCol.title} (${oldCol.sortBy.name})',
            newValue: '${newCol.title} (${newCol.sortBy.name})',
          ));
          break;
        }
      }
    }

    // Compare available tags
    final oldTagIds = oldList.availableTags.map((t) => t.id).toSet();
    final newTagIds = newList.availableTags.map((t) => t.id).toSet();
    if (!_setsEqual(oldTagIds, newTagIds)) {
      changes.add(TodoAuditFieldChange(
        field: 'availableTags',
        previousValue: oldList.availableTags.map((t) => t.title).toList(),
        newValue: newList.availableTags.map((t) => t.title).toList(),
      ));
    }

    // Compare participants
    final oldParticipants = oldList.participants.keys.toSet();
    final newParticipants = newList.participants.keys.toSet();
    if (!_setsEqual(oldParticipants, newParticipants)) {
      changes.add(TodoAuditFieldChange(
        field: 'participants',
        previousValue: oldParticipants.toList(),
        newValue: newParticipants.toList(),
      ));
    }

    return changes;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // READ (paginato)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Recupera i log di audit con paginazione e filtri server-side dove possibile.
  Future<List<SmartTodoAuditLogModel>> getAuditLogs({
    required String listId,
    int limit = 50,
    DocumentSnapshot? startAfter,
    SmartTodoAuditLogFilter? filter,
  }) async {
    Query query = _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_auditSubcollection)
        .orderBy('timestamp', descending: true);

    // Server-side filters (Firestore supports equality filters with orderBy)
    if (filter?.performedBy != null) {
      query = query.where('performedByName', isEqualTo: filter!.performedBy);
    }
    if (filter?.entityType != null) {
      query = query.where('entityType', isEqualTo: filter!.entityType!.name);
    }
    if (filter?.action != null) {
      query = query.where('action', isEqualTo: filter!.action!.name);
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    // Fetch more than limit to account for client-side date/search filtering
    final fetchLimit = (filter?.fromDate != null || filter?.toDate != null || (filter?.searchQuery?.isNotEmpty ?? false))
        ? limit * 3
        : limit;

    final snapshot = await query.limit(fetchLimit).get();

    var logs = snapshot.docs
        .map((doc) => SmartTodoAuditLogModel.fromFirestore(doc))
        .toList();

    // Apply client-side filters (dates, search)
    if (filter != null && !filter.isEmpty) {
      logs = logs.where((log) => filter.matches(log)).toList();
    }

    return logs.take(limit).toList();
  }

  /// Ultimo DocumentSnapshot per paginazione cursor-based.
  Future<DocumentSnapshot?> getLastDocument({
    required String listId,
    int limit = 50,
    DocumentSnapshot? startAfter,
    SmartTodoAuditLogFilter? filter,
  }) async {
    Query query = _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_auditSubcollection)
        .orderBy('timestamp', descending: true);

    if (filter?.performedBy != null) {
      query = query.where('performedByName', isEqualTo: filter!.performedBy);
    }
    if (filter?.entityType != null) {
      query = query.where('entityType', isEqualTo: filter!.entityType!.name);
    }
    if (filter?.action != null) {
      query = query.where('action', isEqualTo: filter!.action!.name);
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.limit(limit).get();
    return snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  bool _setsEqual(Set a, Set b) {
    if (a.length != b.length) return false;
    return a.containsAll(b);
  }

  bool _datesDiffer(DateTime? a, DateTime? b) {
    if (a == null && b == null) return false;
    if (a == null || b == null) return true;
    // Compare by date only (ignore time precision differences)
    return a.year != b.year || a.month != b.month || a.day != b.day;
  }
}
