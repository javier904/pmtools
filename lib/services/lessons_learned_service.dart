import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agile_tools/models/lesson_learned_model.dart';

class LessonsLearnedService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference _lessonsCollection(String projectId) =>
      _db.collection('agile_projects').doc(projectId).collection('lessons_learned');

  /// Create a new lesson and return its document ID.
  Future<String> createLesson(String projectId, LessonLearnedModel lesson) async {
    final docRef = await _lessonsCollection(projectId).add(lesson.toFirestore());
    return docRef.id;
  }

  /// Update an existing lesson by its ID.
  Future<void> updateLesson(String projectId, LessonLearnedModel lesson) async {
    await _lessonsCollection(projectId).doc(lesson.id).update(lesson.toFirestore());
  }

  /// Delete a lesson by its ID.
  Future<void> deleteLesson(String projectId, String lessonId) async {
    await _lessonsCollection(projectId).doc(lessonId).delete();
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
  ) async {
    final now = DateTime.now();
    final importedLesson = lesson.copyWith(
      projectId: targetProjectId,
      createdBy: importerEmail,
      createdAt: now,
      updatedAt: now,
    );
    await _lessonsCollection(targetProjectId).add(importedLesson.toFirestore());
  }
}
