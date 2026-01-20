import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/planning_poker_session_model.dart';
import '../models/planning_poker_story_model.dart';
import '../models/planning_poker_participant_model.dart';
import '../models/estimation_mode.dart';
import '../models/subscription/subscription_limits_model.dart';
import 'subscription/subscription_limits_service.dart';

/// Service per la gestione Firestore del Planning Poker
///
/// Gestisce:
/// - CRUD per sessioni
/// - CRUD per stories (subcollection)
/// - Gestione voti con real-time updates
/// - Reveal e statistiche
class PlanningPokerFirestoreService {
  /// Escape dei punti nell'email per usarla come chiave Firestore
  /// Firestore interpreta i punti come path separator, quindi li sostituiamo
  static String _escapeEmailKey(String email) => email.replaceAll('.', '_DOT_');

  /// Unescape dei punti nell'email (per leggere chiavi Firestore)
  static String unescapeEmailKey(String key) => key.replaceAll('_DOT_', '.');
  static final PlanningPokerFirestoreService _instance =
      PlanningPokerFirestoreService._internal();
  factory PlanningPokerFirestoreService() => _instance;
  PlanningPokerFirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  /// Collection principale delle sessioni
  CollectionReference<Map<String, dynamic>> get _sessionsCollection =>
      _firestore.collection('planning_poker_sessions');

  /// Subcollection delle stories per una sessione
  CollectionReference<Map<String, dynamic>> _storiesCollection(String sessionId) =>
      _sessionsCollection.doc(sessionId).collection('stories');

  // ══════════════════════════════════════════════════════════════════════════
  // SESSIONI - CRUD
  // ══════════════════════════════════════════════════════════════════════════

  /// Crea una nuova sessione
  /// Lancia [LimitExceededException] se il limite progetti e' raggiunto
  Future<String> createSession({
    required String name,
    String description = '',
    required String createdBy,
    List<String> cardSet = const [],
    EstimationMode estimationMode = EstimationMode.fibonacci,
    bool allowObservers = true,
    bool autoReveal = true,
    String? teamId,
    String? teamName,
    String? businessUnitId,
    String? businessUnitName,
    String? projectId,
    String? projectName,
    String? projectCode,
  }) async {
    // 🔒 CHECK LIMITE SUBSCRIPTION (limite separato per sessioni Estimation)
    await _limitsService.enforceProjectLimit(createdBy.toLowerCase(), entityType: 'estimation');

    try {
      // print('🎯 [PlanningPoker] Creando sessione: $name (mode: ${estimationMode.name})');

      final now = DateTime.now();
      final data = <String, dynamic>{
        'name': name,
        'description': description,
        'createdBy': createdBy,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
        'status': 'draft',
        'cardSet': cardSet.isEmpty ? PlanningPokerCardSet.fibonacci : cardSet,
        'estimationMode': estimationMode.name,
        'allowObservers': allowObservers,
        'autoReveal': autoReveal,
        'participants': {
          _escapeEmailKey(createdBy.toLowerCase()): {
            'name': createdBy.split('@').first,
            'role': 'facilitator',
            'joinedAt': Timestamp.fromDate(now),
            'isOnline': true,
          }
        },
        'participantEmails': [createdBy.toLowerCase()], // Array per query
        'storyCount': 0,
        'completedStoryCount': 0,
      };

      // Integrazioni opzionali
      if (teamId != null) data['teamId'] = teamId;
      if (teamName != null) data['teamName'] = teamName;
      if (businessUnitId != null) data['businessUnitId'] = businessUnitId;
      if (businessUnitName != null) data['businessUnitName'] = businessUnitName;
      if (projectId != null) data['projectId'] = projectId;
      if (projectName != null) data['projectName'] = projectName;
      if (projectCode != null) data['projectCode'] = projectCode;

      final docRef = await _sessionsCollection.add(data);

      // print('✅ [PlanningPoker] Sessione creata con ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('❌ [PlanningPoker] Errore creazione sessione: $e');
      rethrow;
    }
  }

  /// Ottiene una sessione per ID
  Future<PlanningPokerSessionModel?> getSession(String sessionId) async {
    try {
      final doc = await _sessionsCollection.doc(sessionId).get();
      if (!doc.exists) return null;
      return PlanningPokerSessionModel.fromFirestore(doc);
    } catch (e) {
      print('❌ [PlanningPoker] Errore lettura sessione: $e');
      rethrow;
    }
  }

  /// Ottiene tutte le sessioni dove l'utente è partecipante o creatore
  /// Include sessioni legacy (senza participantEmails) create dall'utente
  Future<List<PlanningPokerSessionModel>> getSessionsByUser(String userEmail) async {
    try {
      // print('🎯 [PlanningPoker] Caricando sessioni per: $userEmail');
      final email = userEmail.toLowerCase();
      final sessionsMap = <String, PlanningPokerSessionModel>{};

      // Query 1: Sessioni con participantEmails (nuove)
      try {
        final newSnapshot = await _sessionsCollection
            .where('participantEmails', arrayContains: email)
            .orderBy('updatedAt', descending: true)
            .get();
        for (final doc in newSnapshot.docs) {
          sessionsMap[doc.id] = PlanningPokerSessionModel.fromFirestore(doc);
        }
        // print('📋 [PlanningPoker] Sessioni nuove: ${newSnapshot.docs.length}');
      } catch (e) {
        print('⚠️ [PlanningPoker] Query participantEmails fallita: $e');
      }

      // Query 2: Sessioni create dall'utente (legacy + nuove)
      try {
        final legacySnapshot = await _sessionsCollection
            .where('createdBy', isEqualTo: email)
            .orderBy('updatedAt', descending: true)
            .get();
        for (final doc in legacySnapshot.docs) {
          if (!sessionsMap.containsKey(doc.id)) {
            sessionsMap[doc.id] = PlanningPokerSessionModel.fromFirestore(doc);
          }
        }
        // print('📋 [PlanningPoker] Sessioni legacy/create: ${legacySnapshot.docs.length}');
      } catch (e) {
        print('⚠️ [PlanningPoker] Query createdBy fallita: $e');
      }

      // Ordina per updatedAt descending
      final sessions = sessionsMap.values.toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      // print('✅ [PlanningPoker] Totale sessioni uniche: ${sessions.length}');
      return sessions;
    } catch (e) {
      print('❌ [PlanningPoker] Errore caricamento sessioni: $e');
      rethrow;
    }
  }

  /// Stream delle sessioni dove l'utente è partecipante o creatore (real-time)
  /// Combina sessioni nuove (con participantEmails) e legacy (solo createdBy)
  Stream<List<PlanningPokerSessionModel>> streamSessionsByUser(String userEmail) {
    final email = userEmail.toLowerCase();

    // Stream sessioni con participantEmails
    final newSessionsStream = _sessionsCollection
        .where('participantEmails', arrayContains: email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PlanningPokerSessionModel.fromFirestore(doc))
            .toList())
        .handleError((e) {
          print('⚠️ [PlanningPoker] Stream participantEmails error: $e');
          return <PlanningPokerSessionModel>[];
        });

    // Stream sessioni create dall'utente (per legacy)
    final legacySessionsStream = _sessionsCollection
        .where('createdBy', isEqualTo: email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PlanningPokerSessionModel.fromFirestore(doc))
            .toList())
        .handleError((e) {
          print('⚠️ [PlanningPoker] Stream createdBy error: $e');
          return <PlanningPokerSessionModel>[];
        });

    // Combina i due stream e rimuovi duplicati
    return newSessionsStream.asyncExpand((newSessions) {
      return legacySessionsStream.map((legacySessions) {
        final sessionsMap = <String, PlanningPokerSessionModel>{};

        // Aggiungi sessioni nuove
        for (final session in newSessions) {
          sessionsMap[session.id] = session;
        }

        // Aggiungi sessioni legacy (senza sovrascrivere)
        for (final session in legacySessions) {
          if (!sessionsMap.containsKey(session.id)) {
            sessionsMap[session.id] = session;
          }
        }

        // Ordina per updatedAt descending
        final sessions = sessionsMap.values.toList()
          ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

        return sessions;
      });
    });
  }

  /// Stream di una singola sessione (real-time)
  Stream<PlanningPokerSessionModel?> streamSession(String sessionId) {
    return _sessionsCollection.doc(sessionId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return PlanningPokerSessionModel.fromFirestore(doc);
    });
  }

  /// Aggiorna una sessione
  Future<void> updateSession({
    required String sessionId,
    String? name,
    String? description,
    PlanningPokerSessionStatus? status,
    List<String>? cardSet,
    EstimationMode? estimationMode,
    bool? allowObservers,
    bool? autoReveal,
    String? currentStoryId,
    String? teamId,
    String? teamName,
    String? businessUnitId,
    String? businessUnitName,
    String? projectId,
    String? projectName,
    String? projectCode,
    bool clearProject = false,
    bool clearTeam = false,
    bool clearBusinessUnit = false,
  }) async {
    try {
      // print('🎯 [PlanningPoker] Aggiornando sessione: $sessionId');

      final updates = <String, dynamic>{
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      };

      if (name != null) updates['name'] = name;
      if (description != null) updates['description'] = description;
      if (status != null) updates['status'] = status.name;
      if (cardSet != null) updates['cardSet'] = cardSet;
      if (estimationMode != null) updates['estimationMode'] = estimationMode.name;
      if (allowObservers != null) updates['allowObservers'] = allowObservers;
      if (autoReveal != null) updates['autoReveal'] = autoReveal;
      if (currentStoryId != null) updates['currentStoryId'] = currentStoryId;

      // Integrazioni
      if (teamId != null) updates['teamId'] = teamId;
      if (teamName != null) updates['teamName'] = teamName;
      if (businessUnitId != null) updates['businessUnitId'] = businessUnitId;
      if (businessUnitName != null) updates['businessUnitName'] = businessUnitName;
      if (projectId != null) updates['projectId'] = projectId;
      if (projectName != null) updates['projectName'] = projectName;
      if (projectCode != null) updates['projectCode'] = projectCode;

      // Rimozione associazioni
      if (clearProject) {
        updates['projectId'] = FieldValue.delete();
        updates['projectName'] = FieldValue.delete();
        updates['projectCode'] = FieldValue.delete();
      }
      if (clearTeam) {
        updates['teamId'] = FieldValue.delete();
        updates['teamName'] = FieldValue.delete();
      }
      if (clearBusinessUnit) {
        updates['businessUnitId'] = FieldValue.delete();
        updates['businessUnitName'] = FieldValue.delete();
      }

      await _sessionsCollection.doc(sessionId).update(updates);
      // print('✅ [PlanningPoker] Sessione aggiornata');
    } catch (e) {
      print('❌ [PlanningPoker] Errore aggiornamento sessione: $e');
      rethrow;
    }
  }

  /// Elimina una sessione e tutte le sue stories
  Future<void> deleteSession(String sessionId) async {
    try {
      print('🗑️ [PlanningPoker] Eliminando sessione: $sessionId');

      // Elimina prima tutte le stories
      final storiesSnapshot = await _storiesCollection(sessionId).get();
      final batch = _firestore.batch();

      for (final doc in storiesSnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Poi elimina la sessione
      batch.delete(_sessionsCollection.doc(sessionId));
      await batch.commit();

      print('✅ [PlanningPoker] Sessione eliminata con ${storiesSnapshot.docs.length} stories');
    } catch (e) {
      print('❌ [PlanningPoker] Errore eliminazione sessione: $e');
      rethrow;
    }
  }

  /// Avvia una sessione
  Future<void> startSession(String sessionId) async {
    await updateSession(
      sessionId: sessionId,
      status: PlanningPokerSessionStatus.active,
    );
    print('🚀 [PlanningPoker] Sessione avviata: $sessionId');
  }

  /// Completa una sessione
  Future<void> completeSession(String sessionId) async {
    await updateSession(
      sessionId: sessionId,
      status: PlanningPokerSessionStatus.completed,
    );
    print('🏁 [PlanningPoker] Sessione completata: $sessionId');
  }

  // ══════════════════════════════════════════════════════════════════════════
  // PARTECIPANTI
  // ══════════════════════════════════════════════════════════════════════════

  /// Aggiunge un partecipante alla sessione
  Future<void> addParticipant({
    required String sessionId,
    required String email,
    required String name,
    ParticipantRole role = ParticipantRole.voter,
  }) async {
    try {
      print('👤 [PlanningPoker] Aggiungendo partecipante: $email');

      final now = DateTime.now();
      final escapedEmail = _escapeEmailKey(email.toLowerCase());
      await _sessionsCollection.doc(sessionId).update({
        'participants.$escapedEmail': {
          'name': name,
          'role': role.name,
          'joinedAt': Timestamp.fromDate(now),
          'isOnline': false,
        },
        'participantEmails': FieldValue.arrayUnion([email.toLowerCase()]),
        'updatedAt': Timestamp.fromDate(now),
      });

      print('✅ [PlanningPoker] Partecipante aggiunto');
    } catch (e) {
      print('❌ [PlanningPoker] Errore aggiunta partecipante: $e');
      rethrow;
    }
  }

  /// Rimuove un partecipante dalla sessione
  Future<void> removeParticipant({
    required String sessionId,
    required String email,
  }) async {
    try {
      print('👤 [PlanningPoker] Rimuovendo partecipante: $email');

      final escapedEmail = _escapeEmailKey(email.toLowerCase());
      await _sessionsCollection.doc(sessionId).update({
        'participants.$escapedEmail': FieldValue.delete(),
        'participantEmails': FieldValue.arrayRemove([email.toLowerCase()]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ [PlanningPoker] Partecipante rimosso');
    } catch (e) {
      print('❌ [PlanningPoker] Errore rimozione partecipante: $e');
      rethrow;
    }
  }

  /// Aggiorna stato online di un partecipante
  Future<void> updateParticipantOnlineStatus({
    required String sessionId,
    required String email,
    required bool isOnline,
  }) async {
    try {
      final escapedEmail = _escapeEmailKey(email.toLowerCase());
      await _sessionsCollection.doc(sessionId).update({
        'participants.$escapedEmail.isOnline': isOnline,
        'participants.$escapedEmail.lastActivity': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('❌ [PlanningPoker] Errore aggiornamento status: $e');
    }
  }

  /// Aggiorna ruolo di un partecipante
  Future<void> updateParticipantRole({
    required String sessionId,
    required String email,
    required ParticipantRole role,
  }) async {
    try {
      print('👤 [PlanningPoker] Aggiornando ruolo: $email -> ${role.name}');

      final escapedEmail = _escapeEmailKey(email.toLowerCase());
      await _sessionsCollection.doc(sessionId).update({
        'participants.$escapedEmail.role': role.name,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ [PlanningPoker] Ruolo aggiornato');
    } catch (e) {
      print('❌ [PlanningPoker] Errore aggiornamento ruolo: $e');
      rethrow;
    }
  }

  /// Aggiunge un partecipante alla lista pending
  Future<void> addPendingParticipant({
    required String sessionId,
    required String email,
  }) async {
    try {
      print('⏳ [PlanningPoker] Aggiungendo pending: $email');
      await _sessionsCollection.doc(sessionId).update({
        'pendingEmails': FieldValue.arrayUnion([email.toLowerCase()]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('❌ [PlanningPoker] Errore aggiunta pending: $e');
      rethrow;
    }
  }

  /// Promuove un partecipante da pending ad attivo
  Future<void> promotePendingToActive({
    required String sessionId,
    required String email,
    required String name,
    ParticipantRole role = ParticipantRole.voter,
  }) async {
    try {
      print('✅ [PlanningPoker] Promuovendo pending -> active: $email');
      final now = DateTime.now();
      final escapedEmail = _escapeEmailKey(email.toLowerCase());

      await _sessionsCollection.doc(sessionId).update({
        'pendingEmails': FieldValue.arrayRemove([email.toLowerCase()]),
        'participants.$escapedEmail': {
          'name': name,
          'role': role.name,
          'joinedAt': Timestamp.fromDate(now),
          'isOnline': true,
        },
        'participantEmails': FieldValue.arrayUnion([email.toLowerCase()]),
        'updatedAt': Timestamp.fromDate(now),
      });
    } catch (e) {
      print('❌ [PlanningPoker] Errore promozione pending: $e');
      rethrow;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // STORIES - CRUD
  // ══════════════════════════════════════════════════════════════════════════

  /// Crea una nuova story
  /// Lancia [LimitExceededException] se il limite task per entita' e' raggiunto
  Future<String> createStory({
    required String sessionId,
    required String title,
    String description = '',
    int? order,
    String? linkedTaskId,
    String? linkedTaskTitle,
  }) async {
    // 🔒 CHECK LIMITE TASK PER ENTITA'
    await _limitsService.enforceTaskLimit(entityType: 'estimation', entityId: sessionId);

    try {
      print('📝 [PlanningPoker] Creando story: $title');

      // Se non specificato, metti in fondo
      int storyOrder = order ?? 0;
      if (order == null) {
        final existingStories = await _storiesCollection(sessionId).get();
        storyOrder = existingStories.docs.length;
      }

      final now = DateTime.now();
      final docRef = await _storiesCollection(sessionId).add({
        'title': title,
        'description': description,
        'order': storyOrder,
        'status': 'pending',
        'createdAt': Timestamp.fromDate(now),
        'votes': {},
        'voteCount': 0,
        'isRevealed': false,
        if (linkedTaskId != null) 'linkedTaskId': linkedTaskId,
        if (linkedTaskTitle != null) 'linkedTaskTitle': linkedTaskTitle,
      });

      // Aggiorna contatore nella sessione
      await _sessionsCollection.doc(sessionId).update({
        'storyCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(now),
      });

      print('✅ [PlanningPoker] Story creata con ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('❌ [PlanningPoker] Errore creazione story: $e');
      rethrow;
    }
  }

  /// Ottiene tutte le stories di una sessione
  Future<List<PlanningPokerStoryModel>> getStories(String sessionId) async {
    try {
      final snapshot = await _storiesCollection(sessionId)
          .orderBy('order', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => PlanningPokerStoryModel.fromFirestore(doc, sessionId))
          .toList();
    } catch (e) {
      print('❌ [PlanningPoker] Errore caricamento stories: $e');
      rethrow;
    }
  }

  /// Stream delle stories di una sessione (real-time)
  Stream<List<PlanningPokerStoryModel>> streamStories(String sessionId) {
    return _storiesCollection(sessionId)
        .orderBy('order', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PlanningPokerStoryModel.fromFirestore(doc, sessionId))
            .toList());
  }

  /// Stream di una singola story (real-time)
  Stream<PlanningPokerStoryModel?> streamStory(String sessionId, String storyId) {
    return _storiesCollection(sessionId).doc(storyId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return PlanningPokerStoryModel.fromFirestore(doc, sessionId);
    });
  }

  /// Aggiorna una story
  Future<void> updateStory({
    required String sessionId,
    required String storyId,
    String? title,
    String? description,
    int? order,
    StoryStatus? status,
    String? notes,
  }) async {
    try {
      print('📝 [PlanningPoker] Aggiornando story: $storyId');

      final updates = <String, dynamic>{};
      if (title != null) updates['title'] = title;
      if (description != null) updates['description'] = description;
      if (order != null) updates['order'] = order;
      if (status != null) updates['status'] = status.name;
      if (notes != null) updates['notes'] = notes;

      if (updates.isNotEmpty) {
        await _storiesCollection(sessionId).doc(storyId).update(updates);

        // Aggiorna timestamp sessione
        await _sessionsCollection.doc(sessionId).update({
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        });
      }

      print('✅ [PlanningPoker] Story aggiornata');
    } catch (e) {
      print('❌ [PlanningPoker] Errore aggiornamento story: $e');
      rethrow;
    }
  }

  /// Elimina una story
  Future<void> deleteStory({
    required String sessionId,
    required String storyId,
  }) async {
    try {
      print('🗑️ [PlanningPoker] Eliminando story: $storyId');

      await _storiesCollection(sessionId).doc(storyId).delete();

      // Decrementa contatore
      await _sessionsCollection.doc(sessionId).update({
        'storyCount': FieldValue.increment(-1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ [PlanningPoker] Story eliminata');
    } catch (e) {
      print('❌ [PlanningPoker] Errore eliminazione story: $e');
      rethrow;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // VOTAZIONE
  // ══════════════════════════════════════════════════════════════════════════

  /// Avvia la votazione per una story (o ri-avvia per story completate)
  Future<void> startVoting({
    required String sessionId,
    required String storyId,
  }) async {
    try {
      print('🗳️ [PlanningPoker] Avviando votazione per story: $storyId');

      // Prima controlla se la story era completata (per decrementare il contatore)
      final storyDoc = await _storiesCollection(sessionId).doc(storyId).get();
      final wasCompleted = storyDoc.exists && storyDoc.data()?['status'] == 'completed';

      // Resetta la story e imposta status voting
      await _storiesCollection(sessionId).doc(storyId).update({
        'status': 'voting',
        'votes': {},
        'voteCount': 0,
        'isRevealed': false,
        'revealedAt': FieldValue.delete(),
        'statistics': FieldValue.delete(),
        'finalEstimate': FieldValue.delete(), // Rimuovi stima precedente
      });

      // Aggiorna sessione
      final sessionUpdates = <String, dynamic>{
        'currentStoryId': storyId,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      };

      // Se era completata, decrementa il contatore
      if (wasCompleted) {
        sessionUpdates['completedStoryCount'] = FieldValue.increment(-1);
        print('📊 [PlanningPoker] Decrementato contatore stories completate');
      }

      await _sessionsCollection.doc(sessionId).update(sessionUpdates);

      print('✅ [PlanningPoker] Votazione avviata');
    } catch (e) {
      print('❌ [PlanningPoker] Errore avvio votazione: $e');
      rethrow;
    }
  }

  /// Registra un voto
  Future<void> submitVote({
    required String sessionId,
    required String storyId,
    required String voterEmail,
    required String value,
    double? decimalValue,
    double? optimisticValue,
    double? realisticValue,
    double? pessimisticValue,
  }) async {
    try {
      print('🗳️ [PlanningPoker] Voto: $voterEmail -> $value');

      final now = DateTime.now();
      final storyRef = _storiesCollection(sessionId).doc(storyId);

      // Controlla se l'utente aveva già votato (per non incrementare il contatore)
      final storyDoc = await storyRef.get();
      final existingVotes = (storyDoc.data()?['votes'] as Map<String, dynamic>?) ?? {};
      final hadVoted = existingVotes.containsKey(voterEmail.toLowerCase());

      // Usa set con merge per evitare problemi con i punti nell'email
      // (Firestore interpreta i punti come path separators in update())
      final updatedVotes = Map<String, dynamic>.from(existingVotes);
      final voteData = <String, dynamic>{
        'value': value,
        'votedAt': Timestamp.fromDate(now),
      };

      // Aggiungi campi extra per modalita' avanzate
      if (decimalValue != null) {
        voteData['decimalValue'] = decimalValue;
      }
      if (optimisticValue != null) {
        voteData['optimisticValue'] = optimisticValue;
      }
      if (realisticValue != null) {
        voteData['realisticValue'] = realisticValue;
      }
      if (pessimisticValue != null) {
        voteData['pessimisticValue'] = pessimisticValue;
      }

      updatedVotes[voterEmail.toLowerCase()] = voteData;

      await storyRef.update({
        'votes': updatedVotes,
        // Incrementa solo se non aveva già votato
        if (!hadVoted) 'voteCount': FieldValue.increment(1),
      });

      print('✅ [PlanningPoker] Voto registrato (nuovo: ${!hadVoted})');
    } catch (e) {
      print('❌ [PlanningPoker] Errore registrazione voto: $e');
      rethrow;
    }
  }

  /// Rimuove un voto
  Future<void> removeVote({
    required String sessionId,
    required String storyId,
    required String voterEmail,
  }) async {
    try {
      print('🗳️ [PlanningPoker] Rimuovendo voto: $voterEmail');

      final storyRef = _storiesCollection(sessionId).doc(storyId);
      final storyDoc = await storyRef.get();
      final existingVotes = (storyDoc.data()?['votes'] as Map<String, dynamic>?) ?? {};

      if (existingVotes.containsKey(voterEmail.toLowerCase())) {
        final updatedVotes = Map<String, dynamic>.from(existingVotes);
        updatedVotes.remove(voterEmail.toLowerCase());

        await storyRef.update({
          'votes': updatedVotes,
          'voteCount': FieldValue.increment(-1),
        });
        print('✅ [PlanningPoker] Voto rimosso');
      } else {
        print('⚠️ [PlanningPoker] Voto non trovato per: $voterEmail');
      }
    } catch (e) {
      print('❌ [PlanningPoker] Errore rimozione voto: $e');
      rethrow;
    }
  }

  /// Rivela i voti e calcola statistiche
  Future<void> revealVotes({
    required String sessionId,
    required String storyId,
  }) async {
    try {
      print('🎉 [PlanningPoker] Rivelando voti per story: $storyId');

      // Ottieni la story per calcolare statistiche
      final storyDoc = await _storiesCollection(sessionId).doc(storyId).get();
      if (!storyDoc.exists) {
        throw Exception('Story non trovata');
      }

      final story = PlanningPokerStoryModel.fromFirestore(storyDoc, sessionId);
      final statistics = story.calculateStatistics();

      final now = DateTime.now();
      await _storiesCollection(sessionId).doc(storyId).update({
        'isRevealed': true,
        'revealedAt': Timestamp.fromDate(now),
        'status': 'revealed',
        'statistics': statistics.toMap(),
      });

      await _sessionsCollection.doc(sessionId).update({
        'updatedAt': Timestamp.fromDate(now),
      });

      print('✅ [PlanningPoker] Voti rivelati - Stats: $statistics');
    } catch (e) {
      print('❌ [PlanningPoker] Errore reveal: $e');
      rethrow;
    }
  }

  /// Resetta votazione per ri-votare
  Future<void> resetVoting({
    required String sessionId,
    required String storyId,
  }) async {
    try {
      print('🔄 [PlanningPoker] Resettando votazione: $storyId');

      await _storiesCollection(sessionId).doc(storyId).update({
        'status': 'voting',
        'votes': {},
        'voteCount': 0,
        'isRevealed': false,
        'revealedAt': FieldValue.delete(),
        'statistics': FieldValue.delete(),
      });

      print('✅ [PlanningPoker] Votazione resettata');
    } catch (e) {
      print('❌ [PlanningPoker] Errore reset: $e');
      rethrow;
    }
  }

  /// Imposta la stima finale e completa la story
  Future<void> setFinalEstimate({
    required String sessionId,
    required String storyId,
    required String estimate,
    String? notes,
    String? explanationDetail,
  }) async {
    try {
      print('✅ [PlanningPoker] Stima finale: $estimate per story $storyId');

      final updates = <String, dynamic>{
        'finalEstimate': estimate,
        'status': 'completed',
      };
      if (notes != null) updates['notes'] = notes;
      if (explanationDetail != null) updates['explanationDetail'] = explanationDetail;

      await _storiesCollection(sessionId).doc(storyId).update(updates);

      // Incrementa contatore completate
      await _sessionsCollection.doc(sessionId).update({
        'completedStoryCount': FieldValue.increment(1),
        'currentStoryId': FieldValue.delete(),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ [PlanningPoker] Stima finale salvata');
    } catch (e) {
      print('❌ [PlanningPoker] Errore salvataggio stima: $e');
      rethrow;
    }
  }

  /// Salta una story senza votarla
  Future<void> skipStory({
    required String sessionId,
    required String storyId,
  }) async {
    try {
      print('⏭️ [PlanningPoker] Saltando story: $storyId');

      await _storiesCollection(sessionId).doc(storyId).update({
        'status': 'pending',
        'votes': {},
        'voteCount': 0,
        'isRevealed': false,
      });

      await _sessionsCollection.doc(sessionId).update({
        'currentStoryId': FieldValue.delete(),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ [PlanningPoker] Story saltata');
    } catch (e) {
      print('❌ [PlanningPoker] Errore skip: $e');
      rethrow;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // QUERY INTEGRAZIONI
  // ══════════════════════════════════════════════════════════════════════════

  /// Sessioni per progetto
  Future<List<PlanningPokerSessionModel>> getSessionsByProject(String projectId) async {
    try {
      final snapshot = await _sessionsCollection
          .where('projectId', isEqualTo: projectId)
          .orderBy('updatedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => PlanningPokerSessionModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('❌ [PlanningPoker] Errore query per progetto: $e');
      rethrow;
    }
  }

  /// Sessioni per team
  Future<List<PlanningPokerSessionModel>> getSessionsByTeam(String teamId) async {
    try {
      final snapshot = await _sessionsCollection
          .where('teamId', isEqualTo: teamId)
          .orderBy('updatedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => PlanningPokerSessionModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('❌ [PlanningPoker] Errore query per team: $e');
      rethrow;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // STATISTICHE
  // ══════════════════════════════════════════════════════════════════════════

  /// Statistiche di una sessione
  Future<Map<String, dynamic>> getSessionStatistics(String sessionId) async {
    try {
      final stories = await getStories(sessionId);

      int completed = 0;
      int totalEstimate = 0;
      final estimateDistribution = <String, int>{};

      for (final story in stories) {
        if (story.isCompleted) {
          completed++;
          if (story.finalEstimate != null) {
            final estimate = story.finalEstimate!;
            estimateDistribution[estimate] = (estimateDistribution[estimate] ?? 0) + 1;

            final numValue = int.tryParse(estimate);
            if (numValue != null) {
              totalEstimate += numValue;
            }
          }
        }
      }

      return {
        'totalStories': stories.length,
        'completedStories': completed,
        'pendingStories': stories.length - completed,
        'totalEstimate': totalEstimate,
        'estimateDistribution': estimateDistribution,
        'completionRate': stories.isEmpty ? 0.0 : (completed / stories.length) * 100,
      };
    } catch (e) {
      print('❌ [PlanningPoker] Errore statistiche: $e');
      rethrow;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SYNC STIME → GANTT TASKS
  // ══════════════════════════════════════════════════════════════════════════

  /// Verifica se un progetto ha task idonei per il sync delle stime
  /// Condizioni: nessun avanzamento (progress = 0) E nessun utente assegnato
  Future<SyncEligibilityResult> checkSyncEligibility({
    required String projectId,
    required List<PlanningPokerStoryModel> stories,
  }) async {
    try {
      print('🔍 [PlanningPoker] Verificando idoneità sync per progetto: $projectId');

      // Carica i task del progetto
      final ganttDoc = await _firestore.collection('gantt_tasks').doc(projectId).get();

      if (!ganttDoc.exists || ganttDoc.data() == null) {
        return SyncEligibilityResult(
          isEligible: false,
          reason: 'Nessun task trovato nel progetto',
          eligibleStories: [],
          ineligibleStories: [],
          tasksWithProgress: [],
          tasksWithAssignees: [],
        );
      }

      final tasksData = ganttDoc.data()!['tasks'] as List<dynamic>? ?? [];
      final tasks = tasksData.map((t) => Map<String, dynamic>.from(t as Map)).toList();

      // Filtra stories con linkedTaskId e finalEstimate numerico (supporta decimali)
      final storiesWithLinks = stories.where((s) =>
        s.linkedTaskId != null &&
        s.linkedTaskId!.isNotEmpty &&
        s.finalEstimate != null &&
        double.tryParse(s.finalEstimate!) != null
      ).toList();

      if (storiesWithLinks.isEmpty) {
        return SyncEligibilityResult(
          isEligible: false,
          reason: 'Nessuna story con task collegato e stima numerica (intera o decimale)',
          eligibleStories: [],
          ineligibleStories: stories,
          tasksWithProgress: [],
          tasksWithAssignees: [],
        );
      }

      final eligibleStories = <PlanningPokerStoryModel>[];
      final ineligibleStories = <PlanningPokerStoryModel>[];
      final tasksWithProgress = <String>[];
      final tasksWithAssignees = <String>[];

      for (final story in storiesWithLinks) {
        final task = tasks.firstWhere(
          (t) => t['id'] == story.linkedTaskId,
          orElse: () => <String, dynamic>{},
        );

        if (task.isEmpty) {
          ineligibleStories.add(story);
          continue;
        }

        final progress = (task['progress'] ?? 0.0) as num;
        final assignedUsers = List<String>.from(task['assigned_users'] ?? []);

        bool isEligible = true;

        if (progress > 0) {
          tasksWithProgress.add(story.linkedTaskTitle ?? story.title);
          isEligible = false;
        }

        if (assignedUsers.isNotEmpty) {
          tasksWithAssignees.add(story.linkedTaskTitle ?? story.title);
          isEligible = false;
        }

        if (isEligible) {
          eligibleStories.add(story);
        } else {
          ineligibleStories.add(story);
        }
      }

      print('✅ [PlanningPoker] Sync eligibility: ${eligibleStories.length}/${storiesWithLinks.length} stories idonee');

      return SyncEligibilityResult(
        isEligible: eligibleStories.isNotEmpty,
        reason: eligibleStories.isEmpty
          ? 'Tutti i task hanno già avanzamento o assegnazioni'
          : null,
        eligibleStories: eligibleStories,
        ineligibleStories: ineligibleStories,
        tasksWithProgress: tasksWithProgress,
        tasksWithAssignees: tasksWithAssignees,
      );
    } catch (e) {
      print('❌ [PlanningPoker] Errore verifica eligibility: $e');
      return SyncEligibilityResult(
        isEligible: false,
        reason: 'Errore durante la verifica: $e',
        eligibleStories: [],
        ineligibleStories: [],
        tasksWithProgress: [],
        tasksWithAssignees: [],
      );
    }
  }

  /// Sincronizza le stime delle stories con i task Gantt
  /// Aggiorna il campo 'effort' dei task con finalEstimate * 8 (ore)
  Future<SyncEstimatesResult> syncEstimatesToGantt({
    required String projectId,
    required List<PlanningPokerStoryModel> stories,
    required String syncedByUserEmail,
  }) async {
    try {
      print('📤 [PlanningPoker] Sincronizzando stime per progetto: $projectId');

      // Carica i task del progetto
      final ganttDoc = await _firestore.collection('gantt_tasks').doc(projectId).get();

      if (!ganttDoc.exists || ganttDoc.data() == null) {
        throw Exception('Nessun task trovato nel progetto');
      }

      final data = ganttDoc.data()!;
      final tasksData = data['tasks'] as List<dynamic>? ?? [];
      final tasks = tasksData.map((t) => Map<String, dynamic>.from(t as Map)).toList();

      // Filtra stories con linkedTaskId e finalEstimate numerico (supporta decimali)
      final storiesWithLinks = stories.where((s) =>
        s.linkedTaskId != null &&
        s.linkedTaskId!.isNotEmpty &&
        s.finalEstimate != null &&
        double.tryParse(s.finalEstimate!) != null
      ).toList();

      int updatedCount = 0;
      int skippedCount = 0;
      final updatedTasks = <Map<String, dynamic>>[];
      final skippedTasks = <Map<String, dynamic>>[];

      for (final story in storiesWithLinks) {
        final taskIndex = tasks.indexWhere((t) => t['id'] == story.linkedTaskId);

        if (taskIndex == -1) {
          skippedCount++;
          skippedTasks.add({
            'storyTitle': story.title,
            'reason': 'Task non trovato',
          });
          continue;
        }

        final task = tasks[taskIndex];
        final progress = (task['progress'] ?? 0.0) as num;
        final assignedUsers = List<String>.from(task['assigned_users'] ?? []);

        // Verifica condizioni
        if (progress > 0 || assignedUsers.isNotEmpty) {
          skippedCount++;
          skippedTasks.add({
            'storyTitle': story.title,
            'taskName': task['name'],
            'reason': progress > 0
              ? 'Task ha già avanzamento (${(progress * 100).toStringAsFixed(0)}%)'
              : 'Task ha già utenti assegnati',
          });
          continue;
        }

        // Calcola nuovo effort (stima in giorni * 8 ore)
        // Supporta decimali: 1.5 giorni = 12 ore
        final estimateInDays = double.parse(story.finalEstimate!);
        final effortInHoursDecimal = estimateInDays * 8;
        // Arrotonda all'intero più vicino per il campo effort (che è int)
        final effortInHours = effortInHoursDecimal.round();
        final oldEffort = task['effort'];

        // Aggiorna il task
        tasks[taskIndex]['effort'] = effortInHours;

        updatedCount++;
        updatedTasks.add({
          'taskId': story.linkedTaskId,
          'taskName': task['name'],
          'storyTitle': story.title,
          'estimateInDays': estimateInDays,
          'oldEffort': oldEffort,
          'newEffort': effortInHours,
          'newEffortDecimal': effortInHoursDecimal, // Per riferimento
        });

        print('✏️ [PlanningPoker] Task "${task['name']}": effort $oldEffort → $effortInHours ore (${estimateInDays.toStringAsFixed(2)} giorni)');
      }

      if (updatedCount > 0) {
        // Salva i task aggiornati
        await _firestore.collection('gantt_tasks').doc(projectId).update({
          'tasks': tasks,
          'lastModified': Timestamp.fromDate(DateTime.now()),
          'lastModifiedBy': syncedByUserEmail,
        });

        print('✅ [PlanningPoker] Sync completato: $updatedCount task aggiornati, $skippedCount saltati');
      } else {
        print('ℹ️ [PlanningPoker] Nessun task aggiornato');
      }

      return SyncEstimatesResult(
        success: true,
        updatedCount: updatedCount,
        skippedCount: skippedCount,
        updatedTasks: updatedTasks,
        skippedTasks: skippedTasks,
      );
    } catch (e) {
      print('❌ [PlanningPoker] Errore sync stime: $e');
      return SyncEstimatesResult(
        success: false,
        error: e.toString(),
        updatedCount: 0,
        skippedCount: 0,
        updatedTasks: [],
        skippedTasks: [],
      );
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // ARCHIVIAZIONE - Sessioni
  // ══════════════════════════════════════════════════════════════════════════

  /// Archivia una sessione
  ///
  /// [sessionId] - ID della sessione da archiviare
  ///
  /// Le sessioni archiviate sono escluse dai conteggi subscription
  /// e non appaiono nelle liste di default
  Future<bool> archiveSession(String sessionId) async {
    try {
      await _sessionsCollection.doc(sessionId).update({
        'isArchived': true,
        'archivedAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('🗄️ Sessione archiviata: $sessionId');
      return true;
    } catch (e) {
      print('❌ Errore archiveSession: $e');
      return false;
    }
  }

  /// Ripristina una sessione archiviata
  ///
  /// [sessionId] - ID della sessione da ripristinare
  Future<bool> restoreSession(String sessionId) async {
    try {
      await _sessionsCollection.doc(sessionId).update({
        'isArchived': false,
        'archivedAt': null,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('📦 Sessione ripristinata: $sessionId');
      return true;
    } catch (e) {
      print('❌ Errore restoreSession: $e');
      return false;
    }
  }

  /// Stream delle sessioni con filtro archivio
  ///
  /// [userEmail] - Email dell'utente
  /// [includeArchived] - Se true, include anche le archiviate
  Stream<List<PlanningPokerSessionModel>> streamSessionsByUserFiltered({
    required String userEmail,
    bool includeArchived = false,
  }) {
    final email = userEmail.toLowerCase();

    // Query base senza filtro isArchived (per compatibilità con documenti esistenti)
    return _sessionsCollection
        .where('participantEmails', arrayContains: email)
        .snapshots()
        .map((snapshot) {
      var sessions = snapshot.docs
          .map((doc) => PlanningPokerSessionModel.fromFirestore(doc))
          .toList();

      // Filtro client-side per isArchived (gestisce documenti senza il campo)
      if (!includeArchived) {
        sessions = sessions.where((s) => s.isArchived != true).toList();
      }

      // Ordina per updatedAt
      sessions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return sessions;
    }).handleError((e) {
      print('⚠️ [PlanningPoker] Stream sessioni filtrate error: $e');
      return <PlanningPokerSessionModel>[];
    });
  }
}

/// Risultato della verifica di idoneità per il sync
class SyncEligibilityResult {
  final bool isEligible;
  final String? reason;
  final List<PlanningPokerStoryModel> eligibleStories;
  final List<PlanningPokerStoryModel> ineligibleStories;
  final List<String> tasksWithProgress;
  final List<String> tasksWithAssignees;

  const SyncEligibilityResult({
    required this.isEligible,
    this.reason,
    required this.eligibleStories,
    required this.ineligibleStories,
    required this.tasksWithProgress,
    required this.tasksWithAssignees,
  });
}

/// Risultato della sincronizzazione stime
class SyncEstimatesResult {
  final bool success;
  final String? error;
  final int updatedCount;
  final int skippedCount;
  final List<Map<String, dynamic>> updatedTasks;
  final List<Map<String, dynamic>> skippedTasks;

  const SyncEstimatesResult({
    required this.success,
    this.error,
    required this.updatedCount,
    required this.skippedCount,
    required this.updatedTasks,
    required this.skippedTasks,
  });
}
