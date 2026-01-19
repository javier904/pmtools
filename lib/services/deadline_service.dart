import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/smart_todo/todo_task_model.dart';
import '../models/sprint_model.dart';

enum DeadlineType { task, sprint }

class DeadlineItem {
  final String id;
  final String parentId; // listId for tasks, projectId for sprints
  final String title;
  final DateTime date;
  final DeadlineType type;
  final String? priority; // only for tasks

  DeadlineItem({
    required this.id,
    required this.parentId,
    required this.title,
    required this.date,
    required this.type,
    this.priority,
  });

  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day;
  }
}

class DeadlineService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final DeadlineService _instance = DeadlineService._internal();
  factory DeadlineService() => _instance;
  DeadlineService._internal();

  /// Stream combined deadlines for the current user
  Stream<List<DeadlineItem>> streamDeadlines({int daysAhead = 1}) async* {
    final email = _auth.currentUser?.email;
    if (email == null) {
      yield [];
      return;
    }

    final now = DateTime.now();
    final threshold = DateTime(now.year, now.month, now.day + daysAhead, 23, 59, 59);

    // 1. Projects the user is in (to filter sprints)
    final projectsSnap = await _firestore
        .collection('agile_projects')
        .where('participantEmails', arrayContains: email.toLowerCase())
        .get();
    
    final projectIds = projectsSnap.docs.map((doc) => doc.id).toList();

    // Streams
    final tasksStream = _firestore
        .collectionGroup('smart_todo_tasks')
        .where('assignedTo', arrayContains: email.toLowerCase())
        .where('statusId', whereNotIn: ['done', 'completed']) 
        .snapshots();

    // Sprints stream (if there are projects)
    Stream<QuerySnapshot<Map<String, dynamic>>> sprintsStream;
    if (projectIds.isNotEmpty) {
      // Limit to first 30 projects for whereIn
      final limitedProjectIds = projectIds.take(30).toList();
      sprintsStream = _firestore
          .collectionGroup('sprints')
          .where('projectId', whereIn: limitedProjectIds)
          .where('status', isEqualTo: 'active') // Only active sprints
          .snapshots();
    } else {
      sprintsStream = Stream.empty();
    }

    await for (final taskSnap in tasksStream) {
      final items = <DeadlineItem>[];

      // Process Tasks
      for (var doc in taskSnap.docs) {
        final data = doc.data();
        final dueDateStr = data['dueDate'] as String?;
        if (dueDateStr != null) {
          final dueDate = DateTime.tryParse(dueDateStr);
          if (dueDate != null && dueDate.isBefore(threshold)) {
             // Avoid adding overdue tasks if they are too old? 
             // Usually deadlines section shows upcoming or overdue today.
             items.add(DeadlineItem(
              id: doc.id,
              parentId: data['listId'] ?? '',
              title: data['title'] ?? '',
              date: dueDate,
              type: DeadlineType.task,
              priority: data['priority'],
            ));
          }
        }
      }

      // We need to wait for or combine with sprints. 
      // For simplicity in this async* pattern, let's fetch sprints once or use a more complex combination.
      // But snapshots streams are persistent. 
      // Let's use a simpler approach: get tasks once, get sprints once, yield then stop? 
      // No, it should be a stream.
      
      // Let's use a nested fetch for sprints for now to keep it simple within the task stream update.
      if (projectIds.isNotEmpty) {
        final sprintSnap = await _firestore
            .collectionGroup('sprints')
            .where('projectId', whereIn: projectIds.take(30).toList())
            .where('status', isEqualTo: 'active')
            .get();

        for (var doc in sprintSnap.docs) {
          final data = doc.data();
          final endDate = (data['endDate'] as Timestamp?)?.toDate();
          if (endDate != null && endDate.isBefore(threshold)) {
            items.add(DeadlineItem(
              id: doc.id,
              parentId: data['projectId'] ?? '',
              title: 'Sprint ${data['number']}: ${data['name']}',
              date: endDate,
              type: DeadlineType.sprint,
            ));
          }
        }
      }

      // Sort by date 
      items.sort((a, b) => a.date.compareTo(b.date));
      yield items;
    }
  }
}
