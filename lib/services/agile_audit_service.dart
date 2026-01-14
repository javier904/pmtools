import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/audit_log_model.dart';
import '../models/agile_enums.dart';

/// Servizio per la gestione dell'Audit Log
///
/// Registra tutte le operazioni di modifica per tracciabilità.
/// Pattern Singleton.
class AgileAuditService {
  // Singleton
  static final AgileAuditService _instance = AgileAuditService._internal();
  factory AgileAuditService() => _instance;
  AgileAuditService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection path
  static const String _projectsCollection = 'agile_projects';
  static const String _auditLogsSubcollection = 'audit_logs';

  // =========================================================================
  // REFERENCE
  // =========================================================================

  /// Ottiene la reference della subcollection audit_logs
  CollectionReference<Map<String, dynamic>> _auditLogsRef(String projectId) =>
      _firestore
          .collection(_projectsCollection)
          .doc(projectId)
          .collection(_auditLogsSubcollection);

  // =========================================================================
  // LOGGING
  // =========================================================================

  /// Registra un log generico
  Future<AuditLogModel> log(AuditLogModel auditLog) async {
    final docRef = _auditLogsRef(auditLog.projectId).doc();
    final logWithId = auditLog.copyWith(id: docRef.id);
    await docRef.set(logWithId.toFirestore());
    return logWithId;
  }

  /// Registra la creazione di un'entità
  Future<AuditLogModel> logCreate({
    required String projectId,
    required AuditEntityType entityType,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    Map<String, dynamic>? newValue,
    String? description,
  }) async {
    final auditLog = AuditLogModel.create(
      projectId: projectId,
      entityType: entityType,
      entityId: entityId,
      entityName: entityName,
      performedBy: performedBy,
      performedByName: performedByName,
      newValue: newValue,
      description: description,
    );
    return log(auditLog);
  }

  /// Registra l'aggiornamento di un'entità
  Future<AuditLogModel> logUpdate({
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
  }) async {
    final auditLog = AuditLogModel.update(
      projectId: projectId,
      entityType: entityType,
      entityId: entityId,
      entityName: entityName,
      performedBy: performedBy,
      performedByName: performedByName,
      previousValue: previousValue,
      newValue: newValue,
      description: description,
      changedFields: changedFields,
    );
    return log(auditLog);
  }

  /// Registra l'eliminazione di un'entità
  Future<AuditLogModel> logDelete({
    required String projectId,
    required AuditEntityType entityType,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    Map<String, dynamic>? previousValue,
    String? description,
  }) async {
    final auditLog = AuditLogModel.delete(
      projectId: projectId,
      entityType: entityType,
      entityId: entityId,
      entityName: entityName,
      performedBy: performedBy,
      performedByName: performedByName,
      previousValue: previousValue,
      description: description,
    );
    return log(auditLog);
  }

  /// Registra lo spostamento di una story
  Future<AuditLogModel> logMove({
    required String projectId,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    required String fromStatus,
    required String toStatus,
    String? fromSprintId,
    String? toSprintId,
  }) async {
    final auditLog = AuditLogModel.move(
      projectId: projectId,
      entityId: entityId,
      entityName: entityName,
      performedBy: performedBy,
      performedByName: performedByName,
      fromStatus: fromStatus,
      toStatus: toStatus,
      fromSprintId: fromSprintId,
      toSprintId: toSprintId,
    );
    return log(auditLog);
  }

  /// Registra una stima
  Future<AuditLogModel> logEstimate({
    required String projectId,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    required String estimationType,
    String? previousEstimate,
    required String newEstimate,
  }) async {
    final auditLog = AuditLogModel.estimate(
      projectId: projectId,
      entityId: entityId,
      entityName: entityName,
      performedBy: performedBy,
      performedByName: performedByName,
      estimationType: estimationType,
      previousEstimate: previousEstimate,
      newEstimate: newEstimate,
    );
    return log(auditLog);
  }

  /// Registra un'assegnazione
  Future<AuditLogModel> logAssign({
    required String projectId,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    String? previousAssignee,
    required String newAssignee,
  }) async {
    final auditLog = AuditLogModel.assign(
      projectId: projectId,
      entityId: entityId,
      entityName: entityName,
      performedBy: performedBy,
      performedByName: performedByName,
      previousAssignee: previousAssignee,
      newAssignee: newAssignee,
    );
    return log(auditLog);
  }

  /// Registra il completamento
  Future<AuditLogModel> logComplete({
    required String projectId,
    required AuditEntityType entityType,
    required String entityId,
    String? entityName,
    required String performedBy,
    required String performedByName,
    String? description,
  }) async {
    final auditLog = AuditLogModel.complete(
      projectId: projectId,
      entityType: entityType,
      entityId: entityId,
      entityName: entityName,
      performedBy: performedBy,
      performedByName: performedByName,
      description: description,
    );
    return log(auditLog);
  }

  /// Registra l'avvio di uno sprint
  Future<AuditLogModel> logSprintStart({
    required String projectId,
    required String sprintId,
    required String sprintName,
    required String performedBy,
    required String performedByName,
    required int storyCount,
    required int plannedPoints,
  }) async {
    final auditLog = AuditLogModel.startSprint(
      projectId: projectId,
      sprintId: sprintId,
      sprintName: sprintName,
      performedBy: performedBy,
      performedByName: performedByName,
      storyCount: storyCount,
      plannedPoints: plannedPoints,
    );
    return log(auditLog);
  }

  /// Registra la chiusura di uno sprint
  Future<AuditLogModel> logSprintClose({
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
  }) async {
    final auditLog = AuditLogModel.closeSprint(
      projectId: projectId,
      sprintId: sprintId,
      sprintName: sprintName,
      performedBy: performedBy,
      performedByName: performedByName,
      completedStories: completedStories,
      totalStories: totalStories,
      completedPoints: completedPoints,
      plannedPoints: plannedPoints,
      velocity: velocity,
    );
    return log(auditLog);
  }

  /// Registra un invito
  Future<AuditLogModel> logInvite({
    required String projectId,
    required String inviteeEmail,
    required String role,
    required String performedBy,
    required String performedByName,
  }) async {
    final auditLog = AuditLogModel.invite(
      projectId: projectId,
      inviteeEmail: inviteeEmail,
      role: role,
      performedBy: performedBy,
      performedByName: performedByName,
    );
    return log(auditLog);
  }

  /// Registra il join al team
  Future<AuditLogModel> logJoin({
    required String projectId,
    required String userEmail,
    required String userName,
    required String role,
  }) async {
    final auditLog = AuditLogModel.join(
      projectId: projectId,
      userEmail: userEmail,
      userName: userName,
      role: role,
    );
    return log(auditLog);
  }

  /// Registra l'uscita dal team
  Future<AuditLogModel> logLeave({
    required String projectId,
    required String userEmail,
    required String userName,
    required String performedBy,
    required String performedByName,
  }) async {
    final auditLog = AuditLogModel.leave(
      projectId: projectId,
      userEmail: userEmail,
      userName: userName,
      performedBy: performedBy,
      performedByName: performedByName,
    );
    return log(auditLog);
  }

  // =========================================================================
  // QUERY
  // =========================================================================

  /// Ottiene i log di un progetto
  Future<List<AuditLogModel>> getProjectLogs(
    String projectId, {
    int? limit,
    AuditLogFilter? filter,
  }) async {
    Query<Map<String, dynamic>> query = _auditLogsRef(projectId)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    var logs =
        snapshot.docs.map((doc) => AuditLogModel.fromFirestore(doc)).toList();

    // Applica filtri lato client
    if (filter != null) {
      logs = logs.where((log) => filter.matches(log)).toList();
    }

    return logs;
  }

  /// Stream dei log di un progetto
  Stream<List<AuditLogModel>> streamProjectLogs(
    String projectId, {
    int? limit,
  }) {
    Query<Map<String, dynamic>> query = _auditLogsRef(projectId)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => AuditLogModel.fromFirestore(doc)).toList());
  }

  /// Ottiene i log di un'entità specifica
  Future<List<AuditLogModel>> getEntityLogs(
    String projectId,
    String entityId, {
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _auditLogsRef(projectId)
        .where('entityId', isEqualTo: entityId)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => AuditLogModel.fromFirestore(doc)).toList();
  }

  /// Ottiene i log di un utente
  Future<List<AuditLogModel>> getUserLogs(
    String projectId,
    String userEmail, {
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _auditLogsRef(projectId)
        .where('performedBy', isEqualTo: userEmail)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => AuditLogModel.fromFirestore(doc)).toList();
  }

  /// Ottiene i log per tipo di entità
  Future<List<AuditLogModel>> getLogsByEntityType(
    String projectId,
    AuditEntityType entityType, {
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _auditLogsRef(projectId)
        .where('entityType', isEqualTo: entityType.name)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => AuditLogModel.fromFirestore(doc)).toList();
  }

  /// Ottiene i log per tipo di azione
  Future<List<AuditLogModel>> getLogsByAction(
    String projectId,
    AuditAction action, {
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _auditLogsRef(projectId)
        .where('action', isEqualTo: action.name)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => AuditLogModel.fromFirestore(doc)).toList();
  }

  /// Ottiene i log in un intervallo di date
  Future<List<AuditLogModel>> getLogsByDateRange(
    String projectId, {
    required DateTime fromDate,
    required DateTime toDate,
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _auditLogsRef(projectId)
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(fromDate))
        .where('timestamp', isLessThanOrEqualTo: Timestamp.fromDate(toDate))
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => AuditLogModel.fromFirestore(doc)).toList();
  }

  // =========================================================================
  // STATISTICS
  // =========================================================================

  /// Conta i log per tipo di azione
  Future<Map<AuditAction, int>> getActionCounts(String projectId) async {
    final logs = await getProjectLogs(projectId);
    final counts = <AuditAction, int>{};

    for (final action in AuditAction.values) {
      counts[action] = logs.where((l) => l.action == action).length;
    }

    return counts;
  }

  /// Conta i log per tipo di entità
  Future<Map<AuditEntityType, int>> getEntityTypeCounts(
      String projectId) async {
    final logs = await getProjectLogs(projectId);
    final counts = <AuditEntityType, int>{};

    for (final type in AuditEntityType.values) {
      counts[type] = logs.where((l) => l.entityType == type).length;
    }

    return counts;
  }

  /// Conta i log per utente
  Future<Map<String, int>> getUserActivityCounts(String projectId) async {
    final logs = await getProjectLogs(projectId);
    final counts = <String, int>{};

    for (final log in logs) {
      counts[log.performedBy] = (counts[log.performedBy] ?? 0) + 1;
    }

    return counts;
  }

  /// Ottiene l'attività recente (ultime 24 ore)
  Future<List<AuditLogModel>> getRecentActivity(
    String projectId, {
    int hours = 24,
  }) async {
    final fromDate = DateTime.now().subtract(Duration(hours: hours));
    return getLogsByDateRange(
      projectId,
      fromDate: fromDate,
      toDate: DateTime.now(),
    );
  }
}
