import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/smart_todo/todo_list_model.dart';
import '../models/smart_todo/todo_task_model.dart';
import '../models/smart_todo/todo_participant_model.dart';
import '../models/subscription/subscription_limits_model.dart';
import 'subscription/subscription_limits_service.dart';

class SmartTodoService {
  final FirebaseFirestore _firestore;
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  static const String _listsCollection = 'smart_todo_lists';
  static const String _tasksSubcollection = 'smart_todo_tasks';

  SmartTodoService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // ══════════════════════════════════════════════════════════════════════════════
  // LIST OPERATIONS
  // ══════════════════════════════════════════════════════════════════════════════

  /// Get lists where user is owner or participant
  Stream<List<TodoListModel>> streamLists(String userEmail) {
    if (userEmail.isEmpty) return Stream.value([]);
    
    return _firestore
        .collection(_listsCollection)
        .where('participantEmails', arrayContains: userEmail.toLowerCase())
        .snapshots()
        .map((snapshot) {
          final lists = snapshot.docs
            .map((doc) => TodoListModel.fromMap(doc.data(), doc.id))
            .toList();
          // Client-side sort by createdAt descending
          lists.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return lists;
        });
  }

  /// Get lists once (for search)
  Future<List<TodoListModel>> getTodoListsOnce(String userEmail) async {
    if (userEmail.isEmpty) return [];
    
    try {
      final snapshot = await _firestore
          .collection(_listsCollection)
          .where('participantEmails', arrayContains: userEmail.toLowerCase())
          .get();

      return snapshot.docs
          .map((doc) => TodoListModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error getting lists once: $e');
      return [];
    }
  }

  /// Crea una nuova lista
  /// Lancia [LimitExceededException] se il limite liste e' raggiunto
  Future<String> createList(TodoListModel list, String userEmail) async {
    // 🔒 CHECK LIMITE LISTE
    await _limitsService.enforceListLimit(userEmail.toLowerCase());

    final docRef = _firestore.collection(_listsCollection).doc();

    // Add participantEmails for querying (lowercase)
    final data = list.toMap();
    // Normalizza ownerEmail
    data['ownerEmail'] = userEmail.toLowerCase();
    // Normalizza keys partecipanti
    data['participantEmails'] = list.participants.keys.map((e) => e.toLowerCase()).toList();

    await docRef.set(data);
    return docRef.id;
  }

  Future<void> updateList(TodoListModel list) async {
    final data = list.toMap();
    data['participantEmails'] = list.participants.keys.map((e) => e.toLowerCase()).toList();
    await _firestore.collection(_listsCollection).doc(list.id).update(data);
  }

  Future<void> deleteList(String listId) async {
    await _firestore.collection(_listsCollection).doc(listId).delete();
  }

  Future<TodoListModel?> getList(String listId) async {
    final doc = await _firestore.collection(_listsCollection).doc(listId).get();
    if (!doc.exists) return null;
    return TodoListModel.fromMap(doc.data()!, doc.id);
  }

  /// Add a user to pending invites
  Future<void> addPendingParticipant(String listId, String email) async {
    await _firestore.collection(_listsCollection).doc(listId).update({
      'pendingEmails': FieldValue.arrayUnion([email]),
    });
  }

  /// Promote pending user to active participant via Transaction
  Future<void> promotePendingToActive(String listId, TodoParticipant participant) async {
    final docRef = _firestore.collection(_listsCollection).doc(listId);
    
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) throw Exception("List not found");

      final data = snapshot.data()!;
      
      // 1. Update Participants Map
      final participants = Map<String, dynamic>.from(data['participants'] ?? {});
      participants[participant.email] = participant.toMap();

      // 2. Remove from Pending
      final pending = List<String>.from(data['pendingEmails'] ?? []);
      pending.remove(participant.email);

      // 3. Add to Participant Emails (for security/queries)
      final emails = List<String>.from(data['participantEmails'] ?? []);
      if (!emails.contains(participant.email)) {
        emails.add(participant.email);
      }

      transaction.update(docRef, {
        'participants': participants,
        'pendingEmails': pending,
        'participantEmails': emails,
      });
    });
  }

  Stream<TodoListModel?> streamList(String listId) {
    return _firestore
        .collection(_listsCollection)
        .doc(listId)
        .snapshots()
        .map((doc) => doc.exists ? TodoListModel.fromMap(doc.data()!, doc.id) : null);
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // TASK OPERATIONS
  // ══════════════════════════════════════════════════════════════════════════════

  Stream<List<TodoTaskModel>> streamTasks(String listId) {
    return _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection)
        // Removed server-side orderBy to avoid 'failed-precondition' index error
        .snapshots()
        .map((snapshot) {
          final tasks = snapshot.docs
            .map((doc) => TodoTaskModel.fromMap(doc.data(), doc.id))
            .toList();
          // Client-side sort by updatedAt descending
          tasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          return tasks;
        });
  }

  /// Crea un nuovo task in una lista
  /// Lancia [LimitExceededException] se il limite task per entita' e' raggiunto
  Future<String> createTask(String listId, TodoTaskModel task) async {
    // 🔒 CHECK LIMITE TASK PER ENTITA'
    await _limitsService.enforceTaskLimit(entityType: 'smart_todo', entityId: listId);

    final docRef = _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection)
        .doc();

    // Assign default position (timestamp) if not set (though model defaults it too)
    // Using timestamp ensures chronologial order by default for "manual" sort
    final taskWithId = task.copyWith(
      id: docRef.id,
      position: DateTime.now().millisecondsSinceEpoch.toDouble(),
    );

    await docRef.set(taskWithId.toMap());
    return docRef.id;
  }

  Future<void> batchCreateTasks(String listId, List<TodoTaskModel> tasks) async {
    final batch = _firestore.batch();
    final colRef = _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection);

    for (var task in tasks) {
      final docRef = colRef.doc(); // Auto-ID
      batch.set(docRef, task.copyWith(id: docRef.id).toMap());
    }

    await batch.commit();
  }

  Future<void> updateTask(String listId, TodoTaskModel task) async {
    await _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection)
        .doc(task.id)
        .update(task.toMap());
  }

  Future<void> deleteTask(String listId, String taskId) async {
    await _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection)
        .doc(taskId)
        .delete();
  }
  // ══════════════════════════════════════════════════════════════════════════════
  // GLOBAL / MACRO VIEW OPERATIONS
  // ══════════════════════════════════════════════════════════════════════════════

  Stream<int> streamTaskCount(String listId) {
    return _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection)
        .count()
        .get()
        .asStream() // Initial count
        .map((agg) => agg.count ?? 0); 
        // Note: Real-time count requires snapshots().map((s) => s.size) which is costly.
        // For Dashboard, maybe snapshot is better for reactivity?
        // User wants to see "activities within". If I add one, it should update.
        // Let's use snapshots approach for V1, assuming small lists.
  }
  
  Stream<int> streamTaskCountRealtime(String listId) {
     return _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection)
        .snapshots()
        .map((s) => s.size);
  }

  /// Stream che ritorna (totalTasks, completedTasks) per una lista
  Stream<({int total, int completed})> streamTaskCompletionStats(String listId, {required Set<String> doneColumnIds}) {
    return _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection)
        .snapshots()
        .map((snapshot) {
      final total = snapshot.size;
      final completed = snapshot.docs.where((doc) {
        final data = doc.data();
        final statusId = data['statusId'] as String? ?? '';
        return doneColumnIds.contains(statusId);
      }).length;
      return (total: total, completed: completed);
    });
  }

  /// Get ALL tasks assigned to the user across ALL lists (Collection Group Query)
  Stream<List<TodoTaskModel>> streamAssignments(String userEmail) {
    // Queries for both original and lowercase to handle potential inconsistencies
    final trimmedEmail = userEmail.trim();
    final emails = {trimmedEmail, trimmedEmail.toLowerCase()}.toList();
    
    debugPrint('DEBUG: SmartTodoService streamAssignments for emails: $emails');

    return _firestore
        .collectionGroup(_tasksSubcollection)
        .where('assignedTo', arrayContainsAny: emails)
        .snapshots()
        .map((snapshot) {
          debugPrint('DEBUG: SmartTodoService Found ${snapshot.docs.length} tasks for user.');
          final tasks = snapshot.docs
            .map((doc) => TodoTaskModel.fromMap(doc.data(), doc.id))
            .toList();
          // Sort handling might be needed client-side or via composite index
          tasks.sort((a, b) => (a.dueDate ?? DateTime(2100)).compareTo(b.dueDate ?? DateTime(2100)));
          return tasks;
        });
  }

  /// Get ALL tasks from lists owned by the user (Collection Group Query with client-side filter)
  /// Handles chunking for > 30 lists (Firestore limit for 'whereIn').
  Stream<List<TodoTaskModel>> streamTasksByOwner(List<String> ownedListIds) {
    if (ownedListIds.isEmpty) return Stream.value([]);
    
    // Chunking logic for lists > 30
    // Firestore 'whereIn' supports max 30 items.
    List<List<String>> chunks = [];
    for (var i = 0; i < ownedListIds.length; i += 30) {
      chunks.add(ownedListIds.sublist(i, (i + 30) > ownedListIds.length ? ownedListIds.length : (i + 30)));
    }

    if (chunks.length == 1) {
      return _queryTasksByListIds(chunks[0]);
    }

    // Combine streams from multiple chunks
    // We use a StreamController to merge latest results from all chunk streams (CombineLatest behavior)
    StreamController<List<TodoTaskModel>> controller = StreamController();
    List<List<TodoTaskModel>> cachedResults = List.generate(chunks.length, (_) => []);
    
    // Track active subscriptions to cancel them when controller is closed
    List<StreamSubscription> subscriptions = [];

    // Initialize subscriptions
    for (int i = 0; i < chunks.length; i++) {
      final subscription = _queryTasksByListIds(chunks[i]).listen(
        (data) {
          cachedResults[i] = data;
          if (!controller.isClosed) {
            // Flatten results
            final allTasks = cachedResults.expand((x) => x).toList();
            // Sort by updatedAt descending (optional, matching general behavior)
            allTasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
            controller.add(allTasks);
          }
        },
        onError: (e) {
          if (!controller.isClosed) controller.addError(e);
        },
      );
      subscriptions.add(subscription);
    }

    controller.onCancel = () {
      for (var sub in subscriptions) {
        sub.cancel();
      }
    };

    return controller.stream;
  }

  Stream<List<TodoTaskModel>> _queryTasksByListIds(List<String> listIds) {
    return _firestore
        .collectionGroup(_tasksSubcollection)
        .where('listId', whereIn: listIds)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TodoTaskModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // ARCHIVIAZIONE - Liste
  // ══════════════════════════════════════════════════════════════════════════════

  /// Archivia una lista
  ///
  /// [listId] - ID della lista da archiviare
  ///
  /// Le liste archiviate sono escluse dai conteggi subscription
  /// e non appaiono nelle liste di default
  Future<bool> archiveList(String listId) async {
    try {
      await _firestore.collection(_listsCollection).doc(listId).update({
        'isArchived': true,
        'archivedAt': DateTime.now().toIso8601String(),
      });
      print('🗄️ Lista archiviata: $listId');
      return true;
    } catch (e) {
      print('❌ Errore archiveList: $e');
      return false;
    }
  }

  /// Ripristina una lista archiviata
  ///
  /// [listId] - ID della lista da ripristinare
  Future<bool> restoreList(String listId) async {
    try {
      await _firestore.collection(_listsCollection).doc(listId).update({
        'isArchived': false,
        'archivedAt': null,
      });
      print('📦 Lista ripristinata: $listId');
      return true;
    } catch (e) {
      print('❌ Errore restoreList: $e');
      return false;
    }
  }

  /// Stream delle liste con filtro archivio
  ///
  /// [userEmail] - Email dell'utente
  /// [includeArchived] - Se true, include anche le archiviate
  Stream<List<TodoListModel>> streamListsFiltered({
    required String userEmail,
    bool includeArchived = false,
  }) {
    if (userEmail.isEmpty) return Stream.value([]);

    // Query base senza filtro isArchived (per compatibilità con documenti esistenti)
    return _firestore
        .collection(_listsCollection)
        .where('participantEmails', arrayContains: userEmail.toLowerCase())
        .snapshots()
        .map((snapshot) {
      var lists = snapshot.docs
          .map((doc) => TodoListModel.fromMap(doc.data(), doc.id))
          .toList();

      // Filtro client-side per isArchived (gestisce documenti senza il campo)
      if (!includeArchived) {
        lists = lists.where((list) => list.isArchived != true).toList();
      }

      // Client-side sort by createdAt descending
      lists.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return lists;
    });
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // ARCHIVIAZIONE - Task
  // ══════════════════════════════════════════════════════════════════════════════

  /// Archivia un task
  ///
  /// [listId] - ID della lista
  /// [taskId] - ID del task da archiviare
  Future<bool> archiveTask(String listId, String taskId) async {
    try {
      await _firestore
          .collection(_listsCollection)
          .doc(listId)
          .collection(_tasksSubcollection)
          .doc(taskId)
          .update({
        'isArchived': true,
        'archivedAt': DateTime.now().toIso8601String(),
      });
      print('🗄️ Task archiviato: $taskId');
      return true;
    } catch (e) {
      print('❌ Errore archiveTask: $e');
      return false;
    }
  }

  /// Ripristina un task archiviato
  ///
  /// [listId] - ID della lista
  /// [taskId] - ID del task da ripristinare
  Future<bool> restoreTask(String listId, String taskId) async {
    try {
      await _firestore
          .collection(_listsCollection)
          .doc(listId)
          .collection(_tasksSubcollection)
          .doc(taskId)
          .update({
        'isArchived': false,
        'archivedAt': null,
      });
      print('📦 Task ripristinato: $taskId');
      return true;
    } catch (e) {
      print('❌ Errore restoreTask: $e');
      return false;
    }
  }

  /// Stream dei task con filtro archivio
  ///
  /// [listId] - ID della lista
  /// [includeArchived] - Se true, include anche gli archiviati
  Stream<List<TodoTaskModel>> streamTasksFiltered({
    required String listId,
    bool includeArchived = false,
  }) {
    // Query base senza filtro isArchived (per compatibilità con documenti esistenti)
    return _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection)
        .snapshots()
        .map((snapshot) {
      var tasks = snapshot.docs
          .map((doc) => TodoTaskModel.fromMap(doc.data(), doc.id))
          .toList();

      // Filtro client-side per isArchived (gestisce documenti senza il campo)
      if (!includeArchived) {
        tasks = tasks.where((t) => t.isArchived != true).toList();
      }

      // Client-side sort by updatedAt descending
      tasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return tasks;
    });
  }
}
