import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../models/unified_invite_model.dart';
import '../models/eisenhower_invite_model.dart';
import '../models/planning_poker_invite_model.dart';
import '../models/agile_invite_model.dart';
import '../models/smart_todo/todo_invite_model.dart';
import '../models/retro_invite_model.dart';
import 'auth_service.dart';

/// Servizio per aggregare tutti gli inviti pendenti da tutte le sorgenti
///
/// Fornisce:
/// - Stream unificato di tutti gli inviti pendenti
/// - Conteggio inviti pendenti per badge
/// - Metodi per accettare/rifiutare inviti
class InviteAggregatorService {
  static final InviteAggregatorService _instance = InviteAggregatorService._internal();
  factory InviteAggregatorService() => _instance;
  InviteAggregatorService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // Collection names
  static const String _eisenhowerInvitesCollection = 'eisenhower_invites';
  static const String _planningPokerSessionsCollection = 'planning_poker_sessions';
  static const String _agileProjectsCollection = 'agile_projects';
  static const String _smartTodoListsCollection = 'smart_todo_lists';
  static const String _retroInvitesCollection = 'retro_invites';
  static const String _retrospectivesCollection = 'retrospectives';

  // Cache per i nomi delle istanze
  final Map<String, String> _instanceNameCache = {};

  // BehaviorSubject per cachare l'ultimo valore degli inviti
  BehaviorSubject<List<UnifiedInviteModel>>? _invitesSubject;
  StreamSubscription? _invitesSubscription;
  String? _currentUserEmail;

  /// Stream di tutti gli inviti pendenti per l'utente corrente
  /// Usa un BehaviorSubject per cachare l'ultimo valore, così i nuovi subscriber
  /// ricevono subito i dati esistenti invece di aspettare le query Firestore
  Stream<List<UnifiedInviteModel>> streamAllPendingInvites() {
    final userEmail = _authService.currentUserEmail;
    print('📧 [INVITE AGGREGATOR] Current user email: $userEmail');
    if (userEmail == null) return Stream.value([]);

    final normalizedEmail = userEmail.toLowerCase();
    print('📧 [INVITE AGGREGATOR] Normalized email: $normalizedEmail');

    // Se l'utente è cambiato o non abbiamo ancora un subject, creane uno nuovo
    if (_currentUserEmail != normalizedEmail || _invitesSubject == null) {
      print('📧 [INVITE AGGREGATOR] Creating new BehaviorSubject for user');
      _disposeInvitesStream();
      _currentUserEmail = normalizedEmail;
      _invitesSubject = BehaviorSubject<List<UnifiedInviteModel>>.seeded([]);

      // Crea la subscription al combined stream
      _invitesSubscription = CombineLatestStream.list([
        _streamEisenhowerInvites(normalizedEmail).startWith([]),
        _streamPlanningPokerInvites(normalizedEmail).startWith([]),
        _streamAgileInvites(normalizedEmail).startWith([]),
        _streamSmartTodoInvites(normalizedEmail).startWith([]),
        _streamRetroInvites(normalizedEmail).startWith([]),
      ]).map((inviteLists) {
        // Appiattisci tutte le liste in una singola lista
        final allInvites = <UnifiedInviteModel>[];
        print('📋 [INVITE AGGREGATOR] Combining ${inviteLists.length} streams');
        for (int i = 0; i < inviteLists.length; i++) {
          print('📋 [INVITE AGGREGATOR] Stream $i has ${inviteLists[i].length} invites');
          allInvites.addAll(inviteLists[i]);
        }

        // Ordina per data invito (più recenti prima)
        allInvites.sort((a, b) => b.invitedAt.compareTo(a.invitedAt));

        print('📋 [INVITE AGGREGATOR] Total combined invites: ${allInvites.length}');
        return allInvites;
      }).listen(
        (invites) => _invitesSubject?.add(invites),
        onError: (error) => print('❌ [INVITE AGGREGATOR] Stream error: $error'),
      );
    } else {
      print('📧 [INVITE AGGREGATOR] Reusing existing BehaviorSubject (has ${_invitesSubject!.value.length} cached invites)');
    }

    return _invitesSubject!.stream;
  }

  /// Pulisce lo stream degli inviti (chiamare su logout)
  void _disposeInvitesStream() {
    _invitesSubscription?.cancel();
    _invitesSubscription = null;
    _invitesSubject?.close();
    _invitesSubject = null;
    _currentUserEmail = null;
  }

  /// Chiamare quando l'utente fa logout per pulire le risorse
  void dispose() {
    _disposeInvitesStream();
    _instanceNameCache.clear();
  }

  /// Ottieni tutti gli inviti pendenti (one-shot)
  Future<List<UnifiedInviteModel>> getAllPendingInvites() async {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) return [];

    final normalizedEmail = userEmail.toLowerCase();
    final allInvites = <UnifiedInviteModel>[];

    // Fetch da tutte le sorgenti in parallelo
    final results = await Future.wait([
      _getEisenhowerInvites(normalizedEmail),
      _getPlanningPokerInvites(normalizedEmail),
      _getAgileInvites(normalizedEmail),
      _getSmartTodoInvites(normalizedEmail),
      _getRetroInvites(normalizedEmail),
    ]);

    for (final list in results) {
      allInvites.addAll(list);
    }

    // Ordina per data invito (più recenti prima)
    allInvites.sort((a, b) => b.invitedAt.compareTo(a.invitedAt));

    return allInvites;
  }

  /// Conta gli inviti pendenti (per badge)
  Stream<int> streamPendingInviteCount() {
    return streamAllPendingInvites().map((invites) => invites.length);
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // EISENHOWER INVITES
  // ══════════════════════════════════════════════════════════════════════════════

  Stream<List<UnifiedInviteModel>> _streamEisenhowerInvites(String email) {
    print('🔍 [EISENHOWER INVITES] Searching for email: "$email" in collection: $_eisenhowerInvitesCollection');
    return _firestore
        .collection(_eisenhowerInvitesCollection)
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .asyncMap((snapshot) async {
      print('🔍 [EISENHOWER INVITES] Found ${snapshot.docs.length} documents');
      for (final doc in snapshot.docs) {
        print('🔍 [EISENHOWER INVITES] Doc ID: ${doc.id}, data: ${doc.data()}');
      }
      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();
      print('🔍 [EISENHOWER INVITES] Current time: $now');

      for (final doc in snapshot.docs) {
        try {
          final invite = EisenhowerInviteModel.fromFirestore(doc);
          print('🔍 [EISENHOWER INVITES] Parsed invite: email=${invite.email}, expiresAt=${invite.expiresAt}, matrixId=${invite.matrixId}');
          print('🔍 [EISENHOWER INVITES] Is expired? expiresAt.isAfter(now) = ${invite.expiresAt.isAfter(now)}');

          if (invite.expiresAt.isAfter(now)) {
            final matrixName = await _getInstanceName(
              'eisenhower_matrices',
              invite.matrixId,
              'title',
            );
            print('🔍 [EISENHOWER INVITES] Matrix name: $matrixName');
            final unified = UnifiedInviteModel.fromEisenhower(invite, matrixName: matrixName);
            print('🔍 [EISENHOWER INVITES] Created UnifiedInviteModel: ${unified.id}');
            invites.add(unified);
          } else {
            print('🔍 [EISENHOWER INVITES] ⚠️ Invite EXPIRED, not adding');
          }
        } catch (e, stack) {
          print('❌ [EISENHOWER INVITES] Error processing doc ${doc.id}: $e');
          print('❌ [EISENHOWER INVITES] Stack: $stack');
        }
      }
      print('🔍 [EISENHOWER INVITES] Returning ${invites.length} invites');
      return invites;
    });
  }

  Future<List<UnifiedInviteModel>> _getEisenhowerInvites(String email) async {
    final snapshot = await _firestore
        .collection(_eisenhowerInvitesCollection)
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .get();

    final invites = <UnifiedInviteModel>[];
    final now = DateTime.now();

    for (final doc in snapshot.docs) {
      final invite = EisenhowerInviteModel.fromFirestore(doc);
      if (invite.expiresAt.isAfter(now)) {
        final matrixName = await _getInstanceName(
          'eisenhower_matrices',
          invite.matrixId,
          'title',
        );
        invites.add(UnifiedInviteModel.fromEisenhower(invite, matrixName: matrixName));
      }
    }
    return invites;
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // PLANNING POKER (ESTIMATION ROOM) INVITES
  // ══════════════════════════════════════════════════════════════════════════════

  Stream<List<UnifiedInviteModel>> _streamPlanningPokerInvites(String email) {
    print('🎲 [PLANNING POKER INVITES] Starting stream for email: $email');
    // Planning Poker usa subcollection, serve collection group query
    return _firestore
        .collectionGroup('invites')
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .asyncMap((snapshot) async {
      print('🎲 [PLANNING POKER INVITES] Received ${snapshot.docs.length} docs');
      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        // Verifica che sia un invito Planning Poker (controlla path)
        final path = doc.reference.path;
        if (!path.contains(_planningPokerSessionsCollection)) continue;

        try {
          final invite = PlanningPokerInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            final sessionName = await _getInstanceName(
              _planningPokerSessionsCollection,
              invite.sessionId,
              'name',
            );
            invites.add(UnifiedInviteModel.fromPlanningPoker(invite, sessionName: sessionName));
          }
        } catch (e) {
          // Ignora documenti che non corrispondono al modello
          continue;
        }
      }
      return invites;
    });
  }

  Future<List<UnifiedInviteModel>> _getPlanningPokerInvites(String email) async {
    try {
      final snapshot = await _firestore
          .collectionGroup('invites')
          .where('email', isEqualTo: email)
          .where('status', isEqualTo: 'pending')
          .get();

      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        final path = doc.reference.path;
        if (!path.contains(_planningPokerSessionsCollection)) continue;

        try {
          final invite = PlanningPokerInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            final sessionName = await _getInstanceName(
              _planningPokerSessionsCollection,
              invite.sessionId,
              'name',
            );
            invites.add(UnifiedInviteModel.fromPlanningPoker(invite, sessionName: sessionName));
          }
        } catch (e) {
          continue;
        }
      }
      return invites;
    } catch (e) {
      print('⚠️ Errore getPlanningPokerInvites: $e');
      return [];
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // AGILE PROJECT INVITES
  // ══════════════════════════════════════════════════════════════════════════════

  Stream<List<UnifiedInviteModel>> _streamAgileInvites(String email) {
    print('📁 [AGILE INVITES] Starting stream for email: $email');
    return _firestore
        .collectionGroup('invites')
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .asyncMap((snapshot) async {
      print('📁 [AGILE INVITES] Received ${snapshot.docs.length} docs');
      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        final path = doc.reference.path;
        if (!path.contains(_agileProjectsCollection)) continue;

        try {
          final invite = AgileInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            final projectName = await _getInstanceName(
              _agileProjectsCollection,
              invite.projectId,
              'name',
            );
            invites.add(UnifiedInviteModel.fromAgile(invite, projectName: projectName));
          }
        } catch (e) {
          continue;
        }
      }
      return invites;
    });
  }

  Future<List<UnifiedInviteModel>> _getAgileInvites(String email) async {
    try {
      final snapshot = await _firestore
          .collectionGroup('invites')
          .where('email', isEqualTo: email)
          .where('status', isEqualTo: 'pending')
          .get();

      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        final path = doc.reference.path;
        if (!path.contains(_agileProjectsCollection)) continue;

        try {
          final invite = AgileInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            final projectName = await _getInstanceName(
              _agileProjectsCollection,
              invite.projectId,
              'name',
            );
            invites.add(UnifiedInviteModel.fromAgile(invite, projectName: projectName));
          }
        } catch (e) {
          continue;
        }
      }
      return invites;
    } catch (e) {
      print('⚠️ Errore getAgileInvites: $e');
      return [];
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // SMART TODO INVITES
  // ══════════════════════════════════════════════════════════════════════════════

  Stream<List<UnifiedInviteModel>> _streamSmartTodoInvites(String email) {
    print('📝 [SMART TODO INVITES] Starting stream for email: $email');
    return _firestore
        .collectionGroup('invites')
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .asyncMap((snapshot) async {
      print('📝 [SMART TODO INVITES] Received ${snapshot.docs.length} docs');
      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        final path = doc.reference.path;
        if (!path.contains(_smartTodoListsCollection)) continue;

        try {
          final invite = TodoInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            final listName = await _getInstanceName(
              _smartTodoListsCollection,
              invite.listId,
              'name',
            );
            invites.add(UnifiedInviteModel.fromTodo(invite, listName: listName));
          }
        } catch (e) {
          continue;
        }
      }
      return invites;
    });
  }

  Future<List<UnifiedInviteModel>> _getSmartTodoInvites(String email) async {
    try {
      final snapshot = await _firestore
          .collectionGroup('invites')
          .where('email', isEqualTo: email)
          .where('status', isEqualTo: 'pending')
          .get();

      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        final path = doc.reference.path;
        if (!path.contains(_smartTodoListsCollection)) continue;

        try {
          final invite = TodoInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            final listName = await _getInstanceName(
              _smartTodoListsCollection,
              invite.listId,
              'name',
            );
            invites.add(UnifiedInviteModel.fromTodo(invite, listName: listName));
          }
        } catch (e) {
          continue;
        }
      }
      return invites;
    } catch (e) {
      print('⚠️ Errore getSmartTodoInvites: $e');
      return [];
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // RETROSPECTIVE INVITES
  // ══════════════════════════════════════════════════════════════════════════════

  Stream<List<UnifiedInviteModel>> _streamRetroInvites(String email) {
    print('🔄 [RETRO INVITES] Starting stream for email: $email');
    return _firestore
        .collection(_retroInvitesCollection)
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .asyncMap((snapshot) async {
      print('🔄 [RETRO INVITES] Received ${snapshot.docs.length} docs');
      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        try {
          final invite = RetroInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            final boardName = await _getInstanceName(
              _retrospectivesCollection,
              invite.boardId,
              'sprintName',
            );
            invites.add(UnifiedInviteModel.fromRetro(invite, boardName: boardName));
          }
        } catch (e) {
          continue;
        }
      }
      return invites;
    });
  }

  Future<List<UnifiedInviteModel>> _getRetroInvites(String email) async {
    try {
      final snapshot = await _firestore
          .collection(_retroInvitesCollection)
          .where('email', isEqualTo: email)
          .where('status', isEqualTo: 'pending')
          .get();

      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        try {
          final invite = RetroInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            final boardName = await _getInstanceName(
              _retrospectivesCollection,
              invite.boardId,
              'sprintName',
            );
            invites.add(UnifiedInviteModel.fromRetro(invite, boardName: boardName));
          }
        } catch (e) {
          continue;
        }
      }
      return invites;
    } catch (e) {
      print('⚠️ Errore getRetroInvites: $e');
      return [];
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // UTILITY
  // ══════════════════════════════════════════════════════════════════════════════

  /// Ottiene il nome di un'istanza (con cache)
  Future<String> _getInstanceName(String collection, String docId, String field) async {
    final cacheKey = '$collection/$docId';

    if (_instanceNameCache.containsKey(cacheKey)) {
      return _instanceNameCache[cacheKey]!;
    }

    try {
      final doc = await _firestore.collection(collection).doc(docId).get();
      if (doc.exists) {
        final name = doc.data()?[field] as String? ?? 'Unknown';
        _instanceNameCache[cacheKey] = name;
        return name;
      }
    } catch (e) {
      print('⚠️ Errore getInstanceName: $e');
    }

    return 'Unknown';
  }

  /// Pulisce la cache dei nomi
  void clearNameCache() {
    _instanceNameCache.clear();
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // AZIONI SU INVITI
  // ══════════════════════════════════════════════════════════════════════════════

  /// Accetta un invito
  Future<bool> acceptInvite(UnifiedInviteModel invite) async {
    final userEmail = _authService.currentUserEmail;
    final userName = _authService.currentUser?.displayName ?? userEmail?.split('@').first ?? 'User';

    if (userEmail == null) return false;

    try {
      switch (invite.sourceType) {
        case InviteSourceType.eisenhower:
          return await _acceptEisenhowerInvite(invite);
        case InviteSourceType.estimationRoom:
          return await _acceptPlanningPokerInvite(invite, userEmail, userName);
        case InviteSourceType.agileProject:
          return await _acceptAgileInvite(invite, userEmail, userName);
        case InviteSourceType.smartTodo:
          return await _acceptSmartTodoInvite(invite, userEmail, userName);
        case InviteSourceType.retroBoard:
          return await _acceptRetroInvite(invite, userEmail, userName);
      }
    } catch (e) {
      print('❌ Errore acceptInvite: $e');
      return false;
    }
  }

  /// Rifiuta un invito
  Future<bool> declineInvite(UnifiedInviteModel invite, {String? reason}) async {
    try {
      switch (invite.sourceType) {
        case InviteSourceType.eisenhower:
          await _firestore.collection(_eisenhowerInvitesCollection).doc(invite.id).update({
            'status': 'declined',
            'declinedAt': Timestamp.now(),
            if (reason != null) 'declineReason': reason,
          });
          return true;

        case InviteSourceType.estimationRoom:
          await _firestore
              .collection(_planningPokerSessionsCollection)
              .doc(invite.sourceId)
              .collection('invites')
              .doc(invite.id)
              .update({
            'status': 'declined',
            'declinedAt': Timestamp.now(),
            if (reason != null) 'declineReason': reason,
          });
          return true;

        case InviteSourceType.agileProject:
          await _firestore
              .collection(_agileProjectsCollection)
              .doc(invite.sourceId)
              .collection('invites')
              .doc(invite.id)
              .update({
            'status': 'declined',
            'declinedAt': Timestamp.now(),
            if (reason != null) 'declineReason': reason,
          });
          return true;

        case InviteSourceType.smartTodo:
          await _firestore
              .collection(_smartTodoListsCollection)
              .doc(invite.sourceId)
              .collection('invites')
              .doc(invite.id)
              .update({
            'status': 'declined',
            'declinedAt': Timestamp.now(),
            if (reason != null) 'declineReason': reason,
          });
          return true;

        case InviteSourceType.retroBoard:
          final retroBatch = _firestore.batch();

          // 1. Aggiorna status invito
          retroBatch.update(_firestore.collection(_retroInvitesCollection).doc(invite.id), {
            'status': 'declined',
            'declinedAt': Timestamp.now(),
            if (reason != null) 'declineReason': reason,
          });

          // 2. Rimuovi da pendingEmails
          retroBatch.update(_firestore.collection(_retrospectivesCollection).doc(invite.sourceId), {
            'pendingEmails': FieldValue.arrayRemove([invite.email.toLowerCase()]),
          });

          await retroBatch.commit();
          return true;
      }
    } catch (e) {
      print('❌ Errore declineInvite: $e');
      return false;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // ACCEPT HELPERS
  // ══════════════════════════════════════════════════════════════════════════════

  Future<bool> _acceptEisenhowerInvite(UnifiedInviteModel invite) async {
    final userEmail = _authService.currentUserEmail;
    final userName = _authService.currentUser?.displayName ?? userEmail?.split('@').first ?? 'User';

    if (userEmail == null) return false;

    final batch = _firestore.batch();

    // 1. Aggiorna status invito
    final inviteRef = _firestore.collection(_eisenhowerInvitesCollection).doc(invite.id);
    batch.update(inviteRef, {
      'status': 'accepted',
      'acceptedAt': Timestamp.now(),
    });

    // 2. Aggiungi come partecipante
    // IMPORTANTE: Le regole Firestore richiedono che participantEmails array venga aggiornato
    final escapedEmail = userEmail.replaceAll('.', '_DOT_');
    final matrixRef = _firestore.collection('eisenhower_matrices').doc(invite.sourceId);
    batch.update(matrixRef, {
      'participants.$escapedEmail': {
        'email': userEmail,
        'name': userName,
        'role': invite.role.toLowerCase(),
        'joinedAt': Timestamp.now(),
        'isOnline': true,
      },
      'participantEmails': FieldValue.arrayUnion([userEmail.toLowerCase()]),
      'pendingEmails': FieldValue.arrayRemove([userEmail.toLowerCase()]),
      'updatedAt': Timestamp.now(),
    });

    await batch.commit();
    return true;
  }

  Future<bool> _acceptPlanningPokerInvite(UnifiedInviteModel invite, String userEmail, String userName) async {
    final batch = _firestore.batch();

    // 1. Aggiorna status invito
    final inviteRef = _firestore
        .collection(_planningPokerSessionsCollection)
        .doc(invite.sourceId)
        .collection('invites')
        .doc(invite.id);
    batch.update(inviteRef, {
      'status': 'accepted',
      'acceptedAt': Timestamp.now(),
    });

    // 2. Aggiungi come partecipante
    final escapedEmail = userEmail.replaceAll('.', '_DOT_');
    final sessionRef = _firestore.collection(_planningPokerSessionsCollection).doc(invite.sourceId);
    batch.update(sessionRef, {
      'participants.$escapedEmail': {
        'email': userEmail.toLowerCase(),
        'name': userName,
        'role': invite.role.toLowerCase(),
        'joinedAt': Timestamp.now(),
      },
      'participantEmails': FieldValue.arrayUnion([userEmail.toLowerCase()]),
      'pendingEmails': FieldValue.arrayRemove([userEmail.toLowerCase()]),
    });

    await batch.commit();
    return true;
  }

  Future<bool> _acceptAgileInvite(UnifiedInviteModel invite, String userEmail, String userName) async {
    final batch = _firestore.batch();

    // 1. Aggiorna status invito
    final inviteRef = _firestore
        .collection(_agileProjectsCollection)
        .doc(invite.sourceId)
        .collection('invites')
        .doc(invite.id);
    batch.update(inviteRef, {
      'status': 'accepted',
      'acceptedAt': Timestamp.now(),
    });

    // 2. Aggiungi come partecipante
    final projectRef = _firestore.collection(_agileProjectsCollection).doc(invite.sourceId);
    batch.update(projectRef, {
      'participantEmails': FieldValue.arrayUnion([userEmail.toLowerCase()]),
      'pendingEmails': FieldValue.arrayRemove([userEmail.toLowerCase()]),
      'updatedAt': Timestamp.now(),
    });

    await batch.commit();
    return true;
  }

  Future<bool> _acceptSmartTodoInvite(UnifiedInviteModel invite, String userEmail, String userName) async {
    final batch = _firestore.batch();

    // 1. Aggiorna status invito
    final inviteRef = _firestore
        .collection(_smartTodoListsCollection)
        .doc(invite.sourceId)
        .collection('invites')
        .doc(invite.id);
    batch.update(inviteRef, {
      'status': 'accepted',
      'acceptedAt': Timestamp.now(),
    });

    // 2. Aggiungi come partecipante
    final listRef = _firestore.collection(_smartTodoListsCollection).doc(invite.sourceId);
    batch.update(listRef, {
      'participants.$userEmail': {
        'email': userEmail,
        'displayName': userName,
        'role': invite.role.toLowerCase(),
        'joinedAt': Timestamp.now(),
      },
      'participantEmails': FieldValue.arrayUnion([userEmail.toLowerCase()]),
      'pendingEmails': FieldValue.arrayRemove([userEmail.toLowerCase()]),
    });

    await batch.commit();
    return true;
  }

  Future<bool> _acceptRetroInvite(UnifiedInviteModel invite, String userEmail, String userName) async {
    final batch = _firestore.batch();

    // 1. Aggiorna status invito
    final inviteRef = _firestore.collection(_retroInvitesCollection).doc(invite.id);
    batch.update(inviteRef, {
      'status': 'accepted',
      'acceptedAt': Timestamp.now(),
    });

    // 2. Aggiungi come partecipante alla retrospective
    final retroRef = _firestore.collection(_retrospectivesCollection).doc(invite.sourceId);
    batch.update(retroRef, {
      'participantEmails': FieldValue.arrayUnion([userEmail.toLowerCase()]),
      'pendingEmails': FieldValue.arrayRemove([userEmail.toLowerCase()]),
      'updatedAt': Timestamp.now(),
    });

    await batch.commit();
    return true;
  }
}
