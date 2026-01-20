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

  /// Stream favorites excluding archived resources
  /// This method checks each resource to see if it's archived
  Stream<List<FavoriteModel>> streamFavoritesExcludingArchived() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value([]);

    return _favoritesRef(uid)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final favorites =
          snapshot.docs.map((doc) => FavoriteModel.fromFirestore(doc)).toList();

      // Check each resource for archive status
      final nonArchivedFavorites = <FavoriteModel>[];
      for (final favorite in favorites) {
        final isArchived = await _isResourceArchived(favorite.resourceId, favorite.type);
        if (!isArchived) {
          nonArchivedFavorites.add(favorite);
        }
      }
      return nonArchivedFavorites;
    });
  }

  /// Check if a resource is archived based on its type
  Future<bool> _isResourceArchived(String resourceId, String type) async {
    try {
      String collection;
      switch (type) {
        case 'todo_list':
          collection = 'smart_todo_lists';
          break;
        case 'eisenhower_matrix':
          collection = 'eisenhower_matrices';
          break;
        case 'agile_project':
          collection = 'agile_projects';
          break;
        case 'planning_poker':
        case 'poker':
          collection = 'planning_poker_sessions';
          break;
        case 'retrospective':
        case 'retro':
          collection = 'retrospectives';
          break;
        default:
          return false;
      }

      final doc = await _firestore.collection(collection).doc(resourceId).get();
      if (!doc.exists) return true; // Treat missing resource as archived (to filter out)

      final data = doc.data();
      return data?['isArchived'] == true;
    } catch (e) {
      print('Error checking archive status: $e');
      return false; // Default to not archived on error
    }
  }
}
