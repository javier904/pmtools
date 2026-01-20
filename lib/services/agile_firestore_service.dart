import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/agile_project_model.dart';
import '../models/agile_enums.dart';
import '../models/team_member_model.dart';
import '../models/user_story_model.dart';
import '../models/sprint_model.dart';
import '../models/retrospective_model.dart';

/// Servizio Firestore per Agile Process Manager
///
/// Pattern Singleton per gestione centralizzata delle operazioni CRUD.
/// Basato su EisenhowerFirestoreService.
class AgileFirestoreService {
  // Singleton
  static final AgileFirestoreService _instance =
      AgileFirestoreService._internal();
  factory AgileFirestoreService() => _instance;
  AgileFirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection names
  static const String _projectsCollection = 'agile_projects';
  static const String _storiesSubcollection = 'stories';
  static const String _sprintsSubcollection = 'sprints';
  static const String _retrospectivesSubcollection = 'retrospectives';
  static const String _auditLogsSubcollection = 'audit_logs';
  static const String _invitesCollection = 'agile_invites';

  // =========================================================================
  // PROJECTS CRUD
  // =========================================================================

  /// Ottiene la reference della collection progetti
  CollectionReference<Map<String, dynamic>> get _projectsRef =>
      _firestore.collection(_projectsCollection);

  /// Crea un nuovo progetto
  Future<AgileProjectModel> createProject({
    required String name,
    required String description,
    required String createdBy,
    required String createdByName,
    AgileFramework framework = AgileFramework.scrum,
    int sprintDurationDays = 14,
    int workingHoursPerDay = 8,
    String? productOwnerEmail,
    String? scrumMasterEmail,
  }) async {
    final now = DateTime.now();

    // Crea il documento
    final docRef = _projectsRef.doc();

    // Crea il partecipante owner
    final owner = TeamMemberModel(
      email: createdBy.toLowerCase(),
      name: createdByName,
      participantRole: AgileParticipantRole.owner,
      teamRole: TeamRole.productOwner,
      joinedAt: now,
      isOnline: true,
      lastActivity: now,
    );

    final project = AgileProjectModel(
      id: docRef.id,
      name: name,
      description: description,
      createdBy: createdBy.toLowerCase(),
      createdAt: now,
      updatedAt: now,
      framework: framework,
      sprintDurationDays: sprintDurationDays,
      workingHoursPerDay: workingHoursPerDay,
      participants: {createdBy: owner},
      productOwnerEmail: productOwnerEmail,
      scrumMasterEmail: scrumMasterEmail,
    );

    await docRef.set(project.toFirestore());
    return project;
  }

  /// Ottiene un progetto per ID
  Future<AgileProjectModel?> getProject(String projectId) async {
    final doc = await _projectsRef.doc(projectId).get();
    if (!doc.exists) return null;
    return AgileProjectModel.fromFirestore(doc);
  }

  /// Stream di un progetto
  Stream<AgileProjectModel?> streamProject(String projectId) {
    return _projectsRef.doc(projectId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return AgileProjectModel.fromFirestore(doc);
    });
  }

  /// Lista progetti di un utente
  Future<List<AgileProjectModel>> getUserProjects(String userEmail) async {
    final query = await _projectsRef
        .where('participantEmails', arrayContains: userEmail.toLowerCase())
        .orderBy('updatedAt', descending: true)
        .get();

    return query.docs.map((doc) => AgileProjectModel.fromFirestore(doc)).toList();
  }

  /// Stream dei progetti di un utente
  Stream<List<AgileProjectModel>> streamUserProjects(String userEmail) {
    return _projectsRef
        .where('participantEmails', arrayContains: userEmail.toLowerCase())
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => AgileProjectModel.fromFirestore(doc)).toList());
  }

  /// Aggiorna un progetto
  Future<void> updateProject(AgileProjectModel project) async {
    await _projectsRef.doc(project.id).update({
      ...project.toFirestore(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Aggiorna campi specifici di un progetto
  Future<void> updateProjectFields(
    String projectId,
    Map<String, dynamic> fields,
  ) async {
    await _projectsRef.doc(projectId).update({
      ...fields,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Elimina un progetto
  Future<void> deleteProject(String projectId) async {
    // Elimina tutte le subcollection
    await _deleteAllStories(projectId);
    await _deleteAllSprints(projectId);
    await _deleteAllRetrospectives(projectId);
    await _deleteAllAuditLogs(projectId);

    // Elimina il progetto
    await _projectsRef.doc(projectId).delete();
  }

  // =========================================================================
  // PARTICIPANTS
  // =========================================================================

  /// Aggiunge un partecipante al progetto
  Future<void> addParticipant(
    String projectId,
    TeamMemberModel participant,
  ) async {
    final escapedEmail = _escapeEmail(participant.email.toLowerCase());
    await _projectsRef.doc(projectId).update({
      'participants.$escapedEmail': participant.copyWith(email: participant.email.toLowerCase()).toFirestore(),
      'participantEmails': FieldValue.arrayUnion([participant.email.toLowerCase()]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Rimuove un partecipante dal progetto
  Future<void> removeParticipant(String projectId, String email) async {
    final escapedEmail = _escapeEmail(email.toLowerCase());
    await _projectsRef.doc(projectId).update({
      'participants.$escapedEmail': FieldValue.delete(),
      'participantEmails': FieldValue.arrayRemove([email.toLowerCase()]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Aggiorna un partecipante
  Future<void> updateParticipant(
    String projectId,
    TeamMemberModel participant,
  ) async {
    final escapedEmail = _escapeEmail(participant.email.toLowerCase());
    await _projectsRef.doc(projectId).update({
      'participants.$escapedEmail': participant.copyWith(email: participant.email.toLowerCase()).toFirestore(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Aggiunge un partecipante alla lista pending
  Future<void> addPendingParticipant(
    String projectId,
    String email,
  ) async {
    await _projectsRef.doc(projectId).update({
      'pendingEmails': FieldValue.arrayUnion([email.toLowerCase()]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Promuove un partecipante da pending ad attivo
  Future<void> promotePendingToActive(
    String projectId,
    TeamMemberModel participant,
  ) async {
    final escapedEmail = _escapeEmail(participant.email.toLowerCase());
    
    // Batch update atomico
    await _projectsRef.doc(projectId).update({
      'pendingEmails': FieldValue.arrayRemove([participant.email.toLowerCase()]),
      'participants.$escapedEmail': participant.copyWith(email: participant.email.toLowerCase()).toFirestore(),
      'participantEmails': FieldValue.arrayUnion([participant.email.toLowerCase()]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // =========================================================================
  // USER STORIES CRUD
  // =========================================================================

  /// Ottiene la reference della subcollection stories
  CollectionReference<Map<String, dynamic>> _storiesRef(String projectId) =>
      _projectsRef.doc(projectId).collection(_storiesSubcollection);

  /// Crea una nuova user story
  Future<UserStoryModel> createStory({
    required String projectId,
    required String title,
    required String description,
    required String createdBy,
    StoryPriority priority = StoryPriority.should,
    int businessValue = 5,
    List<String> tags = const [],
    List<String> acceptanceCriteria = const [],
  }) async {
    final docRef = _storiesRef(projectId).doc();

    // Ottieni l'ordine massimo attuale
    final maxOrderQuery = await _storiesRef(projectId)
        .orderBy('order', descending: true)
        .limit(1)
        .get();
    final maxOrder =
        maxOrderQuery.docs.isNotEmpty ? maxOrderQuery.docs.first['order'] as int : 0;

    final story = UserStoryModel(
      id: docRef.id,
      projectId: projectId,
      title: title,
      description: description,
      priority: priority,
      businessValue: businessValue,
      tags: tags,
      acceptanceCriteria: acceptanceCriteria,
      order: maxOrder + 1,
      createdAt: DateTime.now(),
      createdBy: createdBy,
    );

    await docRef.set(story.toFirestore());

    // Aggiorna backlog count
    await _projectsRef.doc(projectId).update({
      'backlogCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return story;
  }

  /// Ottiene una story per ID
  Future<UserStoryModel?> getStory(String projectId, String storyId) async {
    final doc = await _storiesRef(projectId).doc(storyId).get();
    if (!doc.exists) return null;
    return UserStoryModel.fromFirestore(doc);
  }

  /// Stream di una story
  Stream<UserStoryModel?> streamStory(String projectId, String storyId) {
    return _storiesRef(projectId).doc(storyId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserStoryModel.fromFirestore(doc);
    });
  }

  /// Lista tutte le stories di un progetto
  Future<List<UserStoryModel>> getProjectStories(String projectId) async {
    final query = await _storiesRef(projectId).orderBy('order').get();
    return query.docs.map((doc) => UserStoryModel.fromFirestore(doc)).toList();
  }

  /// Stream delle stories di un progetto
  Stream<List<UserStoryModel>> streamProjectStories(String projectId) {
    return _storiesRef(projectId).orderBy('order').snapshots().map(
          (query) =>
              query.docs.map((doc) => UserStoryModel.fromFirestore(doc)).toList(),
        );
  }

  /// Lista stories per status
  Future<List<UserStoryModel>> getStoriesByStatus(
    String projectId,
    StoryStatus status,
  ) async {
    final query = await _storiesRef(projectId)
        .where('status', isEqualTo: status.name)
        .orderBy('order')
        .get();
    return query.docs.map((doc) => UserStoryModel.fromFirestore(doc)).toList();
  }

  /// Lista stories di uno sprint
  Future<List<UserStoryModel>> getSprintStories(
    String projectId,
    String sprintId,
  ) async {
    final query = await _storiesRef(projectId)
        .where('sprintId', isEqualTo: sprintId)
        .orderBy('order')
        .get();
    return query.docs.map((doc) => UserStoryModel.fromFirestore(doc)).toList();
  }

  /// Stream delle stories di uno sprint
  Stream<List<UserStoryModel>> streamSprintStories(
    String projectId,
    String sprintId,
  ) {
    return _storiesRef(projectId)
        .where('sprintId', isEqualTo: sprintId)
        .orderBy('order')
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => UserStoryModel.fromFirestore(doc)).toList());
  }

  /// Aggiorna una story
  Future<void> updateStory(String projectId, UserStoryModel story) async {
    await _storiesRef(projectId).doc(story.id).update(story.toFirestore());

    await _projectsRef.doc(projectId).update({
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Aggiorna lo status di una story
  Future<void> updateStoryStatus(
    String projectId,
    String storyId,
    StoryStatus newStatus, {
    String? sprintId,
  }) async {
    final updates = <String, dynamic>{
      'status': newStatus.name,
    };

    if (newStatus == StoryStatus.inProgress) {
      updates['startedAt'] = FieldValue.serverTimestamp();
    } else if (newStatus == StoryStatus.done) {
      updates['completedAt'] = FieldValue.serverTimestamp();
    }

    if (sprintId != null) {
      updates['sprintId'] = sprintId;
    }

    await _storiesRef(projectId).doc(storyId).update(updates);

    await _projectsRef.doc(projectId).update({
      'updatedAt': FieldValue.serverTimestamp(),
    });

    // Auto-update burndown chart when story is completed
    if (newStatus == StoryStatus.done) {
      await _autoUpdateBurndownChart(projectId, sprintId);
    }
  }

  /// Auto-aggiorna il burndown chart quando una story viene completata
  Future<void> _autoUpdateBurndownChart(String projectId, String? sprintId) async {
    if (sprintId == null) return;

    try {
      // Ottieni lo sprint
      final sprintDoc = await _sprintsRef(projectId).doc(sprintId).get();
      if (!sprintDoc.exists) return;
      final sprint = SprintModel.fromFirestore(sprintDoc);

      // Solo per sprint attivi
      if (sprint.status != SprintStatus.active) return;

      // Calcola i punti rimanenti
      final storiesSnapshot = await _storiesRef(projectId)
          .where('sprintId', isEqualTo: sprintId)
          .get();

      final stories = storiesSnapshot.docs
          .map((doc) => UserStoryModel.fromFirestore(doc))
          .toList();

      final remainingPoints = stories
          .where((s) => s.status != StoryStatus.done)
          .fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));

      final completedPoints = stories
          .where((s) => s.status == StoryStatus.done)
          .fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));

      // Aggiungi il punto al burndown
      final burndownPoint = BurndownPoint(
        date: DateTime.now(),
        remainingPoints: remainingPoints,
        completedPoints: completedPoints,
      );

      await addBurndownPoint(projectId, sprintId, burndownPoint);
    } catch (e) {
      print('⚠️ Errore auto-update burndown: $e');
    }
  }

  /// Aggiorna l'ordine delle stories (per drag & drop)
  Future<void> updateStoriesOrder(
    String projectId,
    List<String> storyIds,
  ) async {
    final batch = _firestore.batch();

    for (int i = 0; i < storyIds.length; i++) {
      final ref = _storiesRef(projectId).doc(storyIds[i]);
      batch.update(ref, {'order': i});
    }

    await batch.commit();
  }

  /// Elimina una story
  Future<void> deleteStory(String projectId, String storyId) async {
    await _storiesRef(projectId).doc(storyId).delete();

    await _projectsRef.doc(projectId).update({
      'backlogCount': FieldValue.increment(-1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Elimina tutte le stories di un progetto
  Future<void> _deleteAllStories(String projectId) async {
    final stories = await _storiesRef(projectId).get();
    final batch = _firestore.batch();
    for (final doc in stories.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  // =========================================================================
  // SPRINTS CRUD
  // =========================================================================

  /// Ottiene la reference della subcollection sprints
  CollectionReference<Map<String, dynamic>> _sprintsRef(String projectId) =>
      _projectsRef.doc(projectId).collection(_sprintsSubcollection);

  /// Crea un nuovo sprint
  Future<SprintModel> createSprint({
    required String projectId,
    required String name,
    required String goal,
    required DateTime startDate,
    required DateTime endDate,
    required String createdBy,
    List<String> storyIds = const [],
    int plannedPoints = 0,
    Map<String, int> teamCapacity = const {},
  }) async {
    final docRef = _sprintsRef(projectId).doc();

    // Ottieni il numero dello sprint
    final countQuery = await _sprintsRef(projectId).count().get();
    final sprintNumber = (countQuery.count ?? 0) + 1;

    final totalCapacity = teamCapacity.values.fold(0, (sum, h) => sum + h);

    final sprint = SprintModel(
      id: docRef.id,
      projectId: projectId,
      name: name,
      goal: goal,
      number: sprintNumber,
      startDate: startDate,
      endDate: endDate,
      storyIds: storyIds,
      plannedPoints: plannedPoints,
      teamCapacity: teamCapacity,
      totalCapacityHours: totalCapacity,
      createdAt: DateTime.now(),
      createdBy: createdBy,
    );

    await docRef.set(sprint.toFirestore());

    // Aggiorna sprint count
    await _projectsRef.doc(projectId).update({
      'sprintCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return sprint;
  }

  /// Ottiene uno sprint per ID
  Future<SprintModel?> getSprint(String projectId, String sprintId) async {
    final doc = await _sprintsRef(projectId).doc(sprintId).get();
    if (!doc.exists) return null;
    return SprintModel.fromFirestore(doc);
  }

  /// Stream di uno sprint
  Stream<SprintModel?> streamSprint(String projectId, String sprintId) {
    return _sprintsRef(projectId).doc(sprintId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return SprintModel.fromFirestore(doc);
    });
  }

  /// Lista tutti gli sprint di un progetto
  Future<List<SprintModel>> getProjectSprints(String projectId) async {
    final query =
        await _sprintsRef(projectId).orderBy('number', descending: true).get();
    return query.docs.map((doc) => SprintModel.fromFirestore(doc)).toList();
  }

  /// Stream degli sprint di un progetto
  Stream<List<SprintModel>> streamProjectSprints(String projectId) {
    return _sprintsRef(projectId)
        .orderBy('number', descending: true)
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => SprintModel.fromFirestore(doc)).toList());
  }

  /// Ottiene lo sprint attivo
  Future<SprintModel?> getActiveSprint(String projectId) async {
    final query = await _sprintsRef(projectId)
        .where('status', isEqualTo: SprintStatus.active.name)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return null;
    return SprintModel.fromFirestore(query.docs.first);
  }

  /// Stream dello sprint attivo
  Stream<SprintModel?> streamActiveSprint(String projectId) {
    return _sprintsRef(projectId)
        .where('status', isEqualTo: SprintStatus.active.name)
        .limit(1)
        .snapshots()
        .map((query) {
      if (query.docs.isEmpty) return null;
      return SprintModel.fromFirestore(query.docs.first);
    });
  }

  /// Aggiorna uno sprint
  Future<void> updateSprint(String projectId, SprintModel sprint) async {
    await _sprintsRef(projectId).doc(sprint.id).update(sprint.toFirestore());

    await _projectsRef.doc(projectId).update({
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Avvia uno sprint
  Future<void> startSprint(String projectId, String sprintId) async {
    await _sprintsRef(projectId).doc(sprintId).update({
      'status': SprintStatus.active.name,
      'startedAt': FieldValue.serverTimestamp(),
    });

    await _projectsRef.doc(projectId).update({
      'activeSprintId': sprintId,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Completa uno sprint
  Future<void> completeSprint(
    String projectId,
    String sprintId, {
    required int completedPoints,
    required double velocity,
  }) async {
    await _sprintsRef(projectId).doc(sprintId).update({
      'status': SprintStatus.completed.name,
      'completedAt': FieldValue.serverTimestamp(),
      'completedPoints': completedPoints,
      'velocity': velocity,
    });

    // Aggiorna statistiche progetto
    final project = await getProject(projectId);
    if (project != null) {
      // Calcola nuova media velocity
      final completedSprints = project.completedSprintCount + 1;
      final oldAvgVelocity = project.averageVelocity ?? 0;
      final newAvgVelocity =
          ((oldAvgVelocity * project.completedSprintCount) + velocity) /
              completedSprints;

      await _projectsRef.doc(projectId).update({
        'activeSprintId': null,
        'completedSprintCount': FieldValue.increment(1),
        'averageVelocity': newAvgVelocity,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Aggiunge un punto al burndown
  Future<void> addBurndownPoint(
    String projectId,
    String sprintId,
    BurndownPoint point,
  ) async {
    await _sprintsRef(projectId).doc(sprintId).update({
      'burndownData': FieldValue.arrayUnion([point.toMap()]),
    });
  }

  /// Aggiunge una nota standup
  Future<void> addStandupNote(
    String projectId,
    String sprintId,
    StandupNote note,
  ) async {
    await _sprintsRef(projectId).doc(sprintId).update({
      'standupNotes': FieldValue.arrayUnion([note.toMap()]),
    });
  }

  /// Elimina uno sprint
  Future<void> deleteSprint(String projectId, String sprintId) async {
    await _sprintsRef(projectId).doc(sprintId).delete();

    await _projectsRef.doc(projectId).update({
      'sprintCount': FieldValue.increment(-1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Elimina tutti gli sprint di un progetto
  Future<void> _deleteAllSprints(String projectId) async {
    final sprints = await _sprintsRef(projectId).get();
    final batch = _firestore.batch();
    for (final doc in sprints.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  // =========================================================================
  // RETROSPECTIVES CRUD
  // =========================================================================

  /// Ottiene la reference della subcollection retrospectives
  CollectionReference<Map<String, dynamic>> _retrospectivesRef(
          String projectId) =>
      _projectsRef.doc(projectId).collection(_retrospectivesSubcollection);

  /// Crea una nuova retrospettiva
  Future<RetrospectiveModel> createRetrospective({
    required String projectId,
    required String sprintId,
    required String sprintName,
    required int sprintNumber,
    required String createdBy,
  }) async {
    final docRef = _retrospectivesRef(projectId).doc();

    final retro = RetrospectiveModel(
      id: docRef.id,
      sprintId: sprintId,
      projectId: projectId,
      sprintName: sprintName,
      sprintNumber: sprintNumber,
      createdAt: DateTime.now(),
      createdBy: createdBy,
      timer: const RetroTimer(durationMinutes: 60),
    );

    await docRef.set(retro.toFirestore());
    return retro;
  }

  /// Ottiene una retrospettiva per ID
  Future<RetrospectiveModel?> getRetrospective(
    String projectId,
    String retroId,
  ) async {
    final doc = await _retrospectivesRef(projectId).doc(retroId).get();
    if (!doc.exists) return null;
    return RetrospectiveModel.fromFirestore(doc);
  }

  /// Ottiene la retrospettiva di uno sprint
  Future<RetrospectiveModel?> getSprintRetrospective(
    String projectId,
    String sprintId,
  ) async {
    final query = await _retrospectivesRef(projectId)
        .where('sprintId', isEqualTo: sprintId)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return null;
    return RetrospectiveModel.fromFirestore(query.docs.first);
  }

  /// Stream di una retrospettiva
  Stream<RetrospectiveModel?> streamRetrospective(
    String projectId,
    String retroId,
  ) {
    return _retrospectivesRef(projectId).doc(retroId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return RetrospectiveModel.fromFirestore(doc);
    });
  }

  /// Aggiorna una retrospettiva
  Future<void> updateRetrospective(
    String projectId,
    RetrospectiveModel retro,
  ) async {
    await _retrospectivesRef(projectId).doc(retro.id).update(retro.toFirestore());
  }

  /// Elimina tutte le retrospettive di un progetto
  Future<void> _deleteAllRetrospectives(String projectId) async {
    final retros = await _retrospectivesRef(projectId).get();
    final batch = _firestore.batch();
    for (final doc in retros.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  // =========================================================================
  // AUDIT LOGS
  // =========================================================================

  /// Ottiene la reference della subcollection audit_logs
  CollectionReference<Map<String, dynamic>> _auditLogsRef(String projectId) =>
      _projectsRef.doc(projectId).collection(_auditLogsSubcollection);

  /// Elimina tutti i log di audit di un progetto
  Future<void> _deleteAllAuditLogs(String projectId) async {
    final logs = await _auditLogsRef(projectId).get();
    final batch = _firestore.batch();
    for (final doc in logs.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  // =========================================================================
  // UTILITY
  // =========================================================================

  /// Escape email per uso come chiave Firestore
  String _escapeEmail(String email) => email.replaceAll('.', '_DOT_');

  /// Unescape email key
  String _unescapeEmail(String key) => key.replaceAll('_DOT_', '.');

  /// Calcola la velocity media degli ultimi N sprint
  Future<double> calculateAverageVelocity(
    String projectId, {
    int lastNSprints = 3,
  }) async {
    final query = await _sprintsRef(projectId)
        .where('status', isEqualTo: SprintStatus.completed.name)
        .orderBy('completedAt', descending: true)
        .limit(lastNSprints)
        .get();

    if (query.docs.isEmpty) return 0;

    double totalVelocity = 0;
    for (final doc in query.docs) {
      final sprint = SprintModel.fromFirestore(doc);
      totalVelocity += sprint.velocity ?? 0;
    }

    return totalVelocity / query.docs.length;
  }

  // =========================================================================
  // ARCHIVIAZIONE - Progetti
  // =========================================================================

  /// Archivia un progetto Agile
  ///
  /// [projectId] - ID del progetto da archiviare
  ///
  /// I progetti archiviati sono esclusi dai conteggi subscription.
  /// Sprint e stories del progetto vengono considerati archiviati di conseguenza.
  Future<bool> archiveProject(String projectId) async {
    try {
      await _projectsRef.doc(projectId).update({
        'isArchived': true,
        'archivedAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('🗄️ Progetto archiviato: $projectId');
      return true;
    } catch (e) {
      print('❌ Errore archiveProject: $e');
      return false;
    }
  }

  /// Ripristina un progetto archiviato
  ///
  /// [projectId] - ID del progetto da ripristinare
  Future<bool> restoreProject(String projectId) async {
    try {
      await _projectsRef.doc(projectId).update({
        'isArchived': false,
        'archivedAt': null,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('📦 Progetto ripristinato: $projectId');
      return true;
    } catch (e) {
      print('❌ Errore restoreProject: $e');
      return false;
    }
  }

  /// Stream dei progetti con filtro archivio
  ///
  /// [userEmail] - Email dell'utente
  /// [includeArchived] - Se true, include anche gli archiviati
  Stream<List<AgileProjectModel>> streamProjectsFiltered({
    required String userEmail,
    bool includeArchived = false,
  }) {
    // Query base senza filtro isArchived (per compatibilità con documenti esistenti)
    return _projectsRef
        .where('participantEmails', arrayContains: userEmail.toLowerCase())
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      var projects = snapshot.docs
          .map((doc) => AgileProjectModel.fromFirestore(doc))
          .toList();

      // Filtro client-side per isArchived (gestisce documenti senza il campo)
      if (!includeArchived) {
        projects = projects.where((p) => p.isArchived != true).toList();
      }

      return projects;
    });
  }
}
