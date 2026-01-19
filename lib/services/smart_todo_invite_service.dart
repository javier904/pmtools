import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import '../models/smart_todo/todo_invite_model.dart';
import '../models/smart_todo/todo_participant_model.dart';
import '../models/smart_todo/todo_list_model.dart';

class SmartTodoInviteService {
  final FirebaseFirestore _firestore;

  static const String _listsCollection = 'smart_todo_lists';
  static const String _invitesSubcollection = 'invites';

  SmartTodoInviteService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // ══════════════════════════════════════════════════════════════════════════════
  // CRUD INVITES
  // ══════════════════════════════════════════════════════════════════════════════

  Future<TodoInviteModel> createInvite({
    required String listId,
    required String email,
    required TodoParticipantRole role,
    required String invitedBy,
    required String invitedByName,
    Duration expiration = const Duration(days: 7),
  }) async {
    final now = DateTime.now();
    final token = _generateToken();
    
    // Check for existing pending invite
    final existingRef = _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_invitesSubcollection)
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending');
        
    final existingSnapshot = await existingRef.get();
    if (existingSnapshot.docs.isNotEmpty) {
      throw Exception('Esiste già un invito in attesa per questa email');
    }

    final docRef = _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_invitesSubcollection)
        .doc();

    final invite = TodoInviteModel(
      id: docRef.id,
      listId: listId,
      email: email.toLowerCase(),
      role: role,
      status: TodoInviteStatus.pending,
      invitedBy: invitedBy,
      invitedByName: invitedByName,
      invitedAt: now,
      expiresAt: now.add(expiration),
      token: token,
    );

    // Use batch for atomic creation (Invite + Pending List)
    final batch = _firestore.batch();
    batch.set(docRef, invite.toFirestore());
    
    // Update pendingEmails on List
    final listRef = _firestore.collection(_listsCollection).doc(listId);
    batch.update(listRef, {
      'pendingEmails': FieldValue.arrayUnion([email.toLowerCase()]),
    });

    await batch.commit();
    return invite;
  }

  Stream<List<TodoInviteModel>> streamInvites(String listId) {
    return _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_invitesSubcollection)
        .orderBy('invitedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TodoInviteModel.fromFirestore(doc))
            .toList());
  }

  Future<void> revokeInvite(String listId, String inviteId) async {
    await _firestore
        .collection(_listsCollection)
        .doc(listId)
        .collection(_invitesSubcollection)
        .doc(inviteId)
        .update({'status': 'revoked'});
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // ACCEPTANCE LOGIC
  // ══════════════════════════════════════════════════════════════════════════════

  Future<void> acceptInvite({
    required String listId,
    required String token,
    required String userId, // Kept for interface compatibility, but logic uses Email
    required String userEmail,
    required String? userDisplayName,
  }) async {
    final listRef = _firestore.collection(_listsCollection).doc(listId);
    
    // 1. Query for the invite (Outside Transaction)
    final inviteQuery = await listRef
        .collection(_invitesSubcollection)
        .where('token', isEqualTo: token)
        .where('status', isEqualTo: 'pending')
        .limit(1)
        .get();

    if (inviteQuery.docs.isEmpty) {
      throw const FormatException('Invito non valido o scaduto');
    }
    
    final inviteDocRef = inviteQuery.docs.first.reference;

    await _firestore.runTransaction((transaction) async {
      // 2. Read Documents (List + Invite)
      final listSnapshot = await transaction.get(listRef);
      final inviteSnapshot = await transaction.get(inviteDocRef);

      if (!listSnapshot.exists) throw const FormatException('Lista non trovata');
      if (!inviteSnapshot.exists) throw const FormatException('Invito non trovato');

      final inviteData = TodoInviteModel.fromFirestore(inviteSnapshot);

      // Validation
      if (inviteData.status != TodoInviteStatus.pending) {
         throw const FormatException('Invito già accettato o revocato');
      }
      if (DateTime.now().isAfter(inviteData.expiresAt)) {
        throw const FormatException('Invito scaduto');
      }
      if (inviteData.email.toLowerCase() != userEmail.toLowerCase()) {
        throw const FormatException('Questa email non corrisponde all\'invito');
      }

      // 3. Prepare Updates
      
      // Update Participants Map
      // FORCE KEY TO BE EMAIL for permission checks (isOwner)
      final existingParticipants = Map<String, dynamic>.from(listSnapshot.data()?['participants'] ?? {});
      
      final participant = TodoParticipant(
        email: userEmail,
        role: inviteData.role,
        displayName: userDisplayName,
        joinedAt: DateTime.now(),
      );
      
      existingParticipants[userEmail] = participant.toMap();

      // Remove from Pending
      final pending = List<String>.from(listSnapshot.data()?['pendingEmails'] ?? []);
      pending.remove(userEmail.toLowerCase());

      // Add to Participant Emails
      final emails = List<String>.from(listSnapshot.data()?['participantEmails'] ?? []);
      if (!emails.contains(userEmail)) emails.add(userEmail);

      // 4. Commit Updates
      transaction.update(inviteDocRef, {'status': 'accepted'});
      transaction.update(listRef, {
        'participants': existingParticipants,
        'pendingEmails': pending,
        'participantEmails': emails,
      });
    });
  }

  // Implementation of email sending (Gmail API)
  Future<bool> sendInviteEmail({
    required TodoInviteModel invite,
    required String listName,
    required String senderEmail,
    required gmail.GmailApi gmailApi,
  }) async {
    try {
      // Logic identical to Planning Poker but with custom HTML
      final inviteLink = 'https://dashboard-app/smart-todo/invite?token=${invite.token}&listId=${invite.listId}'; 
      // Note: improved deep link with listId
      
      final htmlBody = '''
      <h3>Ciao!</h3>
      <p><strong>${invite.invitedByName}</strong> ti ha invitato alla lista: <b>$listName</b></p>
      <p>Ruolo: ${invite.role.name}</p>
      <a href="$inviteLink">Accetta Invito</a>
      ''';

      final emailContent = '''From: $senderEmail
To: ${invite.email}
Subject: =?UTF-8?B?${base64Encode(utf8.encode('Invito Smart To-Do: $listName'))}?=
MIME-Version: 1.0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

${base64Encode(utf8.encode(htmlBody))}
''';

      final encodedEmail = base64Url.encode(utf8.encode(emailContent)).replaceAll('=', '');
      final message = gmail.Message(raw: encodedEmail);
      await gmailApi.users.messages.send(message, 'me');
      return true;
    } catch (e) {
      print('Errore invio email: $e');
      return false;
    }
  }

  String _generateToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(32, (_) => chars[random.nextInt(chars.length)]).join();
  }
}
