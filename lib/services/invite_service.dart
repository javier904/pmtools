import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/unified_invite_model.dart';
import '../models/subscription/subscription_limits_model.dart';
import '../utils/validators.dart';
import 'auth_service.dart';
import 'subscription/subscription_limits_service.dart';

/// Servizio unificato per la gestione di TUTTI gli inviti
///
/// Sostituisce: EisenhowerInviteService, PlanningPokerInviteService,
/// AgileInviteService, SmartTodoInviteService, RetroInviteService
///
/// Struttura Firestore:
/// ```
/// invitations/{inviteId}
///   - sourceType: String (eisenhower, estimationRoom, agileProject, smartTodo, retroBoard)
///   - sourceId: String
///   - sourceName: String
///   - email: String
///   - role: String
///   - teamRole: String? (solo per Agile)
///   - status: String (pending, accepted, declined, expired, revoked)
///   - token: String (32 chars)
///   - invitedBy: String
///   - invitedByName: String
///   - invitedAt: Timestamp
///   - expiresAt: Timestamp
///   - acceptedAt: Timestamp?
///   - declinedAt: Timestamp?
///   - declineReason: String?
/// ```
class InviteService {
  static final InviteService _instance = InviteService._internal();
  factory InviteService() => _instance;
  InviteService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  /// Nome della collection unificata
  static const String _collection = 'invitations';

  /// Riferimento alla collection
  CollectionReference<Map<String, dynamic>> get _invitesRef =>
      _firestore.collection(_collection);

  // ══════════════════════════════════════════════════════════════════════════════
  // CREAZIONE INVITI
  // ══════════════════════════════════════════════════════════════════════════════

  /// Crea un nuovo invito per qualsiasi tipo di risorsa
  ///
  /// [sourceType] - Tipo della risorsa (eisenhower, estimationRoom, etc.)
  /// [sourceId] - ID univoco della risorsa
  /// [sourceName] - Nome display della risorsa
  /// [email] - Email dell'invitato (normalizzata a lowercase)
  /// [role] - Ruolo assegnato all'invitato
  /// [teamRole] - Ruolo team opzionale (solo per Agile Project)
  /// [expirationDays] - Giorni prima della scadenza (default: 7)
  ///
  /// Returns: [UnifiedInviteModel] se creato con successo, null se errore.
  ///
  /// Throws:
  /// - [LimitExceededException] se limite inviti raggiunto
  Future<UnifiedInviteModel?> createInvite({
    required InviteSourceType sourceType,
    required String sourceId,
    required String sourceName,
    required String email,
    required String role,
    String? teamRole,
    int expirationDays = 7,
  }) async {
    final inviterEmail = _authService.currentUserEmail;
    if (inviterEmail == null) {
      print('❌ [InviteService] createInvite: Utente non autenticato');
      return null;
    }

    // 🔒 CHECK LIMITE INVITI PER ENTITA'
    await _limitsService.enforceInviteLimit(
      entityType: sourceType.name,
      entityId: sourceId,
    );

    // Verifica che non esista già un invito pending per questa email
    final existingInvite = await getActiveInviteForEmail(sourceType, sourceId, email);
    if (existingInvite != null) {
      print('⚠️ [InviteService] Invito già esistente per $email');
      return existingInvite;
    }

    try {
      final now = DateTime.now();
      final token = UnifiedInviteModel.generateToken();
      final inviterName = _authService.currentUser?.displayName ?? inviterEmail.split('@').first;

      final invite = UnifiedInviteModel(
        id: '',
        sourceType: sourceType,
        sourceId: sourceId,
        sourceName: sourceName,
        email: email.toLowerCase().trim(),
        role: role,
        teamRole: teamRole,
        status: UnifiedInviteStatus.pending,
        invitedBy: inviterEmail.toLowerCase(),
        invitedByName: inviterName,
        invitedAt: now,
        expiresAt: now.add(Duration(days: expirationDays)),
        token: token,
      );

      final batch = _firestore.batch();

      // 1. Crea invito nella collection unificata
      final inviteRef = _invitesRef.doc();
      batch.set(inviteRef, invite.toFirestore());

      // 2. Aggiungi a pendingEmails nell'entità sorgente
      final sourceRef = _getSourceDocRef(sourceType, sourceId);
      batch.update(sourceRef, {
        'pendingEmails': FieldValue.arrayUnion([email.toLowerCase().trim()]),
        'updatedAt': Timestamp.fromDate(now),
      });

      await batch.commit();

      print('✅ [InviteService] Invito creato: ${inviteRef.id} per $email (${sourceType.name})');

      return invite.copyWith(id: inviteRef.id);
    } catch (e) {
      print('❌ [InviteService] Errore createInvite: $e');
      return null;
    }
  }

  /// Ottiene il riferimento al documento sorgente basato sul tipo
  DocumentReference _getSourceDocRef(InviteSourceType type, String id) {
    switch (type) {
      case InviteSourceType.eisenhower:
        return _firestore.collection('eisenhower_matrices').doc(id);
      case InviteSourceType.estimationRoom:
        return _firestore.collection('planning_poker_sessions').doc(id);
      case InviteSourceType.agileProject:
        return _firestore.collection('agile_projects').doc(id);
      case InviteSourceType.smartTodo:
        return _firestore.collection('smart_todo_lists').doc(id);
      case InviteSourceType.retroBoard:
        return _firestore.collection('retrospectives').doc(id);
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // RICERCA INVITI
  // ══════════════════════════════════════════════════════════════════════════════

  /// Ottiene un invito per token (per deep linking)
  Future<UnifiedInviteModel?> getInviteByToken(String token) async {
    try {
      final snapshot = await _invitesRef
          .where('token', isEqualTo: token)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return UnifiedInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ [InviteService] Errore getInviteByToken: $e');
      return null;
    }
  }

  /// Ottiene un invito attivo per email in una specifica risorsa
  Future<UnifiedInviteModel?> getActiveInviteForEmail(
    InviteSourceType sourceType,
    String sourceId,
    String email,
  ) async {
    try {
      final snapshot = await _invitesRef
          .where('sourceType', isEqualTo: sourceType.name)
          .where('sourceId', isEqualTo: sourceId)
          .where('email', isEqualTo: email.toLowerCase())
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return UnifiedInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ [InviteService] Errore getActiveInviteForEmail: $e');
      return null;
    }
  }

  /// Ottiene tutti gli inviti per una specifica risorsa
  Future<List<UnifiedInviteModel>> getInvitesForSource(
    InviteSourceType sourceType,
    String sourceId,
  ) async {
    try {
      final snapshot = await _invitesRef
          .where('sourceType', isEqualTo: sourceType.name)
          .where('sourceId', isEqualTo: sourceId)
          .orderBy('invitedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => UnifiedInviteModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('❌ [InviteService] Errore getInvitesForSource: $e');
      return [];
    }
  }

  /// Stream degli inviti per una specifica risorsa
  Stream<List<UnifiedInviteModel>> streamInvitesForSource(
    InviteSourceType sourceType,
    String sourceId,
  ) {
    return _invitesRef
        .where('sourceType', isEqualTo: sourceType.name)
        .where('sourceId', isEqualTo: sourceId)
        .orderBy('invitedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UnifiedInviteModel.fromFirestore(doc))
            .toList());
  }

  /// Ottiene gli inviti pendenti per l'utente corrente
  Future<List<UnifiedInviteModel>> getMyPendingInvites() async {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) return [];

    try {
      final snapshot = await _invitesRef
          .where('email', isEqualTo: userEmail.toLowerCase())
          .where('status', isEqualTo: 'pending')
          .get();

      // Filtra quelli scaduti
      final now = DateTime.now();
      return snapshot.docs
          .map((doc) => UnifiedInviteModel.fromFirestore(doc))
          .where((invite) => invite.expiresAt.isAfter(now))
          .toList()
        ..sort((a, b) => b.invitedAt.compareTo(a.invitedAt));
    } catch (e) {
      print('❌ [InviteService] Errore getMyPendingInvites: $e');
      return [];
    }
  }

  /// Stream degli inviti pendenti per l'utente corrente
  Stream<List<UnifiedInviteModel>> streamMyPendingInvites() {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) return Stream.value([]);

    return _invitesRef
        .where('email', isEqualTo: userEmail.toLowerCase())
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      final now = DateTime.now();
      return snapshot.docs
          .map((doc) => UnifiedInviteModel.fromFirestore(doc))
          .where((invite) => invite.expiresAt.isAfter(now))
          .toList()
        ..sort((a, b) => b.invitedAt.compareTo(a.invitedAt));
    });
  }

  /// Ottiene inviti pendenti per tipo specifico
  Future<List<UnifiedInviteModel>> getMyPendingInvitesByType(InviteSourceType sourceType) async {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) return [];

    try {
      final snapshot = await _invitesRef
          .where('email', isEqualTo: userEmail.toLowerCase())
          .where('status', isEqualTo: 'pending')
          .where('sourceType', isEqualTo: sourceType.name)
          .get();

      final now = DateTime.now();
      return snapshot.docs
          .map((doc) => UnifiedInviteModel.fromFirestore(doc))
          .where((invite) => invite.expiresAt.isAfter(now))
          .toList()
        ..sort((a, b) => b.invitedAt.compareTo(a.invitedAt));
    } catch (e) {
      print('❌ [InviteService] Errore getMyPendingInvitesByType: $e');
      return [];
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // GESTIONE INVITI
  // ══════════════════════════════════════════════════════════════════════════════

  /// Accetta un invito
  ///
  /// [invite] - L'invito da accettare
  /// [accepterName] - Nome dell'utente che accetta (opzionale)
  ///
  /// Aggiunge automaticamente l'utente come partecipante alla risorsa
  Future<bool> acceptInvite(UnifiedInviteModel invite, {String? accepterName}) async {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) {
      print('❌ [InviteService] acceptInvite: Utente non autenticato');
      return false;
    }

    // Verifica che l'invito sia valido
    if (!invite.isValid) {
      print('❌ [InviteService] Invito non valido o scaduto');
      return false;
    }

    // Verifica che sia per l'utente corrente
    if (invite.email.toLowerCase() != userEmail.toLowerCase()) {
      print('❌ [InviteService] Invito non destinato a questo utente');
      return false;
    }

    try {
      final batch = _firestore.batch();
      final now = DateTime.now();
      final name = accepterName ?? userEmail.split('@').first;

      // 1. Aggiorna lo status dell'invito
      batch.update(_invitesRef.doc(invite.id), {
        'status': 'accepted',
        'acceptedAt': Timestamp.fromDate(now),
      });

      // 2. Aggiungi l'utente come partecipante alla risorsa e rimuovi da pending
      final sourceRef = _getSourceDocRef(invite.sourceType, invite.sourceId);
      final escapedEmail = _escapeEmail(userEmail);

      // Costruisci il partecipante basato sul tipo
      final participantData = _buildParticipantData(
        invite: invite,
        email: userEmail,
        name: name,
        now: now,
      );

      batch.update(sourceRef, {
        'participants.$escapedEmail': participantData,
        'participantEmails': FieldValue.arrayUnion([userEmail.toLowerCase()]),
        'pendingEmails': FieldValue.arrayRemove([userEmail.toLowerCase()]),
        'updatedAt': Timestamp.fromDate(now),
      });

      await batch.commit();

      print('✅ [InviteService] Invito accettato: ${invite.id}');
      return true;
    } catch (e) {
      print('❌ [InviteService] Errore acceptInvite: $e');
      return false;
    }
  }

  /// Costruisce i dati del partecipante in base al tipo di risorsa
  Map<String, dynamic> _buildParticipantData({
    required UnifiedInviteModel invite,
    required String email,
    required String name,
    required DateTime now,
  }) {
    switch (invite.sourceType) {
      case InviteSourceType.eisenhower:
        return {
          'email': email,
          'name': name,
          'role': invite.role.toLowerCase(),
          'joinedAt': Timestamp.fromDate(now),
          'isOnline': true,
        };

      case InviteSourceType.estimationRoom:
        return {
          'email': email,
          'name': name,
          'role': invite.role.toLowerCase(),
          'joinedAt': Timestamp.fromDate(now),
          'isOnline': true,
          'hasVoted': false,
        };

      case InviteSourceType.agileProject:
        return {
          'email': email,
          'name': name,
          'participantRole': invite.role.toLowerCase(),
          'teamRole': invite.teamRole ?? 'developer',
          'joinedAt': Timestamp.fromDate(now),
          'isActive': true,
        };

      case InviteSourceType.smartTodo:
        return {
          'email': email,
          'name': name,
          'role': invite.role.toLowerCase(),
          'joinedAt': Timestamp.fromDate(now),
        };

      case InviteSourceType.retroBoard:
        return {
          'email': email,
          'name': name,
          'role': invite.role.toLowerCase(),
          'joinedAt': Timestamp.fromDate(now),
        };
    }
  }

  /// Rifiuta un invito
  ///
  /// [inviteId] - ID dell'invito
  /// [reason] - Motivo del rifiuto (opzionale)
  Future<bool> declineInvite(String inviteId, {String? reason}) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ [InviteService] Invito non trovato: $inviteId');
        return false;
      }

      final invite = UnifiedInviteModel.fromFirestore(doc);
      final batch = _firestore.batch();

      // 1. Aggiorna stato invito
      batch.update(_invitesRef.doc(inviteId), {
        'status': 'declined',
        'declinedAt': Timestamp.fromDate(DateTime.now()),
        if (reason != null) 'declineReason': reason,
      });

      // 2. Rimuovi da pendingEmails della risorsa
      final sourceRef = _getSourceDocRef(invite.sourceType, invite.sourceId);
      batch.update(sourceRef, {
        'pendingEmails': FieldValue.arrayRemove([invite.email.toLowerCase()]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      await batch.commit();

      print('✅ [InviteService] Invito rifiutato: $inviteId');
      return true;
    } catch (e) {
      print('❌ [InviteService] Errore declineInvite: $e');
      return false;
    }
  }

  /// Revoca un invito (solo per chi ha invitato)
  Future<bool> revokeInvite(String inviteId) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ [InviteService] Invito non trovato: $inviteId');
        return false;
      }

      final invite = UnifiedInviteModel.fromFirestore(doc);
      final batch = _firestore.batch();

      // 1. Aggiorna stato invito
      batch.update(_invitesRef.doc(inviteId), {
        'status': 'revoked',
      });

      // 2. Rimuovi da pendingEmails della risorsa
      final sourceRef = _getSourceDocRef(invite.sourceType, invite.sourceId);
      batch.update(sourceRef, {
        'pendingEmails': FieldValue.arrayRemove([invite.email.toLowerCase()]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      await batch.commit();

      print('✅ [InviteService] Invito revocato: $inviteId');
      return true;
    } catch (e) {
      print('❌ [InviteService] Errore revokeInvite: $e');
      return false;
    }
  }

  /// Reinvia un invito (crea un nuovo token e resetta la scadenza)
  Future<UnifiedInviteModel?> resendInvite(String inviteId, {int expirationDays = 7}) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ [InviteService] Invito non trovato: $inviteId');
        return null;
      }

      final invite = UnifiedInviteModel.fromFirestore(doc);
      final now = DateTime.now();
      final newToken = UnifiedInviteModel.generateToken();

      await _invitesRef.doc(inviteId).update({
        'token': newToken,
        'status': 'pending',
        'expiresAt': Timestamp.fromDate(now.add(Duration(days: expirationDays))),
        'invitedAt': Timestamp.fromDate(now),
      });

      print('✅ [InviteService] Invito reinviato: $inviteId');
      return invite.copyWith(
        token: newToken,
        status: UnifiedInviteStatus.pending,
        expiresAt: now.add(Duration(days: expirationDays)),
        invitedAt: now,
      );
    } catch (e) {
      print('❌ [InviteService] Errore resendInvite: $e');
      return null;
    }
  }

  /// Elimina un invito
  Future<bool> deleteInvite(String inviteId) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ [InviteService] Invito non trovato: $inviteId');
        return false;
      }

      final invite = UnifiedInviteModel.fromFirestore(doc);
      final batch = _firestore.batch();

      // 1. Elimina invito
      batch.delete(_invitesRef.doc(inviteId));

      // 2. Rimuovi da pendingEmails della risorsa (se pending)
      if (invite.status == UnifiedInviteStatus.pending) {
        final sourceRef = _getSourceDocRef(invite.sourceType, invite.sourceId);
        batch.update(sourceRef, {
          'pendingEmails': FieldValue.arrayRemove([invite.email.toLowerCase()]),
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        });
      }

      await batch.commit();

      print('✅ [InviteService] Invito eliminato: $inviteId');
      return true;
    } catch (e) {
      print('❌ [InviteService] Errore deleteInvite: $e');
      return false;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // UTILITY
  // ══════════════════════════════════════════════════════════════════════════════

  /// Genera il link di invito per deep linking
  String generateInviteLink(
    UnifiedInviteModel invite, {
    String baseUrl = 'https://pm-agile-tools-app.web.app',
  }) {
    final typePath = _getTypePathForDeepLink(invite.sourceType);
    return '$baseUrl/#/invite/$typePath/${invite.sourceId}';
  }

  String _getTypePathForDeepLink(InviteSourceType type) {
    switch (type) {
      case InviteSourceType.eisenhower:
        return 'eisenhower';
      case InviteSourceType.estimationRoom:
        return 'estimation-room';
      case InviteSourceType.agileProject:
        return 'agile-project';
      case InviteSourceType.smartTodo:
        return 'smart-todo';
      case InviteSourceType.retroBoard:
        return 'retro';
    }
  }

  /// Aggiorna gli inviti scaduti a status 'expired'
  Future<int> expireOldInvites() async {
    try {
      final now = DateTime.now();
      final snapshot = await _invitesRef
          .where('status', isEqualTo: 'pending')
          .where('expiresAt', isLessThan: Timestamp.fromDate(now))
          .get();

      if (snapshot.docs.isEmpty) return 0;

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {'status': 'expired'});
      }
      await batch.commit();

      print('✅ [InviteService] ${snapshot.docs.length} inviti scaduti aggiornati');
      return snapshot.docs.length;
    } catch (e) {
      print('❌ [InviteService] Errore expireOldInvites: $e');
      return 0;
    }
  }

  /// Conta gli inviti pendenti per una risorsa
  Future<int> countPendingInvites(InviteSourceType sourceType, String sourceId) async {
    try {
      final snapshot = await _invitesRef
          .where('sourceType', isEqualTo: sourceType.name)
          .where('sourceId', isEqualTo: sourceId)
          .where('status', isEqualTo: 'pending')
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      print('❌ [InviteService] Errore countPendingInvites: $e');
      return 0;
    }
  }

  /// Verifica se l'utente corrente ha inviti pendenti
  Future<bool> hasMyPendingInvites() async {
    final invites = await getMyPendingInvites();
    return invites.isNotEmpty;
  }

  /// Escape email per uso come chiave Firestore (sostituisce . con _DOT_)
  String _escapeEmail(String email) {
    return email.toLowerCase().replaceAll('.', '_DOT_');
  }
}
