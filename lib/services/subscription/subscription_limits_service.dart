import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../models/subscription/subscription_limits_model.dart';
import '../../models/user_profile/subscription_model.dart';
import '../user_profile_service.dart';

/// Service per controllare e applicare i limiti di abbonamento
///
/// Singleton pattern come altri servizi dell'app.
/// Fornisce:
/// - Controllo limiti correnti
/// - Conteggio utilizzo
/// - Enforcement limiti prima delle operazioni di creazione
/// - Cache per performance
class SubscriptionLimitsService {
  static final SubscriptionLimitsService _instance = SubscriptionLimitsService._internal();
  factory SubscriptionLimitsService() => _instance;
  SubscriptionLimitsService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final UserProfileService _profileService = UserProfileService();

  // Cache
  SubscriptionLimits? _cachedLimits;
  DateTime? _limitsCacheTime;
  static const Duration _cacheValidityDuration = Duration(minutes: 5);

  // ═══════════════════════════════════════════════════════════════════════════
  // LIMITI CORRENTI
  // ═══════════════════════════════════════════════════════════════════════════

  /// Ottiene i limiti dell'abbonamento corrente dell'utente
  Future<SubscriptionLimits> getCurrentLimits() async {
    // Check cache
    if (_cachedLimits != null && _limitsCacheTime != null) {
      if (DateTime.now().difference(_limitsCacheTime!) < _cacheValidityDuration) {
        return _cachedLimits!;
      }
    }

    final subscription = await _profileService.getCurrentSubscription();
    final plan = subscription?.plan ?? SubscriptionPlan.free;

    // Verifica se abbonamento attivo
    final isActive = subscription?.isActive ?? false;
    final isInTrial = subscription?.isInTrial ?? false;
    final effectivePlan = (isActive || isInTrial) ? plan : SubscriptionPlan.free;

    _cachedLimits = SubscriptionLimits.forPlan(effectivePlan);
    _limitsCacheTime = DateTime.now();

    return _cachedLimits!;
  }

  /// Invalida la cache dei limiti (chiamare dopo cambi subscription)
  void invalidateCache() {
    _cachedLimits = null;
    _limitsCacheTime = null;
  }

  /// Callback da chiamare al logout
  void onLogout() {
    invalidateCache();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONTEGGIO UTILIZZO
  // ═══════════════════════════════════════════════════════════════════════════

  /// Conta le matrici Eisenhower dell'utente (come creatore)
  /// Esclude le matrici archiviate
  Future<int> countEisenhowerMatrices(String userEmail) async {
    try {
      final snapshot = await _firestore
          .collection('eisenhower_matrices')
          .where('createdBy', isEqualTo: userEmail.toLowerCase())
          .where('isArchived', isEqualTo: false)
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      // Fallback per backward compatibility (documenti senza isArchived)
      try {
        final snapshot = await _firestore
            .collection('eisenhower_matrices')
            .where('createdBy', isEqualTo: userEmail.toLowerCase())
            .count()
            .get();
        return snapshot.count ?? 0;
      } catch (e2) {
        // Blocca creazione in caso di errore (safety measure)
        return 999;
      }
    }
  }

  /// Conta le sessioni Estimation Room attive dell'utente
  /// Esclude le sessioni archiviate, completate e quelle con tutte le storie stimate
  /// Una sessione conta verso il limite solo se ha storie ancora da stimare
  /// Usa participantEmails (sempre lowercase) per trovare sessioni dell'utente,
  /// poi filtra client-side per createdBy (case-insensitive) per contare solo le proprie
  Future<int> countEstimationSessions(String userEmail) async {
    final emailLower = userEmail.toLowerCase();
    try {
      // Query tramite participantEmails (sempre stored in lowercase)
      // Questo trova sia sessioni vecchie (createdBy mixed case) che nuove (lowercase)
      final snapshot = await _firestore
          .collection('planning_poker_sessions')
          .where('participantEmails', arrayContains: emailLower)
          .get();

      int count = 0;
      for (final doc in snapshot.docs) {
        final data = doc.data();
        // Filtra solo sessioni CREATE dall'utente (case-insensitive)
        final createdBy = (data['createdBy'] as String?)?.toLowerCase() ?? '';
        if (createdBy != emailLower) continue;

        // Escludi archiviate
        final isArchived = data['isArchived'] ?? false;
        if (isArchived == true) continue;

        // Escludi completate
        final status = data['status'] ?? '';
        if (status == 'completed') continue;

        // Sessione conta verso il limite se ha storie ancora da stimare
        final storyCount = data['storyCount'] ?? 0;
        final completedStoryCount = data['completedStoryCount'] ?? 0;
        if (storyCount == 0 || storyCount > completedStoryCount) {
          count++;
        }
      }
      return count;
    } catch (e) {
      // Fallback: query diretta per createdBy lowercase
      try {
        final snapshot = await _firestore
            .collection('planning_poker_sessions')
            .where('createdBy', isEqualTo: emailLower)
            .get();

        int count = 0;
        for (final doc in snapshot.docs) {
          final data = doc.data();
          final isArchived = data['isArchived'] ?? false;
          if (isArchived == true) continue;
          final status = data['status'] ?? '';
          if (status == 'completed') continue;
          final storyCount = data['storyCount'] ?? 0;
          final completedStoryCount = data['completedStoryCount'] ?? 0;
          if (storyCount == 0 || storyCount > completedStoryCount) {
            count++;
          }
        }
        return count;
      } catch (e2) {
        // Blocca creazione in caso di errore (safety measure)
        return 999;
      }
    }
  }

  /// Conta le retrospettive dell'utente
  Future<int> countRetrospectives(String userEmail) async {
    try {
      final snapshot = await _firestore
          .collection('retrospectives')
          .where('createdBy', isEqualTo: userEmail.toLowerCase())
          .where('isArchived', isEqualTo: false)
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      // Fallback senza isArchived per backward compatibility
      try {
        final snapshot = await _firestore
            .collection('retrospectives')
            .where('createdBy', isEqualTo: userEmail.toLowerCase())
            .count()
            .get();
        return snapshot.count ?? 0;
      } catch (e2) {
        // Blocca creazione in caso di errore (safety measure)
        return 999;
      }
    }
  }

  /// Conta le liste Smart Todo dell'utente (attive = non archiviate)
  /// Usa participantEmails (sempre lowercase) per trovare liste dell'utente,
  /// poi filtra client-side per ownerId (case-insensitive) per contare solo le proprie
  Future<int> countSmartTodoLists(String userEmail) async {
    final emailLower = userEmail.toLowerCase();
    try {
      // Query tramite participantEmails (sempre stored in lowercase)
      final snapshot = await _firestore
          .collection('smart_todo_lists')
          .where('participantEmails', arrayContains: emailLower)
          .get();

      int count = 0;
      for (final doc in snapshot.docs) {
        final data = doc.data();
        // Filtra solo liste CREATE dall'utente (case-insensitive)
        final ownerId = (data['ownerId'] as String?)?.toLowerCase() ?? '';
        final ownerEmail = (data['ownerEmail'] as String?)?.toLowerCase() ?? '';
        if (ownerId != emailLower && ownerEmail != emailLower) continue;

        // Escludi archiviate
        final isArchived = data['isArchived'] ?? false;
        if (isArchived == true) continue;

        count++;
      }
      return count;
    } catch (e) {
      // Fallback: query diretta per ownerId
      try {
        final snapshot = await _firestore
            .collection('smart_todo_lists')
            .where('ownerId', isEqualTo: emailLower)
            .get();

        int count = 0;
        for (final doc in snapshot.docs) {
          final data = doc.data();
          final isArchived = data['isArchived'] ?? false;
          if (isArchived == true) continue;
          count++;
        }
        return count;
      } catch (e2) {
        // Blocca creazione in caso di errore (safety measure)
        return 999;
      }
    }
  }

  /// Conta il totale "progetti" (matrici + sessioni + retro)
  /// NON include liste Smart Todo (contate separatamente)
  Future<int> countTotalProjects(String userEmail) async {
    final results = await Future.wait<int>([
      countEisenhowerMatrices(userEmail),
      countEstimationSessions(userEmail),
      countRetrospectives(userEmail),
    ]);
    return results.fold<int>(0, (sum, count) => sum + count);
  }

  /// Conta le attivita in un'entita specifica
  /// Esclude elementi completati e archiviati dove applicabile
  Future<int> countTasksInEntity({
    required String entityType,
    required String entityId,
  }) async {
    String collection;
    String subcollection;

    switch (entityType) {
      case 'eisenhower':
        collection = 'eisenhower_matrices';
        subcollection = 'activities';
        break;
      case 'estimation':
        collection = 'planning_poker_sessions';
        subcollection = 'stories';
        break;
      case 'smart_todo':
        collection = 'smart_todo_lists';
        subcollection = 'smart_todo_tasks';
        break;
      case 'retrospective':
        collection = 'retrospectives';
        subcollection = 'items';
        break;
      default:
        return 0;
    }

    try {
      // Per Eisenhower e Smart Todo, escludiamo completati e archiviati
      if (entityType == 'eisenhower') {
        final snapshot = await _firestore
            .collection(collection)
            .doc(entityId)
            .collection(subcollection)
            .where('isCompleted', isEqualTo: false)
            .where('isArchived', isEqualTo: false)
            .count()
            .get();
        return snapshot.count ?? 0;
      } else if (entityType == 'smart_todo') {
        // Smart Todo tasks: escludiamo solo archiviati (completati rimangono visibili)
        final snapshot = await _firestore
            .collection(collection)
            .doc(entityId)
            .collection(subcollection)
            .where('isArchived', isEqualTo: false)
            .count()
            .get();
        return snapshot.count ?? 0;
      } else {
        // Altri tipi: conteggio semplice
        final snapshot = await _firestore
            .collection(collection)
            .doc(entityId)
            .collection(subcollection)
            .count()
            .get();
        return snapshot.count ?? 0;
      }
    } catch (e) {
      // Fallback senza filtri per backward compatibility
      try {
        final snapshot = await _firestore
            .collection(collection)
            .doc(entityId)
            .collection(subcollection)
            .count()
            .get();
        return snapshot.count ?? 0;
      } catch (e2) {
        return 0;
      }
    }
  }

  /// Conta i partecipanti/inviti per un'entita
  Future<int> countInvitesForEntity({
    required String entityType,
    required String entityId,
  }) async {
    final doc = await _getEntityDocument(entityType, entityId);
    if (doc == null || !doc.exists) return 0;

    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) return 0;

    // Conta partecipanti attivi + inviti pending
    final participants = data['participants'] as Map<String, dynamic>?;
    final pendingEmails = data['pendingEmails'] as List?;

    final participantCount = participants?.length ?? 0;
    final pendingCount = pendingEmails?.length ?? 0;

    // Sottrae 1 per escludere il creatore dal conteggio
    return (participantCount + pendingCount - 1).clamp(0, 999);
  }

  Future<DocumentSnapshot?> _getEntityDocument(String entityType, String entityId) async {
    String collection;
    switch (entityType) {
      case 'eisenhower':
        collection = 'eisenhower_matrices';
        break;
      case 'estimation':
        collection = 'planning_poker_sessions';
        break;
      case 'smart_todo':
        collection = 'smart_todo_lists';
        break;
      case 'retrospective':
        collection = 'retrospectives';
        break;
      default:
        return null;
    }

    try {
      return await _firestore.collection(collection).doc(entityId).get();
    } catch (e) {
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLLO LIMITI
  // ═══════════════════════════════════════════════════════════════════════════

  /// Verifica se l'utente puo creare una nuova entità del tipo specificato
  /// Ogni tipo ha il suo limite SEPARATO (non sommato)
  /// entityType: 'eisenhower', 'estimation', 'retrospective', 'agile_project'
  Future<LimitCheckResult> canCreateProject(String userEmail, {String entityType = 'eisenhower'}) async {
    final limits = await getCurrentLimits();
    if (limits.isUnlimitedProjects) {
      return LimitCheckResult.allowed();
    }

    // Conta solo le entità del tipo specificato (NON sommate)
    final currentCount = await _countEntitiesByType(userEmail, entityType);
    final entityLabel = _getEntityLabel(entityType);

    if (currentCount >= limits.maxActiveProjects) {
      return LimitCheckResult.denied(
        reason: 'Hai raggiunto il limite di ${limits.maxActiveProjects} $entityLabel.',
        currentCount: currentCount,
        limit: limits.maxActiveProjects,
        upgradeRequired: true,
        suggestedPlan: _getSuggestedPlanForProjects(currentCount),
      );
    }

    return LimitCheckResult.allowed(
      currentCount: currentCount,
      limit: limits.maxActiveProjects,
    );
  }

  /// Conta le entità di un tipo specifico per l'utente
  Future<int> _countEntitiesByType(String userEmail, String entityType) async {
    switch (entityType) {
      case 'eisenhower':
        return countEisenhowerMatrices(userEmail);
      case 'estimation':
        return countEstimationSessions(userEmail);
      case 'retrospective':
        return countRetrospectives(userEmail);
      case 'agile_project':
        return _countAgileProjects(userEmail);
      default:
        return 0;
    }
  }

  /// Conta i progetti Agile dell'utente
  /// Esclude i progetti archiviati
  Future<int> _countAgileProjects(String userEmail) async {
    try {
      final snapshot = await _firestore
          .collection('agile_projects')
          .where('createdBy', isEqualTo: userEmail.toLowerCase())
          .where('isArchived', isEqualTo: false)
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      // Fallback per backward compatibility (documenti senza isArchived)
      try {
        final snapshot = await _firestore
            .collection('agile_projects')
            .where('createdBy', isEqualTo: userEmail.toLowerCase())
            .count()
            .get();
        return snapshot.count ?? 0;
      } catch (e2) {
        // Blocca creazione in caso di errore (safety measure)
        return 999;
      }
    }
  }

  /// Restituisce l'etichetta per il tipo di entità
  String _getEntityLabel(String entityType) {
    switch (entityType) {
      case 'eisenhower':
        return 'matrici Eisenhower';
      case 'estimation':
        return 'sessioni Estimation';
      case 'retrospective':
        return 'retrospettive';
      case 'agile_project':
        return 'progetti Agile';
      default:
        return 'entità';
    }
  }

  /// Verifica se l'utente puo creare una nuova lista Smart Todo
  Future<LimitCheckResult> canCreateList(String userEmail) async {
    final limits = await getCurrentLimits();
    if (limits.isUnlimitedLists) {
      return LimitCheckResult.allowed();
    }

    final currentCount = await countSmartTodoLists(userEmail);
    if (currentCount >= limits.maxActiveLists) {
      return LimitCheckResult.denied(
        reason: 'Hai raggiunto il limite di ${limits.maxActiveLists} liste attive.',
        currentCount: currentCount,
        limit: limits.maxActiveLists,
        upgradeRequired: true,
        suggestedPlan: _getSuggestedPlanForLists(currentCount),
      );
    }

    return LimitCheckResult.allowed(
      currentCount: currentCount,
      limit: limits.maxActiveLists,
    );
  }

  /// Verifica se l'utente puo aggiungere un task a un'entita
  Future<LimitCheckResult> canAddTask({
    required String entityType,
    required String entityId,
  }) async {
    final limits = await getCurrentLimits();
    if (limits.isUnlimitedTasks) {
      return LimitCheckResult.allowed();
    }

    final currentCount = await countTasksInEntity(
      entityType: entityType,
      entityId: entityId,
    );

    if (currentCount >= limits.maxTasksPerEntity) {
      return LimitCheckResult.denied(
        reason: 'Hai raggiunto il limite di ${limits.maxTasksPerEntity} attivita per questo progetto.',
        currentCount: currentCount,
        limit: limits.maxTasksPerEntity,
        upgradeRequired: true,
        suggestedPlan: 'premium',
      );
    }

    return LimitCheckResult.allowed(
      currentCount: currentCount,
      limit: limits.maxTasksPerEntity,
    );
  }

  /// Verifica se l'utente puo invitare qualcuno a un'entita
  Future<LimitCheckResult> canInvite({
    required String entityType,
    required String entityId,
  }) async {
    final limits = await getCurrentLimits();
    if (limits.isUnlimitedInvites) {
      return LimitCheckResult.allowed();
    }

    final currentCount = await countInvitesForEntity(
      entityType: entityType,
      entityId: entityId,
    );

    if (currentCount >= limits.maxInvitesPerEntity) {
      return LimitCheckResult.denied(
        reason: 'Hai raggiunto il limite di ${limits.maxInvitesPerEntity} partecipanti per questo progetto.',
        currentCount: currentCount,
        limit: limits.maxInvitesPerEntity,
        upgradeRequired: true,
        suggestedPlan: 'premium',
      );
    }

    return LimitCheckResult.allowed(
      currentCount: currentCount,
      limit: limits.maxInvitesPerEntity,
    );
  }

  /// Verifica se mostrare pubblicita
  Future<bool> shouldShowAds() async {
    final limits = await getCurrentLimits();
    return limits.showsAds;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // RIEPILOGO UTILIZZO
  // ═══════════════════════════════════════════════════════════════════════════

  /// Ottiene il riepilogo completo dell'utilizzo per l'utente corrente
  Future<UsageSummary> getUsageSummary(String userEmail) async {
    final limits = await getCurrentLimits();
    final subscription = await _profileService.getCurrentSubscription();
    final plan = subscription?.plan ?? SubscriptionPlan.free;

    final results = await Future.wait([
      countTotalProjects(userEmail),
      countSmartTodoLists(userEmail),
    ]);

    return UsageSummary(
      limits: limits,
      projectsUsed: results[0],
      listsUsed: results[1],
      currentPlan: plan,
    );
  }

  /// Ottiene il piano corrente dell'utente
  Future<SubscriptionPlan> getCurrentPlan() async {
    final subscription = await _profileService.getCurrentSubscription();
    return subscription?.plan ?? SubscriptionPlan.free;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  String _getSuggestedPlanForProjects(int currentCount) {
    if (currentCount < 30) return 'premium';
    return 'elite';
  }

  String _getSuggestedPlanForLists(int currentCount) {
    if (currentCount < 30) return 'premium';
    return 'elite';
  }

  /// Verifica il limite e lancia eccezione se superato
  /// Utility method per uso diretto nei servizi
  /// entityType: 'eisenhower', 'estimation', 'retrospective', 'agile_project'
  Future<void> enforceProjectLimit(String userEmail, {String entityType = 'eisenhower'}) async {
    final result = await canCreateProject(userEmail, entityType: entityType);
    if (!result.allowed) {
      throw LimitExceededException(
        message: result.reason!,
        upgradeRequired: result.upgradeRequired,
        suggestedPlan: result.suggestedPlan,
        currentCount: result.currentCount,
        limit: result.limit,
      );
    }
  }

  Future<void> enforceListLimit(String userEmail) async {
    final result = await canCreateList(userEmail);
    if (!result.allowed) {
      throw LimitExceededException(
        message: result.reason!,
        upgradeRequired: result.upgradeRequired,
        suggestedPlan: result.suggestedPlan,
        currentCount: result.currentCount,
        limit: result.limit,
      );
    }
  }

  Future<void> enforceTaskLimit({
    required String entityType,
    required String entityId,
  }) async {
    final result = await canAddTask(entityType: entityType, entityId: entityId);
    if (!result.allowed) {
      throw LimitExceededException(
        message: result.reason!,
        upgradeRequired: result.upgradeRequired,
        suggestedPlan: result.suggestedPlan,
        currentCount: result.currentCount,
        limit: result.limit,
      );
    }
  }

  Future<void> enforceInviteLimit({
    required String entityType,
    required String entityId,
  }) async {
    final result = await canInvite(entityType: entityType, entityId: entityId);
    if (!result.allowed) {
      throw LimitExceededException(
        message: result.reason!,
        upgradeRequired: result.upgradeRequired,
        suggestedPlan: result.suggestedPlan,
        currentCount: result.currentCount,
        limit: result.limit,
      );
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SERVER-SIDE VALIDATION (Cloud Function double-check)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Valida il limite di creazione lato server tramite Cloud Function.
  /// Ritorna LimitCheckResult con il risultato della validazione server-side.
  /// In caso di errore di rete o funzione non disponibile, permette l'operazione
  /// (fail-open) per non bloccare l'utente se il backend non è raggiungibile.
  ///
  /// entityType: 'estimation', 'eisenhower', 'smart_todo', 'retrospective', 'agile_project'
  Future<LimitCheckResult> validateServerSide(String entityType) async {
    try {
      final callable = _functions.httpsCallable(
        'validateCreationLimit',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 10)),
      );

      final result = await callable.call<Map<String, dynamic>>({
        'entityType': entityType,
      });

      final data = result.data;
      final allowed = data['allowed'] as bool? ?? true;
      final currentCount = data['currentCount'] as int? ?? 0;
      final limit = data['limit'] as int? ?? 999999;
      final tier = data['tier'] as String? ?? 'free';

      if (!allowed) {
        final entityLabel = _getEntityLabel(entityType);
        return LimitCheckResult.denied(
          reason: 'Limite server: hai raggiunto il limite di $limit $entityLabel (piano $tier).',
          currentCount: currentCount,
          limit: limit,
          upgradeRequired: true,
          suggestedPlan: _getSuggestedPlanForProjects(currentCount),
        );
      }

      return LimitCheckResult.allowed(
        currentCount: currentCount,
        limit: limit,
      );
    } catch (e) {
      // Fail-open: se la Cloud Function non è raggiungibile, permetti l'operazione
      // Il controllo client-side rimane come prima linea di difesa
      print('⚠️ Server-side validation unavailable: $e');
      return LimitCheckResult.allowed();
    }
  }
}
