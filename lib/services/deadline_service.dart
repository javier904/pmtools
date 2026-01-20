import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/smart_todo/todo_task_model.dart';
import '../models/sprint_model.dart';
import 'package:flutter/foundation.dart';

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
  /// [daysAhead]: -1 = All (no date filter), 0 = Today, 1 = Tomorrow, etc.
  /// [exactDay]: if true, filters for exact day only; if false, shows "up to" that day
  Stream<List<DeadlineItem>> streamDeadlines({int daysAhead = 1, bool exactDay = true}) {
    final email = _auth.currentUser?.email;
    if (email == null) {
      return Stream.value([]);
    }

    // Normalize email
    final trimmedEmail = email.trim();
    final emails = {trimmedEmail, trimmedEmail.toLowerCase()}.toList();

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    // Calculate date range based on filter mode
    DateTime? startThreshold;
    DateTime? endThreshold;

    if (daysAhead == -1) {
      // "All" mode - no date filtering (show all non-completed tasks with due dates)
      startThreshold = null;
      endThreshold = null;
      // debugPrint('DEBUG: DeadlineService stream for $emails | Mode: ALL (no date filter)');
    } else if (exactDay) {
      // Exact day mode - only tasks due on that specific day
      final targetDay = todayStart.add(Duration(days: daysAhead));
      startThreshold = targetDay;
      endThreshold = DateTime(targetDay.year, targetDay.month, targetDay.day, 23, 59, 59);
      // debugPrint('DEBUG: DeadlineService stream for $emails | Mode: EXACT DAY $daysAhead ($startThreshold - $endThreshold)');
    } else {
      // Legacy mode - show all tasks up to that day
      startThreshold = null;
      endThreshold = DateTime(now.year, now.month, now.day + daysAhead, 23, 59, 59);
      // debugPrint('DEBUG: DeadlineService stream for $emails | Mode: UP TO $daysAhead (Threshold: $endThreshold)');
    }

    // Combine streams using StreamZip or Rx would be better, but let's stick to a simpler approach
    // We will listen to tasks and on each update, fetch sprints.
    
    return _firestore
        .collectionGroup('smart_todo_tasks')
        .where('assignedTo', arrayContainsAny: emails)
        // .where('statusId', whereNotIn: ['done', 'completed']) // Requires composite index usually
        // Let's filter status client-side to avoid index hell if possible, or handle error
        .snapshots()
        .asyncMap((taskSnap) async {
          // debugPrint('DEBUG: DeadlineService found ${taskSnap.docs.length} raw tasks');
          final items = <DeadlineItem>[];

          // 1. Process Tasks
          for (var doc in taskSnap.docs) {
            final data = doc.data();
            
            // Client-side status filter (safer without index)
            final statusId = data['statusId'] ?? data['status'];
            if (statusId == 'done' || statusId == 'completed') continue;

            final dueDateStr = data['dueDate'] as String?;
            if (dueDateStr != null) {
              final dueDate = DateTime.tryParse(dueDateStr);
              if (dueDate != null) {
                // Check if dueDate falls within the filter range
                bool include = false;
                if (startThreshold == null && endThreshold == null) {
                  // "All" mode - include all tasks with due dates
                  include = true;
                } else if (startThreshold != null && endThreshold != null) {
                  // Exact day mode - include if within the exact day range
                  include = !dueDate.isBefore(startThreshold) && dueDate.isBefore(endThreshold.add(const Duration(seconds: 1)));
                } else if (endThreshold != null) {
                  // Legacy mode - include if before threshold
                  include = dueDate.isBefore(endThreshold);
                }

                if (include) {
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
          }

          // 2. Fetch Sprints (Once per task update is not ideal, but okay for "Home" view)
          // To improve, we should use BehaviorSubject or similar.
          try {
             // Fetch projects first
             final projectsSnap = await _firestore
                .collection('agile_projects')
                .where('participantEmails', arrayContains: trimmedEmail.toLowerCase())
                .get();
             
             final projectIds = projectsSnap.docs.map((doc) => doc.id).toList();
             
             if (projectIds.isNotEmpty) {
                final sprintSnap = await _firestore
                    .collectionGroup('sprints')
                    .where('projectId', whereIn: projectIds.take(30).toList())
                    .where('status', isEqualTo: 'active')
                    .get();

                for (var doc in sprintSnap.docs) {
                  final data = doc.data();
                  final endDate = (data['endDate'] as Timestamp?)?.toDate();
                  if (endDate != null) {
                    // Check if endDate falls within the filter range
                    bool include = false;
                    if (startThreshold == null && endThreshold == null) {
                      // "All" mode - include all
                      include = true;
                    } else if (startThreshold != null && endThreshold != null) {
                      // Exact day mode
                      include = !endDate.isBefore(startThreshold) && endDate.isBefore(endThreshold.add(const Duration(seconds: 1)));
                    } else if (endThreshold != null) {
                      // Legacy mode
                      include = endDate.isBefore(endThreshold);
                    }

                    if (include) {
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
             }
          } catch (e) {
            // Silently ignore - sprints/agile_projects may not exist in this app
            // Continue with just tasks
          }

          // Sort by date
          items.sort((a, b) => a.date.compareTo(b.date));
          // debugPrint('DEBUG: DeadlineService yielding ${items.length} items');
          return items;
        }).handleError((e) {
             debugPrint('DEBUG: DeadlineService Stream Error: $e');
             // If it's an index error, rethrow or return empty?
             // If we return empty, user sees "No upcoming". 
             // Better to let UI handle error if possible, but StreamBuilder handles it.
             throw e; 
        });
  }
}

