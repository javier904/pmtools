import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Tipo di entità tracciata nell'audit log
enum TodoAuditEntityType {
  list,
  task,
  invite,
  participant,
  column,
  tag;

  String get displayName {
    switch (this) {
      case TodoAuditEntityType.list: return 'Lista';
      case TodoAuditEntityType.task: return 'Task';
      case TodoAuditEntityType.invite: return 'Invito';
      case TodoAuditEntityType.participant: return 'Partecipante';
      case TodoAuditEntityType.column: return 'Colonna';
      case TodoAuditEntityType.tag: return 'Tag';
    }
  }

  IconData get icon {
    switch (this) {
      case TodoAuditEntityType.list: return Icons.list_alt;
      case TodoAuditEntityType.task: return Icons.task_alt;
      case TodoAuditEntityType.invite: return Icons.mail_outline;
      case TodoAuditEntityType.participant: return Icons.person;
      case TodoAuditEntityType.column: return Icons.view_column;
      case TodoAuditEntityType.tag: return Icons.label;
    }
  }
}

/// Azione tracciata nell'audit log
enum TodoAuditAction {
  create,
  update,
  delete,
  archive,
  restore,
  move,         // cambio statusId (colonna)
  assign,       // cambio assignedTo
  invite,
  join,
  revoke,
  reorder,      // cambio position
  batchCreate;  // import multiplo

  String get displayName {
    switch (this) {
      case TodoAuditAction.create: return 'Creato';
      case TodoAuditAction.update: return 'Modificato';
      case TodoAuditAction.delete: return 'Eliminato';
      case TodoAuditAction.archive: return 'Archiviato';
      case TodoAuditAction.restore: return 'Ripristinato';
      case TodoAuditAction.move: return 'Spostato';
      case TodoAuditAction.assign: return 'Assegnato';
      case TodoAuditAction.invite: return 'Invitato';
      case TodoAuditAction.join: return 'Entrato';
      case TodoAuditAction.revoke: return 'Revocato';
      case TodoAuditAction.reorder: return 'Riordinato';
      case TodoAuditAction.batchCreate: return 'Import';
    }
  }

  IconData get icon {
    switch (this) {
      case TodoAuditAction.create: return Icons.add_circle;
      case TodoAuditAction.update: return Icons.edit;
      case TodoAuditAction.delete: return Icons.delete;
      case TodoAuditAction.archive: return Icons.archive;
      case TodoAuditAction.restore: return Icons.unarchive;
      case TodoAuditAction.move: return Icons.swap_horiz;
      case TodoAuditAction.assign: return Icons.person_add;
      case TodoAuditAction.invite: return Icons.mail;
      case TodoAuditAction.join: return Icons.login;
      case TodoAuditAction.revoke: return Icons.block;
      case TodoAuditAction.reorder: return Icons.reorder;
      case TodoAuditAction.batchCreate: return Icons.playlist_add;
    }
  }

  Color get color {
    switch (this) {
      case TodoAuditAction.create: return const Color(0xFF43A047);
      case TodoAuditAction.update: return const Color(0xFF1976D2);
      case TodoAuditAction.delete: return const Color(0xFFE53935);
      case TodoAuditAction.archive: return const Color(0xFF9E9E9E);
      case TodoAuditAction.restore: return const Color(0xFF43A047);
      case TodoAuditAction.move: return const Color(0xFF7B1FA2);
      case TodoAuditAction.assign: return const Color(0xFFFB8C00);
      case TodoAuditAction.invite: return const Color(0xFF1976D2);
      case TodoAuditAction.join: return const Color(0xFF43A047);
      case TodoAuditAction.revoke: return const Color(0xFFE53935);
      case TodoAuditAction.reorder: return const Color(0xFF00ACC1);
      case TodoAuditAction.batchCreate: return const Color(0xFF43A047);
    }
  }
}

/// Singolo campo modificato
class TodoAuditFieldChange {
  final String field;
  final dynamic previousValue;
  final dynamic newValue;

  const TodoAuditFieldChange({
    required this.field,
    this.previousValue,
    this.newValue,
  });

  Map<String, dynamic> toMap() => {
    'field': field,
    if (previousValue != null) 'previousValue': previousValue,
    if (newValue != null) 'newValue': newValue,
  };

  factory TodoAuditFieldChange.fromMap(Map<String, dynamic> map) {
    return TodoAuditFieldChange(
      field: map['field'] ?? '',
      previousValue: map['previousValue'],
      newValue: map['newValue'],
    );
  }

  /// Formatta il nome del campo per visualizzazione
  String get fieldDisplayName {
    switch (field) {
      case 'title': return 'Titolo';
      case 'description': return 'Descrizione';
      case 'statusId': return 'Stato';
      case 'priority': return 'Priorità';
      case 'assignedTo': return 'Assegnato a';
      case 'tags': return 'Tag';
      case 'startDate': return 'Data inizio';
      case 'dueDate': return 'Scadenza';
      case 'effort': return 'Effort';
      case 'subtasks': return 'Subtask';
      case 'comments': return 'Commenti';
      case 'attachments': return 'Allegati';
      case 'columns': return 'Colonne';
      case 'availableTags': return 'Tag disponibili';
      case 'participants': return 'Partecipanti';
      case 'position': return 'Posizione';
      default: return field;
    }
  }
}

/// Entry dell'audit log
class SmartTodoAuditLogModel {
  final String id;
  final String listId;
  final TodoAuditEntityType entityType;
  final String entityId;
  final String? entityName;
  final TodoAuditAction action;
  final String performedBy;
  final String performedByName;
  final DateTime timestamp;
  final List<TodoAuditFieldChange> changes;
  final Map<String, dynamic>? metadata;
  final String? description;

  const SmartTodoAuditLogModel({
    required this.id,
    required this.listId,
    required this.entityType,
    required this.entityId,
    this.entityName,
    required this.action,
    required this.performedBy,
    required this.performedByName,
    required this.timestamp,
    this.changes = const [],
    this.metadata,
    this.description,
  });

  Map<String, dynamic> toFirestore() => {
    'listId': listId,
    'entityType': entityType.name,
    'entityId': entityId,
    if (entityName != null) 'entityName': entityName,
    'action': action.name,
    'performedBy': performedBy,
    'performedByName': performedByName,
    'timestamp': Timestamp.fromDate(timestamp),
    'changes': changes.map((c) => c.toMap()).toList(),
    if (metadata != null) 'metadata': metadata,
    if (description != null) 'description': description,
  };

  factory SmartTodoAuditLogModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return SmartTodoAuditLogModel(
      id: doc.id,
      listId: data['listId'] ?? '',
      entityType: TodoAuditEntityType.values.firstWhere(
        (e) => e.name == data['entityType'],
        orElse: () => TodoAuditEntityType.task,
      ),
      entityId: data['entityId'] ?? '',
      entityName: data['entityName'],
      action: TodoAuditAction.values.firstWhere(
        (a) => a.name == data['action'],
        orElse: () => TodoAuditAction.update,
      ),
      performedBy: data['performedBy'] ?? '',
      performedByName: data['performedByName'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      changes: (data['changes'] as List?)
          ?.map((c) => TodoAuditFieldChange.fromMap(c as Map<String, dynamic>))
          .toList() ?? [],
      metadata: data['metadata'] as Map<String, dynamic>?,
      description: data['description'],
    );
  }

  /// Formatta il timestamp per la visualizzazione
  String get formattedTimestamp {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return 'Adesso';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min fa';
    if (diff.inHours < 24) return '${diff.inHours} ore fa';
    if (diff.inDays < 7) return '${diff.inDays} giorni fa';

    return '${timestamp.day.toString().padLeft(2, '0')}/${timestamp.month.toString().padLeft(2, '0')}/${timestamp.year} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  /// Descrizione completa per UI
  String get fullDescription {
    if (description != null && description!.isNotEmpty) return description!;
    final entityDesc = entityName ?? entityId;
    return '$performedByName ${action.displayName.toLowerCase()} ${entityType.displayName.toLowerCase()} "$entityDesc"';
  }
}

/// Filtri per la ricerca nell'audit log
class SmartTodoAuditLogFilter {
  final TodoAuditEntityType? entityType;
  final TodoAuditAction? action;
  final String? performedBy;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? searchQuery;

  const SmartTodoAuditLogFilter({
    this.entityType,
    this.action,
    this.performedBy,
    this.fromDate,
    this.toDate,
    this.searchQuery,
  });

  bool get isEmpty =>
      entityType == null &&
      action == null &&
      performedBy == null &&
      fromDate == null &&
      toDate == null &&
      (searchQuery == null || searchQuery!.isEmpty);

  /// Verifica se un log passa il filtro (client-side)
  bool matches(SmartTodoAuditLogModel log) {
    if (entityType != null && log.entityType != entityType) return false;
    if (action != null && log.action != action) return false;
    if (performedBy != null && log.performedBy != performedBy) return false;
    if (fromDate != null && log.timestamp.isBefore(fromDate!)) return false;
    if (toDate != null && log.timestamp.isAfter(toDate!.add(const Duration(days: 1)))) return false;

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      final matchesEntity = log.entityName?.toLowerCase().contains(query) ?? false;
      final matchesDesc = log.description?.toLowerCase().contains(query) ?? false;
      final matchesUser = log.performedByName.toLowerCase().contains(query);
      if (!matchesEntity && !matchesDesc && !matchesUser) return false;
    }

    return true;
  }

  SmartTodoAuditLogFilter copyWith({
    TodoAuditEntityType? entityType,
    TodoAuditAction? action,
    String? performedBy,
    DateTime? fromDate,
    DateTime? toDate,
    String? searchQuery,
    bool clearEntityType = false,
    bool clearAction = false,
    bool clearPerformedBy = false,
    bool clearFromDate = false,
    bool clearToDate = false,
  }) {
    return SmartTodoAuditLogFilter(
      entityType: clearEntityType ? null : (entityType ?? this.entityType),
      action: clearAction ? null : (action ?? this.action),
      performedBy: clearPerformedBy ? null : (performedBy ?? this.performedBy),
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
