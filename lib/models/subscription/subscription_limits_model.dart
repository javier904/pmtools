import '../user_profile/subscription_model.dart';

/// Definisce i limiti per ogni tier di abbonamento
///
/// Sistema modulare e riutilizzabile per gestire:
/// - Limiti progetti/liste/task/inviti
/// - Configurazione ads
/// - Feature aggiuntive per tier
class SubscriptionLimits {
  final int maxActiveProjects;
  final int maxActiveLists;
  final int maxTasksPerEntity;
  final int maxInvitesPerEntity;
  final bool showsAds;
  final bool hasAdvancedExport;
  final bool hasApiAccess;
  final bool hasPrioritySupport;

  const SubscriptionLimits({
    required this.maxActiveProjects,
    required this.maxActiveLists,
    required this.maxTasksPerEntity,
    required this.maxInvitesPerEntity,
    required this.showsAds,
    this.hasAdvancedExport = false,
    this.hasApiAccess = false,
    this.hasPrioritySupport = false,
  });

  /// Valore che rappresenta "illimitato"
  static const int unlimited = -1;

  // ═══════════════════════════════════════════════════════════════════════════
  // COMPUTED PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  bool get isUnlimitedProjects => maxActiveProjects == unlimited;
  bool get isUnlimitedLists => maxActiveLists == unlimited;
  bool get isUnlimitedTasks => maxTasksPerEntity == unlimited;
  bool get isUnlimitedInvites => maxInvitesPerEntity == unlimited;

  /// Stringa display per il limite progetti
  String get projectsLimitDisplay =>
      isUnlimitedProjects ? 'Illimitati' : '$maxActiveProjects';

  /// Stringa display per il limite liste
  String get listsLimitDisplay =>
      isUnlimitedLists ? 'Illimitate' : '$maxActiveLists';

  /// Stringa display per il limite task
  String get tasksLimitDisplay =>
      isUnlimitedTasks ? 'Illimitati' : '$maxTasksPerEntity';

  /// Stringa display per il limite inviti
  String get invitesLimitDisplay =>
      isUnlimitedInvites ? 'Illimitati' : '$maxInvitesPerEntity';

  // ═══════════════════════════════════════════════════════════════════════════
  // FACTORY CONSTRUCTORS PER TIER
  // ═══════════════════════════════════════════════════════════════════════════

  /// Limiti per tier FREE
  /// - 5 per ogni tipo di entità (NON sommati)
  /// - 5 matrici Eisenhower
  /// - 5 sessioni Estimation Room
  /// - 5 retrospettive
  /// - 5 liste Smart Todo
  /// - 5 progetti Agile
  /// - 50 task per entita
  /// - 10 inviti per entita
  factory SubscriptionLimits.free() => const SubscriptionLimits(
    maxActiveProjects: 5,  // Limite per OGNI tipo, non sommato
    maxActiveLists: 5,
    maxTasksPerEntity: 50,
    maxInvitesPerEntity: 10,
    showsAds: false,  // No ads per Agile Tools standalone
    hasAdvancedExport: true,
    hasApiAccess: false,
    hasPrioritySupport: false,
  );

  /// Limiti per tier PREMIUM (4.99/mese - 39.99/anno)
  /// - 30 progetti attivi
  /// - 30 liste Smart Todo
  /// - 100 task per entita
  /// - 15 inviti per entita
  /// - Nessuna pubblicita
  /// - Export avanzato
  factory SubscriptionLimits.premium() => const SubscriptionLimits(
    maxActiveProjects: 30,
    maxActiveLists: 30,
    maxTasksPerEntity: 100,
    maxInvitesPerEntity: 15,
    showsAds: false,
    hasAdvancedExport: true,
    hasApiAccess: false,
    hasPrioritySupport: false,
  );

  /// Limiti per tier ELITE (7.99/mese - 69.99/anno)
  /// - Progetti illimitati
  /// - Liste illimitate
  /// - Task illimitati
  /// - Inviti illimitati
  /// - Nessuna pubblicita
  /// - Tutte le feature
  factory SubscriptionLimits.elite() => const SubscriptionLimits(
    maxActiveProjects: unlimited,
    maxActiveLists: unlimited,
    maxTasksPerEntity: unlimited,
    maxInvitesPerEntity: unlimited,
    showsAds: false,
    hasAdvancedExport: true,
    hasApiAccess: true,
    hasPrioritySupport: true,
  );

  /// Ottiene i limiti per un piano specifico
  static SubscriptionLimits forPlan(SubscriptionPlan plan) {
    switch (plan) {
      case SubscriptionPlan.free:
        return SubscriptionLimits.free();
      case SubscriptionPlan.premium:
        return SubscriptionLimits.premium();
      case SubscriptionPlan.elite:
        return SubscriptionLimits.elite();
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SERIALIZATION
  // ═══════════════════════════════════════════════════════════════════════════

  Map<String, dynamic> toMap() => {
    'maxActiveProjects': maxActiveProjects,
    'maxActiveLists': maxActiveLists,
    'maxTasksPerEntity': maxTasksPerEntity,
    'maxInvitesPerEntity': maxInvitesPerEntity,
    'showsAds': showsAds,
    'hasAdvancedExport': hasAdvancedExport,
    'hasApiAccess': hasApiAccess,
    'hasPrioritySupport': hasPrioritySupport,
  };

  factory SubscriptionLimits.fromMap(Map<String, dynamic> map) {
    return SubscriptionLimits(
      maxActiveProjects: map['maxActiveProjects'] ?? 5,
      maxActiveLists: map['maxActiveLists'] ?? 5,
      maxTasksPerEntity: map['maxTasksPerEntity'] ?? 50,
      maxInvitesPerEntity: map['maxInvitesPerEntity'] ?? 10,
      showsAds: map['showsAds'] ?? true,
      hasAdvancedExport: map['hasAdvancedExport'] ?? false,
      hasApiAccess: map['hasApiAccess'] ?? false,
      hasPrioritySupport: map['hasPrioritySupport'] ?? false,
    );
  }

  @override
  String toString() {
    return 'SubscriptionLimits(projects: $projectsLimitDisplay, lists: $listsLimitDisplay, '
           'tasks: $tasksLimitDisplay, invites: $invitesLimitDisplay, ads: $showsAds)';
  }
}

/// Risultato di un controllo limite
class LimitCheckResult {
  final bool allowed;
  final String? reason;
  final int? currentCount;
  final int? limit;
  final bool upgradeRequired;
  final String? suggestedPlan;

  const LimitCheckResult._({
    required this.allowed,
    this.reason,
    this.currentCount,
    this.limit,
    this.upgradeRequired = false,
    this.suggestedPlan,
  });

  /// Crea un risultato "permesso"
  factory LimitCheckResult.allowed({
    int? currentCount,
    int? limit,
  }) {
    return LimitCheckResult._(
      allowed: true,
      currentCount: currentCount,
      limit: limit,
    );
  }

  /// Crea un risultato "negato"
  factory LimitCheckResult.denied({
    required String reason,
    int? currentCount,
    int? limit,
    bool upgradeRequired = false,
    String? suggestedPlan,
  }) {
    return LimitCheckResult._(
      allowed: false,
      reason: reason,
      currentCount: currentCount,
      limit: limit,
      upgradeRequired: upgradeRequired,
      suggestedPlan: suggestedPlan,
    );
  }

  /// Numero rimanente prima del limite
  int? get remaining {
    if (limit == null || currentCount == null) return null;
    if (limit == SubscriptionLimits.unlimited) return null;
    return limit! - currentCount!;
  }

  /// Percentuale di utilizzo (0-100)
  double? get usagePercentage {
    if (limit == null || currentCount == null) return null;
    if (limit == SubscriptionLimits.unlimited) return 0;
    if (limit == 0) return 100;
    return (currentCount! / limit!) * 100;
  }

  /// Verifica se vicino al limite (>80%)
  bool get isNearLimit {
    final percentage = usagePercentage;
    if (percentage == null) return false;
    return percentage >= 80;
  }

  @override
  String toString() {
    if (allowed) {
      return 'LimitCheckResult.allowed(current: $currentCount, limit: $limit)';
    }
    return 'LimitCheckResult.denied(reason: $reason, upgrade: $upgradeRequired)';
  }
}

/// Riepilogo utilizzo utente
class UsageSummary {
  final SubscriptionLimits limits;
  final int projectsUsed;
  final int listsUsed;
  final SubscriptionPlan currentPlan;

  const UsageSummary({
    required this.limits,
    required this.projectsUsed,
    required this.listsUsed,
    required this.currentPlan,
  });

  /// Percentuale utilizzo progetti
  double get projectsPercentage {
    if (limits.isUnlimitedProjects) return 0;
    if (limits.maxActiveProjects == 0) return 100;
    return (projectsUsed / limits.maxActiveProjects) * 100;
  }

  /// Percentuale utilizzo liste
  double get listsPercentage {
    if (limits.isUnlimitedLists) return 0;
    if (limits.maxActiveLists == 0) return 100;
    return (listsUsed / limits.maxActiveLists) * 100;
  }

  /// Progetti rimanenti
  int? get projectsRemaining {
    if (limits.isUnlimitedProjects) return null;
    return limits.maxActiveProjects - projectsUsed;
  }

  /// Liste rimanenti
  int? get listsRemaining {
    if (limits.isUnlimitedLists) return null;
    return limits.maxActiveLists - listsUsed;
  }

  /// Verifica se vicino al limite progetti
  bool get isNearProjectLimit => projectsPercentage >= 80;

  /// Verifica se vicino al limite liste
  bool get isNearListLimit => listsPercentage >= 80;

  /// Verifica se ha raggiunto il limite progetti
  bool get hasReachedProjectLimit =>
      !limits.isUnlimitedProjects && projectsUsed >= limits.maxActiveProjects;

  /// Verifica se ha raggiunto il limite liste
  bool get hasReachedListLimit =>
      !limits.isUnlimitedLists && listsUsed >= limits.maxActiveLists;

  @override
  String toString() {
    return 'UsageSummary(plan: ${currentPlan.name}, '
           'projects: $projectsUsed/${limits.projectsLimitDisplay}, '
           'lists: $listsUsed/${limits.listsLimitDisplay})';
  }
}

/// Eccezione per limite superato
class LimitExceededException implements Exception {
  final String message;
  final bool upgradeRequired;
  final String? suggestedPlan;
  final int? currentCount;
  final int? limit;

  const LimitExceededException({
    required this.message,
    this.upgradeRequired = false,
    this.suggestedPlan,
    this.currentCount,
    this.limit,
  });

  @override
  String toString() => 'LimitExceededException: $message';
}
