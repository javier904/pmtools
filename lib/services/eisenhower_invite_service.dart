import 'dart:math';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/eisenhower_invite_model.dart';
import '../models/eisenhower_participant_model.dart';
import '../models/subscription/subscription_limits_model.dart';
import '../utils/validators.dart';
import 'auth_service.dart';
import 'eisenhower_firestore_service.dart';
import 'subscription/subscription_limits_service.dart';

/// Servizio per la gestione degli inviti alla Matrice di Eisenhower
///
/// Gestisce il ciclo di vita completo degli inviti:
/// - Creazione inviti con token univoci
/// - Accettazione/rifiuto inviti
/// - Ricerca inviti per token (deep linking)
/// - Scadenza automatica
///
/// Struttura Firestore:
/// ```
/// eisenhower_invites/{inviteId}
///   - matrixId: String
///   - email: String
///   - role: String (voter, observer)
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
class EisenhowerInviteService {
  static final EisenhowerInviteService _instance = EisenhowerInviteService._internal();
  factory EisenhowerInviteService() => _instance;
  EisenhowerInviteService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final EisenhowerFirestoreService _matrixService = EisenhowerFirestoreService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  /// Nome della collection
  static const String _invitesCollection = 'eisenhower_invites';

  /// Riferimento alla collection
  CollectionReference<Map<String, dynamic>> get _invitesRef =>
      _firestore.collection(_invitesCollection);

  // ============================================================
  // CREAZIONE INVITI
  // ============================================================

  /// Crea un nuovo invito per una matrice
  ///
  /// [matrixId] - ID della matrice
  /// [email] - Email dell'invitato
  /// [role] - Ruolo assegnato (default: voter)
  /// [expirationDays] - Giorni di validita' (default: 7)
  ///
  /// Ritorna l'invito creato o null in caso di errore
  /// Lancia [LimitExceededException] se il limite inviti per entita' e' raggiunto
  Future<EisenhowerInviteModel?> createInvite({
    required String matrixId,
    required String email,
    EisenhowerParticipantRole role = EisenhowerParticipantRole.voter,
    int expirationDays = 7,
  }) async {
    final inviterEmail = _authService.currentUserEmail;
    if (inviterEmail == null) {
      print('❌ createInvite: Utente non autenticato');
      return null;
    }

    // 🔒 CHECK LIMITE INVITI PER ENTITA'
    await _limitsService.enforceInviteLimit(entityType: 'eisenhower', entityId: matrixId);

    // Verifica che non esista già un invito pending per questa email
    final existingInvite = await getActiveInviteForEmail(matrixId, email);
    if (existingInvite != null) {
      print('⚠️ Invito già esistente per $email');
      return existingInvite;
    }

    try {
      final now = DateTime.now();
      final token = _generateToken();

      final invite = EisenhowerInviteModel(
        id: '', // Sarà l'ID del documento
        matrixId: matrixId,
        email: email.toLowerCase().trim(),
        role: role,
        status: EisenhowerInviteStatus.pending,
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

      // 2. Aggiungi a pendingEmails nella matrice
      final matrixDocRef = _firestore.collection('eisenhower_matrices').doc(matrixId);
      
      batch.update(matrixDocRef, {
        'pendingEmails': FieldValue.arrayUnion([email.toLowerCase().trim()]),
        'updatedAt': Timestamp.fromDate(now),
      });

      await batch.commit();

      print('✅ Invito creato con Pending: ${inviteRef.id} per $email');

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
  Future<EisenhowerInviteModel?> getInviteByToken(String token) async {
    try {
      final snapshot = await _invitesRef
          .where('token', isEqualTo: token)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return EisenhowerInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ Errore getInviteByToken: $e');
      return null;
    }
  }

  /// Ottiene un invito attivo per email in una matrice
  Future<EisenhowerInviteModel?> getActiveInviteForEmail(String matrixId, String email) async {
    try {
      final snapshot = await _invitesRef
          .where('matrixId', isEqualTo: matrixId)
          .where('email', isEqualTo: email.toLowerCase())
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return EisenhowerInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ Errore getActiveInviteForEmail: $e');
      return null;
    }
  }

  /// Ottiene tutti gli inviti per una matrice
  Future<List<EisenhowerInviteModel>> getInvitesForMatrix(String matrixId) async {
    try {
      final snapshot = await _invitesRef
          .where('matrixId', isEqualTo: matrixId)
          .orderBy('invitedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => EisenhowerInviteModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('❌ Errore getInvitesForMatrix: $e');
      return [];
    }
  }

  /// Stream degli inviti per una matrice
  Stream<List<EisenhowerInviteModel>> streamInvitesForMatrix(String matrixId) {
    return _invitesRef
        .where('matrixId', isEqualTo: matrixId)
        .orderBy('invitedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EisenhowerInviteModel.fromFirestore(doc))
            .toList());
  }

  /// Ottiene gli inviti pendenti per l'utente corrente
  Future<List<EisenhowerInviteModel>> getMyPendingInvites() async {
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
          .map((doc) => EisenhowerInviteModel.fromFirestore(doc))
          .where((invite) => invite.expiresAt.isAfter(now))
          .toList();
    } catch (e) {
      print('❌ Errore getMyPendingInvites: $e');
      return [];
    }
  }

  /// Stream degli inviti pendenti per l'utente corrente
  Stream<List<EisenhowerInviteModel>> streamMyPendingInvites() {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) return Stream.value([]);

    return _invitesRef
        .where('email', isEqualTo: userEmail.toLowerCase())
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      final now = DateTime.now();
      return snapshot.docs
          .map((doc) => EisenhowerInviteModel.fromFirestore(doc))
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
  /// Aggiunge automaticamente l'utente come partecipante alla matrice
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

      final invite = EisenhowerInviteModel.fromFirestore(doc);

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

      // 2. Aggiungi l'utente come partecipante alla matrice e rimuovi da pending
      final participant = EisenhowerParticipantModel(
        email: userEmail,
        name: accepterName ?? userEmail.split('@').first,
        role: invite.role,
        joinedAt: DateTime.now(),
        isOnline: true,
      );

      final escapedEmail = EisenhowerParticipantModel.escapeEmail(userEmail);
      final matrixRef = _firestore.collection('eisenhower_matrices').doc(invite.matrixId);

      batch.update(matrixRef, {
        'participants.$escapedEmail': participant.toMap(),
        'pendingEmails': FieldValue.arrayRemove([userEmail]), // Rimuovi da pending
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      await batch.commit();

      print('✅ Invito accettato e promosso: $inviteId');
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

      await _invitesRef.doc(inviteId).update({
        'status': 'declined',
        'declinedAt': Timestamp.fromDate(DateTime.now()),
        if (reason != null) 'declineReason': reason,
      });

      print('✅ Invito rifiutato: $inviteId');
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

      await _invitesRef.doc(inviteId).update({
        'status': 'revoked',
      });

      print('✅ Invito revocato: $inviteId');
      return true;
    } catch (e) {
      print('❌ Errore revokeInvite: $e');
      return false;
    }
  }

  /// Reinvia un invito (crea un nuovo token e resetta la scadenza)
  Future<EisenhowerInviteModel?> resendInvite(String inviteId, {int expirationDays = 7}) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ Invito non trovato: $inviteId');
        return null;
      }

      final invite = EisenhowerInviteModel.fromFirestore(doc);
      final now = DateTime.now();
      final newToken = _generateToken();

      await _invitesRef.doc(inviteId).update({
        'token': newToken,
        'status': 'pending',
        'expiresAt': Timestamp.fromDate(now.add(Duration(days: expirationDays))),
        'invitedAt': Timestamp.fromDate(now),
      });

      print('✅ Invito reinviato: $inviteId');
      return invite.copyWith(
        token: newToken,
        status: EisenhowerInviteStatus.pending,
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
      await _invitesRef.doc(inviteId).delete();
      print('✅ Invito eliminato: $inviteId');
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
  /// Nuovo formato deep link: /invite/eisenhower/{matrixId}/{token}
  String generateInviteLink(String token, {String baseUrl = 'https://pm-agile-tools-app.web.app', String? matrixId}) {
    if (matrixId != null) {
      return '$baseUrl/#/invite/eisenhower/$matrixId';
    }
    // Fallback al formato token per retrocompatibilità
    return '$baseUrl/#/invite/eisenhower/token/$token';
  }

  /// Aggiorna gli inviti scaduti a status 'expired'
  ///
  /// Da chiamare periodicamente o al caricamento delle matrici
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

      print('✅ ${snapshot.docs.length} inviti scaduti aggiornati');
      return snapshot.docs.length;
    } catch (e) {
      print('❌ Errore expireOldInvites: $e');
      return 0;
    }
  }

  /// Conta gli inviti pendenti per una matrice
  Future<int> countPendingInvites(String matrixId) async {
    try {
      final snapshot = await _invitesRef
          .where('matrixId', isEqualTo: matrixId)
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
