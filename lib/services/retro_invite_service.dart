import 'dart:math';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/retro_invite_model.dart';
import '../models/subscription/subscription_limits_model.dart';
import '../utils/validators.dart';
import 'auth_service.dart';
import 'subscription/subscription_limits_service.dart';

/// Servizio per la gestione degli inviti alle Retrospective
///
/// Gestisce il ciclo di vita completo degli inviti:
/// - Creazione inviti con token univoci
/// - Accettazione/rifiuto inviti
/// - Ricerca inviti per token (deep linking)
/// - Scadenza automatica
///
/// Struttura Firestore:
/// ```
/// retro_invites/{inviteId}
///   - boardId: String
///   - email: String
///   - role: String (facilitator, participant, observer)
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
class RetroInviteService {
  static final RetroInviteService _instance = RetroInviteService._internal();
  factory RetroInviteService() => _instance;
  RetroInviteService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  /// Nome della collection
  static const String _invitesCollection = 'retro_invites';

  /// Riferimento alla collection
  CollectionReference<Map<String, dynamic>> get _invitesRef =>
      _firestore.collection(_invitesCollection);

  // ============================================================
  // CREAZIONE INVITI
  // ============================================================

  /// Crea un nuovo invito per una retrospective
  ///
  /// [boardId] - ID della retrospective
  /// [email] - Email dell'invitato
  /// [role] - Ruolo assegnato (default: participant)
  /// [expirationDays] - Giorni di validita' (default: 7)
  ///
  /// Ritorna l'invito creato o null in caso di errore
  /// Lancia [LimitExceededException] se il limite inviti per entita' e' raggiunto
  Future<RetroInviteModel?> createInvite({
    required String boardId,
    required String email,
    RetroParticipantRole role = RetroParticipantRole.participant,
    int expirationDays = 7,
  }) async {
    final inviterEmail = _authService.currentUserEmail;
    if (inviterEmail == null) {
      print('❌ createInvite: Utente non autenticato');
      return null;
    }

    // 🔒 CHECK LIMITE INVITI PER ENTITA'
    await _limitsService.enforceInviteLimit(entityType: 'retro', entityId: boardId);

    // Verifica che non esista già un invito pending per questa email
    final existingInvite = await getActiveInviteForEmail(boardId, email);
    if (existingInvite != null) {
      print('⚠️ Invito già esistente per $email');
      return existingInvite;
    }

    try {
      final now = DateTime.now();
      final token = _generateToken();

      final invite = RetroInviteModel(
        id: '', // Sarà l'ID del documento
        boardId: boardId,
        email: email.toLowerCase().trim(),
        role: role,
        status: RetroInviteStatus.pending,
        invitedBy: inviterEmail,
        invitedByName: inviterEmail.split('@').first,
        invitedAt: now,
        expiresAt: now.add(Duration(days: expirationDays)),
        token: token,
      );

      final batch = _firestore.batch();

      // 1. Crea invito
      final inviteRef = _invitesRef.doc();
      batch.set(inviteRef, invite.toFirestore());

      // 2. Aggiungi a pendingEmails nella retrospective (se il campo esiste)
      final retroDocRef = _firestore.collection('retrospectives').doc(boardId);

      batch.update(retroDocRef, {
        'pendingEmails': FieldValue.arrayUnion([email.toLowerCase().trim()]),
        'updatedAt': Timestamp.fromDate(now),
      });

      await batch.commit();

      print('✅ Invito retro creato con Pending: ${inviteRef.id} per $email');

      return invite.copyWith(id: inviteRef.id);
    } catch (e) {
      print('❌ Errore createInvite: $e');
      return null;
    }
  }

  /// Genera un token random di 32 caratteri
  String _generateToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(32, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // ============================================================
  // RICERCA INVITI
  // ============================================================

  /// Ottiene un invito per token (per deep linking)
  Future<RetroInviteModel?> getInviteByToken(String token) async {
    try {
      final snapshot = await _invitesRef
          .where('token', isEqualTo: token)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return RetroInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ Errore getInviteByToken: $e');
      return null;
    }
  }

  /// Ottiene un invito attivo per email in una retrospective
  Future<RetroInviteModel?> getActiveInviteForEmail(String boardId, String email) async {
    try {
      final snapshot = await _invitesRef
          .where('boardId', isEqualTo: boardId)
          .where('email', isEqualTo: email.toLowerCase())
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return RetroInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ Errore getActiveInviteForEmail: $e');
      return null;
    }
  }

  /// Ottiene tutti gli inviti per una retrospective
  Future<List<RetroInviteModel>> getInvitesForBoard(String boardId) async {
    try {
      final snapshot = await _invitesRef
          .where('boardId', isEqualTo: boardId)
          .orderBy('invitedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => RetroInviteModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('❌ Errore getInvitesForBoard: $e');
      return [];
    }
  }

  /// Stream degli inviti per una retrospective
  Stream<List<RetroInviteModel>> streamInvitesForBoard(String boardId) {
    return _invitesRef
        .where('boardId', isEqualTo: boardId)
        .orderBy('invitedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => RetroInviteModel.fromFirestore(doc))
            .toList());
  }

  /// Ottiene gli inviti pendenti per l'utente corrente
  Future<List<RetroInviteModel>> getMyPendingInvites() async {
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
          .map((doc) => RetroInviteModel.fromFirestore(doc))
          .where((invite) => invite.expiresAt.isAfter(now))
          .toList();
    } catch (e) {
      print('❌ Errore getMyPendingInvites: $e');
      return [];
    }
  }

  /// Stream degli inviti pendenti per l'utente corrente
  Stream<List<RetroInviteModel>> streamMyPendingInvites() {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) return Stream.value([]);

    return _invitesRef
        .where('email', isEqualTo: userEmail.toLowerCase())
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      final now = DateTime.now();
      return snapshot.docs
          .map((doc) => RetroInviteModel.fromFirestore(doc))
          .where((invite) => invite.expiresAt.isAfter(now))
          .toList();
    });
  }

  // ============================================================
  // GESTIONE INVITI
  // ============================================================

  /// Accetta un invito
  ///
  /// [inviteId] - ID dell'invito
  /// [accepterName] - Nome dell'utente che accetta (opzionale)
  ///
  /// Aggiunge automaticamente l'utente come partecipante alla retrospective
  Future<bool> acceptInvite(String inviteId, {String? accepterName}) async {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) {
      print('❌ acceptInvite: Utente non autenticato');
      return false;
    }

    try {
      // Ottieni l'invito
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ Invito non trovato: $inviteId');
        return false;
      }

      final invite = RetroInviteModel.fromFirestore(doc);

      // Verifica che l'invito sia valido
      if (!invite.isValid) {
        print('❌ Invito non valido o scaduto');
        return false;
      }

      // Verifica che sia per l'utente corrente
      if (invite.email.toLowerCase() != userEmail.toLowerCase()) {
        print('❌ Invito non destinato a questo utente');
        return false;
      }

      final batch = _firestore.batch();

      // 1. Aggiorna lo status dell'invito
      batch.update(_invitesRef.doc(inviteId), {
        'status': 'accepted',
        'acceptedAt': Timestamp.fromDate(DateTime.now()),
      });

      // 2. Aggiungi l'utente come partecipante alla retrospective
      final retroRef = _firestore.collection('retrospectives').doc(invite.boardId);

      batch.update(retroRef, {
        'participantEmails': FieldValue.arrayUnion([userEmail.toLowerCase()]),
        'pendingEmails': FieldValue.arrayRemove([userEmail.toLowerCase()]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      await batch.commit();

      print('✅ Invito retro accettato e promosso: $inviteId');
      return true;
    } catch (e) {
      print('❌ Errore acceptInvite: $e');
      return false;
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
        print('❌ Invito non trovato: $inviteId');
        return false;
      }

      final invite = RetroInviteModel.fromFirestore(doc);

      final batch = _firestore.batch();

      // 1. Aggiorna status invito
      batch.update(_invitesRef.doc(inviteId), {
        'status': 'declined',
        'declinedAt': Timestamp.fromDate(DateTime.now()),
        if (reason != null) 'declineReason': reason,
      });

      // 2. Rimuovi da pendingEmails
      final retroRef = _firestore.collection('retrospectives').doc(invite.boardId);
      batch.update(retroRef, {
        'pendingEmails': FieldValue.arrayRemove([invite.email.toLowerCase()]),
      });

      await batch.commit();

      print('✅ Invito retro rifiutato: $inviteId');
      return true;
    } catch (e) {
      print('❌ Errore declineInvite: $e');
      return false;
    }
  }

  /// Revoca un invito (solo per il facilitatore)
  Future<bool> revokeInvite(String inviteId) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ Invito non trovato: $inviteId');
        return false;
      }

      final invite = RetroInviteModel.fromFirestore(doc);

      final batch = _firestore.batch();

      batch.update(_invitesRef.doc(inviteId), {
        'status': 'revoked',
      });

      // Rimuovi da pendingEmails
      final retroRef = _firestore.collection('retrospectives').doc(invite.boardId);
      batch.update(retroRef, {
        'pendingEmails': FieldValue.arrayRemove([invite.email.toLowerCase()]),
      });

      await batch.commit();

      print('✅ Invito retro revocato: $inviteId');
      return true;
    } catch (e) {
      print('❌ Errore revokeInvite: $e');
      return false;
    }
  }

  /// Reinvia un invito (crea un nuovo token e resetta la scadenza)
  Future<RetroInviteModel?> resendInvite(String inviteId, {int expirationDays = 7}) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ Invito non trovato: $inviteId');
        return null;
      }

      final invite = RetroInviteModel.fromFirestore(doc);
      final now = DateTime.now();
      final newToken = _generateToken();

      await _invitesRef.doc(inviteId).update({
        'token': newToken,
        'status': 'pending',
        'expiresAt': Timestamp.fromDate(now.add(Duration(days: expirationDays))),
        'invitedAt': Timestamp.fromDate(now),
      });

      print('✅ Invito retro reinviato: $inviteId');
      return invite.copyWith(
        token: newToken,
        status: RetroInviteStatus.pending,
        expiresAt: now.add(Duration(days: expirationDays)),
        invitedAt: now,
      );
    } catch (e) {
      print('❌ Errore resendInvite: $e');
      return null;
    }
  }

  /// Elimina un invito
  Future<bool> deleteInvite(String inviteId) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (doc.exists) {
        final invite = RetroInviteModel.fromFirestore(doc);

        // Rimuovi anche da pendingEmails
        await _firestore.collection('retrospectives').doc(invite.boardId).update({
          'pendingEmails': FieldValue.arrayRemove([invite.email.toLowerCase()]),
        });
      }

      await _invitesRef.doc(inviteId).delete();
      print('✅ Invito retro eliminato: $inviteId');
      return true;
    } catch (e) {
      print('❌ Errore deleteInvite: $e');
      return false;
    }
  }

  // ============================================================
  // UTILITY
  // ============================================================

  /// Genera il link di invito
  /// Formato deep link: /invite/retro/{boardId}
  String generateInviteLink(String token, {String baseUrl = 'https://pm-agile-tools-app.web.app', String? boardId}) {
    if (boardId != null) {
      return '$baseUrl/#/invite/retro/$boardId';
    }
    // Fallback al formato token per retrocompatibilità
    return '$baseUrl/#/invite/retro/token/$token';
  }

  /// Aggiorna gli inviti scaduti a status 'expired'
  ///
  /// Da chiamare periodicamente o al caricamento delle retrospective
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

      print('✅ ${snapshot.docs.length} inviti retro scaduti aggiornati');
      return snapshot.docs.length;
    } catch (e) {
      print('❌ Errore expireOldInvites: $e');
      return 0;
    }
  }

  /// Conta gli inviti pendenti per una retrospective
  Future<int> countPendingInvites(String boardId) async {
    try {
      final snapshot = await _invitesRef
          .where('boardId', isEqualTo: boardId)
          .where('status', isEqualTo: 'pending')
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      print('❌ Errore countPendingInvites: $e');
      return 0;
    }
  }

  /// Verifica se l'utente corrente ha inviti pendenti
  Future<bool> hasMyPendingInvites() async {
    final invites = await getMyPendingInvites();
    return invites.isNotEmpty;
  }

}
