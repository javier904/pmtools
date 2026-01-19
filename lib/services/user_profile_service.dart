import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile/user_profile_model.dart' as profile_model;
import '../models/user_profile/subscription_model.dart';
import '../models/user_profile/user_settings_model.dart';

// Re-export per uso esterno
export '../models/user_profile/user_profile_model.dart';

/// Service per gestione profilo utente - Modulare e riutilizzabile
///
/// Gestisce:
/// - CRUD profilo utente
/// - Gestione abbonamenti
/// - Impostazioni utente
/// - Storico modifiche abbonamento
class UserProfileService {
  static final UserProfileService _instance = UserProfileService._internal();
  factory UserProfileService() => _instance;
  UserProfileService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection names
  static const String _usersCollection = 'users';
  static const String _subscriptionsSubcollection = 'subscription';
  static const String _settingsSubcollection = 'settings';
  static const String _subscriptionHistorySubcollection = 'subscription_history';

  // Cache locale
  profile_model.UserProfileModel? _cachedProfile;
  SubscriptionModel? _cachedSubscription;
  UserSettingsModel? _cachedSettings;

  /// Ottiene l'ID dell'utente corrente
  String? get currentUserId => _auth.currentUser?.uid;

  /// Ottiene l'email dell'utente corrente
  String? get currentUserEmail => _auth.currentUser?.email;

  // ═══════════════════════════════════════════════════════════════════════════
  // USER PROFILE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Crea o aggiorna il profilo utente dopo il login
  Future<profile_model.UserProfileModel> createOrUpdateProfileFromAuth({
    profile_model.AuthProvider provider = profile_model.AuthProvider.email,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Utente non autenticato');
    }

    final docRef = _firestore.collection(_usersCollection).doc(user.uid);
    final doc = await docRef.get();

    profile_model.UserProfileModel userProfile;

    if (doc.exists) {
      // Aggiorna lastLoginAt
      userProfile = profile_model.UserProfileModel.fromFirestore(doc);
      userProfile = userProfile.copyWith(lastLoginAt: DateTime.now());
      await docRef.update({
        'lastLoginAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } else {
      // Crea nuovo profilo
      userProfile = profile_model.UserProfileModel.fromAuthUser(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        provider: provider,
      );
      await docRef.set(userProfile.toFirestore());

      // Crea anche subscription e settings di default
      await _createDefaultSubscription(user.uid);
      await _createDefaultSettings(user.uid);
    }

    _cachedProfile = userProfile;
    return userProfile;
  }

  /// Ottiene il profilo utente corrente
  Future<profile_model.UserProfileModel?> getCurrentProfile() async {
    if (_cachedProfile != null) return _cachedProfile;

    final userId = currentUserId;
    if (userId == null) return null;

    return getProfile(userId);
  }

  /// Ottiene un profilo utente per ID
  Future<profile_model.UserProfileModel?> getProfile(String userId) async {
    final doc = await _firestore.collection(_usersCollection).doc(userId).get();
    if (!doc.exists) return null;

    _cachedProfile = profile_model.UserProfileModel.fromFirestore(doc);
    return _cachedProfile;
  }

  /// Stream del profilo utente corrente
  Stream<profile_model.UserProfileModel?> streamCurrentProfile() {
    final userId = currentUserId;
    if (userId == null) return Stream.value(null);

    return _firestore
        .collection(_usersCollection)
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      _cachedProfile = profile_model.UserProfileModel.fromFirestore(doc);
      return _cachedProfile;
    });
  }

  /// Aggiorna il profilo utente
  Future<void> updateProfile(profile_model.UserProfileModel userProfile) async {
    await _firestore
        .collection(_usersCollection)
        .doc(userProfile.id)
        .set(
          userProfile.copyWith(updatedAt: DateTime.now()).toFirestore(),
          SetOptions(merge: true),
        );
    _cachedProfile = userProfile;
  }

  /// Aggiorna campi specifici del profilo
  Future<void> updateProfileFields(Map<String, dynamic> fields) async {
    final userId = currentUserId;
    if (userId == null) throw Exception('Utente non autenticato');

    fields['updatedAt'] = Timestamp.fromDate(DateTime.now());
    await _firestore.collection(_usersCollection).doc(userId).update(fields);
    _cachedProfile = null; // Invalida cache
  }

  /// Richiede cancellazione account
  Future<void> requestAccountDeletion(String reason) async {
    final userId = currentUserId;
    if (userId == null) throw Exception('Utente non autenticato');

    await _firestore.collection(_usersCollection).doc(userId).update({
      'status': profile_model.AccountStatus.pendingDeletion.name,
      'deletionRequestedAt': DateTime.now().toIso8601String(),
      'deletionReason': reason,
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });

    _cachedProfile = null;
  }

  /// Annulla richiesta cancellazione account
  Future<void> cancelDeletionRequest() async {
    final userId = currentUserId;
    if (userId == null) throw Exception('Utente non autenticato');

    await _firestore.collection(_usersCollection).doc(userId).update({
      'status': profile_model.AccountStatus.active.name,
      'deletionRequestedAt': null,
      'deletionReason': null,
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });

    _cachedProfile = null;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SUBSCRIPTION
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> _createDefaultSubscription(String userId) async {
    final subscription = SubscriptionModel.freeDefault(userId);
    await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_subscriptionsSubcollection)
        .doc('current')
        .set(subscription.toFirestore());
  }

  /// Ottiene l'abbonamento corrente
  Future<SubscriptionModel?> getCurrentSubscription() async {
    if (_cachedSubscription != null) return _cachedSubscription;

    final userId = currentUserId;
    if (userId == null) return null;

    final doc = await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_subscriptionsSubcollection)
        .doc('current')
        .get();

    if (!doc.exists) return null;

    _cachedSubscription = SubscriptionModel.fromFirestore(doc);
    return _cachedSubscription;
  }

  /// Stream dell'abbonamento corrente
  Stream<SubscriptionModel?> streamCurrentSubscription() {
    final userId = currentUserId;
    if (userId == null) return Stream.value(null);

    return _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_subscriptionsSubcollection)
        .doc('current')
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      _cachedSubscription = SubscriptionModel.fromFirestore(doc);
      return _cachedSubscription;
    });
  }

  /// Aggiorna l'abbonamento
  Future<void> updateSubscription(
    SubscriptionModel subscription, {
    required SubscriptionHistoryAction action,
    String? notes,
  }) async {
    final userId = currentUserId;
    if (userId == null) throw Exception('Utente non autenticato');

    // Salva abbonamento corrente
    await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_subscriptionsSubcollection)
        .doc('current')
        .set(subscription.copyWith(updatedAt: DateTime.now()).toFirestore());

    // Aggiungi allo storico
    await _addSubscriptionHistory(
      userId: userId,
      subscriptionId: subscription.id,
      action: action,
      newPlan: subscription.plan,
      newStatus: subscription.status,
      reason: notes,
    );

    _cachedSubscription = subscription;
  }

  /// Attiva un piano di abbonamento
  Future<void> activateSubscription({
    required SubscriptionPlan plan,
    required BillingCycle billingCycle,
    String? paymentMethodId,
    String? externalSubscriptionId,
    bool startTrial = false,
  }) async {
    final userId = currentUserId;
    if (userId == null) throw Exception('Utente non autenticato');

    final now = DateTime.now();
    DateTime endDate;
    DateTime? trialEnd;

    if (startTrial && plan.trialDays > 0) {
      trialEnd = now.add(Duration(days: plan.trialDays));
      endDate = trialEnd;
    } else {
      switch (billingCycle) {
        case BillingCycle.monthly:
          endDate = DateTime(now.year, now.month + 1, now.day);
        case BillingCycle.quarterly:
          endDate = DateTime(now.year, now.month + 3, now.day);
        case BillingCycle.yearly:
          endDate = DateTime(now.year + 1, now.month, now.day);
        case BillingCycle.lifetime:
          endDate = DateTime(2099, 12, 31);
      }
    }

    final subscription = SubscriptionModel(
      id: 'current',
      userId: userId,
      plan: plan,
      status: startTrial ? SubscriptionStatus.trialing : SubscriptionStatus.active,
      billingCycle: billingCycle,
      startDate: now,
      endDate: endDate,
      trialEndDate: trialEnd,
      nextBillingDate: startTrial ? null : endDate,
      price: plan.monthlyPrice * billingCycle.months,
      paymentMethodId: paymentMethodId,
      externalSubscriptionId: externalSubscriptionId,
      createdAt: now,
      updatedAt: now,
    );

    await updateSubscription(
      subscription,
      action: startTrial
          ? SubscriptionHistoryAction.trialStarted
          : SubscriptionHistoryAction.created,
    );
  }

  /// Annulla l'abbonamento
  Future<void> cancelSubscription({String? reason}) async {
    final current = await getCurrentSubscription();
    if (current == null) return;

    final updated = current.copyWith(
      status: SubscriptionStatus.cancelled,
      cancelAtPeriodEnd: true,
      cancelledAt: DateTime.now(),
      cancellationReason: reason,
    );

    await updateSubscription(
      updated,
      action: SubscriptionHistoryAction.cancelled,
      notes: reason,
    );
  }

  /// Ottiene lo storico abbonamenti
  Future<List<SubscriptionHistoryModel>> getSubscriptionHistory() async {
    final userId = currentUserId;
    if (userId == null) return [];

    final query = await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_subscriptionHistorySubcollection)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    return query.docs
        .map((doc) => SubscriptionHistoryModel.fromFirestore(doc))
        .toList();
  }

  Future<void> _addSubscriptionHistory({
    required String userId,
    required String subscriptionId,
    required SubscriptionHistoryAction action,
    SubscriptionPlan? previousPlan,
    SubscriptionPlan? newPlan,
    SubscriptionStatus? previousStatus,
    SubscriptionStatus? newStatus,
    String? reason,
  }) async {
    final history = SubscriptionHistoryModel(
      id: '',
      subscriptionId: subscriptionId,
      userId: userId,
      action: action,
      previousPlan: previousPlan,
      newPlan: newPlan,
      previousStatus: previousStatus,
      newStatus: newStatus,
      reason: reason,
      createdAt: DateTime.now(),
    );

    await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_subscriptionHistorySubcollection)
        .add(history.toFirestore());
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> _createDefaultSettings(String userId) async {
    final settings = UserSettingsModel.defaultSettings(userId);
    await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_settingsSubcollection)
        .doc('preferences')
        .set(settings.toFirestore());
  }

  /// Ottiene le impostazioni correnti
  Future<UserSettingsModel?> getCurrentSettings() async {
    if (_cachedSettings != null) return _cachedSettings;

    final userId = currentUserId;
    if (userId == null) return null;

    final doc = await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_settingsSubcollection)
        .doc('preferences')
        .get();

    if (!doc.exists) return null;

    _cachedSettings = UserSettingsModel.fromFirestore(userId, doc.data()!);
    return _cachedSettings;
  }

  /// Stream delle impostazioni correnti
  Stream<UserSettingsModel?> streamCurrentSettings() {
    final userId = currentUserId;
    if (userId == null) return Stream.value(null);

    return _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_settingsSubcollection)
        .doc('preferences')
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      _cachedSettings = UserSettingsModel.fromFirestore(userId, doc.data()!);
      return _cachedSettings;
    });
  }

  /// Aggiorna le impostazioni
  Future<void> updateSettings(UserSettingsModel settings) async {
    final userId = currentUserId;
    if (userId == null) throw Exception('Utente non autenticato');

    await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_settingsSubcollection)
        .doc('preferences')
        .set(settings.copyWith(updatedAt: DateTime.now()).toFirestore());

    _cachedSettings = settings;
  }

  /// Aggiorna il tema
  Future<void> updateTheme(ThemePreference theme) async {
    final settings = await getCurrentSettings();
    if (settings == null) return;

    await updateSettings(settings.copyWith(themeMode: theme));
  }

  /// Aggiorna le notifiche
  Future<void> updateNotifications(NotificationSettings notifications) async {
    final settings = await getCurrentSettings();
    if (settings == null) return;

    await updateSettings(settings.copyWith(notifications: notifications));
  }

  /// Aggiorna i feature flags
  Future<void> updateFeatureFlags(FeatureFlags flags) async {
    final settings = await getCurrentSettings();
    if (settings == null) return;

    await updateSettings(settings.copyWith(featureFlags: flags));
  }

  /// Aggiorna un singolo feature flag
  Future<void> toggleFeatureFlag(String flagName, bool enabled) async {
    final settings = await getCurrentSettings();
    if (settings == null) return;

    final currentFlags = settings.featureFlags.toMap();
    currentFlags[flagName] = enabled;

    await updateSettings(
      settings.copyWith(featureFlags: FeatureFlags.fromMap(currentFlags)),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CACHE MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════

  /// Invalida tutte le cache
  void invalidateCache() {
    _cachedProfile = null;
    _cachedSubscription = null;
    _cachedSettings = null;
  }

  /// Chiamato al logout
  void onLogout() {
    invalidateCache();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Verifica se l'utente ha un abbonamento attivo
  Future<bool> hasActiveSubscription() async {
    final subscription = await getCurrentSubscription();
    return subscription?.isActive ?? false;
  }

  /// Verifica se una feature è abilitata
  Future<bool> isFeatureEnabled(String featureName) async {
    final settings = await getCurrentSettings();
    return settings?.featureFlags.isEnabled(featureName) ?? false;
  }

  /// Ottiene tutti i dati utente in una volta
  Future<({
    profile_model.UserProfileModel? profile,
    SubscriptionModel? subscription,
    UserSettingsModel? settings,
  })> getAllUserData() async {
    final results = await Future.wait([
      getCurrentProfile(),
      getCurrentSubscription(),
      getCurrentSettings(),
    ]);

    return (
      profile: results[0] as profile_model.UserProfileModel?,
      subscription: results[1] as SubscriptionModel?,
      settings: results[2] as UserSettingsModel?,
    );
  }
}
