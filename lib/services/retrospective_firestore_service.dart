import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/retrospective_model.dart';
import '../models/audit_log_model.dart';
import '../models/audit_log_model.dart';
import '../models/agile_enums.dart';
import '../models/user_story_model.dart';

class RetrospectiveFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _retrosCollection =>
      _db.collection('retrospectives');

  CollectionReference<Map<String, dynamic>> get _auditCollection =>
      _db.collection('audit_logs');
  
  // Reuse existing collection or generic path. Assuming standard Agile project structure.
  CollectionReference<Map<String, dynamic>> _getStoriesCollection(String projectId) =>
      _db.collection('agile_projects').doc(projectId).collection('stories');

  /// Crea una nuova retrospettiva
  Future<String> createRetrospective(RetrospectiveModel retro) async {
    final docRef = _retrosCollection.doc();
    
    // V2: Generate default columns if not provided
    var columns = retro.columns;
    if (columns.isEmpty) {
        columns = retro.template.defaultColumns;
    }

    final normalizedCreatedBy = retro.createdBy.toLowerCase();
    final newRetro = retro.copyWith(
      id: docRef.id,
      columns: columns,
      createdBy: normalizedCreatedBy,
      // Ensure timer is initialized
      timer: const RetroTimer(isRunning: false, durationMinutes: 0),
      // Ensure participants list contains creator
      participantEmails: [
        ...retro.participantEmails.map((e) => e.toLowerCase()),
        if (!retro.participantEmails.map((e) => e.toLowerCase()).contains(normalizedCreatedBy)) normalizedCreatedBy
      ],
    );
    
    await docRef.set(newRetro.toFirestore());
    await _logAudit(
      AuditLogModel.create(
        projectId: retro.projectId ?? '',
        entityType: AuditEntityType.sprint,
        entityId: docRef.id,
        entityName: 'Retro: ${retro.sprintName}',
        performedBy: retro.createdBy,
        performedByName: 'System/User',
        description: 'Creata retrospettiva con template ${retro.template.name}',
      ),
    );
    return docRef.id;
  }

  /// Recupera una retrospettiva
  Future<RetrospectiveModel?> getRetrospective(String id) async {
    final doc = await _retrosCollection.doc(id).get();
    if (!doc.exists) return null;
    return RetrospectiveModel.fromFirestore(doc);
  }

  /// Elimina definitivamente una retrospettiva
  Future<void> deleteRetrospective(String retroId) async {
    await _retrosCollection.doc(retroId).delete();
  }

  /// Stream di una singola retrospettiva (Real-time sync)
  Stream<RetrospectiveModel?> streamRetrospective(String id) {
    return _retrosCollection.doc(id).snapshots().map((doc) {
      if (!doc.exists) return null;
      return RetrospectiveModel.fromFirestore(doc);
    });
  }

  /// Stream di tutte le retrospettive di un progetto
  Stream<List<RetrospectiveModel>> streamProjectRetrospectives(String projectId) {
    return _retrosCollection
        .where('projectId', isEqualTo: projectId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => RetrospectiveModel.fromFirestore(doc))
          .toList();
    });
  }

  /// Stream di tutte le retrospettive visibili a un utente (Progetto + Standalone)
  /// Unisce i risultati di 'participantEmails' e 'createdBy' per supportare dati legacy.
  Stream<List<RetrospectiveModel>> streamUserRetrospectives(String userEmail) {
    if (userEmail.isEmpty) {
      return Stream.value([]);
    }
    
    final lowerUserEmail = userEmail.toLowerCase();
    final controller = StreamController<List<RetrospectiveModel>>();
    List<RetrospectiveModel> list1 = []; // Participants
    List<RetrospectiveModel> list2 = []; // CreatedBy
    Timer? debounce;
    
    void emit() {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(milliseconds: 50), () {
        if (controller.isClosed) return;
        
        final ids = <String>{};
        final combined = <RetrospectiveModel>[];
        for (var item in [...list1, ...list2]) {
          if (ids.add(item.id)) {
            combined.add(item);
          }
        }
        // Client-side sorting
        combined.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        controller.add(combined);
      });
    }

    final sub1 = _retrosCollection
        .where('participantEmails', arrayContains: lowerUserEmail)
        .snapshots()
        .listen((snapshot) {
      list1 = snapshot.docs
          .map((doc) => RetrospectiveModel.fromFirestore(doc))
          .toList();
      emit();
    });

    final sub2 = _retrosCollection
        .where('createdBy', isEqualTo: lowerUserEmail)
        .snapshots()
        .listen((snapshot) {
      list2 = snapshot.docs
          .map((doc) => RetrospectiveModel.fromFirestore(doc))
          .toList();
      emit();
    });

    controller.onCancel = () {
      debounce?.cancel();
      sub1.cancel();
      sub2.cancel();
    };

    return controller.stream;
  }

  /// Aggiorna la fase della retrospettiva
  Future<void> updatePhase(String retroId, RetroPhase newPhase, String userId, String userName) async {
    final retroDoc = await _retrosCollection.doc(retroId).get();
    if (!retroDoc.exists) return;
    final retro = RetrospectiveModel.fromFirestore(retroDoc);

    final updates = <String, dynamic>{
      'currentPhase': newPhase.name,
    };

    // Auto-Start Timer if Duration is Configured
    final phaseDuration = retro.phaseDurations[newPhase.name];
    if (phaseDuration != null && phaseDuration > 0) {
        final endTime = DateTime.now().add(Duration(minutes: phaseDuration));
        updates['timer'] = RetroTimer(
            durationMinutes: phaseDuration,
            endTime: endTime,
            isRunning: true,
        ).toMap();
    } else {
        // Stop timer if no configuration for this phase
        updates['timer'] = const RetroTimer(isRunning: false).toMap();
    }

    // Fix Visibility: Update status field to 'completed' if phase is completed
    if (newPhase == RetroPhase.completed) {
      updates['status'] = RetroStatus.completed.name;
    } else if (retro.status == RetroStatus.completed) {
      // Auto-reactivate if moving away from completed?
      // Usually handled by reopen, but good safety.
      updates['status'] = RetroStatus.active.name;
    } else if (retro.status == RetroStatus.draft && newPhase != RetroPhase.setup) {
      // First start
      updates['status'] = RetroStatus.active.name;
    }

    await _retrosCollection.doc(retroId).update(updates);

    // Log Phase Change
    await _logAudit(
      AuditLogModel.update(
        projectId: retro.projectId ?? '',
        entityType: AuditEntityType.sprint,
        entityId: retroId,
        entityName: 'Retro: ${retro.sprintName}',
        performedBy: userId,
        performedByName: userName,
        newValue: {'currentPhase': newPhase.name, 'status': updates['status']},
        previousValue: {'currentPhase': retro.currentPhase.name, 'status': retro.status.name},
        description: 'Fase retrospettiva cambiata in ${newPhase.name}',
      ),
    );
  }

  /// Aggiorna lo step del Wizard (per metodologie guidate)
  Future<void> updateWizardStep(String retroId, int step, String userId, String userName) async {
    await _retrosCollection.doc(retroId).update({
      'currentWizardStep': step,
    });
    // Log is optional for minor step changes, but good for replayability
  }

  // =========================================================================
  // V2 Methodology Methods: Timer, Reveal, Items
  // =========================================================================

  /// Avvia il timer
  Future<void> startTimer(String retroId, int minutes) async {
    final endTime = DateTime.now().add(Duration(minutes: minutes));
    final timer = RetroTimer(
        durationMinutes: minutes,
        endTime: endTime,
        isRunning: true,
    );
    await _retrosCollection.doc(retroId).update({
        'timer': timer.toMap(),
    });
  }

  /// Ferma il timer
  Future<void> stopTimer(String retroId) async {
    await _retrosCollection.doc(retroId).update({
        'timer': const RetroTimer(isRunning: false).toMap(),
    });
  }

  /// Rivela le card a tutti (fine fase Writing)
  Future<void> revealCards(String retroId) async {
    await _retrosCollection.doc(retroId).update({
        'areTeamCardsVisible': true,
    });
  }
  
  /// Aggiunge un item alla retrospettiva (Supporta V2 Columns)
  Future<void> addRetroItem(String retroId, RetroItem item) async {
    final docRef = _retrosCollection.doc(retroId);
    
    // We use arrayUnion for atomic addition to the 'items' list
    await docRef.update({
      'items': FieldValue.arrayUnion([item.toMap()]),
    });
  }

  /// Aggiorna un item esistente (es. content edit)
  Future<void> updateRetroItem(String retroId, RetroItem item) async {
      final doc = await _retrosCollection.doc(retroId).get();
      if (!doc.exists) return;
      
      final retro = RetrospectiveModel.fromFirestore(doc);
      final updatedItems = retro.items.map((i) => i.id == item.id ? item : i).toList();

      await _retrosCollection.doc(retroId).update({
          'items': updatedItems.map((e) => e.toMap()).toList(),
      });
  }

  /// Cancella un item
  Future<void> deleteRetroItem(String retroId, String itemId) async {
      final doc = await _retrosCollection.doc(retroId).get();
      if (!doc.exists) return;
      
      final retro = RetrospectiveModel.fromFirestore(doc);
      final updatedItems = retro.items.where((i) => i.id != itemId).toList();

      await _retrosCollection.doc(retroId).update({
          'items': updatedItems.map((e) => e.toMap()).toList(),
      });
  }

  /// Vota un item
  Future<void> voteItem(String retroId, String itemId, String userEmail) async {
    // Transaction needed for atomic vote count consistency or complex arrays
    // Simple arrayUnion implies simple concurrency.
    // For V2, we need to find the item in the list and update it.
    
    final docRef = _retrosCollection.doc(retroId);
    
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) return;
      
      final retro = RetrospectiveModel.fromFirestore(snapshot);
      final itemIndex = retro.items.indexWhere((i) => i.id == itemId);
      
      if (itemIndex == -1) return;
      
      final item = retro.items[itemIndex];
      // Toggle vote
      final newItem = item.hasVoted(userEmail) 
          ? item.withoutVote(userEmail) 
          : item.withVote(userEmail);

      final newItems = List<RetroItem>.from(retro.items);
      newItems[itemIndex] = newItem;

      transaction.update(docRef, {
        'items': newItems.map((i) => i.toMap()).toList(),
      });
    });
  }

  /// Invia un voto sentiment (Icebreaker)
  Future<void> submitSentiment(String retroId, String userEmail, int score) async {
    final docRef = _retrosCollection.doc(retroId);
    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) return;
      
      final retro = RetrospectiveModel.fromFirestore(snapshot);
      final newVotes = Map<String, int>.from(retro.sentimentVotes);
      newVotes[userEmail] = score;
      
      // Recalculate average
      double? newAverage;
      if (newVotes.isNotEmpty) {
        final total = newVotes.values.reduce((a, b) => a + b);
        newAverage = total / newVotes.length;
      }

      transaction.update(docRef, {
        'sentimentVotes': newVotes,
        'averageSentiment': newAverage,
      });
    });
  }

  /// Aggiunge un Action Item
  Future<void> addActionItem(String retroId, ActionItem item) async {
    final docRef = _retrosCollection.doc(retroId);
    await docRef.update({
      'actionItems': FieldValue.arrayUnion([item.toMap()]),
    });
  }

  /// Aggiorna un Action Item esistente
  Future<void> updateActionItem(String retroId, ActionItem item) async {
    final docRef = _retrosCollection.doc(retroId);
    
    // Essendo in un array, dobbiamo leggere, trovare e sostituire
    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) return;

      final retro = RetrospectiveModel.fromFirestore(snapshot);
      final index = retro.actionItems.indexWhere((i) => i.id == item.id);
      
      if (index == -1) return; // Item not found

      final newItems = List<ActionItem>.from(retro.actionItems);
      newItems[index] = item;

      transaction.update(docRef, {
        'actionItems': newItems.map((i) => i.toMap()).toList(),
      });
    });
  }

  /// Elimina un Action Item
  Future<void> deleteActionItem(String retroId, String itemId) async {
    final docRef = _retrosCollection.doc(retroId);
    
    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) return;

      final retro = RetrospectiveModel.fromFirestore(snapshot);
      final newItems = retro.actionItems.where((i) => i.id != itemId).toList();

      transaction.update(docRef, {
        'actionItems': newItems.map((i) => i.toMap()).toList(),
      });
    });
  }

  /// Promuove un Action Item a User Story
  Future<void> promoteActionToStory(String retroId, ActionItem actionItem, String projectId, String userId, String userName) async {
    final storiesCollection = _getStoriesCollection(projectId);
    
    // 1. Create User Story
    final newStoryDoc = storiesCollection.doc();
    final newStory = UserStoryModel(
      id: newStoryDoc.id,
      projectId: projectId,
      title: 'Retro Action: ${actionItem.description}',
      description: 'Promoted from Retrospective Action Item created on ${actionItem.createdAt}.',
      priority: StoryPriority.should,
      status: StoryStatus.backlog,
      tags: ['retrospective', 'action-item'],
      createdAt: DateTime.now(),
      createdBy: userId,
      assigneeEmail: actionItem.assigneeEmail,
    );
    
    await newStoryDoc.set(newStory.toFirestore());

    // 2. Mark Action Item as Linked (Optional: Update description or remove it from list)
    // For now, we update description to indicate linkage
    final retroDoc = _retrosCollection.doc(retroId);
    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(retroDoc);
      if (!snapshot.exists) return;
      
      final retro = RetrospectiveModel.fromFirestore(snapshot);
      final index = retro.actionItems.indexWhere((a) => a.id == actionItem.id);
      if (index == -1) return;

      final updatedAction = ActionItem(
        id: actionItem.id,
        description: '${actionItem.description} [Linked to Story]',
        ownerEmail: actionItem.ownerEmail, // Preserve owner
        assigneeEmail: actionItem.assigneeEmail,
        assigneeName: actionItem.assigneeName,
        createdAt: actionItem.createdAt,
        dueDate: actionItem.dueDate,
        isCompleted: true, // Mark as "handled" since it's now a story
        priority: actionItem.priority,
      );
      
      final newActions = List<ActionItem>.from(retro.actionItems);
      newActions[index] = updatedAction;

      transaction.update(retroDoc, {
        'actionItems': newActions.map((a) => a.toMap()).toList(),
      });
      
      // Log Audit
      transaction.set(_auditCollection.doc(), AuditLogModel.create(
        projectId: projectId,
        entityType: AuditEntityType.story,
        entityId: newStory.id,
        entityName: newStory.title,
        performedBy: userId,
        performedByName: userName,
        description: 'Promosso Action Item a User Story',
      ).toFirestore());
    });
  }

  /// Aggiunge un partecipante alla retrospettiva
  Future<void> addParticipant(String retroId, String email) async {
    final docRef = _retrosCollection.doc(retroId);
    await docRef.update({
      'participantEmails': FieldValue.arrayUnion([email]),
    });
  }

  // =========================================================================
  // ONLINE PRESENCE - Heartbeat System
  // =========================================================================

  /// Invia heartbeat per segnalare presenza online
  ///
  /// Chiamato periodicamente (ogni 15 secondi) per mantenere lo stato online.
  /// [retroId] - ID della retrospettiva
  /// [userEmail] - Email dell'utente che invia l'heartbeat
  Future<void> sendHeartbeat(String retroId, String userEmail) async {
    try {
      final docRef = _retrosCollection.doc(retroId);
      await docRef.update({
        'participantPresence.$userEmail': {
          'isOnline': true,
          'lastActivity': FieldValue.serverTimestamp(),
        },
      });
    } catch (e) {
      print('⚠️ Errore sendHeartbeat: $e');
      // Non rilanciare l'errore - heartbeat fallito non deve bloccare l'app
    }
  }

  /// Marca l'utente come offline
  ///
  /// Chiamato quando l'utente lascia esplicitamente la retrospettiva
  /// o quando l'app viene chiusa.
  /// [retroId] - ID della retrospettiva
  /// [userEmail] - Email dell'utente da marcare offline
  Future<void> markOffline(String retroId, String userEmail) async {
    try {
      final docRef = _retrosCollection.doc(retroId);
      await docRef.update({
        'participantPresence.$userEmail.isOnline': false,
      });
    } catch (e) {
      print('⚠️ Errore markOffline: $e');
      // Non rilanciare l'errore - può fallire se la retrospettiva non esiste più
    }
  }

  /// Helper per log
  Future<void> _logAudit(AuditLogModel log) async {
    await _auditCollection.add(log.toFirestore());
  }

  // =========================================================================
  // ARCHIVIAZIONE - Retrospettive
  // =========================================================================

  /// Archivia una retrospettiva
  ///
  /// [retroId] - ID della retrospettiva da archiviare
  ///
  /// Le retrospettive archiviate sono escluse dai conteggi subscription
  /// e non appaiono nelle liste di default
  Future<bool> archiveRetrospective(String retroId) async {
    try {
      await _retrosCollection.doc(retroId).update({
        'isArchived': true,
        'archivedAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('🗄️ Retrospettiva archiviata: $retroId');
      return true;
    } catch (e) {
      print('❌ Errore archiveRetrospective: $e');
      return false;
    }
  }

  /// Ripristina una retrospettiva archiviata
  ///
  /// [retroId] - ID della retrospettiva da ripristinare
  Future<bool> restoreRetrospective(String retroId) async {
    try {
      await _retrosCollection.doc(retroId).update({
        'isArchived': false,
        'archivedAt': null,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('📦 Retrospettiva ripristinata: $retroId');
      return true;
    } catch (e) {
      print('❌ Errore restoreRetrospective: $e');
      return false;
    }
  }

  /// Stream delle retrospettive con filtro archivio
  ///
  /// [userEmail] - Email dell'utente
  /// [includeArchived] - Se true, include anche le archiviate
  Stream<List<RetrospectiveModel>> streamRetrospectivesFiltered({
    required String userEmail,
    bool includeArchived = false,
  }) {
    // Query base senza filtro isArchived (per compatibilità con documenti esistenti)
    return _retrosCollection
        .where('participantEmails', arrayContains: userEmail.toLowerCase())
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      var retros = snapshot.docs
          .map((doc) => RetrospectiveModel.fromFirestore(doc))
          .toList();

      // Filtro client-side per isArchived (gestisce documenti senza il campo)
      if (!includeArchived) {
        retros = retros.where((r) => r.isArchived != true).toList();
      }

      return retros;
    });
  }
}
