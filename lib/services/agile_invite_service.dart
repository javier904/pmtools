import 'dart:math';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import '../models/agile_invite_model.dart';
import '../models/agile_enums.dart';
import '../models/team_member_model.dart';
import '../utils/validators.dart';
import 'auth_service.dart';
import 'agile_firestore_service.dart';
import 'agile_audit_service.dart';

/// Servizio per la gestione degli inviti ai Progetti Agile
///
/// Gestisce il ciclo di vita completo degli inviti:
/// - Creazione inviti con token univoci
/// - Accettazione/rifiuto inviti
/// - Ricerca inviti per token (deep linking)
/// - Scadenza automatica
///
/// Struttura Firestore:
/// ```
/// agile_invites/{inviteId}
///   - projectId: String
///   - email: String
///   - participantRole: String (owner, admin, member, viewer)
///   - teamRole: String (product_owner, scrum_master, developer, designer, qa, stakeholder)
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
class AgileInviteService {
  static final AgileInviteService _instance = AgileInviteService._internal();
  factory AgileInviteService() => _instance;
  AgileInviteService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final AgileFirestoreService _projectService = AgileFirestoreService();
  final AgileAuditService _auditService = AgileAuditService();

  /// Nome della collection
  static const String _invitesCollection = 'agile_invites';

  /// Riferimento alla collection
  CollectionReference<Map<String, dynamic>> get _invitesRef =>
      _firestore.collection(_invitesCollection);

  // ============================================================
  // CREAZIONE INVITI
  // ============================================================

  /// Crea un nuovo invito per un progetto
  ///
  /// [projectId] - ID del progetto
  /// [email] - Email dell'invitato
  /// [participantRole] - Ruolo nel progetto (default: member)
  /// [teamRole] - Ruolo nel team (default: developer)
  /// [expirationDays] - Giorni di validita' (default: 7)
  ///
  /// Ritorna l'invito creato o null in caso di errore
  Future<AgileInviteModel?> createInvite({
    required String projectId,
    required String email,
    AgileParticipantRole participantRole = AgileParticipantRole.member,
    TeamRole teamRole = TeamRole.developer,
    int expirationDays = 7,
  }) async {
    final inviterEmail = _authService.currentUserEmail;
    if (inviterEmail == null) {
      print('❌ createInvite: Utente non autenticato');
      return null;
    }

    // Verifica che non esista già un invito pending per questa email
    final existingInvite = await getActiveInviteForEmail(projectId, email);
    if (existingInvite != null) {
      print('⚠️ Invito già esistente per $email');
      return existingInvite;
    }

    try {
      final now = DateTime.now();
      final token = _generateToken();

      final invite = AgileInviteModel(
        id: '', // Generato da Firestore
        projectId: projectId,
        email: email.toLowerCase().trim(),
        participantRole: participantRole,
        teamRole: teamRole,
        status: AgileInviteStatus.pending,
        invitedBy: inviterEmail,
        invitedByName: inviterEmail.split('@').first,
        invitedAt: now,
        expiresAt: now.add(Duration(days: expirationDays)),
        token: token,
      );

      final docRef = await _invitesRef.add(invite.toFirestore());
      print('✅ Invito creato: ${docRef.id} per $email');

      // Log audit
      await _auditService.logInvite(
        projectId: projectId,
        inviteeEmail: email,
        role: '${participantRole.displayName} / ${teamRole.displayName}',
        performedBy: inviterEmail,
        performedByName: inviterEmail.split('@').first,
      );

      // Aggiungi ai pending participants del progetto
      await _projectService.addPendingParticipant(projectId, email);

      return invite.copyWith(id: docRef.id);
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
  Future<AgileInviteModel?> getInviteByToken(String token) async {
    try {
      final snapshot = await _invitesRef
          .where('token', isEqualTo: token)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return AgileInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ Errore getInviteByToken: $e');
      return null;
    }
  }

  /// Ottiene un invito attivo per email in un progetto
  Future<AgileInviteModel?> getActiveInviteForEmail(String projectId, String email) async {
    try {
      final snapshot = await _invitesRef
          .where('projectId', isEqualTo: projectId)
          .where('email', isEqualTo: email.toLowerCase())
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return AgileInviteModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ Errore getActiveInviteForEmail: $e');
      return null;
    }
  }

  /// Ottiene tutti gli inviti per un progetto
  Future<List<AgileInviteModel>> getInvitesForProject(String projectId) async {
    try {
      final snapshot = await _invitesRef
          .where('projectId', isEqualTo: projectId)
          .orderBy('invitedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => AgileInviteModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('❌ Errore getInvitesForProject: $e');
      return [];
    }
  }

  /// Stream degli inviti per un progetto
  Stream<List<AgileInviteModel>> streamInvitesForProject(String projectId) {
    return _invitesRef
        .where('projectId', isEqualTo: projectId)
        .orderBy('invitedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AgileInviteModel.fromFirestore(doc))
            .toList());
  }

  /// Ottiene gli inviti pendenti per l'utente corrente
  Future<List<AgileInviteModel>> getMyPendingInvites() async {
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
          .map((doc) => AgileInviteModel.fromFirestore(doc))
          .where((invite) => invite.expiresAt.isAfter(now))
          .toList();
    } catch (e) {
      print('❌ Errore getMyPendingInvites: $e');
      return [];
    }
  }

  /// Stream degli inviti pendenti per l'utente corrente
  Stream<List<AgileInviteModel>> streamMyPendingInvites() {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) return Stream.value([]);

    return _invitesRef
        .where('email', isEqualTo: userEmail.toLowerCase())
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      final now = DateTime.now();
      return snapshot.docs
          .map((doc) => AgileInviteModel.fromFirestore(doc))
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
  /// Aggiunge automaticamente l'utente come partecipante al progetto
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

      final invite = AgileInviteModel.fromFirestore(doc);

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

      // Aggiorna lo status dell'invito
      await _invitesRef.doc(inviteId).update({
        'status': 'accepted',
        'acceptedAt': Timestamp.fromDate(DateTime.now()),
      });

      // Aggiungi l'utente come partecipante al progetto
      final participant = TeamMemberModel(
        email: userEmail,
        name: accepterName ?? userEmail.split('@').first,
        participantRole: invite.participantRole,
        teamRole: invite.teamRole,
        joinedAt: DateTime.now(),
        isOnline: true,
      );

      await _projectService.promotePendingToActive(invite.projectId, participant);

      // Log audit
      await _auditService.logJoin(
        projectId: invite.projectId,
        userEmail: userEmail,
        userName: accepterName ?? userEmail.split('@').first,
        role: '${invite.participantRole.displayName} / ${invite.teamRole.displayName}',
      );

      print('✅ Invito accettato: $inviteId');
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

  /// Revoca un invito (solo per owner/admin)
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
  Future<AgileInviteModel?> resendInvite(String inviteId, {int expirationDays = 7}) async {
    try {
      final doc = await _invitesRef.doc(inviteId).get();
      if (!doc.exists) {
        print('❌ Invito non trovato: $inviteId');
        return null;
      }

      final invite = AgileInviteModel.fromFirestore(doc);
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
        status: AgileInviteStatus.pending,
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

  /// Genera il link di invito - nuovo formato deep link
  String generateInviteLink(String token, {String baseUrl = 'https://pm-agile-tools-app.web.app', String? projectId}) {
    if (projectId != null) {
      return '$baseUrl/#/invite/agile-project/$projectId';
    }
    // Fallback al formato token per retrocompatibilità
    return '$baseUrl/#/invite/agile-project/token/$token';
  }

  /// Aggiorna gli inviti scaduti a status 'expired'
  ///
  /// Da chiamare periodicamente o al caricamento dei progetti
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

  /// Conta gli inviti pendenti per un progetto
  Future<int> countPendingInvites(String projectId) async {
    try {
      final snapshot = await _invitesRef
          .where('projectId', isEqualTo: projectId)
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

  // ============================================================
  // EMAIL (via Gmail API - account utente loggato)
  // ============================================================

  /// Invia email di invito usando l'account Gmail dell'utente loggato
  Future<bool> sendInviteEmail({
    required AgileInviteModel invite,
    required String projectName,
    required String baseUrl,
    required String senderEmail,
    required gmail.GmailApi gmailApi,
  }) async {
    print('📧 [SERVICE] sendInviteEmail() chiamato');
    print('📧 [SERVICE] - projectName: $projectName');
    print('📧 [SERVICE] - baseUrl: $baseUrl');
    print('📧 [SERVICE] - senderEmail: $senderEmail');
    print('📧 [SERVICE] - destinatario: ${invite.email}');

    try {
      final inviteLink = generateInviteLink(invite.token, baseUrl: baseUrl, projectId: invite.projectId);
      final expirationDate = _formatDate(invite.expiresAt);
      final participantRoleName = invite.participantRole.displayName;
      final teamRoleName = invite.teamRole.displayName;

      // 🔒 SICUREZZA: Sanitizza input utente per prevenire HTML injection
      final safeInviterName = Validators.sanitizeHtml(invite.invitedByName);
      final safeProjectName = Validators.sanitizeHtml(projectName);

      print('📧 [SERVICE] Link invito: $inviteLink');

      // Costruisci il contenuto HTML dell'email
      final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
    .header { background: linear-gradient(135deg, #9C27B0 0%, #7B1FA2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
    .header h1 { color: white; margin: 0; font-size: 24px; }
    .content { background: #f9f9f9; padding: 30px; border: 1px solid #ddd; }
    .button { display: inline-block; background: #4CAF50; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px; font-weight: bold; margin: 20px 0; }
    .button:hover { background: #45a049; }
    .info-box { background: white; padding: 15px; border-radius: 5px; margin: 15px 0; border-left: 4px solid #9C27B0; }
    .footer { text-align: center; padding: 20px; color: #666; font-size: 12px; }
    .role-badge { display: inline-block; background: #f3e5f5; color: #7b1fa2; padding: 5px 10px; border-radius: 15px; font-size: 12px; margin-right: 5px; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>🚀 Invito Progetto Agile</h1>
    </div>
    <div class="content">
      <p>Ciao!</p>
      <p><strong>$safeInviterName</strong> ti ha invitato a partecipare al progetto Agile.</p>

      <div class="info-box">
        <p><strong>📋 Progetto:</strong> $safeProjectName</p>
        <p><strong>👤 Ruolo Progetto:</strong> <span class="role-badge">$participantRoleName</span></p>
        <p><strong>🎯 Ruolo Team:</strong> <span class="role-badge">$teamRoleName</span></p>
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
      <p>Questa email è stata inviata automaticamente dal sistema Keisen.</p>
    </div>
  </div>
</body>
</html>
''';

      // Costruisci email in formato MIME (Subject usa valore sanitizzato)
      final emailContent = '''From: $senderEmail
To: ${invite.email}
Subject: =?UTF-8?B?${base64Encode(utf8.encode('🚀 Invito Progetto Agile: $safeProjectName'))}?=
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
      print('📧 [SERVICE] Chiamata Gmail API users.messages.send()...');

      try {
        final sentMessage = await gmailApi.users.messages.send(message, 'me');
        print('📧 [SERVICE] ✅ Email inviata con successo!');
        print('📧 [SERVICE] Message ID: ${sentMessage.id}');
        print('📧 [SERVICE] Thread ID: ${sentMessage.threadId}');
        return true;
      } catch (gmailError) {
        print('❌ [SERVICE] ERRORE Gmail API: $gmailError');
        print('❌ [SERVICE] Tipo errore: ${gmailError.runtimeType}');
        // Check if it's a DetailedApiRequestError
        if (gmailError is gmail.DetailedApiRequestError) {
          print('❌ [SERVICE] Status: ${gmailError.status}');
          print('❌ [SERVICE] Message: ${gmailError.message}');
        }
        return false;
      }
    } catch (e, stack) {
      print('❌ [SERVICE] Errore generico invio email: $e');
      print('❌ [SERVICE] Stack: $stack');
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
}
