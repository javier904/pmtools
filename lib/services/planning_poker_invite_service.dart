import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import '../models/planning_poker_invite_model.dart';
import '../models/planning_poker_participant_model.dart';
import '../models/planning_poker_session_model.dart';

/// Servizio per la gestione degli inviti alle sessioni di Planning Poker
class PlanningPokerInviteService {
  final FirebaseFirestore _firestore;

  // Collection names
  static const String _sessionsCollection = 'planning_poker_sessions';
  static const String _invitesSubcollection = 'invites';

  PlanningPokerInviteService({
    FirebaseFirestore? firestore,
  })  : _firestore = firestore ?? FirebaseFirestore.instance;

  // ══════════════════════════════════════════════════════════════════════════
  // CRUD INVITI
  // ══════════════════════════════════════════════════════════════════════════

  /// Crea un nuovo invito
  Future<PlanningPokerInviteModel> createInvite({
    required String sessionId,
    required String email,
    required ParticipantRole role,
    required String invitedBy,
    required String invitedByName,
    Duration expiration = const Duration(days: 7),
  }) async {
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
    final inviteId = _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
        .doc()
        .id;

    final invite = PlanningPokerInviteModel(
      id: inviteId,
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

    await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
        .doc(inviteId)
        .set(invite.toFirestore());

    print('✅ Invito creato: ${invite.email} -> sessione $sessionId');
    return invite;
  }

  /// Ottieni un invito per ID
  Future<PlanningPokerInviteModel?> getInvite(String sessionId, String inviteId) async {
    final doc = await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
        .doc(inviteId)
        .get();

    if (!doc.exists) return null;
    return PlanningPokerInviteModel.fromFirestore(doc);
  }

  /// Ottieni un invito per email
  Future<PlanningPokerInviteModel?> getInviteByEmail(String sessionId, String email) async {
    final query = await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
        .where('email', isEqualTo: email.toLowerCase())
        .where('status', isEqualTo: 'pending')
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return PlanningPokerInviteModel.fromFirestore(query.docs.first);
  }

  /// Ottieni un invito per token
  Future<PlanningPokerInviteModel?> getInviteByToken(String token) async {
    // Query su tutte le sessioni per trovare l'invito con questo token
    final sessionsQuery = await _firestore
        .collection(_sessionsCollection)
        .get();

    for (final sessionDoc in sessionsQuery.docs) {
      final inviteQuery = await sessionDoc.reference
          .collection(_invitesSubcollection)
          .where('token', isEqualTo: token)
          .limit(1)
          .get();

      if (inviteQuery.docs.isNotEmpty) {
        return PlanningPokerInviteModel.fromFirestore(inviteQuery.docs.first);
      }
    }

    return null;
  }

  /// Ottieni tutti gli inviti di una sessione
  Future<List<PlanningPokerInviteModel>> getSessionInvites(String sessionId) async {
    final query = await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
        .orderBy('invitedAt', descending: true)
        .get();

    return query.docs
        .map((doc) => PlanningPokerInviteModel.fromFirestore(doc))
        .toList();
  }

  /// Ottieni inviti pending di una sessione
  Future<List<PlanningPokerInviteModel>> getPendingInvites(String sessionId) async {
    final query = await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
        .where('status', isEqualTo: 'pending')
        .orderBy('invitedAt', descending: true)
        .get();

    return query.docs
        .map((doc) => PlanningPokerInviteModel.fromFirestore(doc))
        .toList();
  }

  /// Stream degli inviti di una sessione
  Stream<List<PlanningPokerInviteModel>> streamSessionInvites(String sessionId) {
    return _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
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
      await _updateInviteStatus(invite.sessionId, invite.id, InviteStatus.expired);
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

    // Aggiorna la sessione con il nuovo partecipante
    // Escape dei punti nell'email per usarla come chiave Firestore
    final escapedEmail = acceptingUserEmail.toLowerCase().replaceAll('.', '_DOT_');
    final sessionRef = _firestore.collection(_sessionsCollection).doc(invite.sessionId);
    batch.update(sessionRef, {
      'participants.$escapedEmail': participant.toMap(),
      'participantEmails': FieldValue.arrayUnion([acceptingUserEmail.toLowerCase()]),
    });

    // Aggiorna lo stato dell'invito
    final inviteRef = sessionRef.collection(_invitesSubcollection).doc(invite.id);
    batch.update(inviteRef, {
      'status': 'accepted',
      'acceptedAt': Timestamp.now(),
    });

    await batch.commit();
    print('✅ Invito accettato: ${invite.email} -> sessione ${invite.sessionId}');
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

    await _firestore
        .collection(_sessionsCollection)
        .doc(invite.sessionId)
        .collection(_invitesSubcollection)
        .doc(invite.id)
        .update({
      'status': 'declined',
      'declinedAt': Timestamp.now(),
      if (reason != null) 'declineReason': reason,
    });

    print('❌ Invito rifiutato: ${invite.email}');
  }

  /// Revoca un invito (solo facilitatore)
  Future<void> revokeInvite(String sessionId, String inviteId) async {
    await _updateInviteStatus(sessionId, inviteId, InviteStatus.revoked);
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

    await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
        .doc(inviteId)
        .update({
      'token': newToken,
      'expiresAt': Timestamp.fromDate(now.add(const Duration(days: 7))),
      'status': 'pending',
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
    await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
        .doc(inviteId)
        .delete();

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
      <p><strong>${invite.invitedByName}</strong> ti ha invitato a partecipare a una sessione di Planning Poker.</p>

      <div class="info-box">
        <p><strong>📋 Sessione:</strong> $sessionName</p>
        <p><strong>📁 Progetto:</strong> $projectName</p>
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

      // Costruisci email in formato MIME
      final emailContent = '''From: $senderEmail
To: ${invite.email}
Subject: =?UTF-8?B?${base64Encode(utf8.encode('🎯 Invito Planning Poker: $sessionName'))}?=
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

  /// Pulisci inviti scaduti
  Future<int> cleanExpiredInvites(String sessionId) async {
    final now = DateTime.now();
    final query = await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
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

  /// Verifica se un utente ha un invito pending per una sessione
  Future<bool> hasUserPendingInvite(String sessionId, String email) async {
    final invite = await getInviteByEmail(sessionId, email);
    return invite != null && invite.isPending;
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
  Future<void> _updateInviteStatus(String sessionId, String inviteId, InviteStatus status) async {
    await _firestore
        .collection(_sessionsCollection)
        .doc(sessionId)
        .collection(_invitesSubcollection)
        .doc(inviteId)
        .update({'status': status.name});
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
