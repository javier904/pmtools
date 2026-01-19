import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/user_profile/subscription_model.dart';
import '../user_profile_service.dart';
import 'subscription_limits_service.dart';

/// Service per integrazione Stripe via Firebase Extension
///
/// Usa il pattern "Run Payments with Stripe" Firebase Extension:
/// - Products/prices salvati in Firestore
/// - Checkout sessions create in Firestore (triggera extension)
/// - Subscription status sync via webhooks
///
/// Singleton pattern come altri servizi dell'app.
class StripePaymentService {
  static final StripePaymentService _instance = StripePaymentService._internal();
  factory StripePaymentService() => _instance;
  StripePaymentService._internal();

  /// Apre un URL (checkout o portal) usando url_launcher
  Future<void> openCheckoutUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Impossibile aprire l\'URL: $url');
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserProfileService _profileService = UserProfileService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  // Collection names (Firebase Extension convention)
  static const String _productsCollection = 'stripe_products';
  static const String _customersCollection = 'stripe_customers';
  static const String _checkoutSessionsSubcollection = 'checkout_sessions';
  static const String _subscriptionsSubcollection = 'subscriptions';
  static const String _paymentsSubcollection = 'payments';
  static const String _portalSessionsSubcollection = 'portal_sessions';

  // Base URL per redirect
  static const String _baseUrl = 'https://pm-agile-tools-app.web.app';

  String? get _currentUserId => _auth.currentUser?.uid;
  String? get _currentUserEmail => _auth.currentUser?.email;

  // ═══════════════════════════════════════════════════════════════════════════
  // PRODUCTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Ottiene tutti i prodotti/prezzi disponibili
  Future<List<StripeProductModel>> getProducts() async {
    final snapshot = await _firestore
        .collection(_productsCollection)
        .where('active', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((doc) => StripeProductModel.fromFirestore(doc))
        .toList();
  }

  /// Ottiene i prodotti per un piano specifico
  Future<List<StripeProductModel>> getProductsForPlan(SubscriptionPlan plan) async {
    final products = await getProducts();
    return products.where((p) => p.plan == plan).toList();
  }

  /// Ottiene il prezzo ID per un piano e ciclo specifico
  Future<String?> getPriceId({
    required SubscriptionPlan plan,
    required BillingCycle billingCycle,
  }) async {
    final products = await getProducts();
    final matching = products.where(
      (p) => p.plan == plan && p.billingCycle == billingCycle,
    );
    return matching.isNotEmpty ? matching.first.priceId : null;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CHECKOUT
  // ═══════════════════════════════════════════════════════════════════════════

  /// Crea una checkout session per abbonamento
  /// Ritorna l'URL di checkout Stripe
  Future<String> createCheckoutSession({
    required String priceId,
    bool includeTrial = true,
    String? successUrl,
    String? cancelUrl,
  }) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('Utente non autenticato');

    final docRef = _firestore
        .collection(_customersCollection)
        .doc(userId)
        .collection(_checkoutSessionsSubcollection)
        .doc();

    final sessionData = <String, dynamic>{
      'price': priceId,
      'success_url': successUrl ?? '$_baseUrl/subscription/success?session_id={CHECKOUT_SESSION_ID}',
      'cancel_url': cancelUrl ?? '$_baseUrl/subscription/cancel',
      'mode': 'subscription',
      'allow_promotion_codes': true,
      'billing_address_collection': 'auto',
      'tax_id_collection': {'enabled': true},
      'metadata': {
        'userId': userId,
        'userEmail': _currentUserEmail,
        'createdAt': DateTime.now().toIso8601String(),
      },
    };

    // Aggiungi trial se applicabile
    if (includeTrial) {
      sessionData['subscription_data'] = {
        'trial_settings': {
          'end_behavior': {'missing_payment_method': 'cancel'},
        },
      };
    }

    await docRef.set(sessionData);

    // Attendi che l'extension Stripe popoli l'URL
    final checkoutSession = await docRef
        .snapshots()
        .firstWhere((doc) {
          final data = doc.data();
          return data?['url'] != null || data?['error'] != null;
        })
        .timeout(
          const Duration(seconds: 30),
          onTimeout: () => throw Exception('Timeout creazione checkout session'),
        );

    final data = checkoutSession.data();
    if (data?['error'] != null) {
      final error = data!['error'];
      throw Exception('Errore checkout: ${error['message'] ?? error}');
    }

    final url = data?['url'] as String?;
    if (url == null) {
      throw Exception('URL checkout non generato');
    }

    return url;
  }

  /// Crea una portal session per gestione abbonamento
  /// Permette all'utente di: modificare carta, cancellare, vedere fatture
  Future<String> createPortalSession({String? returnUrl}) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('Utente non autenticato');

    final docRef = _firestore
        .collection(_customersCollection)
        .doc(userId)
        .collection(_portalSessionsSubcollection)
        .doc();

    await docRef.set({
      'return_url': returnUrl ?? '$_baseUrl/profile',
      'created': FieldValue.serverTimestamp(),
    });

    // Attendi che Cloud Function popoli l'URL
    final portalSession = await docRef
        .snapshots()
        .firstWhere((doc) {
          final data = doc.data();
          return data?['url'] != null || data?['error'] != null;
        })
        .timeout(
          const Duration(seconds: 30),
          onTimeout: () => throw Exception('Timeout creazione portal session'),
        );

    final data = portalSession.data();
    if (data?['error'] != null) {
      final error = data!['error'];
      throw Exception('Errore portal: ${error['message'] ?? error}');
    }

    final url = data?['url'] as String?;
    if (url == null) {
      throw Exception('URL portal non generato');
    }

    return url;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SUBSCRIPTION STATUS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Stream delle subscription Stripe dell'utente
  Stream<List<StripeSubscription>> streamSubscriptions() {
    final userId = _currentUserId;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection(_customersCollection)
        .doc(userId)
        .collection(_subscriptionsSubcollection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => StripeSubscription.fromFirestore(doc))
            .toList());
  }

  /// Ottiene la subscription Stripe attiva
  Future<StripeSubscription?> getActiveSubscription() async {
    final userId = _currentUserId;
    if (userId == null) return null;

    final snapshot = await _firestore
        .collection(_customersCollection)
        .doc(userId)
        .collection(_subscriptionsSubcollection)
        .where('status', whereIn: ['active', 'trialing'])
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return StripeSubscription.fromFirestore(snapshot.docs.first);
  }

  /// Sincronizza lo stato Stripe con il SubscriptionModel dell'app
  Future<void> syncSubscriptionStatus() async {
    final stripeSubscription = await getActiveSubscription();

    if (stripeSubscription == null) {
      // Nessuna subscription attiva, imposta Free
      await _profileService.activateSubscription(
        plan: SubscriptionPlan.free,
        billingCycle: BillingCycle.monthly,
      );
    } else {
      // Mappa Stripe subscription a app subscription
      await _profileService.activateSubscription(
        plan: stripeSubscription.plan,
        billingCycle: stripeSubscription.billingCycle,
        externalSubscriptionId: stripeSubscription.id,
        startTrial: stripeSubscription.status == 'trialing',
      );
    }

    // Invalida cache limiti
    _limitsService.invalidateCache();
  }

  /// Verifica se l'utente ha una subscription Stripe attiva
  Future<bool> hasActiveStripeSubscription() async {
    final subscription = await getActiveSubscription();
    return subscription != null && subscription.isActive;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PAYMENT HISTORY
  // ═══════════════════════════════════════════════════════════════════════════

  /// Ottiene lo storico pagamenti
  Future<List<StripePayment>> getPaymentHistory({int limit = 20}) async {
    final userId = _currentUserId;
    if (userId == null) return [];

    final snapshot = await _firestore
        .collection(_customersCollection)
        .doc(userId)
        .collection(_paymentsSubcollection)
        .orderBy('created', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => StripePayment.fromFirestore(doc))
        .toList();
  }

  /// Stream dello storico pagamenti
  Stream<List<StripePayment>> streamPaymentHistory({int limit = 20}) {
    final userId = _currentUserId;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection(_customersCollection)
        .doc(userId)
        .collection(_paymentsSubcollection)
        .orderBy('created', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => StripePayment.fromFirestore(doc))
            .toList());
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CANCELLATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Cancella l'abbonamento a fine periodo (no-refund policy)
  /// L'utente mantiene l'accesso fino alla scadenza
  Future<void> cancelSubscriptionAtPeriodEnd() async {
    // Apri il portal Stripe dove l'utente puo cancellare
    // La cancellazione viene gestita da Stripe e sincronizzata via webhook
    final portalUrl = await createPortalSession();
    // L'URL viene usato dal chiamante per redirect
    throw UnimplementedError(
      'Redirect utente a portal: $portalUrl\n'
      'La cancellazione avviene nel portal Stripe.',
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UPGRADE/DOWNGRADE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Avvia processo di upgrade a un piano superiore
  Future<String> upgradeToPlan({
    required SubscriptionPlan targetPlan,
    required BillingCycle billingCycle,
  }) async {
    final priceId = await getPriceId(plan: targetPlan, billingCycle: billingCycle);
    if (priceId == null) {
      throw Exception('Prezzo non trovato per piano ${targetPlan.name}');
    }

    // Verifica se esiste subscription attiva
    final existingSubscription = await getActiveSubscription();
    if (existingSubscription != null) {
      // Ha gia subscription, usa portal per modificare
      return createPortalSession();
    }

    // Nuova subscription, crea checkout
    return createCheckoutSession(
      priceId: priceId,
      includeTrial: targetPlan.trialDays > 0,
    );
  }

  /// Callback da chiamare al logout
  void onLogout() {
    // Nulla da pulire lato service, ma potrebbe servire in futuro
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// MODELS
// ═══════════════════════════════════════════════════════════════════════════

/// Modello prodotto Stripe salvato in Firestore
class StripeProductModel {
  final String productId;
  final String priceId;
  final SubscriptionPlan plan;
  final BillingCycle billingCycle;
  final double price;
  final String currency;
  final String? description;
  final bool active;

  const StripeProductModel({
    required this.productId,
    required this.priceId,
    required this.plan,
    required this.billingCycle,
    required this.price,
    this.currency = 'EUR',
    this.description,
    this.active = true,
  });

  factory StripeProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StripeProductModel(
      productId: data['productId'] ?? doc.id,
      priceId: data['priceId'] ?? '',
      plan: _parsePlan(data['plan']),
      billingCycle: _parseBillingCycle(data['billingCycle']),
      price: (data['price'] as num?)?.toDouble() ?? 0,
      currency: data['currency'] ?? 'EUR',
      description: data['description'],
      active: data['active'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'productId': productId,
    'priceId': priceId,
    'plan': plan.name,
    'billingCycle': billingCycle.name,
    'price': price,
    'currency': currency,
    'description': description,
    'active': active,
  };

  static SubscriptionPlan _parsePlan(String? planName) {
    if (planName == null) return SubscriptionPlan.free;
    return SubscriptionPlan.values.firstWhere(
      (p) => p.name == planName,
      orElse: () => SubscriptionPlan.free,
    );
  }

  static BillingCycle _parseBillingCycle(String? cycleName) {
    if (cycleName == null) return BillingCycle.monthly;
    return BillingCycle.values.firstWhere(
      (b) => b.name == cycleName,
      orElse: () => BillingCycle.monthly,
    );
  }

  String get formattedPrice => '$currency ${price.toStringAsFixed(2)}';
}

/// Subscription Stripe da Firebase Extension
class StripeSubscription {
  final String id;
  final String status;
  final String priceId;
  final SubscriptionPlan plan;
  final BillingCycle billingCycle;
  final DateTime? currentPeriodStart;
  final DateTime? currentPeriodEnd;
  final DateTime? trialEnd;
  final bool cancelAtPeriodEnd;

  const StripeSubscription({
    required this.id,
    required this.status,
    required this.priceId,
    required this.plan,
    required this.billingCycle,
    this.currentPeriodStart,
    this.currentPeriodEnd,
    this.trialEnd,
    this.cancelAtPeriodEnd = false,
  });

  factory StripeSubscription.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Parse plan da metadata o price
    final metadata = data['metadata'] as Map<String, dynamic>? ?? {};
    final planName = metadata['plan'] as String? ?? 'free';

    return StripeSubscription(
      id: doc.id,
      status: data['status'] ?? 'inactive',
      priceId: _extractPriceId(data),
      plan: StripeProductModel._parsePlan(planName),
      billingCycle: (data['interval'] == 'year')
          ? BillingCycle.yearly
          : BillingCycle.monthly,
      currentPeriodStart: _parseTimestamp(data['current_period_start']),
      currentPeriodEnd: _parseTimestamp(data['current_period_end']),
      trialEnd: _parseTimestamp(data['trial_end']),
      cancelAtPeriodEnd: data['cancel_at_period_end'] ?? false,
    );
  }

  static String _extractPriceId(Map<String, dynamic> data) {
    // Stripe Extension puo salvare price in vari formati
    if (data['price'] is String) return data['price'] as String;
    if (data['price'] is Map) {
      return (data['price'] as Map)['id']?.toString() ?? '';
    }
    if (data['items'] is List && (data['items'] as List).isNotEmpty) {
      final firstItem = (data['items'] as List).first;
      if (firstItem is Map && firstItem['price'] is Map) {
        return (firstItem['price'] as Map)['id']?.toString() ?? '';
      }
    }
    return '';
  }

  static DateTime? _parseTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value * 1000);
    if (value is Map && value['_seconds'] != null) {
      return DateTime.fromMillisecondsSinceEpoch((value['_seconds'] as int) * 1000);
    }
    return null;
  }

  bool get isActive => status == 'active' || status == 'trialing';
  bool get isTrialing => status == 'trialing';
  bool get isPastDue => status == 'past_due';
  bool get isCanceled => status == 'canceled';

  /// Giorni rimanenti nel periodo corrente
  int? get daysRemaining {
    if (currentPeriodEnd == null) return null;
    final remaining = currentPeriodEnd!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  /// Giorni rimanenti nel trial
  int? get trialDaysRemaining {
    if (trialEnd == null) return null;
    final remaining = trialEnd!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }
}

/// Pagamento Stripe
class StripePayment {
  final String id;
  final int amount; // In centesimi
  final String currency;
  final String status;
  final DateTime? created;
  final String? receiptUrl;
  final String? description;

  const StripePayment({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    this.created,
    this.receiptUrl,
    this.description,
  });

  factory StripePayment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StripePayment(
      id: doc.id,
      amount: (data['amount'] as num?)?.toInt() ?? 0,
      currency: data['currency'] ?? 'eur',
      status: data['status'] ?? '',
      created: StripeSubscription._parseTimestamp(data['created']),
      receiptUrl: data['receipt_url'],
      description: data['description'],
    );
  }

  /// Importo formattato (da centesimi a euro)
  String get formattedAmount {
    final euros = amount / 100;
    final symbol = currency.toUpperCase() == 'EUR' ? '\u20AC' : currency.toUpperCase();
    return '$symbol${euros.toStringAsFixed(2)}';
  }

  bool get isSucceeded => status == 'succeeded';
  bool get isFailed => status == 'failed';
  bool get isPending => status == 'pending' || status == 'processing';
}
