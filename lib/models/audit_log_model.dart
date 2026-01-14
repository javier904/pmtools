import 'package:cloud_firestore/cloud_firestore.dart';
import 'agile_enums.dart';

/// Modello per un entry dell'audit log
///
/// Registra tutte le operazioni di modifica/salvataggio
/// per tracciabilità e compliance.
class AuditLogModel {
  final String id;
  final String projectId;
  final AuditEntityType entityType;
  final String entityId;
  final String? entityName; // Nome leggibile dell'entità
  final AuditAction action;
  final String performedBy; // Email dell'utente
  final String performedByName; // Nome dell'utente
  final DateTime timestamp;
  final Map<String, dynamic>? previousValue; // Stato precedente
  final Map<String, dynamic>? newValue; // Nuovo stato
  final String? description; // Descrizione human-readable
  final Map<String, dynamic>? metadata; // Metadata aggiuntivi

  const AuditLogModel({
    required this.id,
    required this.projectId,
    required this.entityType,
    required this.entityId,
    this.entityName,
    required this.action,
    required this.performedBy,
    required this.performedByName,
    required this.timestamp,
    this.previousValue,
    this.newValue,
    this.description,
    this.metadata,
  });

  /// Crea da documento Firestore
  factory AuditLogModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return AuditLogModel.fromMap(doc.id, data);
  }

  /// Crea da mappa
  factory AuditLogModel.fromMap(String id, Map<String, dynamic> data) {
    return AuditLogModel(
      id: id,
      projectId: data['projectId'] ?? '',
      entityType: AuditEntityType.values.firstWhere(
        (e) => e.name == data['entityType'],
        orElse: () => AuditEntityType.project,
      ),
      entityId: data['entityId'] ?? '',
      entityName: data['entityName'],
      action: AuditAction.values.firstWhere(
        (a) => a.name == data['action'],
        orElse: () => AuditAction.update,
      ),
      performedBy: data['performedBy'] ?? '',
      performedByName: data['performedByName'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      previousValue: data['previousValue'] as Map<String, dynamic>?,
      newValue: data['newValue'] as Map<String, dynamic>?,
      description: data['description'],
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Converte per Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'projectId': projectId,
      'entityType': entityType.name,
      'entityId': entityId,
      if (entityName != null) 'entityName': entityName,
      'action': action.name,
      'performedBy': performedBy,
      'performedByName': performedByName,
      'timestamp': Timestamp.fromDate(timestamp),
      if (previousValue != null) 'previousValue': previousValue,
      if (newValue != null) 'newValue': newValue,
      if (description != null) 'description': description,
      if (metadata != null) 'metadata': metadata,
    };
  }

  /// Copia con modifiche
  AuditLogModel copyWith({
    String? id,
    String? projectId,
    AuditEntityType? entityType,
    String? entityId,
    String? entityName,
    AuditAction? action,
    String? performedBy,
    String? performedByName,
    DateTime? timestamp,
    Map<String, dynamic>? previousValue,
    Map<String, dynamic>? newValue,
    String? description,
    Map<String, dynamic>? metadata,
  }) {
    return AuditLogModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      entityName: entityName ?? this.entityName,
      action: action ?? this.action,
      performedBy: performedBy ?? this.performedBy,
      performedByName: performedByName ?? this.performedByName,
      timestamp: timestamp ?? this.timestamp,
      previousValue: previousValue ?? this.previousValue,
      newValue: newValue ?? this.newValue,
      description: description ?? this.description,
      metadata: metadata ?? this.metadata,
    );
  }

  // =========================================================================
  // Factory methods per azioni comuni
  // =========================================================================

  /// Crea log per creazione entità
  factory AuditLogModel.create({
    required String projectId,
    required AuditEntityType entityType,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    Map<String, dynamic>? newValue,
    String? description,
  }) {
    return AuditLogModel(
      id: '', // Sarà generato da Firestore
      projectId: projectId,
      entityType: entityType,
      entityId: entityId,
      entityName: entityName,
      action: AuditAction.create,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      newValue: newValue,
      description: description ?? 'Creato ${entityType.displayName}',
    );
  }

  /// Crea log per aggiornamento entità
  factory AuditLogModel.update({
    required String projectId,
    required AuditEntityType entityType,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    Map<String, dynamic>? previousValue,
    Map<String, dynamic>? newValue,
    String? description,
    List<String>? changedFields,
  }) {
    String desc = description ?? 'Aggiornato ${entityType.displayName}';
    if (changedFields != null && changedFields.isNotEmpty) {
      desc = 'Aggiornato: ${changedFields.join(', ')}';
    }

    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: entityType,
      entityId: entityId,
      entityName: entityName,
      action: AuditAction.update,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      previousValue: previousValue,
      newValue: newValue,
      description: desc,
      metadata: changedFields != null ? {'changedFields': changedFields} : null,
    );
  }

  /// Crea log per eliminazione entità
  factory AuditLogModel.delete({
    required String projectId,
    required AuditEntityType entityType,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    Map<String, dynamic>? previousValue,
    String? description,
  }) {
    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: entityType,
      entityId: entityId,
      entityName: entityName,
      action: AuditAction.delete,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      previousValue: previousValue,
      description: description ?? 'Eliminato ${entityType.displayName}',
    );
  }

  /// Crea log per spostamento story
  factory AuditLogModel.move({
    required String projectId,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    required String fromStatus,
    required String toStatus,
    String? fromSprintId,
    String? toSprintId,
  }) {
    String desc = 'Spostato da $fromStatus a $toStatus';
    if (fromSprintId != null || toSprintId != null) {
      desc = 'Spostato tra sprint';
    }

    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: AuditEntityType.story,
      entityId: entityId,
      entityName: entityName,
      action: AuditAction.move,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      previousValue: {
        'status': fromStatus,
        if (fromSprintId != null) 'sprintId': fromSprintId,
      },
      newValue: {
        'status': toStatus,
        if (toSprintId != null) 'sprintId': toSprintId,
      },
      description: desc,
    );
  }

  /// Crea log per stima story
  factory AuditLogModel.estimate({
    required String projectId,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    required String estimationType,
    String? previousEstimate,
    required String newEstimate,
  }) {
    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: AuditEntityType.story,
      entityId: entityId,
      entityName: entityName,
      action: AuditAction.estimate,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      previousValue: previousEstimate != null
          ? {'storyPoints': previousEstimate}
          : null,
      newValue: {'storyPoints': newEstimate, 'estimationType': estimationType},
      description: 'Stimato $newEstimate punti ($estimationType)',
    );
  }

  /// Crea log per assegnazione
  factory AuditLogModel.assign({
    required String projectId,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    String? previousAssignee,
    required String newAssignee,
  }) {
    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: AuditEntityType.story,
      entityId: entityId,
      entityName: entityName,
      action: AuditAction.assign,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      previousValue: previousAssignee != null
          ? {'assigneeEmail': previousAssignee}
          : null,
      newValue: {'assigneeEmail': newAssignee},
      description: 'Assegnato a $newAssignee',
    );
  }

  /// Crea log per completamento
  factory AuditLogModel.complete({
    required String projectId,
    required AuditEntityType entityType,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    String? description,
  }) {
    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: entityType,
      entityId: entityId,
      entityName: entityName,
      action: AuditAction.complete,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      description: description ?? 'Completato ${entityType.displayName}',
    );
  }

  /// Crea log per avvio sprint
  factory AuditLogModel.startSprint({
    required String projectId,
    required String sprintId,
    required String sprintName,
    required String performedBy,
    required String performedByName,
    required int storyCount,
    required int plannedPoints,
  }) {
    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: AuditEntityType.sprint,
      entityId: sprintId,
      entityName: sprintName,
      action: AuditAction.start,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      newValue: {
        'storyCount': storyCount,
        'plannedPoints': plannedPoints,
      },
      description: 'Avviato sprint con $storyCount stories ($plannedPoints punti)',
    );
  }

  /// Crea log per chiusura sprint
  factory AuditLogModel.closeSprint({
    required String projectId,
    required String sprintId,
    required String sprintName,
    required String performedBy,
    required String performedByName,
    required int completedStories,
    required int totalStories,
    required int completedPoints,
    required int plannedPoints,
    required double velocity,
  }) {
    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: AuditEntityType.sprint,
      entityId: sprintId,
      entityName: sprintName,
      action: AuditAction.close,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      newValue: {
        'completedStories': completedStories,
        'totalStories': totalStories,
        'completedPoints': completedPoints,
        'plannedPoints': plannedPoints,
        'velocity': velocity,
      },
      description:
          'Chiuso sprint: $completedStories/$totalStories stories, velocity $velocity',
    );
  }

  /// Crea log per invito
  factory AuditLogModel.invite({
    required String projectId,
    required String inviteeEmail,
    required String role,
    required String performedBy,
    required String performedByName,
  }) {
    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: AuditEntityType.team,
      entityId: inviteeEmail,
      entityName: inviteeEmail,
      action: AuditAction.invite,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      newValue: {'email': inviteeEmail, 'role': role},
      description: 'Invitato $inviteeEmail come $role',
    );
  }

  /// Crea log per join team
  factory AuditLogModel.join({
    required String projectId,
    required String userEmail,
    required String userName,
    required String role,
  }) {
    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: AuditEntityType.team,
      entityId: userEmail,
      entityName: userName,
      action: AuditAction.join,
      performedBy: userEmail,
      performedByName: userName,
      timestamp: DateTime.now(),
      newValue: {'role': role},
      description: '$userName è entrato nel team come $role',
    );
  }

  /// Crea log per leave team
  factory AuditLogModel.leave({
    required String projectId,
    required String userEmail,
    required String userName,
    required String performedBy,
    required String performedByName,
  }) {
    return AuditLogModel(
      id: '',
      projectId: projectId,
      entityType: AuditEntityType.team,
      entityId: userEmail,
      entityName: userName,
      action: AuditAction.leave,
      performedBy: performedBy,
      performedByName: performedByName,
      timestamp: DateTime.now(),
      description: performedBy == userEmail
          ? '$userName ha lasciato il team'
          : '$userName è stato rimosso dal team',
    );
  }

  // =========================================================================
  // Helper
  // =========================================================================

  /// Ottiene i campi modificati confrontando previousValue e newValue
  List<String> get changedFields {
    if (previousValue == null || newValue == null) return [];

    final changed = <String>[];
    for (final key in newValue!.keys) {
      if (!previousValue!.containsKey(key) ||
          previousValue![key] != newValue![key]) {
        changed.add(key);
      }
    }
    return changed;
  }

  /// Formatta il timestamp per la visualizzazione
  String get formattedTimestamp {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return 'Adesso';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min fa';
    if (diff.inHours < 24) return '${diff.inHours} ore fa';
    if (diff.inDays < 7) return '${diff.inDays} giorni fa';

    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  /// Descrizione completa per UI
  String get fullDescription {
    if (description != null) return description!;

    final entityDesc = entityName ?? entityId;
    return '${performedByName} ${action.displayName.toLowerCase()} ${entityType.displayName.toLowerCase()} "$entityDesc"';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuditLogModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'AuditLogModel(id: $id, action: $action, entity: $entityType/$entityId)';
}

/// Filtri per la ricerca nell'audit log
class AuditLogFilter {
  final List<AuditEntityType>? entityTypes;
  final List<AuditAction>? actions;
  final String? performedBy;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? searchQuery;

  const AuditLogFilter({
    this.entityTypes,
    this.actions,
    this.performedBy,
    this.fromDate,
    this.toDate,
    this.searchQuery,
  });

  /// Verifica se un log passa il filtro
  bool matches(AuditLogModel log) {
    if (entityTypes != null &&
        entityTypes!.isNotEmpty &&
        !entityTypes!.contains(log.entityType)) {
      return false;
    }

    if (actions != null &&
        actions!.isNotEmpty &&
        !actions!.contains(log.action)) {
      return false;
    }

    if (performedBy != null && log.performedBy != performedBy) {
      return false;
    }

    if (fromDate != null && log.timestamp.isBefore(fromDate!)) {
      return false;
    }

    if (toDate != null && log.timestamp.isAfter(toDate!)) {
      return false;
    }

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      final matchesEntity = log.entityName?.toLowerCase().contains(query) ?? false;
      final matchesDescription =
          log.description?.toLowerCase().contains(query) ?? false;
      final matchesUser = log.performedByName.toLowerCase().contains(query);
      if (!matchesEntity && !matchesDescription && !matchesUser) {
        return false;
      }
    }

    return true;
  }

  /// Crea una copia con modifiche
  AuditLogFilter copyWith({
    List<AuditEntityType>? entityTypes,
    List<AuditAction>? actions,
    String? performedBy,
    DateTime? fromDate,
    DateTime? toDate,
    String? searchQuery,
  }) {
    return AuditLogFilter(
      entityTypes: entityTypes ?? this.entityTypes,
      actions: actions ?? this.actions,
      performedBy: performedBy ?? this.performedBy,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
