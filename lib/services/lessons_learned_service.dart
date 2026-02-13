import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agile_tools/models/lesson_learned_model.dart';
import 'agile_audit_service.dart';
import '../models/agile_enums.dart';

class LessonsLearnedService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference _lessonsCollection(String projectId) =>
      _db.collection('agile_projects').doc(projectId).collection('lessons_learned');

  /// Create a new lesson and return its document ID.
  Future<String> createLesson(String projectId, LessonLearnedModel lesson, {String? userName}) async {
    final docRef = await _lessonsCollection(projectId).add(lesson.toFirestore());
    
    await AgileAuditService().logCreate(
      projectId: projectId,
      entityType: AuditEntityType.lessonLearned,
      entityId: docRef.id,
      entityName: lesson.title,
      performedBy: lesson.createdBy,
      performedByName: userName ?? 'User',
      description: 'Creata nuova Lesson Learned',
      newValue: lesson.toFirestore(),
    );

    return docRef.id;
  }

  /// Update an existing lesson by its ID.
  Future<void> updateLesson(String projectId, LessonLearnedModel lesson, {String? userName}) async {
    final doc = await _lessonsCollection(projectId).doc(lesson.id).get();
    Map<String, dynamic>? previousValue;
    if (doc.exists) {
        previousValue = doc.data() as Map<String, dynamic>?;
    }

    await _lessonsCollection(projectId).doc(lesson.id).update(lesson.toFirestore());

    await AgileAuditService().logUpdate(
      projectId: projectId,
      entityType: AuditEntityType.lessonLearned,
      entityId: lesson.id,
      entityName: lesson.title,
      performedBy: lesson.createdBy, // Use creator or current user? Assuming current user for logs.
      performedByName: userName ?? 'User',
      previousValue: previousValue,
      newValue: lesson.toFirestore(),
      description: 'Aggiornata Lesson Learned',
    );
  }

  /// Delete a lesson by its ID.
  Future<void> deleteLesson(String projectId, String lessonId, {String? userId, String? userName}) async {
    final doc = await _lessonsCollection(projectId).doc(lessonId).get();
    if (!doc.exists) return;
    final lesson = LessonLearnedModel.fromFirestore(doc);

    await _lessonsCollection(projectId).doc(lessonId).delete();

    if (userId != null) {
      await AgileAuditService().logDelete(
        projectId: projectId,
        entityType: AuditEntityType.lessonLearned,
        entityId: lessonId,
        entityName: lesson.title,
        performedBy: userId,
        performedByName: userName ?? 'User',
        description: 'Eliminata Lesson Learned',
      );
    }
  }

  /// Stream all lessons for a project, ordered by createdAt descending.
  Stream<List<LessonLearnedModel>> streamProjectLessons(String projectId) {
    return _lessonsCollection(projectId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LessonLearnedModel.fromFirestore(doc))
            .toList());
  }

  /// Get all lessons for a project as a one-time fetch, ordered by createdAt descending.
  Future<List<LessonLearnedModel>> getProjectLessons(String projectId) async {
    final snapshot = await _lessonsCollection(projectId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => LessonLearnedModel.fromFirestore(doc))
        .toList();
  }

  /// Fetch lessons from multiple projects and merge results (for cross-project import).
  Future<List<LessonLearnedModel>> getLessonsFromProjects(List<String> projectIds) async {
    final List<LessonLearnedModel> allLessons = [];
    for (final projectId in projectIds) {
      final lessons = await getProjectLessons(projectId);
      allLessons.addAll(lessons);
    }
    allLessons.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return allLessons;
  }

  /// Import a lesson from another project into the target project.
  /// Creates a copy with new projectId, timestamps, and the importer as createdBy.
  Future<void> importLessonToProject(
    String targetProjectId,
    LessonLearnedModel lesson,
    String importerEmail,
    {String? importerName}
  ) async {
    final now = DateTime.now();
    final importedLesson = lesson.copyWith(
      projectId: targetProjectId,
      createdBy: importerEmail,
      createdAt: now,
      updatedAt: now,
    );
    final docRef = await _lessonsCollection(targetProjectId).add(importedLesson.toFirestore());

    await AgileAuditService().logCreate(
      projectId: targetProjectId,
      entityType: AuditEntityType.lessonLearned,
      entityId: docRef.id,
      entityName: lesson.title,
      performedBy: importerEmail,
      performedByName: importerName ?? 'User',
      description: 'Importata Lesson Learned dal progetto ${lesson.importedFromProjectName ?? 'esterno'}',
    );
  }
}
