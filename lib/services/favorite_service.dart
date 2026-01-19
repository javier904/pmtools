import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteModel {
  final String id;
  final String resourceId;
  final String type; // todo_list, eisenhower_matrix, agile_project, retro, poker
  final String title;
  final String? colorHex;
  final DateTime addedAt;

  FavoriteModel({
    required this.id,
    required this.resourceId,
    required this.type,
    required this.title,
    this.colorHex,
    required this.addedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'resourceId': resourceId,
      'type': type,
      'title': title,
      'colorHex': colorHex,
      'addedAt': Timestamp.fromDate(addedAt),
    };
  }

  factory FavoriteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      id: doc.id,
      resourceId: data['resourceId'] ?? '',
      type: data['type'] ?? '',
      title: data['title'] ?? '',
      colorHex: data['colorHex'],
      addedAt: (data['addedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  CollectionReference _favoritesRef(String uid) =>
      _firestore.collection('users').doc(uid).collection('favorites');

  /// Toggle favorite status
  Future<void> toggleFavorite({
    required String resourceId,
    required String type,
    required String title,
    String? colorHex,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final ref = _favoritesRef(uid);
    final query = await ref.where('resourceId', isEqualTo: resourceId).limit(1).get();

    if (query.docs.isNotEmpty) {
      await query.docs.first.reference.delete();
    } else {
      await ref.add({
        'resourceId': resourceId,
        'type': type,
        'title': title,
        'colorHex': colorHex,
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Stream all favorites for user
  Stream<List<FavoriteModel>> streamFavorites() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value([]);

    return _favoritesRef(uid)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => FavoriteModel.fromFirestore(doc)).toList());
  }

  /// Check if resource is favorited
  Stream<bool> isFavorite(String resourceId) {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value(false);

    return _favoritesRef(uid)
        .where('resourceId', isEqualTo: resourceId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }
}
