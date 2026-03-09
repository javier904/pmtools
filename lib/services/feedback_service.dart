import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/feedback_model.dart';
import 'auth_service.dart';

class FeedbackService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('system_feedback');

  /// Creates a new feedback entry in Firestore
  Future<String> submitFeedback(FeedbackModel feedback) async {
    final user = _authService.currentUser;
    if (user == null) throw Exception('User must be logged in to submit feedback');

    final docRef = _collection.doc();
    
    // Ensure the email matches the authenticated user for security purposes
    final secureFeedback = feedback.copyWith(
      id: docRef.id,
      userEmail: user.email?.toLowerCase() ?? '',
      createdAt: DateTime.now(),
      status: FeedbackStatus.newRequest,
    );

    await docRef.set(secureFeedback.toFirestore());
    return docRef.id;
  }

  /// Retrieves a stream of feedback items submitted by a specific user
  Stream<List<FeedbackModel>> getUserFeedback(String email) {
    return _collection
        .where('userEmail', isEqualTo: email.toLowerCase())
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => FeedbackModel.fromFirestore(doc)).toList();
    });
  }

  /// Retrieves a stream of ALL feedback items (Intended for Admin use)
  Stream<List<FeedbackModel>> getAllFeedback() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => FeedbackModel.fromFirestore(doc)).toList();
    });
  }

  /// Updates the status of a feedback item (Intended for Admin use)
  Future<void> updateFeedbackStatus(String id, FeedbackStatus newStatus) async {
    await _collection.doc(id).update({
      'status': newStatus.name,
    });
  }
}
