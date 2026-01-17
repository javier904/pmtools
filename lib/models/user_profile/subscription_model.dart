import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Modello abbonamento utente - Modulare e riutilizzabile
///
/// Gestisce:
/// - Tipo di piano (free, pro, enterprise, etc.)
/// - Stato abbonamento
/// - Date (inizio, fine, rinnovo)
/// - Pagamenti
/// - Storico modifiche
class SubscriptionModel {
  final String id;
  final String userId;
  final SubscriptionPlan plan;
  final SubscriptionStatus status;

  // Date
  final DateTime startDate;
  final DateTime? endDate; // null = lifetime o finché attivo
  final DateTime? trialEndDate;
  final DateTime? nextBillingDate;
  final DateTime? cancelledAt;
  final DateTime? pausedAt;

  // Billing
  final BillingCycle billingCycle;
  final double? price;
  final String? currency;
  final String? paymentMethodId; // Riferimento a metodo di pagamento
  final String? externalSubscriptionId; // ID Stripe/PayPal etc.

  // Cancellation
  final String? cancellationReason;
  final bool cancelAtPeriodEnd; // Se true, cancella alla fine del periodo

  // Metadata
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? metadata;

  const SubscriptionModel({
    required this.id,
    required this.userId,
    required this.plan,
    required this.status,
    required this.startDate,
    this.endDate,
    this.trialEndDate,
    this.nextBillingDate,
    this.cancelledAt,
    this.pausedAt,
    this.billingCycle = BillingCycle.monthly,
    this.price,
    this.currency = 'EUR',
    this.paymentMethodId,
    this.externalSubscriptionId,
    this.cancellationReason,
    this.cancelAtPeriodEnd = false,
    required this.createdAt,
    required this.updatedAt,
    this.metadata,
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // COMPUTED PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Verifica se l'abbonamento è attivo
  bool get isActive => status == SubscriptionStatus.active;

  /// Verifica se è in trial
  bool get isInTrial {
    if (trialEndDate == null) return false;
    return DateTime.now().isBefore(trialEndDate!);
  }

  /// Giorni rimanenti nel trial
  int get trialDaysRemaining {
    if (trialEndDate == null) return 0;
    final remaining = trialEndDate!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  /// Giorni rimanenti nell'abbonamento
  int? get daysRemaining {
    if (endDate == null) return null;
    final remaining = endDate!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  /// Verifica se l'abbonamento è scaduto
  bool get isExpired {
    if (endDate == null) return false;
    return DateTime.now().isAfter(endDate!);
  }

  /// Verifica se sta per scadere (entro 7 giorni)
  bool get isExpiringSoon {
    final days = daysRemaining;
    if (days == null) return false;
    return days <= 7 && days > 0;
  }

  /// Verifica se ha un piano a pagamento
  bool get isPaid => plan != SubscriptionPlan.free;

  /// Prezzo formattato
  String get formattedPrice {
    if (price == null) return 'Gratuito';
    return '€${price!.toStringAsFixed(2)}/${billingCycle.shortName}';
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SERIALIZATION
  // ═══════════════════════════════════════════════════════════════════════════

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'plan': plan.name,
      'status': status.name,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'trialEndDate': trialEndDate != null ? Timestamp.fromDate(trialEndDate!) : null,
      'nextBillingDate': nextBillingDate != null ? Timestamp.fromDate(nextBillingDate!) : null,
      'cancelledAt': cancelledAt != null ? Timestamp.fromDate(cancelledAt!) : null,
      'pausedAt': pausedAt != null ? Timestamp.fromDate(pausedAt!) : null,
      'billingCycle': billingCycle.name,
      'price': price,
      'currency': currency,
      'paymentMethodId': paymentMethodId,
      'externalSubscriptionId': externalSubscriptionId,
      'cancellationReason': cancellationReason,
      'cancelAtPeriodEnd': cancelAtPeriodEnd,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'metadata': metadata,
    };
  }

  factory SubscriptionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SubscriptionModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      plan: SubscriptionPlan.values.firstWhere(
        (p) => p.name == data['plan'],
        orElse: () => SubscriptionPlan.free,
      ),
      status: SubscriptionStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => SubscriptionStatus.active,
      ),
      startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (data['endDate'] as Timestamp?)?.toDate(),
      trialEndDate: (data['trialEndDate'] as Timestamp?)?.toDate(),
      nextBillingDate: (data['nextBillingDate'] as Timestamp?)?.toDate(),
      cancelledAt: (data['cancelledAt'] as Timestamp?)?.toDate(),
      pausedAt: (data['pausedAt'] as Timestamp?)?.toDate(),
      billingCycle: BillingCycle.values.firstWhere(
        (b) => b.name == data['billingCycle'],
        orElse: () => BillingCycle.monthly,
      ),
      price: (data['price'] as num?)?.toDouble(),
      currency: data['currency'] ?? 'EUR',
      paymentMethodId: data['paymentMethodId'],
      externalSubscriptionId: data['externalSubscriptionId'],
      cancellationReason: data['cancellationReason'],
      cancelAtPeriodEnd: data['cancelAtPeriodEnd'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Crea abbonamento free di default
  factory SubscriptionModel.freeDefault(String userId) {
    final now = DateTime.now();
    return SubscriptionModel(
      id: '',
      userId: userId,
      plan: SubscriptionPlan.free,
      status: SubscriptionStatus.active,
      startDate: now,
      createdAt: now,
      updatedAt: now,
    );
  }

  SubscriptionModel copyWith({
    SubscriptionPlan? plan,
    SubscriptionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    bool clearEndDate = false,
    DateTime? trialEndDate,
    DateTime? nextBillingDate,
    DateTime? cancelledAt,
    DateTime? pausedAt,
    BillingCycle? billingCycle,
    double? price,
    String? currency,
    String? paymentMethodId,
    String? externalSubscriptionId,
    String? cancellationReason,
    bool? cancelAtPeriodEnd,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return SubscriptionModel(
      id: id,
      userId: userId,
      plan: plan ?? this.plan,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
      trialEndDate: trialEndDate ?? this.trialEndDate,
      nextBillingDate: nextBillingDate ?? this.nextBillingDate,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      pausedAt: pausedAt ?? this.pausedAt,
      billingCycle: billingCycle ?? this.billingCycle,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      externalSubscriptionId: externalSubscriptionId ?? this.externalSubscriptionId,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      cancelAtPeriodEnd: cancelAtPeriodEnd ?? this.cancelAtPeriodEnd,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      metadata: metadata ?? this.metadata,
    );
  }
}

/// Storico modifiche abbonamento
class SubscriptionHistoryModel {
  final String id;
  final String subscriptionId;
  final String userId;
  final SubscriptionHistoryAction action;
  final SubscriptionPlan? previousPlan;
  final SubscriptionPlan? newPlan;
  final SubscriptionStatus? previousStatus;
  final SubscriptionStatus? newStatus;
  final String? reason;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  const SubscriptionHistoryModel({
    required this.id,
    required this.subscriptionId,
    required this.userId,
    required this.action,
    this.previousPlan,
    this.newPlan,
    this.previousStatus,
    this.newStatus,
    this.reason,
    required this.createdAt,
    this.metadata,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'subscriptionId': subscriptionId,
      'userId': userId,
      'action': action.name,
      'previousPlan': previousPlan?.name,
      'newPlan': newPlan?.name,
      'previousStatus': previousStatus?.name,
      'newStatus': newStatus?.name,
      'reason': reason,
      'createdAt': Timestamp.fromDate(createdAt),
      'metadata': metadata,
    };
  }

  factory SubscriptionHistoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SubscriptionHistoryModel(
      id: doc.id,
      subscriptionId: data['subscriptionId'] ?? '',
      userId: data['userId'] ?? '',
      action: SubscriptionHistoryAction.values.firstWhere(
        (a) => a.name == data['action'],
        orElse: () => SubscriptionHistoryAction.created,
      ),
      previousPlan: data['previousPlan'] != null
          ? SubscriptionPlan.values.firstWhere(
              (p) => p.name == data['previousPlan'],
              orElse: () => SubscriptionPlan.free,
            )
          : null,
      newPlan: data['newPlan'] != null
          ? SubscriptionPlan.values.firstWhere(
              (p) => p.name == data['newPlan'],
              orElse: () => SubscriptionPlan.free,
            )
          : null,
      previousStatus: data['previousStatus'] != null
          ? SubscriptionStatus.values.firstWhere(
              (s) => s.name == data['previousStatus'],
              orElse: () => SubscriptionStatus.active,
            )
          : null,
      newStatus: data['newStatus'] != null
          ? SubscriptionStatus.values.firstWhere(
              (s) => s.name == data['newStatus'],
              orElse: () => SubscriptionStatus.active,
            )
          : null,
      reason: data['reason'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ENUMS
// ═══════════════════════════════════════════════════════════════════════════

/// Piani di abbonamento disponibili
enum SubscriptionPlan {
  free,
  starter,
  pro,
  business,
  enterprise;

  String get displayName {
    switch (this) {
      case SubscriptionPlan.free:
        return 'Free';
      case SubscriptionPlan.starter:
        return 'Starter';
      case SubscriptionPlan.pro:
        return 'Pro';
      case SubscriptionPlan.business:
        return 'Business';
      case SubscriptionPlan.enterprise:
        return 'Enterprise';
    }
  }

  Color get color {
    switch (this) {
      case SubscriptionPlan.free:
        return Colors.grey;
      case SubscriptionPlan.starter:
        return Colors.blue;
      case SubscriptionPlan.pro:
        return Colors.purple;
      case SubscriptionPlan.business:
        return Colors.orange;
      case SubscriptionPlan.enterprise:
        return Colors.amber;
    }
  }

  IconData get icon {
    switch (this) {
      case SubscriptionPlan.free:
        return Icons.person_outline;
      case SubscriptionPlan.starter:
        return Icons.rocket_launch_outlined;
      case SubscriptionPlan.pro:
        return Icons.star_outline;
      case SubscriptionPlan.business:
        return Icons.business_outlined;
      case SubscriptionPlan.enterprise:
        return Icons.corporate_fare;
    }
  }

  /// Descrizione del piano
  String get description {
    switch (this) {
      case SubscriptionPlan.free:
        return 'Funzionalità base per iniziare';
      case SubscriptionPlan.starter:
        return 'Per piccoli team e progetti personali';
      case SubscriptionPlan.pro:
        return 'Per professionisti e team in crescita';
      case SubscriptionPlan.business:
        return 'Per aziende con esigenze avanzate';
      case SubscriptionPlan.enterprise:
        return 'Soluzione personalizzata per grandi organizzazioni';
    }
  }

  /// Prezzo mensile in EUR
  double get monthlyPrice {
    switch (this) {
      case SubscriptionPlan.free:
        return 0;
      case SubscriptionPlan.starter:
        return 9.99;
      case SubscriptionPlan.pro:
        return 19.99;
      case SubscriptionPlan.business:
        return 49.99;
      case SubscriptionPlan.enterprise:
        return 99.99;
    }
  }

  /// Giorni di prova gratuita
  int get trialDays {
    switch (this) {
      case SubscriptionPlan.free:
        return 0;
      case SubscriptionPlan.starter:
        return 7;
      case SubscriptionPlan.pro:
        return 14;
      case SubscriptionPlan.business:
        return 14;
      case SubscriptionPlan.enterprise:
        return 30;
    }
  }
}

/// Stato dell'abbonamento
enum SubscriptionStatus {
  active,
  trialing,
  pastDue,
  paused,
  cancelled,
  expired;

  String get displayName {
    switch (this) {
      case SubscriptionStatus.active:
        return 'Attivo';
      case SubscriptionStatus.trialing:
        return 'In prova';
      case SubscriptionStatus.pastDue:
        return 'Pagamento scaduto';
      case SubscriptionStatus.paused:
        return 'In pausa';
      case SubscriptionStatus.cancelled:
        return 'Cancellato';
      case SubscriptionStatus.expired:
        return 'Scaduto';
    }
  }

  Color get color {
    switch (this) {
      case SubscriptionStatus.active:
        return Colors.green;
      case SubscriptionStatus.trialing:
        return Colors.blue;
      case SubscriptionStatus.pastDue:
        return Colors.orange;
      case SubscriptionStatus.paused:
        return Colors.grey;
      case SubscriptionStatus.cancelled:
        return Colors.red;
      case SubscriptionStatus.expired:
        return Colors.red;
    }
  }
}

/// Ciclo di fatturazione
enum BillingCycle {
  monthly,
  quarterly,
  yearly,
  lifetime;

  String get displayName {
    switch (this) {
      case BillingCycle.monthly:
        return 'Mensile';
      case BillingCycle.quarterly:
        return 'Trimestrale';
      case BillingCycle.yearly:
        return 'Annuale';
      case BillingCycle.lifetime:
        return 'Lifetime';
    }
  }

  String get shortName {
    switch (this) {
      case BillingCycle.monthly:
        return 'mese';
      case BillingCycle.quarterly:
        return 'trim';
      case BillingCycle.yearly:
        return 'anno';
      case BillingCycle.lifetime:
        return 'sempre';
    }
  }

  int get months {
    switch (this) {
      case BillingCycle.monthly:
        return 1;
      case BillingCycle.quarterly:
        return 3;
      case BillingCycle.yearly:
        return 12;
      case BillingCycle.lifetime:
        return 9999;
    }
  }
}

/// Azioni storico abbonamento
enum SubscriptionHistoryAction {
  created,
  upgraded,
  downgraded,
  renewed,
  cancelled,
  paused,
  resumed,
  expired,
  paymentFailed,
  paymentSucceeded,
  trialStarted,
  trialEnded;

  String get displayName {
    switch (this) {
      case SubscriptionHistoryAction.created:
        return 'Creato';
      case SubscriptionHistoryAction.upgraded:
        return 'Upgrade';
      case SubscriptionHistoryAction.downgraded:
        return 'Downgrade';
      case SubscriptionHistoryAction.renewed:
        return 'Rinnovato';
      case SubscriptionHistoryAction.cancelled:
        return 'Cancellato';
      case SubscriptionHistoryAction.paused:
        return 'In pausa';
      case SubscriptionHistoryAction.resumed:
        return 'Ripreso';
      case SubscriptionHistoryAction.expired:
        return 'Scaduto';
      case SubscriptionHistoryAction.paymentFailed:
        return 'Pagamento fallito';
      case SubscriptionHistoryAction.paymentSucceeded:
        return 'Pagamento riuscito';
      case SubscriptionHistoryAction.trialStarted:
        return 'Trial iniziato';
      case SubscriptionHistoryAction.trialEnded:
        return 'Trial terminato';
    }
  }

  IconData get icon {
    switch (this) {
      case SubscriptionHistoryAction.created:
        return Icons.add_circle_outline;
      case SubscriptionHistoryAction.upgraded:
        return Icons.arrow_upward;
      case SubscriptionHistoryAction.downgraded:
        return Icons.arrow_downward;
      case SubscriptionHistoryAction.renewed:
        return Icons.refresh;
      case SubscriptionHistoryAction.cancelled:
        return Icons.cancel_outlined;
      case SubscriptionHistoryAction.paused:
        return Icons.pause_circle_outline;
      case SubscriptionHistoryAction.resumed:
        return Icons.play_circle_outline;
      case SubscriptionHistoryAction.expired:
        return Icons.timer_off_outlined;
      case SubscriptionHistoryAction.paymentFailed:
        return Icons.error_outline;
      case SubscriptionHistoryAction.paymentSucceeded:
        return Icons.check_circle_outline;
      case SubscriptionHistoryAction.trialStarted:
        return Icons.hourglass_top;
      case SubscriptionHistoryAction.trialEnded:
        return Icons.hourglass_bottom;
    }
  }

  Color get color {
    switch (this) {
      case SubscriptionHistoryAction.created:
      case SubscriptionHistoryAction.upgraded:
      case SubscriptionHistoryAction.renewed:
      case SubscriptionHistoryAction.resumed:
      case SubscriptionHistoryAction.paymentSucceeded:
      case SubscriptionHistoryAction.trialStarted:
        return Colors.green;
      case SubscriptionHistoryAction.downgraded:
      case SubscriptionHistoryAction.paused:
      case SubscriptionHistoryAction.trialEnded:
        return Colors.orange;
      case SubscriptionHistoryAction.cancelled:
      case SubscriptionHistoryAction.expired:
      case SubscriptionHistoryAction.paymentFailed:
        return Colors.red;
    }
  }
}
