import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../models/unified_invite_model.dart';
import '../models/eisenhower_invite_model.dart';
import '../models/planning_poker_invite_model.dart';
import '../models/agile_invite_model.dart';
import '../models/smart_todo/todo_invite_model.dart' show TodoInviteModel;
import '../models/retro_invite_model.dart';
import 'auth_service.dart';
import 'invite_service.dart';

/// Servizio per aggregare tutti gli inviti pendenti da tutte le sorgenti
///
/// Fornisce:
/// - Stream unificato di tutti gli inviti pendenti
/// - Conteggio inviti pendenti per badge
/// - Metodi per accettare/rifiutare inviti
///
/// ARCHITETTURA:
/// - Prioritizza la collection unificata `invitations` (nuovi inviti)
/// - Fallback alle collection legacy per retrocompatibilità
/// - Flag `_useUnifiedCollection` per controllare il comportamento
class InviteAggregatorService {
  static final InviteAggregatorService _instance = InviteAggregatorService._internal();
  factory InviteAggregatorService() => _instance;
  InviteAggregatorService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final InviteService _inviteService = InviteService();

  /// Feature flag: se true, usa SOLO la collection unificata
  /// Se false, combina collection unificata + legacy (periodo transitorio)
  static const bool _useOnlyUnifiedCollection = false;

  // Collection names (legacy)
  static const String _unifiedInvitesCollection = 'invitations';
  static const String _eisenhowerInvitesCollection = 'eisenhower_invites';
  static const String _planningPokerSessionsCollection = 'planning_poker_sessions';
  /// MIGRATO: Collection dedicata per inviti Estimation Room (come Eisenhower)
  static const String _estimationRoomInvitesCollection = 'estimation_room_invites';
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
  ///
  /// ARCHITETTURA TRANSITORIA:
  /// - Combina inviti dalla collection unificata `invitations` E dalle collection legacy
  /// - Rimuove duplicati basandosi su (sourceType, sourceId, email)
  /// - Quando _useOnlyUnifiedCollection = true, legge solo dalla collection unificata
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
      final streams = <Stream<List<UnifiedInviteModel>>>[];

      // 1. SEMPRE includi la collection unificata (nuovi inviti)
      streams.add(_streamUnifiedInvites(normalizedEmail).startWith([]));

      // 2. Se non usiamo SOLO la collection unificata, aggiungi anche le legacy
      if (!_useOnlyUnifiedCollection) {
        streams.addAll([
          _streamEisenhowerInvites(normalizedEmail).startWith([]),
          _streamPlanningPokerInvites(normalizedEmail).startWith([]),
          _streamAgileInvites(normalizedEmail).startWith([]),
          _streamSmartTodoInvites(normalizedEmail).startWith([]),
          _streamRetroInvites(normalizedEmail).startWith([]),
        ]);
      }

      _invitesSubscription = CombineLatestStream.list(streams).map((inviteLists) {
        // Appiattisci tutte le liste in una singola lista
        final allInvites = <UnifiedInviteModel>[];
        print('📋 [INVITE AGGREGATOR] Combining ${inviteLists.length} streams');
        for (int i = 0; i < inviteLists.length; i++) {
          print('📋 [INVITE AGGREGATOR] Stream $i has ${inviteLists[i].length} invites');
          allInvites.addAll(inviteLists[i]);
        }

        // Rimuovi duplicati (stesso sourceType + sourceId + email)
        final uniqueInvites = _removeDuplicates(allInvites);

        // Ordina per data invito (più recenti prima)
        uniqueInvites.sort((a, b) => b.invitedAt.compareTo(a.invitedAt));

        print('📋 [INVITE AGGREGATOR] Total combined invites: ${uniqueInvites.length} (dopo dedup)');
        return uniqueInvites;
      }).listen(
        (invites) => _invitesSubject?.add(invites),
        onError: (error) => print('❌ [INVITE AGGREGATOR] Stream error: $error'),
      );
    } else {
      print('📧 [INVITE AGGREGATOR] Reusing existing BehaviorSubject (has ${_invitesSubject!.value.length} cached invites)');
    }

    return _invitesSubject!.stream;
  }

  /// Rimuove duplicati mantenendo l'invito più recente
  List<UnifiedInviteModel> _removeDuplicates(List<UnifiedInviteModel> invites) {
    final seen = <String, UnifiedInviteModel>{};
    for (final invite in invites) {
      final key = '${invite.sourceType.name}:${invite.sourceId}:${invite.email.toLowerCase()}';
      final existing = seen[key];
      if (existing == null || invite.invitedAt.isAfter(existing.invitedAt)) {
        seen[key] = invite;
      }
    }
    return seen.values.toList();
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
  ///
  /// ARCHITETTURA TRANSITORIA:
  /// - Combina inviti dalla collection unificata E dalle collection legacy
  /// - Rimuove duplicati
  Future<List<UnifiedInviteModel>> getAllPendingInvites() async {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) return [];

    final normalizedEmail = userEmail.toLowerCase();
    final allInvites = <UnifiedInviteModel>[];

    // Fetch dalla collection unificata
    final unifiedInvites = await _getUnifiedInvites(normalizedEmail);
    allInvites.addAll(unifiedInvites);

    // Se non usiamo SOLO la collection unificata, aggiungi anche le legacy
    if (!_useOnlyUnifiedCollection) {
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
    }

    // Rimuovi duplicati e ordina
    final uniqueInvites = _removeDuplicates(allInvites);
    uniqueInvites.sort((a, b) => b.invitedAt.compareTo(a.invitedAt));

    return uniqueInvites;
  }

  /// Conta gli inviti pendenti (per badge)
  Stream<int> streamPendingInviteCount() {
    return streamAllPendingInvites().map((invites) => invites.length);
  }

  /// Ottiene TUTTI gli inviti per una specifica risorsa (unified + legacy)
  /// Include tutti gli stati: pending, accepted, declined, expired, revoked
  Future<List<UnifiedInviteModel>> getInvitesForSource(
    InviteSourceType sourceType,
    String sourceId,
  ) async {
    final allInvites = <UnifiedInviteModel>[];

    // 1. Cerca nella collection unificata
    try {
      final unifiedSnapshot = await _firestore
          .collection(_unifiedInvitesCollection)
          .where('sourceType', isEqualTo: sourceType.name)
          .where('sourceId', isEqualTo: sourceId)
          .get();

      for (final doc in unifiedSnapshot.docs) {
        try {
          allInvites.add(UnifiedInviteModel.fromFirestore(doc));
        } catch (e) {
          print('❌ [AGGREGATOR] Error parsing unified invite ${doc.id}: $e');
        }
      }
      print('📋 [AGGREGATOR] Found ${unifiedSnapshot.docs.length} invites in unified collection');
    } catch (e) {
      print('❌ [AGGREGATOR] Error querying unified collection: $e');
    }

    // 2. Cerca nella collection legacy appropriata
    try {
      switch (sourceType) {
        case InviteSourceType.eisenhower:
          final legacySnapshot = await _firestore
              .collection(_eisenhowerInvitesCollection)
              .where('matrixId', isEqualTo: sourceId)
              .get();

          for (final doc in legacySnapshot.docs) {
            try {
              final invite = EisenhowerInviteModel.fromFirestore(doc);
              // Ottieni il nome della matrice
              String? matrixName;
              try {
                final matrixDoc = await _firestore.collection('eisenhower_matrices').doc(sourceId).get();
                matrixName = matrixDoc.data()?['title'] as String?;
              } catch (_) {}
              allInvites.add(UnifiedInviteModel.fromEisenhower(invite, matrixName: matrixName));
            } catch (e) {
              print('❌ [AGGREGATOR] Error parsing eisenhower invite ${doc.id}: $e');
            }
          }
          print('📋 [AGGREGATOR] Found ${legacySnapshot.docs.length} invites in eisenhower_invites');
          break;

        case InviteSourceType.estimationRoom:
          final legacySnapshot = await _firestore
              .collection(_estimationRoomInvitesCollection)
              .where('sessionId', isEqualTo: sourceId)
              .get();

          for (final doc in legacySnapshot.docs) {
            try {
              final invite = PlanningPokerInviteModel.fromFirestore(doc);
              // Ottieni il nome della sessione
              String? sessionName;
              try {
                final sessionDoc = await _firestore.collection(_planningPokerSessionsCollection).doc(sourceId).get();
                sessionName = sessionDoc.data()?['name'] as String?;
              } catch (_) {}
              allInvites.add(UnifiedInviteModel.fromPlanningPoker(invite, sessionName: sessionName));
            } catch (e) {
              print('❌ [AGGREGATOR] Error parsing estimation room invite ${doc.id}: $e');
            }
          }
          print('📋 [AGGREGATOR] Found ${legacySnapshot.docs.length} invites in estimation_room_invites');
          break;

        case InviteSourceType.agileProject:
          // Agile usa subcollection
          final legacySnapshot = await _firestore
              .collection(_agileProjectsCollection)
              .doc(sourceId)
              .collection('invites')
              .get();

          for (final doc in legacySnapshot.docs) {
            try {
              final invite = AgileInviteModel.fromFirestore(doc);
              String? projectName;
              try {
                final projectDoc = await _firestore.collection(_agileProjectsCollection).doc(sourceId).get();
                projectName = projectDoc.data()?['name'] as String?;
              } catch (_) {}
              allInvites.add(UnifiedInviteModel.fromAgile(invite, projectName: projectName));
            } catch (e) {
              print('❌ [AGGREGATOR] Error parsing agile invite ${doc.id}: $e');
            }
          }
          print('📋 [AGGREGATOR] Found ${legacySnapshot.docs.length} invites in agile_projects subcollection');
          break;

        case InviteSourceType.smartTodo:
          // SmartTodo usa subcollection
          final legacySnapshot = await _firestore
              .collection(_smartTodoListsCollection)
              .doc(sourceId)
              .collection('invites')
              .get();

          for (final doc in legacySnapshot.docs) {
            try {
              final invite = TodoInviteModel.fromFirestore(doc);
              String? listName;
              try {
                final listDoc = await _firestore.collection(_smartTodoListsCollection).doc(sourceId).get();
                listName = listDoc.data()?['name'] as String?;
              } catch (_) {}
              allInvites.add(UnifiedInviteModel.fromTodo(invite, listName: listName));
            } catch (e) {
              print('❌ [AGGREGATOR] Error parsing smart todo invite ${doc.id}: $e');
            }
          }
          print('📋 [AGGREGATOR] Found ${legacySnapshot.docs.length} invites in smart_todo_lists subcollection');
          break;

        case InviteSourceType.retroBoard:
          final legacySnapshot = await _firestore
              .collection(_retroInvitesCollection)
              .where('boardId', isEqualTo: sourceId)
              .get();

          for (final doc in legacySnapshot.docs) {
            try {
              final invite = RetroInviteModel.fromFirestore(doc);
              String? boardName;
              try {
                final boardDoc = await _firestore.collection(_retrospectivesCollection).doc(sourceId).get();
                boardName = boardDoc.data()?['title'] as String?;
              } catch (_) {}
              allInvites.add(UnifiedInviteModel.fromRetro(invite, boardName: boardName));
            } catch (e) {
              print('❌ [AGGREGATOR] Error parsing retro invite ${doc.id}: $e');
            }
          }
          print('📋 [AGGREGATOR] Found ${legacySnapshot.docs.length} invites in retro_invites');
          break;
      }
    } catch (e) {
      print('❌ [AGGREGATOR] Error querying legacy collection: $e');
    }

    // 3. Rimuovi duplicati e ordina per data (più recenti prima)
    final uniqueInvites = _removeDuplicates(allInvites);
    uniqueInvites.sort((a, b) => b.invitedAt.compareTo(a.invitedAt));

    print('📋 [AGGREGATOR] Total unique invites for $sourceType/$sourceId: ${uniqueInvites.length}');
    return uniqueInvites;
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // UNIFIED INVITES (NUOVA COLLECTION CENTRALIZZATA)
  // ══════════════════════════════════════════════════════════════════════════════

  /// Stream degli inviti dalla collection unificata `invitations`
  Stream<List<UnifiedInviteModel>> _streamUnifiedInvites(String email) {
    print('🆕 [UNIFIED INVITES] Starting stream for email: $email');
    return _firestore
        .collection(_unifiedInvitesCollection)
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      print('🆕 [UNIFIED INVITES] Received ${snapshot.docs.length} docs');
      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        try {
          final invite = UnifiedInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            print('🆕 [UNIFIED INVITES] ✅ Adding: ${invite.sourceType.name}/${invite.sourceName}');
            invites.add(invite);
          } else {
            print('🆕 [UNIFIED INVITES] ⏭️ Skipping expired: ${invite.id}');
          }
        } catch (e) {
          print('🆕 [UNIFIED INVITES] ❌ Error parsing doc ${doc.id}: $e');
        }
      }
      print('🆕 [UNIFIED INVITES] Returning ${invites.length} invites');
      return invites;
    });
  }

  /// Ottieni inviti dalla collection unificata (one-shot)
  Future<List<UnifiedInviteModel>> _getUnifiedInvites(String email) async {
    try {
      print('🆕 [GET UNIFIED INVITES] Querying for email: $email');
      final snapshot = await _firestore
          .collection(_unifiedInvitesCollection)
          .where('email', isEqualTo: email)
          .where('status', isEqualTo: 'pending')
          .get();

      print('🆕 [GET UNIFIED INVITES] Found ${snapshot.docs.length} docs');

      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        try {
          final invite = UnifiedInviteModel.fromFirestore(doc);
          if (invite.expiresAt.isAfter(now)) {
            invites.add(invite);
          }
        } catch (e) {
          print('🆕 [GET UNIFIED INVITES] ❌ Error: $e');
        }
      }
      return invites;
    } catch (e) {
      print('⚠️ Errore getUnifiedInvites: $e');
      return [];
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // EISENHOWER INVITES (LEGACY)
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
  // MIGRATO: Usa collection dedicata come Eisenhower (query semplici, affidabili)
  // ══════════════════════════════════════════════════════════════════════════════

  Stream<List<UnifiedInviteModel>> _streamPlanningPokerInvites(String email) {
    print('🎲 [ESTIMATION ROOM INVITES] Starting stream for email: $email');
    // MIGRATO: Query diretta sulla collection dedicata (come Eisenhower)
    return _firestore
        .collection(_estimationRoomInvitesCollection)
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .asyncMap((snapshot) async {
      print('🎲 [ESTIMATION ROOM INVITES] Found ${snapshot.docs.length} documents');
      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        try {
          final invite = PlanningPokerInviteModel.fromFirestore(doc);
          print('🎲 [ESTIMATION ROOM INVITES] Parsed: email=${invite.email}, sessionId=${invite.sessionId}, expiresAt=${invite.expiresAt}');

          if (invite.expiresAt.isAfter(now)) {
            final sessionName = await _getInstanceName(
              _planningPokerSessionsCollection,
              invite.sessionId,
              'name',
            );
            print('🎲 [ESTIMATION ROOM INVITES] ✅ Adding invite for session: $sessionName');
            invites.add(UnifiedInviteModel.fromPlanningPoker(invite, sessionName: sessionName));
          } else {
            print('🎲 [ESTIMATION ROOM INVITES] ⏭️ Skipping - expired');
          }
        } catch (e) {
          print('🎲 [ESTIMATION ROOM INVITES] ❌ Error parsing doc: $e');
          continue;
        }
      }
      print('🎲 [ESTIMATION ROOM INVITES] Returning ${invites.length} invites');
      return invites;
    });
  }

  Future<List<UnifiedInviteModel>> _getPlanningPokerInvites(String email) async {
    try {
      print('🎲 [GET ESTIMATION INVITES] Querying for email: $email');
      // MIGRATO: Query diretta sulla collection dedicata (come Eisenhower)
      final snapshot = await _firestore
          .collection(_estimationRoomInvitesCollection)
          .where('email', isEqualTo: email)
          .where('status', isEqualTo: 'pending')
          .get();

      print('🎲 [GET ESTIMATION INVITES] Found ${snapshot.docs.length} docs');

      final invites = <UnifiedInviteModel>[];
      final now = DateTime.now();

      for (final doc in snapshot.docs) {
        try {
          final invite = PlanningPokerInviteModel.fromFirestore(doc);
          print('🎲 [GET ESTIMATION INVITES] Invite sessionId: ${invite.sessionId}');

          if (invite.expiresAt.isAfter(now)) {
            final sessionName = await _getInstanceName(
              _planningPokerSessionsCollection,
              invite.sessionId,
              'name',
            );
            print('🎲 [GET ESTIMATION INVITES] ✅ Adding invite for session: $sessionName');
            invites.add(UnifiedInviteModel.fromPlanningPoker(invite, sessionName: sessionName));
          } else {
            print('🎲 [GET ESTIMATION INVITES] ⏭️ Skipping - expired');
          }
        } catch (e) {
          print('🎲 [GET ESTIMATION INVITES] ❌ Error: $e');
          continue;
        }
      }
      print('🎲 [GET ESTIMATION INVITES] Returning ${invites.length} invites');
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
  ///
  /// Verifica prima se l'invito è nella collection unificata,
  /// altrimenti usa le collection legacy
  Future<bool> acceptInvite(UnifiedInviteModel invite) async {
    final userEmail = _authService.currentUserEmail;
    final userName = _authService.currentUser?.displayName ?? userEmail?.split('@').first ?? 'User';

    if (userEmail == null) return false;

    try {
      // Prima verifica se esiste nella collection unificata
      final unifiedDoc = await _firestore.collection(_unifiedInvitesCollection).doc(invite.id).get();
      if (unifiedDoc.exists) {
        print('🆕 [ACCEPT] Invito trovato nella collection unificata');
        return await _inviteService.acceptInvite(invite, accepterName: userName);
      }

      // Altrimenti usa le collection legacy
      print('📦 [ACCEPT] Invito trovato nelle collection legacy');
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
  ///
  /// Verifica prima se l'invito è nella collection unificata,
  /// altrimenti usa le collection legacy
  Future<bool> declineInvite(UnifiedInviteModel invite, {String? reason}) async {
    try {
      print('🔴 [DECLINE] Starting decline for invite ID: ${invite.id}');
      print('🔴 [DECLINE] Source type: ${invite.sourceType}, sourceId: ${invite.sourceId}');
      print('🔴 [DECLINE] Email: ${invite.email}');

      // Prima verifica se esiste nella collection unificata
      // Wrap in try-catch per gestire permission-denied se il doc non è accessibile
      bool foundInUnified = false;
      try {
        final unifiedDoc = await _firestore.collection(_unifiedInvitesCollection).doc(invite.id).get();
        foundInUnified = unifiedDoc.exists;
        print('🔍 [DECLINE] Check unified collection: exists=${unifiedDoc.exists}');
      } catch (e) {
        print('🔍 [DECLINE] Check unified failed (permission or not found): $e');
        foundInUnified = false;
      }

      if (foundInUnified) {
        print('🆕 [DECLINE] Invito trovato nella collection unificata');
        final result = await _inviteService.declineInvite(invite.id, reason: reason);
        print('🆕 [DECLINE] Unified decline result: $result');
        return result;
      }

      // Altrimenti usa le collection legacy
      print('📦 [DECLINE] Usando collection legacy per sourceType: ${invite.sourceType}');
      switch (invite.sourceType) {
        case InviteSourceType.eisenhower:
          print('📦 [DECLINE] Eisenhower: Updating invite in $_eisenhowerInvitesCollection/${invite.id}');
          print('📦 [DECLINE] Eisenhower: Removing from eisenhower_matrices/${invite.sourceId} pendingEmails');

          final eisenhowerBatch = _firestore.batch();

          // 1. Aggiorna status invito
          eisenhowerBatch.update(_firestore.collection(_eisenhowerInvitesCollection).doc(invite.id), {
            'status': 'declined',
            'declinedAt': Timestamp.now(),
            if (reason != null) 'declineReason': reason,
          });

          // 2. Rimuovi da pendingEmails nella matrice
          eisenhowerBatch.update(_firestore.collection('eisenhower_matrices').doc(invite.sourceId), {
            'pendingEmails': FieldValue.arrayRemove([invite.email.toLowerCase()]),
          });

          await eisenhowerBatch.commit();
          print('📦 [DECLINE] Eisenhower: Batch commit SUCCESS');
          return true;

        case InviteSourceType.estimationRoom:
          // MIGRATO: Usa collection dedicata
          final estimationBatch = _firestore.batch();

          // 1. Aggiorna status invito nella collection dedicata
          estimationBatch.update(_firestore.collection(_estimationRoomInvitesCollection).doc(invite.id), {
            'status': 'declined',
            'declinedAt': Timestamp.now(),
            if (reason != null) 'declineReason': reason,
          });

          // 2. Rimuovi da pendingEmails nella sessione
          estimationBatch.update(_firestore.collection(_planningPokerSessionsCollection).doc(invite.sourceId), {
            'pendingEmails': FieldValue.arrayRemove([invite.email.toLowerCase()]),
          });

          await estimationBatch.commit();
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
    } catch (e, stackTrace) {
      print('❌ [DECLINE] Errore declineInvite: $e');
      print('❌ [DECLINE] Stack trace: $stackTrace');
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

    // 1. Aggiorna status invito nella collection dedicata
    final inviteRef = _firestore.collection(_estimationRoomInvitesCollection).doc(invite.id);
    batch.update(inviteRef, {
      'status': 'accepted',
      'acceptedAt': Timestamp.now(),
    });

    // 2. Aggiungi come partecipante alla sessione
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
