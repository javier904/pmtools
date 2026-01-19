import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/smart_todo/todo_list_model.dart';
import '../models/smart_todo/todo_task_model.dart';
import '../models/smart_todo/todo_participant_model.dart';

class SmartTodoService {
  final FirebaseFirestore _firestore;

  static const String _listsCollection = 'smart_todo_lists';
  static const String _tasksSubcollection = 'smart_todo_tasks';

  SmartTodoService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // ══════════════════════════════════════════════════════════════════════════════
  // LIST OPERATIONS
  // ══════════════════════════════════════════════════════════════════════════════

  /// Get lists where user is owner or participant
  Stream<List<TodoListModel>> streamLists(String userEmail) {
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

  Future<String> createList(TodoListModel list, String userEmail) async {
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

  Future<String> createTask(String listId, TodoTaskModel task) async {
    final docRef = _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_tasksSubcollection)
        .doc();
    
    await docRef.set(task.copyWith(id: docRef.id).toMap());
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
  
  /// Get ALL tasks assigned to the user across ALL lists (Collection Group Query)
  Stream<List<TodoTaskModel>> streamAssignments(String userEmail) {
    return _firestore
        .collectionGroup(_tasksSubcollection)
        .where('assignedTo', arrayContains: userEmail)
        .snapshots()
        .map((snapshot) {
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
}
