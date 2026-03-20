import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile/user_profile_model.dart';
import '../models/user_profile/user_settings_model.dart';

class AdminUserMetrics {
  final UserProfileModel profile;
  final UserSettingsModel? settings;
  final int loginCount;
  final int? feedbackRating;
  final String? feedbackComment;
  final DateTime? feedbackRatedAt;

  AdminUserMetrics({
    required this.profile,
    this.settings,
    this.loginCount = 0,
    this.feedbackRating,
    this.feedbackComment,
    this.feedbackRatedAt,
  });
}

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<AdminUserMetrics>> getAllUsersMetrics() async {
    QuerySnapshot usersSnapshot;
    try {
      usersSnapshot = await _firestore.collection('users').get();
    } catch (e) {
      throw Exception('Failed to fetch users collection: $e');
    }
    
    List<AdminUserMetrics> metricsList = [];

    for (var doc in usersSnapshot.docs) {
      final profile = UserProfileModel.fromFirestore(doc);
      
      UserSettingsModel? settings;
      int loginCount = 0;
      int? feedbackRating;
      String? feedbackComment;
      DateTime? feedbackRatedAt;

      // Fetch settings for this user safely
      try {
        final settingsDoc = await _firestore
            .collection('users')
            .doc(profile.id)
            .collection('settings')
            .doc('preferences')
            .get();

        if (settingsDoc.exists && settingsDoc.data() != null) {
          settings = UserSettingsModel.fromFirestore(profile.id, settingsDoc.data()!);
          loginCount = settings.getModuleSetting<int>('feedback', 'loginCount', defaultValue: 0) ?? 0;
          feedbackRating = settings.getModuleSetting<int>('feedback', 'rating');
          feedbackComment = settings.getModuleSetting<String>('feedback', 'comment');
          final ratedAtStr = settings.getModuleSetting<String>('feedback', 'ratedAt');
          if (ratedAtStr != null) {
            feedbackRatedAt = DateTime.tryParse(ratedAtStr);
          }
        }
      } catch (e) {
        print('Permission denied or error fetching settings for user ${profile.id}: $e');
        // Continue even if settings fail to read, so we at least see the users
      }

      metricsList.add(AdminUserMetrics(
        profile: profile,
        settings: settings,
        loginCount: loginCount,
        feedbackRating: feedbackRating,
        feedbackComment: feedbackComment,
        feedbackRatedAt: feedbackRatedAt,
      ));
    }

    return metricsList;
  }
}
