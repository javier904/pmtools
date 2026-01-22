import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import '../models/planning_poker_invite_model.dart';
import '../models/planning_poker_participant_model.dart';
import '../models/planning_poker_session_model.dart';
import '../models/subscription/subscription_limits_model.dart';
import '../utils/validators.dart';
import 'subscription/subscription_limits_service.dart';

/// Servizio per la gestione degli inviti alle sessioni di Planning Poker
///
/// Struttura Firestore (MIGRATO a collection dedicata come Eisenhower):
/// ```
/// estimation_room_invites/{inviteId}
///   - sessionId: String
///   - email: String
///   - role: String (facilitator, voter, observer)
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
class PlanningPokerInviteService {
  static final PlanningPokerInviteService _instance = PlanningPokerInviteService._internal();
  factory PlanningPokerInviteService() => _instance;
  PlanningPokerInviteService._internal() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  // Collection names
  static const String _sessionsCollection = 'planning_poker_sessions';
  /// MIGRATO: Collection dedicata come Eisenhower invece di subcollection
  static const String _invitesCollection = 'estimation_room_invites';

  /// Riferimento alla collection inviti
  CollectionReference<Map<String, dynamic>> get _invitesRef =>
      _firestore.collection(_invitesCollection);

  // ══════════════════════════════════════════════════════════════════════════
  // CRUD INVITI
  // ══════════════════════════════════════════════════════════════════════════

  /// Crea un nuovo invito
  /// Lancia [LimitExceededException] se il limite inviti per entita' e' raggiunto
  Future<PlanningPokerInviteModel> createInvite({
    required String sessionId,
    required String email,
    required ParticipantRole role,
    required String invitedBy,
    required String invitedByName,
    Duration expiration = const Duration(days: 7),
  }) async {
    // 🔒 CHECK LIMITE INVITI PER ENTITA'
    await _limitsService.enforceInviteLimit(entityType: 'estimation', entityId: sessionId);

    // Verifica se esiste già un invito pending per questa email
    final existingInvite = await getInviteByEmail(sessionId, email);
    if (existingInvite != null && existingInvite.isPending) {
      throw Exception('Esiste già un invito in attesa per questa email');
    }

    // Verifica se l'utente è già partecipante
    final session = await _getSession(sessionId);
    if (session != null && session.participants.containsKey(email.toLowerCase())) {
      throw Exception('Questo utente è già un partecipante della sessione');
    }

    final now = DateTime.now();
    final token = _generateToken();

    final invite = PlanningPokerInviteModel(
      id: '', // Sarà l'ID del documento
      sessionId: sessionId,
      email: email.toLowerCase(),
      role: role,
      status: InviteStatus.pending,
      invitedBy: invitedBy,
      invitedByName: invitedByName,
      invitedAt: now,
      expiresAt: now.add(expiration),
      token: token,
    );

    final batch = _firestore.batch();

    // 1. Crea documento invito nella collection dedicata
    final inviteRef = _invitesRef.doc();
    batch.set(inviteRef, invite.toFirestore());

    // 2. Aggiungi a pendingEmails (Sessione)
    final sessionRef = _firestore.collection(_sessionsCollection).doc(sessionId);
    batch.update(sessionRef, {
      'pendingEmails': FieldValue.arrayUnion([email.toLowerCase()]),
      'updatedAt': Timestamp.fromDate(now),
    });

    await batch.commit();

    print('✅ Invito creato in collection dedicata: ${invite.email} -> sessione $sessionId');
    return invite.copyWith(id: inviteRef.id);
  }

  /// Ottieni un invito per ID
  Future<PlanningPokerInviteModel?> getInvite(String sessionId, String inviteId) async {
    final doc = await _invitesRef.doc(inviteId).get();
    if (!doc.exists) return null;
    return PlanningPokerInviteModel.fromFirestore(doc);
  }

  /// Ottieni un invito per email in una specifica sessione
  Future<PlanningPokerInviteModel?> getInviteByEmail(String sessionId, String email) async {
    final query = await _invitesRef
        .where('sessionId', isEqualTo: sessionId)
        .where('email', isEqualTo: email.toLowerCase())
        .where('status', isEqualTo: 'pending')
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return PlanningPokerInviteModel.fromFirestore(query.docs.first);
  }

  /// Ottieni un invito per token (query semplice sulla collection dedicata)
  Future<PlanningPokerInviteModel?> getInviteByToken(String token) async {
    try {
      final snapshot = await _invitesRef
          .where('token', isEqualTo: token)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return PlanningPokerInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ Errore getInviteByToken: $e');
      return null;
    }
  }

  /// Ottieni un invito attivo per email (senza sessione specifica)
  Future<PlanningPokerInviteModel?> getActiveInviteForEmail(String email) async {
    try {
      final snapshot = await _invitesRef
          .where('email', isEqualTo: email.toLowerCase())
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return PlanningPokerInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ Errore getActiveInviteForEmail: $e');
      return null;
    }
  }

  /// Ottieni tutti gli inviti di una sessione
  Future<List<PlanningPokerInviteModel>> getSessionInvites(String sessionId) async {
    final query = await _invitesRef
        .where('sessionId', isEqualTo: sessionId)
        .orderBy('invitedAt', descending: true)
        .get();

    return query.docs
        .map((doc) => PlanningPokerInviteModel.fromFirestore(doc))
        .toList();
  }

  /// Ottieni inviti pending di una sessione
  Future<List<PlanningPokerInviteModel>> getPendingInvites(String sessionId) async {
    final query = await _invitesRef
        .where('sessionId', isEqualTo: sessionId)
        .where('status', isEqualTo: 'pending')
        .orderBy('invitedAt', descending: true)
        .get();

    return query.docs
        .map((doc) => PlanningPokerInviteModel.fromFirestore(doc))
        .toList();
  }

  /// Ottieni gli inviti pendenti per l'utente corrente
  Future<List<PlanningPokerInviteModel>> getMyPendingInvites(String email) async {
    try {
      final snapshot = await _invitesRef
          .where('email', isEqualTo: email.toLowerCase())
          .where('status', isEqualTo: 'pending')
          .get();

      // Filtra quelli scaduti
      final now = DateTime.now();
      return snapshot.docs
          .map((doc) => PlanningPokerInviteModel.fromFirestore(doc))
          .where((invite) => invite.expiresAt.isAfter(now))
          .toList();
    } catch (e) {
      print('❌ Errore getMyPendingInvites: $e');
      return [];
    }
  }

  /// Stream degli inviti pendenti per un utente
  Stream<List<PlanningPokerInviteModel>> streamMyPendingInvites(String email) {
    return _invitesRef
        .where('email', isEqualTo: email.toLowerCase())
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      final now = DateTime.now();
      return snapshot.docs
          .map((doc) => PlanningPokerInviteModel.fromFirestore(doc))
          .where((invite) => invite.expiresAt.isAfter(now))
          .toList();
    });
  }

  /// Stream degli inviti di una sessione
  Stream<List<PlanningPokerInviteModel>> streamSessionInvites(String sessionId) {
    return _invitesRef
        .where('sessionId', isEqualTo: sessionId)
        .orderBy('invitedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PlanningPokerInviteModel.fromFirestore(doc))
            .toList());
  }

  // ══════════════════════════════════════════════════════════════════════════
  // AZIONI INVITI
  // ══════════════════════════════════════════════════════════════════════════

  /// Accetta un invito (aggiunge l'utente come partecipante)
  Future<void> acceptInvite({
    required String token,
    required String acceptingUserEmail,
    required String acceptingUserName,
  }) async {
    final invite = await getInviteByToken(token);

    if (invite == null) {
      throw Exception('Invito non trovato');
    }

    if (invite.status != InviteStatus.pending) {
      throw Exception('Questo invito non è più valido (stato: ${invite.status.label})');
    }

    if (invite.isExpired) {
      // Aggiorna lo stato a expired
      await _updateInviteStatus(invite.id, InviteStatus.expired);
      throw Exception('Questo invito è scaduto');
    }

    // Verifica che l'email corrisponda (case insensitive)
    if (invite.email.toLowerCase() != acceptingUserEmail.toLowerCase()) {
      throw Exception('Questo invito è destinato a un altro utente');
    }

    // Aggiungi l'utente come partecipante alla sessione
    final participant = PlanningPokerParticipantModel(
      email: acceptingUserEmail.toLowerCase(),
      name: acceptingUserName,
      role: invite.role,
      joinedAt: DateTime.now(),
    );

    final batch = _firestore.batch();

    // 1. Aggiorna la sessione con il nuovo partecipante e RIMUOVI da pending
    final escapedEmail = acceptingUserEmail.toLowerCase().replaceAll('.', '_DOT_');
    final sessionRef = _firestore.collection(_sessionsCollection).doc(invite.sessionId);
    batch.update(sessionRef, {
      'participants.$escapedEmail': participant.toMap(),
      'participantEmails': FieldValue.arrayUnion([acceptingUserEmail.toLowerCase()]),
      'pendingEmails': FieldValue.arrayRemove([acceptingUserEmail.toLowerCase()]),
    });

    // 2. Aggiorna lo stato dell'invito nella collection dedicata
    batch.update(_invitesRef.doc(invite.id), {
      'status': 'accepted',
      'acceptedAt': Timestamp.now(),
    });

    await batch.commit();
    print('✅ Invito accettato: ${invite.email} -> sessione ${invite.sessionId}');
  }

  /// Accetta un invito per ID (usato da InviteAggregatorService)
  Future<bool> acceptInviteById(String inviteId, {String? accepterName}) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ Invito non trovato: $inviteId');
        return false;
      }

      final invite = PlanningPokerInviteModel.fromFirestore(doc);

      if (!invite.isPending || invite.isExpired) {
        print('❌ Invito non valido o scaduto');
        return false;
      }

      // Aggiungi l'utente come partecipante
      final participant = PlanningPokerParticipantModel(
        email: invite.email,
        name: accepterName ?? invite.email.split('@').first,
        role: invite.role,
        joinedAt: DateTime.now(),
      );

      final batch = _firestore.batch();

      // 1. Aggiorna status invito
      batch.update(_invitesRef.doc(inviteId), {
        'status': 'accepted',
        'acceptedAt': Timestamp.now(),
      });

      // 2. Aggiungi come partecipante alla sessione
      final escapedEmail = invite.email.replaceAll('.', '_DOT_');
      final sessionRef = _firestore.collection(_sessionsCollection).doc(invite.sessionId);
      batch.update(sessionRef, {
        'participants.$escapedEmail': participant.toMap(),
        'participantEmails': FieldValue.arrayUnion([invite.email]),
        'pendingEmails': FieldValue.arrayRemove([invite.email]),
      });

      await batch.commit();
      print('✅ Invito accettato: $inviteId');
      return true;
    } catch (e) {
      print('❌ Errore acceptInviteById: $e');
      return false;
    }
  }

  /// Rifiuta un invito
  Future<void> declineInvite({
    required String token,
    String? reason,
  }) async {
    final invite = await getInviteByToken(token);

    if (invite == null) {
      throw Exception('Invito non trovato');
    }

    if (invite.status != InviteStatus.pending) {
      throw Exception('Questo invito non è più valido');
    }

    await _invitesRef.doc(invite.id).update({
      'status': 'declined',
      'declinedAt': Timestamp.now(),
      if (reason != null) 'declineReason': reason,
    });

    print('❌ Invito rifiutato: ${invite.email}');
  }

  /// Rifiuta un invito per ID
  Future<bool> declineInviteById(String inviteId, {String? reason}) async {
    try {
      await _invitesRef.doc(inviteId).update({
        'status': 'declined',
        'declinedAt': Timestamp.now(),
        if (reason != null) 'declineReason': reason,
      });
      print('❌ Invito rifiutato: $inviteId');
      return true;
    } catch (e) {
      print('❌ Errore declineInviteById: $e');
      return false;
    }
  }

  /// Revoca un invito (solo facilitatore)
  Future<void> revokeInvite(String sessionId, String inviteId) async {
    await _updateInviteStatus(inviteId, InviteStatus.revoked);
    print('🚫 Invito revocato: $inviteId');
  }

  /// Reinvia un invito (genera nuovo token e reset expiration)
  Future<PlanningPokerInviteModel> resendInvite(String sessionId, String inviteId) async {
    final invite = await getInvite(sessionId, inviteId);

    if (invite == null) {
      throw Exception('Invito non trovato');
    }

    final now = DateTime.now();
    final newToken = _generateToken();

    await _invitesRef.doc(inviteId).update({
      'token': newToken,
      'expiresAt': Timestamp.fromDate(now.add(const Duration(days: 7))),
      'status': 'pending',
      'invitedAt': Timestamp.fromDate(now),
    });

    print('🔄 Invito reinviato: ${invite.email}');

    return invite.copyWith(
      token: newToken,
      expiresAt: now.add(const Duration(days: 7)),
      status: InviteStatus.pending,
    );
  }

  /// Elimina un invito
  Future<void> deleteInvite(String sessionId, String inviteId) async {
    await _invitesRef.doc(inviteId).delete();
    print('🗑️ Invito eliminato: $inviteId');
  }

  // ══════════════════════════════════════════════════════════════════════════
  // EMAIL (via Gmail API - account utente loggato)
  // ══════════════════════════════════════════════════════════════════════════

  /// Invia email di invito usando l'account Gmail dell'utente loggato
  Future<bool> sendInviteEmail({
    required PlanningPokerInviteModel invite,
    required String sessionName,
    required String projectName,
    required String baseUrl,
    required String senderEmail,
    required gmail.GmailApi gmailApi,
  }) async {
    try {
      final inviteLink = invite.generateInviteLink(baseUrl);
      final expirationDate = _formatDate(invite.expiresAt);
      final roleName = _getRoleName(invite.role);

      // 🔒 SICUREZZA: Sanitizza input utente per prevenire HTML injection
      final safeInviterName = Validators.sanitizeHtml(invite.invitedByName);
      final safeSessionName = Validators.sanitizeHtml(sessionName);
      final safeProjectName = Validators.sanitizeHtml(projectName);

      // Costruisci il contenuto HTML dell'email
      final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
    .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
    .header h1 { color: white; margin: 0; font-size: 24px; }
    .content { background: #f9f9f9; padding: 30px; border: 1px solid #ddd; }
    .button { display: inline-block; background: #4CAF50; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px; font-weight: bold; margin: 20px 0; }
    .button:hover { background: #45a049; }
    .info-box { background: white; padding: 15px; border-radius: 5px; margin: 15px 0; border-left: 4px solid #667eea; }
    .footer { text-align: center; padding: 20px; color: #666; font-size: 12px; }
    .role-badge { display: inline-block; background: #e8f5e9; color: #2e7d32; padding: 5px 10px; border-radius: 15px; font-size: 12px; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>🎯 Invito Planning Poker</h1>
    </div>
    <div class="content">
      <p>Ciao!</p>
      <p><strong>$safeInviterName</strong> ti ha invitato a partecipare a una sessione di Planning Poker.</p>

      <div class="info-box">
        <p><strong>📋 Sessione:</strong> $safeSessionName</p>
        <p><strong>📁 Progetto:</strong> $safeProjectName</p>
        <p><strong>👤 Ruolo:</strong> <span class="role-badge">$roleName</span></p>
        <p><strong>⏰ Scadenza invito:</strong> $expirationDate</p>
      </div>

      <p style="text-align: center;">
        <a href="$inviteLink" class="button">Accetta Invito</a>
      </p>

      <p style="font-size: 12px; color: #666;">
        Se il pulsante non funziona, copia e incolla questo link nel browser:<br>
        <a href="$inviteLink">$inviteLink</a>
      </p>
    </div>
    <div class="footer">
      <p>Questa email è stata inviata automaticamente dal sistema PMO Dashboard.</p>
    </div>
  </div>
</body>
</html>
''';

      // Costruisci email in formato MIME (Subject usa valore sanitizzato)
      final emailContent = '''From: $senderEmail
To: ${invite.email}
Subject: =?UTF-8?B?${base64Encode(utf8.encode('🎯 Invito Planning Poker: $safeSessionName'))}?=
MIME-Version: 1.0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

${base64Encode(utf8.encode(htmlBody))}
''';

      // Codifica per Gmail API
      final encodedEmail = base64Url
          .encode(utf8.encode(emailContent))
          .replaceAll('+', '-')
          .replaceAll('/', '_')
          .replaceAll('=', '');

      final message = gmail.Message(raw: encodedEmail);
      await gmailApi.users.messages.send(message, 'me');

      print('📧 Email invito inviata a: ${invite.email}');
      return true;
    } catch (e) {
      print('❌ Errore invio email: $e');
      return false;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'gennaio', 'febbraio', 'marzo', 'aprile', 'maggio', 'giugno',
      'luglio', 'agosto', 'settembre', 'ottobre', 'novembre', 'dicembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getRoleName(ParticipantRole role) {
    switch (role) {
      case ParticipantRole.facilitator:
        return 'Facilitatore';
      case ParticipantRole.voter:
        return 'Votante';
      case ParticipantRole.observer:
        return 'Osservatore';
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // UTILITY
  // ══════════════════════════════════════════════════════════════════════════

  /// Pulisci inviti scaduti per una sessione
  Future<int> cleanExpiredInvites(String sessionId) async {
    final now = DateTime.now();
    final query = await _invitesRef
        .where('sessionId', isEqualTo: sessionId)
        .where('status', isEqualTo: 'pending')
        .get();

    int count = 0;
    final batch = _firestore.batch();

    for (final doc in query.docs) {
      final invite = PlanningPokerInviteModel.fromFirestore(doc);
      if (invite.isExpired) {
        batch.update(doc.reference, {'status': 'expired'});
        count++;
      }
    }

    if (count > 0) {
      await batch.commit();
      print('🧹 Puliti $count inviti scaduti');
    }

    return count;
  }

  /// Aggiorna gli inviti scaduti globalmente
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

  /// Verifica se un utente ha un invito pending per una sessione
  Future<bool> hasUserPendingInvite(String sessionId, String email) async {
    final invite = await getInviteByEmail(sessionId, email);
    return invite != null && invite.isPending;
  }

  /// Conta gli inviti pendenti per una sessione
  Future<int> countPendingInvites(String sessionId) async {
    try {
      final snapshot = await _invitesRef
          .where('sessionId', isEqualTo: sessionId)
          .where('status', isEqualTo: 'pending')
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      print('❌ Errore countPendingInvites: $e');
      return 0;
    }
  }

  /// Ottieni statistiche inviti per una sessione
  Future<Map<String, int>> getInviteStats(String sessionId) async {
    final invites = await getSessionInvites(sessionId);

    return {
      'total': invites.length,
      'pending': invites.where((i) => i.status == InviteStatus.pending).length,
      'accepted': invites.where((i) => i.status == InviteStatus.accepted).length,
      'declined': invites.where((i) => i.status == InviteStatus.declined).length,
      'expired': invites.where((i) => i.status == InviteStatus.expired).length,
      'revoked': invites.where((i) => i.status == InviteStatus.revoked).length,
    };
  }

  /// Genera il link di invito
  /// Nuovo formato deep link: /invite/estimation-room/{sessionId}
  String generateInviteLink(String token, {String baseUrl = 'https://pm-agile-tools-app.web.app', String? sessionId}) {
    if (sessionId != null) {
      return '$baseUrl/#/invite/estimation-room/$sessionId';
    }
    // Fallback al formato token per retrocompatibilità
    return '$baseUrl/#/invite/estimation-room/token/$token';
  }

  // ══════════════════════════════════════════════════════════════════════════
  // PRIVATE HELPERS
  // ══════════════════════════════════════════════════════════════════════════

  /// Genera un token univoco
  String _generateToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(32, (_) => chars[random.nextInt(chars.length)]).join();
  }

  /// Aggiorna lo stato di un invito
  Future<void> _updateInviteStatus(String inviteId, InviteStatus status) async {
    await _invitesRef.doc(inviteId).update({'status': status.name});
  }

  /// Ottieni una sessione
  Future<PlanningPokerSessionModel?> _getSession(String sessionId) async {
    final doc = await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .get();

    if (!doc.exists) return null;
    return PlanningPokerSessionModel.fromFirestore(doc);
  }
}
