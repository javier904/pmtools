import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../models/eisenhower_matrix_model.dart';
import '../models/eisenhower_activity_model.dart';
import '../models/eisenhower_participant_model.dart';
import '../models/raci_models.dart';
import '../models/subscription/subscription_limits_model.dart';
import 'auth_service.dart';
import 'subscription/subscription_limits_service.dart';
import 'favorite_service.dart';

/// Servizio Firestore per la Matrice di Eisenhower
///
/// Gestisce le operazioni CRUD per matrici e attivita' standalone
/// senza dipendenze da team, business unit o progetti del PMO.
///
/// Struttura Firestore:
/// ```
/// eisenhower_matrices/{matrixId}
///   - title: String
///   - description: String
///   - createdBy: String (email utente)
///   - createdAt: Timestamp
///   - updatedAt: Timestamp
///   - participants: List<String>
///   - activityCount: int
///   └── activities/{activityId}
///       - title: String
///       - description: String
///       - createdAt: Timestamp
///       - tags: List<String>
///       - votes: Map<String, {urgency: int, importance: int}>
///       - aggregatedUrgency: double
///       - aggregatedImportance: double
///       - quadrant: String
///       - voteCount: int
/// ```
class EisenhowerFirestoreService {
  static final EisenhowerFirestoreService _instance = EisenhowerFirestoreService._internal();
  factory EisenhowerFirestoreService() => _instance;
  EisenhowerFirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  /// Nome della collection principale
  static const String _matricesCollection = 'eisenhower_matrices';

  /// Nome della subcollection per le attivita'
  static const String _activitiesSubcollection = 'activities';

  /// Riferimento alla collection delle matrici
  CollectionReference<Map<String, dynamic>> get _matricesRef =>
      _firestore.collection(_matricesCollection);

  /// Riferimento alla subcollection delle attivita' di una matrice
  CollectionReference<Map<String, dynamic>> _activitiesRef(String matrixId) =>
      _matricesRef.doc(matrixId).collection(_activitiesSubcollection);

  // ============================================================
  // MATRICI - CRUD Operations
  // ============================================================

  /// Ottiene tutte le matrici dell'utente corrente
  ///
  /// Ritorna una lista di [EisenhowerMatrixModel] ordinate per data creazione (desc)
  /// Include matrici create dall'utente E matrici dove l'utente è partecipante.
  Future<List<EisenhowerMatrixModel>> getMatrices() async {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) {
      print('⚠️ EisenhowerFirestoreService: Utente non autenticato');
      return [];
    }

    final normalizedEmail = userEmail.toLowerCase();

    try {
      // Query 1: Matrici create dall'utente
      final ownedSnapshot = await _matricesRef
          .where('createdBy', isEqualTo: normalizedEmail)
          .get();

      // Query 2: Matrici dove l'utente è partecipante
      final participantSnapshot = await _matricesRef
          .where('participantEmails', arrayContains: normalizedEmail)
          .get();

      // Combina ed elimina duplicati
      final allMatrices = <String, EisenhowerMatrixModel>{};
      for (final doc in ownedSnapshot.docs) {
        final matrix = EisenhowerMatrixModel.fromFirestore(doc);
        allMatrices[matrix.id] = matrix;
      }
      for (final doc in participantSnapshot.docs) {
        final matrix = EisenhowerMatrixModel.fromFirestore(doc);
        allMatrices[matrix.id] = matrix;
      }

      // Ordina per createdAt descending
      final result = allMatrices.values.toList();
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return result;
    } catch (e) {
      print('❌ Errore getMatrices: $e');
      return [];
    }
  }

  /// Stream real-time delle matrici dell'utente corrente
  ///
  /// Include matrici create dall'utente E matrici dove l'utente è partecipante.
  /// Emette aggiornamenti automatici quando le matrici cambiano.
  Stream<List<EisenhowerMatrixModel>> streamMatrices() {
    final userEmail = _authService.currentUserEmail;
    if (userEmail == null) {
      print('⚠️ EisenhowerFirestoreService: Utente non autenticato');
      return Stream.value([]);
    }

    final normalizedEmail = userEmail.toLowerCase();
    print('🔍 [EISENHOWER] streamMatrices for user: $normalizedEmail');

    // Stream 1: Matrici create dall'utente
    final ownedStream = _matricesRef
        .where('createdBy', isEqualTo: normalizedEmail)
        .snapshots()
        .map((snapshot) {
          print('🔍 [EISENHOWER] Owned matrices: ${snapshot.docs.length}');
          return snapshot.docs
              .map((doc) => EisenhowerMatrixModel.fromFirestore(doc))
              .toList();
        });

    // Stream 2: Matrici dove l'utente è partecipante
    final participantStream = _matricesRef
        .where('participantEmails', arrayContains: normalizedEmail)
        .snapshots()
        .map((snapshot) {
          print('🔍 [EISENHOWER] Participant matrices: ${snapshot.docs.length}');
          for (final doc in snapshot.docs) {
            print('🔍 [EISENHOWER] - Matrix: ${doc.id}, participantEmails: ${doc.data()['participantEmails']}');
          }
          return snapshot.docs
              .map((doc) => EisenhowerMatrixModel.fromFirestore(doc))
              .toList();
        });

    // Combina entrambi gli stream ed elimina duplicati
    return CombineLatestStream.list([
      ownedStream.startWith([]),
      participantStream.startWith([]),
    ]).map((lists) {
      print('🔍 [EISENHOWER] CombineLatestStream emitted: owned=${lists[0].length}, participant=${lists[1].length}');
      final allMatrices = <String, EisenhowerMatrixModel>{};
      for (final list in lists) {
        for (final matrix in list) {
          allMatrices[matrix.id] = matrix; // Usa ID come chiave per evitare duplicati
        }
      }
      print('🔍 [EISENHOWER] Total unique matrices: ${allMatrices.length}');
      // Ordina per createdAt descending
      final result = allMatrices.values.toList();
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return result;
    });
  }

  /// Stream real-time delle matrici di un utente specifico
  ///
  /// Include matrici create dall'utente E matrici dove l'utente è partecipante.
  /// [userEmail] - Email dell'utente di cui ottenere le matrici
  Stream<List<EisenhowerMatrixModel>> streamMatricesByUser(String userEmail) {
    final normalizedEmail = userEmail.toLowerCase();

    // Stream 1: Matrici create dall'utente
    final ownedStream = _matricesRef
        .where('createdBy', isEqualTo: normalizedEmail)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EisenhowerMatrixModel.fromFirestore(doc))
            .toList());

    // Stream 2: Matrici dove l'utente è partecipante
    final participantStream = _matricesRef
        .where('participantEmails', arrayContains: normalizedEmail)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EisenhowerMatrixModel.fromFirestore(doc))
            .toList());

    // Combina entrambi gli stream ed elimina duplicati
    return CombineLatestStream.list([
      ownedStream.startWith([]),
      participantStream.startWith([]),
    ]).map((lists) {
      final allMatrices = <String, EisenhowerMatrixModel>{};
      for (final list in lists) {
        for (final matrix in list) {
          allMatrices[matrix.id] = matrix;
        }
      }
      final result = allMatrices.values.toList();
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return result;
    });
  }

  /// Ottiene una singola matrice per ID
  Future<EisenhowerMatrixModel?> getMatrix(String matrixId) async {
    try {
      final doc = await _matricesRef.doc(matrixId).get();
      if (!doc.exists) return null;
      return EisenhowerMatrixModel.fromFirestore(doc);
    } catch (e) {
      print('❌ Errore getMatrix: $e');
      return null;
    }
  }

  /// Stream real-time di una singola matrice
  Stream<EisenhowerMatrixModel?> streamMatrix(String matrixId) {
    return _matricesRef.doc(matrixId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return EisenhowerMatrixModel.fromFirestore(doc);
    });
  }

  /// Crea una nuova matrice
  ///
  /// [title] - Titolo della matrice (obbligatorio)
  /// [description] - Descrizione opzionale
  /// [createdBy] - Email del creatore (opzionale, usa l'utente corrente se non specificato)
  /// [creatorName] - Nome del creatore (opzionale)
  ///
  /// Il creatore viene automaticamente aggiunto come facilitatore
  ///
  /// Ritorna l'ID della matrice creata o null in caso di errore
  /// Lancia [LimitExceededException] se il limite progetti e' raggiunto
  Future<String?> createMatrix({
    required String title,
    String description = '',
    String? createdBy,
    String? creatorName,
  }) async {
    final userEmail = createdBy?.toLowerCase() ?? _authService.currentUserEmail?.toLowerCase();
    if (userEmail == null) {
      print('❌ createMatrix: Utente non autenticato');
      return null;
    }

    // 🔒 CHECK LIMITE SUBSCRIPTION (limite separato per matrici Eisenhower)
    await _limitsService.enforceProjectLimit(userEmail, entityType: 'eisenhower');

    try {
      final now = DateTime.now();

      // Il creatore diventa automaticamente facilitatore
      final creatorParticipant = EisenhowerParticipantModel(
        email: userEmail,
        name: creatorName ?? userEmail.split('@').first,
        role: EisenhowerParticipantRole.facilitator,
        joinedAt: now,
        isOnline: true,
      );

      final matrix = EisenhowerMatrixModel(
        id: '', // Verra' generato da Firestore
        title: title,
        description: description,
        createdBy: userEmail,
        createdAt: now,
        updatedAt: now,
        participants: {userEmail: creatorParticipant},
        activityCount: 0,
      );

      final docRef = await _matricesRef.add(matrix.toFirestore());
      print('✅ Matrice creata: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('❌ Errore createMatrix: $e');
      return null;
    }
  }

  /// Aggiorna una matrice esistente
  ///
  /// [matrixId] - ID della matrice da aggiornare
  /// [title] - Nuovo titolo (opzionale)
  /// [description] - Nuova descrizione (opzionale)
  ///
  /// Per aggiornare i partecipanti, usa updateAllParticipants() o addParticipantModel()
  Future<bool> updateMatrix({
    required String matrixId,
    String? title,
    String? description,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      };

      if (title != null) data['title'] = title;
      if (description != null) data['description'] = description;

      await _matricesRef.doc(matrixId).update(data);
      print('✅ Matrice aggiornata: $matrixId');
      return true;
    } catch (e) {
      print('❌ Errore updateMatrix: $e');
      return false;
    }
  }

  /// Elimina una matrice e tutte le sue attivita'
  ///
  /// [matrixId] - ID della matrice da eliminare
  ///
  /// Nota: Elimina anche la subcollection activities in batch
  Future<bool> deleteMatrix(String matrixId) async {
    try {
      // Prima elimina tutte le attivita' (subcollection)
      final activitiesSnapshot = await _activitiesRef(matrixId).get();

      if (activitiesSnapshot.docs.isNotEmpty) {
        final batch = _firestore.batch();
        for (final doc in activitiesSnapshot.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
        print('🗑️ Eliminate ${activitiesSnapshot.docs.length} attivita');
      }

      // Poi elimina la matrice
      await _matricesRef.doc(matrixId).delete();

      // ⭐️ Rimuovi dai preferiti
      FavoriteService().removeFavorite(matrixId);

      print('✅ Matrice eliminata: $matrixId');
      return true;
    } catch (e) {
      print('❌ Errore deleteMatrix: $e');
      return false;
    }
  }

  // ============================================================
  // ATTIVITA' - CRUD Operations
  // ============================================================

  /// Ottiene tutte le attivita' di una matrice
  ///
  /// [matrixId] - ID della matrice
  ///
  /// Ritorna una lista di [EisenhowerActivityModel] ordinate per data creazione
  Future<List<EisenhowerActivityModel>> getActivities(String matrixId) async {
    try {
      final snapshot = await _activitiesRef(matrixId)
          .orderBy('createdAt', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => EisenhowerActivityModel.fromFirestore(doc, matrixId))
          .toList();
    } catch (e) {
      print('❌ Errore getActivities: $e');
      return [];
    }
  }

  /// Stream real-time delle attivita' di una matrice
  ///
  /// [matrixId] - ID della matrice
  ///
  /// Emette aggiornamenti automatici quando le attivita' cambiano
  Stream<List<EisenhowerActivityModel>> streamActivities(String matrixId) {
    return _activitiesRef(matrixId)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EisenhowerActivityModel.fromFirestore(doc, matrixId))
            .toList());
  }

  /// Ottiene una singola attivita' per ID
  Future<EisenhowerActivityModel?> getActivity(String matrixId, String activityId) async {
    try {
      final doc = await _activitiesRef(matrixId).doc(activityId).get();
      if (!doc.exists) return null;
      return EisenhowerActivityModel.fromFirestore(doc, matrixId);
    } catch (e) {
      print('❌ Errore getActivity: $e');
      return null;
    }
  }

  /// Crea una nuova attivita' in una matrice
  ///
  /// [matrixId] - ID della matrice
  /// [title] - Titolo dell'attivita' (obbligatorio)
  /// [description] - Descrizione opzionale
  /// [tags] - Lista di tag opzionali
  ///
  /// Ritorna l'ID dell'attivita' creata o null in caso di errore
  /// Aggiorna automaticamente il contatore activityCount della matrice
  /// Lancia [LimitExceededException] se il limite task per entita' e' raggiunto
  Future<String?> createActivity({
    required String matrixId,
    required String title,
    String description = '',
    List<String> tags = const [],
  }) async {
    // 🔒 CHECK LIMITE TASK PER ENTITA'
    await _limitsService.enforceTaskLimit(entityType: 'eisenhower', entityId: matrixId);

    try {
      final activity = EisenhowerActivityModel(
        id: '', // Verra' generato da Firestore
        matrixId: matrixId,
        title: title,
        description: description,
        createdAt: DateTime.now(),
        tags: tags,
        votes: {},
      );

      final docRef = await _activitiesRef(matrixId).add(activity.toFirestore());

      // Aggiorna il contatore nella matrice
      await _matricesRef.doc(matrixId).update({
        'activityCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Attivita creata: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('❌ Errore createActivity: $e');
      return null;
    }
  }

  /// Crea un'attivita' passando direttamente il model
  ///
  /// [activity] - Istanza di EisenhowerActivityModel da salvare
  ///
  /// Utile per creare attivita' con voti gia' impostati
  Future<String?> createActivityFromModel(EisenhowerActivityModel activity) async {
    try {
      final docRef = await _activitiesRef(activity.matrixId).add(activity.toFirestore());

      // Aggiorna il contatore nella matrice
      await _matricesRef.doc(activity.matrixId).update({
        'activityCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Attivita creata da model: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('❌ Errore createActivityFromModel: $e');
      return null;
    }
  }

  /// Aggiorna un'attivita' esistente
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita' da aggiornare
  /// [data] - Map con i campi da aggiornare
  ///
  /// Campi supportati: title, description, tags, votes
  Future<bool> updateActivity(String matrixId, String activityId, Map<String, dynamic> data) async {
    try {
      await _activitiesRef(matrixId).doc(activityId).update(data);

      // Aggiorna updatedAt della matrice
      await _matricesRef.doc(matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Attivita aggiornata: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore updateActivity: $e');
      return false;
    }
  }

  /// Aggiorna un'attivita' passando il model completo
  ///
  /// [activity] - Istanza aggiornata di EisenhowerActivityModel
  Future<bool> updateActivityFromModel(EisenhowerActivityModel activity) async {
    try {
      await _activitiesRef(activity.matrixId).doc(activity.id).update(activity.toFirestore());

      // Aggiorna updatedAt della matrice
      await _matricesRef.doc(activity.matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Attivita aggiornata da model: ${activity.id}');
      return true;
    } catch (e) {
      print('❌ Errore updateActivityFromModel: $e');
      return false;
    }
  }

  /// Elimina un'attivita'
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita' da eliminare
  ///
  /// Aggiorna automaticamente il contatore activityCount della matrice
  Future<bool> deleteActivity({
    required String matrixId,
    required String activityId,
  }) async {
    try {
      await _activitiesRef(matrixId).doc(activityId).delete();

      // Aggiorna il contatore nella matrice
      await _matricesRef.doc(matrixId).update({
        'activityCount': FieldValue.increment(-1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Attivita eliminata: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore deleteActivity: $e');
      return false;
    }
  }

  // ============================================================
  // VOTI - Operations
  // ============================================================

  /// Salva i voti di tutti i partecipanti per un'attivita'
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita'
  /// [votes] - Map dei voti {participantName: EisenhowerVote}
  ///
  /// Aggiorna tutti i voti in una singola operazione
  Future<bool> saveVotes({
    required String matrixId,
    required String activityId,
    required Map<String, EisenhowerVote> votes,
  }) async {
    try {
      // Converti i voti in Map<String, Map>
      final votesData = <String, dynamic>{};
      votes.forEach((participant, vote) {
        votesData[participant] = vote.toMap();
      });

      // Calcola i valori aggregati
      double totalUrgency = 0;
      double totalImportance = 0;
      if (votes.isNotEmpty) {
        for (final vote in votes.values) {
          totalUrgency += vote.urgency;
          totalImportance += vote.importance;
        }
        totalUrgency /= votes.length;
        totalImportance /= votes.length;
      }

      await _activitiesRef(matrixId).doc(activityId).update({
        'votes': votesData,
        'aggregatedUrgency': totalUrgency,
        'aggregatedImportance': totalImportance,
        'voteCount': votes.length,
      });

      // Aggiorna updatedAt della matrice
      await _matricesRef.doc(matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Voti salvati per attivita: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore saveVotes: $e');
      return false;
    }
  }

  /// Aggiunge o aggiorna il voto di un partecipante su un'attivita'
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita'
  /// [participantName] - Nome del partecipante che vota
  /// [vote] - Voto con urgenza e importanza
  Future<bool> addVote({
    required String matrixId,
    required String activityId,
    required String participantName,
    required EisenhowerVote vote,
  }) async {
    try {
      // Ottieni l'attivita' corrente
      final activity = await getActivity(matrixId, activityId);
      if (activity == null) {
        print('❌ Attivita non trovata: $activityId');
        return false;
      }

      // Aggiungi il voto
      final updatedActivity = activity.withVote(participantName, vote);

      // Salva
      return await updateActivityFromModel(updatedActivity);
    } catch (e) {
      print('❌ Errore addVote: $e');
      return false;
    }
  }

  /// Rimuove il voto di un partecipante da un'attivita'
  Future<bool> removeVote({
    required String matrixId,
    required String activityId,
    required String participantName,
  }) async {
    try {
      final activity = await getActivity(matrixId, activityId);
      if (activity == null) return false;

      final updatedActivity = activity.withoutVote(participantName);
      return await updateActivityFromModel(updatedActivity);
    } catch (e) {
      print('❌ Errore removeVote: $e');
      return false;
    }
  }

  /// Aggiorna tutti i voti di un'attivita' in una sola operazione
  ///
  /// Utile per sessioni di voto batch
  Future<bool> updateAllVotes({
    required String matrixId,
    required String activityId,
    required Map<String, EisenhowerVote> votes,
  }) async {
    try {
      final activity = await getActivity(matrixId, activityId);
      if (activity == null) return false;

      final updatedActivity = activity.withAllVotes(votes);
      return await updateActivityFromModel(updatedActivity);
    } catch (e) {
      print('❌ Errore updateAllVotes: $e');
      return false;
    }
  }

  // ============================================================
  // PARTECIPANTI - Operations (Nuovo formato Map con email)
  // ============================================================

  /// Aggiunge un partecipante alla matrice con dati completi
  ///
  /// [matrixId] - ID della matrice
  /// [participant] - Dati completi del partecipante
  Future<bool> addParticipantModel(String matrixId, EisenhowerParticipantModel participant) async {
    try {
      final escapedEmail = EisenhowerParticipantModel.escapeEmail(participant.email.toLowerCase());
      await _matricesRef.doc(matrixId).update({
        'participants.$escapedEmail': participant.copyWith(email: participant.email.toLowerCase()).toMap(),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('✅ Partecipante aggiunto: ${participant.email}');
      return true;
    } catch (e) {
      print('❌ Errore addParticipantModel: $e');
      return false;
    }
  }

  /// Rimuove un partecipante dalla matrice per email
  ///
  /// Nota: I voti del partecipante nelle attivita' NON vengono rimossi automaticamente
  Future<bool> removeParticipantByEmail(String matrixId, String email) async {
    try {
      final escapedEmail = EisenhowerParticipantModel.escapeEmail(email.toLowerCase());
      await _matricesRef.doc(matrixId).update({
        'participants.$escapedEmail': FieldValue.delete(),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('✅ Partecipante rimosso: $email');
      return true;
    } catch (e) {
      print('❌ Errore removeParticipantByEmail: $e');
      return false;
    }
  }

  /// Aggiorna lo stato online di un partecipante
  Future<bool> updateParticipantOnlineStatus(String matrixId, String email, bool isOnline) async {
    try {
      final escapedEmail = EisenhowerParticipantModel.escapeEmail(email.toLowerCase());
      await _matricesRef.doc(matrixId).update({
        'participants.$escapedEmail.isOnline': isOnline,
        'participants.$escapedEmail.lastActivity': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      return true;
    } catch (e) {
      print('❌ Errore updateParticipantOnlineStatus: $e');
      return false;
    }
  }

  /// Aggiorna il ruolo di un partecipante
  Future<bool> updateParticipantRole(String matrixId, String email, EisenhowerParticipantRole role) async {
    try {
      final escapedEmail = EisenhowerParticipantModel.escapeEmail(email.toLowerCase());
      await _matricesRef.doc(matrixId).update({
        'participants.$escapedEmail.role': role.name,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('✅ Ruolo aggiornato per $email: ${role.name}');
      return true;
    } catch (e) {
      print('❌ Errore updateParticipantRole: $e');
      return false;
    }
  }

  /// Aggiorna tutti i partecipanti in batch (sostituisce tutti)
  Future<bool> updateAllParticipants(String matrixId, Map<String, EisenhowerParticipantModel> participants) async {
    try {
      final participantsData = <String, dynamic>{};
      participants.forEach((email, participant) {
        final escapedEmail = EisenhowerParticipantModel.escapeEmail(email.toLowerCase());
        participantsData[escapedEmail] = participant.toMap();
      });

      await _matricesRef.doc(matrixId).update({
        'participants': participantsData,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('✅ Partecipanti aggiornati: ${participants.length}');
      return true;
    } catch (e) {
      print('❌ Errore updateAllParticipants: $e');
      return false;
    }
  }

  /// Aggiunge un partecipante alla lista pending
  Future<bool> addPendingParticipant(String matrixId, String email) async {
    try {
      await _matricesRef.doc(matrixId).update({
        'pendingEmails': FieldValue.arrayUnion([email.toLowerCase()]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('⏳ Pending aggiunto: $email');
      return true;
    } catch (e) {
      print('❌ Errore addPendingParticipant: $e');
      return false;
    }
  }

  /// Promuove un partecipante da pending ad attivo
  Future<bool> promotePendingToActive(String matrixId, EisenhowerParticipantModel participant) async {
    try {
      final escapedEmail = EisenhowerParticipantModel.escapeEmail(participant.email);
       // Batch update atomico
      await _matricesRef.doc(matrixId).update({
        'pendingEmails': FieldValue.arrayRemove([participant.email.toLowerCase()]),
        'participants.$escapedEmail': participant.copyWith(email: participant.email.toLowerCase()).toMap(),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('✅ Promosso da Pending ad Attivo: ${participant.email}');
      return true;
    } catch (e) {
      print('❌ Errore promotePendingToActive: $e');
      return false;
    }
  }

  // ============================================================
  // VOTAZIONE INDIPENDENTE - Session Management
  // ============================================================

  /// Avvia una sessione di votazione collettiva su un'attivita'
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita'
  ///
  /// Imposta isVotingActive=true e PRESERVA i voti pre-esistenti.
  /// I votanti che hanno gia' votato vengono automaticamente aggiunti a readyVoters.
  /// Nasconde i valori aggregati fino al reveal.
  Future<bool> startVotingSession(String matrixId, String activityId) async {
    try {
      // Prima ottieni l'attivita' per vedere se ci sono gia' voti
      final activity = await getActivity(matrixId, activityId);

      // Raccogli le email dei votanti che hanno gia' votato (pre-voti)
      final List<String> preVoters = activity?.votes.keys.toList() ?? [];

      print('🗳️ Avvio votazione - Pre-voti esistenti: ${preVoters.length}');

      await _activitiesRef(matrixId).doc(activityId).update({
        'isVotingActive': true,
        'isRevealed': false,
        'votingStartedAt': Timestamp.fromDate(DateTime.now()),
        'revealedAt': null,
        // Sincronizza readyVoters con chi ha gia' votato
        'readyVoters': preVoters,
        // NON resetta i voti! Preserva i pre-voti esistenti
        // 'votes': {}, // ❌ RIMOSSO - non cancellare i pre-voti
        // Nasconde gli aggregati fino al reveal (PMI best practice)
        'aggregatedUrgency': 0,
        'aggregatedImportance': 0,
        'quadrant': null,
        'voteCount': 0, // Il count reale sara' calcolato al reveal
      });

      await _matricesRef.doc(matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Sessione votazione avviata per attivita: $activityId (${preVoters.length} pre-voti preservati)');
      return true;
    } catch (e) {
      print('❌ Errore startVotingSession: $e');
      return false;
    }
  }

  /// Invia un voto durante la votazione indipendente (nascosto fino al reveal)
  ///
  /// Il voto viene salvato ma non sara' visibile agli altri fino al reveal
  Future<bool> submitBlindedVote({
    required String matrixId,
    required String activityId,
    required String voterEmail,
    required EisenhowerVote vote,
  }) async {
    try {
      final escapedEmail = EisenhowerParticipantModel.escapeEmail(voterEmail);

      await _activitiesRef(matrixId).doc(activityId).update({
        'votes.$escapedEmail': vote.toMap(),
      });

      print('✅ Voto nascosto salvato per: $voterEmail');
      return true;
    } catch (e) {
      print('❌ Errore submitBlindedVote: $e');
      return false;
    }
  }

  /// Marca un votante come pronto (ha completato il suo voto)
  ///
  /// Usato per mostrare agli altri chi ha gia' votato senza rivelare il voto
  Future<bool> markVoterReady({
    required String matrixId,
    required String activityId,
    required String voterEmail,
  }) async {
    try {
      await _activitiesRef(matrixId).doc(activityId).update({
        'readyVoters': FieldValue.arrayUnion([voterEmail]),
      });

      print('✅ Votante pronto: $voterEmail');
      return true;
    } catch (e) {
      print('❌ Errore markVoterReady: $e');
      return false;
    }
  }

  /// Rimuove un votante dalla lista dei pronti (es. se modifica il voto)
  Future<bool> unmarkVoterReady({
    required String matrixId,
    required String activityId,
    required String voterEmail,
  }) async {
    try {
      await _activitiesRef(matrixId).doc(activityId).update({
        'readyVoters': FieldValue.arrayRemove([voterEmail]),
      });
      return true;
    } catch (e) {
      print('❌ Errore unmarkVoterReady: $e');
      return false;
    }
  }

  /// Rivela tutti i voti e calcola gli aggregati
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita'
  ///
  /// Imposta isRevealed=true e calcola urgenza/importanza aggregate
  Future<bool> revealVotes(String matrixId, String activityId) async {
    try {
      // Ottieni l'attivita' per calcolare gli aggregati
      final activity = await getActivity(matrixId, activityId);
      if (activity == null) return false;

      // Calcola i valori aggregati
      double totalUrgency = 0;
      double totalImportance = 0;
      String? quadrant;

      if (activity.votes.isNotEmpty) {
        for (final vote in activity.votes.values) {
          totalUrgency += vote.urgency;
          totalImportance += vote.importance;
        }
        totalUrgency /= activity.votes.length;
        totalImportance /= activity.votes.length;

        // Calcola il quadrante
        quadrant = EisenhowerQuadrantExtension.calculateQuadrant(
          totalUrgency,
          totalImportance,
        ).name;
      }

      await _activitiesRef(matrixId).doc(activityId).update({
        'isRevealed': true,
        'isVotingActive': false,
        'revealedAt': Timestamp.fromDate(DateTime.now()),
        'aggregatedUrgency': totalUrgency,
        'aggregatedImportance': totalImportance,
        'quadrant': quadrant,
        'voteCount': activity.votes.length,
      });

      await _matricesRef.doc(matrixId).update({
        'votedActivityCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Voti rivelati per attivita: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore revealVotes: $e');
      return false;
    }
  }

  /// Resetta la sessione di votazione (torna allo stato iniziale)
  Future<bool> resetVotingSession(String matrixId, String activityId) async {
    try {
      // Controlla se l'attivita' era gia' rivelata per decrementare il contatore
      final activity = await getActivity(matrixId, activityId);
      final wasRevealed = activity?.isRevealed ?? false;

      await _activitiesRef(matrixId).doc(activityId).update({
        'isVotingActive': false,
        'isRevealed': false,
        'votingStartedAt': null,
        'revealedAt': null,
        'readyVoters': [],
        'votes': {},
        'aggregatedUrgency': 0,
        'aggregatedImportance': 0,
        'quadrant': null,
        'voteCount': 0,
      });

      await _matricesRef.doc(matrixId).update({
        if (wasRevealed) 'votedActivityCount': FieldValue.increment(-1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Sessione votazione resettata per attivita: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore resetVotingSession: $e');
      return false;
    }
  }

  // ============================================================
  // VOTAZIONE INDIPENDENTE - Real-time Streams
  // ============================================================

  /// Stream real-time di una singola attivita'
  ///
  /// Usato per monitorare lo stato della votazione in tempo reale
  Stream<EisenhowerActivityModel?> streamActivity(String matrixId, String activityId) {
    return _activitiesRef(matrixId).doc(activityId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return EisenhowerActivityModel.fromFirestore(doc, matrixId);
    });
  }

  /// Stream dei votanti pronti per un'attivita'
  ///
  /// Emette la lista aggiornata ogni volta che qualcuno completa il voto
  Stream<List<String>> streamReadyVoters(String matrixId, String activityId) {
    return _activitiesRef(matrixId).doc(activityId).snapshots().map((doc) {
      if (!doc.exists) return [];
      final data = doc.data();
      if (data == null) return [];
      return List<String>.from(data['readyVoters'] ?? []);
    });
  }

  /// Verifica se tutti i votanti hanno completato
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita'
  /// [voterEmails] - Lista delle email di tutti i votanti attesi
  Future<bool> areAllVotersReady(String matrixId, String activityId, List<String> voterEmails) async {
    try {
      final activity = await getActivity(matrixId, activityId);
      if (activity == null) return false;
      return activity.areAllVotersReady(voterEmails);
    } catch (e) {
      print('❌ Errore areAllVotersReady: $e');
      return false;
    }
  }

  // ============================================================
  // UTILITY - Helper Methods
  // ============================================================

  /// Verifica se l'utente corrente e' il creatore di una matrice
  Future<bool> isMatrixOwner(String matrixId) async {
    final matrix = await getMatrix(matrixId);
    if (matrix == null) return false;
    return matrix.createdBy == _authService.currentUserEmail;
  }

  /// Ottiene le statistiche di una matrice
  ///
  /// Ritorna una Map con:
  /// - totalActivities: numero totale di attivita'
  /// - votedActivities: attivita' con almeno un voto
  /// - quadrantCounts: conteggio per quadrante
  Future<Map<String, dynamic>> getMatrixStatistics(String matrixId) async {
    final activities = await getActivities(matrixId);

    return {
      'totalActivities': activities.length,
      'votedActivities': activities.where((a) => a.hasVotes).length,
      'quadrantCounts': activities.quadrantCounts,
      'totalVotes': activities.fold<int>(0, (sum, a) => sum + a.voteCount),
    };
  }

  /// Duplica una matrice (senza voti)
  ///
  /// Crea una copia della matrice con tutte le attivita' ma senza i voti
  /// I partecipanti vengono copiati dalla matrice originale
  Future<String?> duplicateMatrix(String matrixId, {String? newTitle}) async {
    try {
      final matrix = await getMatrix(matrixId);
      if (matrix == null) return null;

      // Crea la nuova matrice (l'utente corrente sara' il nuovo facilitatore)
      final newMatrixId = await createMatrix(
        title: newTitle ?? '${matrix.title} (copia)',
        description: matrix.description,
      );

      if (newMatrixId == null) return null;

      // Copia i partecipanti dalla matrice originale (escluso il creatore gia' aggiunto)
      if (matrix.participants.isNotEmpty) {
        final userEmail = _authService.currentUserEmail;
        final participantsToCopy = Map<String, EisenhowerParticipantModel>.from(matrix.participants);

        // Rimuovi l'utente corrente se presente (e' gia' stato aggiunto come facilitatore)
        if (userEmail != null) {
          participantsToCopy.remove(userEmail);
        }

        // Aggiungi gli altri partecipanti
        for (final participant in participantsToCopy.values) {
          await addParticipantModel(newMatrixId, participant.copyWith(
            joinedAt: DateTime.now(),
            isOnline: false,
          ));
        }
      }

      // Copia le attivita' (senza voti)
      final activities = await getActivities(matrixId);
      for (final activity in activities) {
        await createActivity(
          matrixId: newMatrixId,
          title: activity.title,
          description: activity.description,
          tags: activity.tags,
        );
      }

      print('✅ Matrice duplicata: $matrixId -> $newMatrixId');
      return newMatrixId;
    } catch (e) {
      print('❌ Errore duplicateMatrix: $e');
      return null;
    }
  }

  /// Resetta tutti i voti di una matrice
  ///
  /// Rimuove tutti i voti da tutte le attivita' della matrice
  Future<bool> resetAllVotes(String matrixId) async {
    try {
      final activities = await getActivities(matrixId);

      final batch = _firestore.batch();
      for (final activity in activities) {
        final ref = _activitiesRef(matrixId).doc(activity.id);
        batch.update(ref, {
          'votes': {},
          'aggregatedUrgency': 0,
          'aggregatedImportance': 0,
          'quadrant': null,
          'voteCount': 0,
        });
      }

      await batch.commit();

      // Aggiorna updatedAt della matrice
      await _matricesRef.doc(matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Voti resettati per matrice: $matrixId');
      return true;
    } catch (e) {
      print('❌ Errore resetAllVotes: $e');
      return false;
    }
  }

  // ============================================================
  // RACI - Colonne e Assegnazioni
  // ============================================================

  /// Aggiorna le colonne RACI di una matrice
  ///
  /// [matrixId] - ID della matrice
  /// [columns] - Lista delle colonne RACI da salvare
  Future<bool> updateRaciColumns(String matrixId, List<RaciColumn> columns) async {
    try {
      final columnsData = columns.map((col) => col.toMap()).toList();

      await _matricesRef.doc(matrixId).update({
        'raciColumns': columnsData,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Colonne RACI aggiornate: ${columns.length}');
      return true;
    } catch (e) {
      print('❌ Errore updateRaciColumns: $e');
      return false;
    }
  }

  /// Aggiunge una colonna RACI alla matrice
  ///
  /// [matrixId] - ID della matrice
  /// [column] - Colonna RACI da aggiungere
  Future<bool> addRaciColumn(String matrixId, RaciColumn column) async {
    try {
      await _matricesRef.doc(matrixId).update({
        'raciColumns': FieldValue.arrayUnion([column.toMap()]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Colonna RACI aggiunta: ${column.name}');
      return true;
    } catch (e) {
      print('❌ Errore addRaciColumn: $e');
      return false;
    }
  }

  /// Rimuove una colonna RACI dalla matrice
  ///
  /// [matrixId] - ID della matrice
  /// [columnId] - ID della colonna da rimuovere
  ///
  /// Nota: Rimuove anche le assegnazioni RACI dalle attivita'
  Future<bool> removeRaciColumn(String matrixId, String columnId) async {
    try {
      // Prima ottieni la matrice per trovare la colonna da rimuovere
      final matrix = await getMatrix(matrixId);
      if (matrix == null) return false;

      final columnToRemove = matrix.raciColumns
          .where((col) => col.id == columnId)
          .firstOrNull;

      if (columnToRemove == null) {
        print('⚠️ Colonna RACI non trovata: $columnId');
        return false;
      }

      // Rimuovi la colonna
      await _matricesRef.doc(matrixId).update({
        'raciColumns': FieldValue.arrayRemove([columnToRemove.toMap()]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      // Rimuovi le assegnazioni RACI dalle attivita' per questa colonna
      final activities = await getActivities(matrixId);
      final batch = _firestore.batch();

      for (final activity in activities) {
        if (activity.raciAssignments.containsKey(columnId)) {
          batch.update(_activitiesRef(matrixId).doc(activity.id), {
            'raciAssignments.$columnId': FieldValue.delete(),
          });
        }
      }

      await batch.commit();

      print('✅ Colonna RACI rimossa: $columnId');
      return true;
    } catch (e) {
      print('❌ Errore removeRaciColumn: $e');
      return false;
    }
  }

  /// Aggiorna le assegnazioni RACI di un'attivita'
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita'
  /// [assignments] - Map delle assegnazioni {columnId: RaciRole}
  Future<bool> updateActivityRaci(
    String matrixId,
    String activityId,
    Map<String, RaciRole> assignments,
  ) async {
    try {
      // Serializza le assegnazioni
      final raciData = <String, String>{};
      assignments.forEach((key, value) {
        raciData[key] = value.name;
      });

      await _activitiesRef(matrixId).doc(activityId).update({
        'raciAssignments': raciData,
      });

      await _matricesRef.doc(matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Assegnazioni RACI aggiornate per attivita: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore updateActivityRaci: $e');
      return false;
    }
  }

  /// Imposta un singolo ruolo RACI per un'attivita'
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita'
  /// [columnId] - ID della colonna RACI
  /// [role] - Ruolo RACI da assegnare (null per rimuovere)
  Future<bool> setActivityRaciRole(
    String matrixId,
    String activityId,
    String columnId,
    RaciRole? role,
  ) async {
    try {
      if (role == null) {
        // Rimuovi l'assegnazione
        await _activitiesRef(matrixId).doc(activityId).update({
          'raciAssignments.$columnId': FieldValue.delete(),
        });
      } else {
        // Imposta l'assegnazione
        await _activitiesRef(matrixId).doc(activityId).update({
          'raciAssignments.$columnId': role.name,
        });
      }

      await _matricesRef.doc(matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Ruolo RACI ${role?.name ?? 'rimosso'} per colonna $columnId');
      return true;
    } catch (e) {
      print('❌ Errore setActivityRaciRole: $e');
      return false;
    }
  }

  /// Ottiene le attivita' filtrate per ruolo RACI
  ///
  /// [matrixId] - ID della matrice
  /// [columnId] - ID della colonna RACI
  /// [role] - Ruolo RACI da filtrare
  Future<List<EisenhowerActivityModel>> getActivitiesByRaciRole(
    String matrixId,
    String columnId,
    RaciRole role,
  ) async {
    try {
      final activities = await getActivities(matrixId);
      return activities
          .where((a) => a.raciAssignments[columnId] == role)
          .toList();
    } catch (e) {
      print('❌ Errore getActivitiesByRaciRole: $e');
      return [];
    }
  }

  /// Resetta tutte le assegnazioni RACI di una matrice
  Future<bool> resetAllRaciAssignments(String matrixId) async {
    try {
      final activities = await getActivities(matrixId);

      final batch = _firestore.batch();
      for (final activity in activities) {
        if (activity.raciAssignments.isNotEmpty) {
          batch.update(_activitiesRef(matrixId).doc(activity.id), {
            'raciAssignments': {},
          });
        }
      }

      await batch.commit();

      await _matricesRef.doc(matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Assegnazioni RACI resettate per matrice: $matrixId');
      return true;
    } catch (e) {
      print('❌ Errore resetAllRaciAssignments: $e');
      return false;
    }
  }

  // ============================================================
  // ARCHIVIAZIONE - Matrici
  // ============================================================

  /// Archivia una matrice
  ///
  /// [matrixId] - ID della matrice da archiviare
  ///
  /// Le matrici archiviate sono escluse dai conteggi subscription
  /// e non appaiono nelle liste di default
  Future<bool> archiveMatrix(String matrixId) async {
    try {
      await _matricesRef.doc(matrixId).update({
        'isArchived': true,
        'archivedAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('🗄️ Matrice archiviata: $matrixId');
      return true;
    } catch (e) {
      print('❌ Errore archiveMatrix: $e');
      return false;
    }
  }

  /// Ripristina una matrice archiviata
  ///
  /// [matrixId] - ID della matrice da ripristinare
  Future<bool> restoreMatrix(String matrixId) async {
    try {
      await _matricesRef.doc(matrixId).update({
        'isArchived': false,
        'archivedAt': null,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      print('📦 Matrice ripristinata: $matrixId');
      return true;
    } catch (e) {
      print('❌ Errore restoreMatrix: $e');
      return false;
    }
  }

  /// Stream delle matrici con filtro archivio
  ///
  /// [userEmail] - Email dell'utente
  /// [includeArchived] - Se true, include anche le archiviate
  Stream<List<EisenhowerMatrixModel>> streamMatricesFiltered({
    required String userEmail,
    bool includeArchived = false,
  }) {
    final normalizedEmail = userEmail.toLowerCase();
    print('🔍 [EISENHOWER] streamMatricesFiltered for: $normalizedEmail');

    // Stream 1: Matrici create dall'utente
    final ownedStream = _matricesRef
        .where('createdBy', isEqualTo: normalizedEmail)
        .snapshots()
        .map((snapshot) {
          print('🔍 [EISENHOWER] Owned matrices found: ${snapshot.docs.length}');
          return snapshot.docs
              .map((doc) => EisenhowerMatrixModel.fromFirestore(doc))
              .toList();
        });

    // Stream 2: Matrici dove l'utente è partecipante
    final participantStream = _matricesRef
        .where('participantEmails', arrayContains: normalizedEmail)
        .snapshots()
        .map((snapshot) {
          print('🔍 [EISENHOWER] Participant matrices found: ${snapshot.docs.length}');
          return snapshot.docs
              .map((doc) => EisenhowerMatrixModel.fromFirestore(doc))
              .toList();
        });

    // Combina entrambi gli stream ed elimina duplicati
    return CombineLatestStream.list([
      ownedStream.startWith([]),
      participantStream.startWith([]),
    ]).map((lists) {
      final allMatrices = <String, EisenhowerMatrixModel>{};
      for (final list in lists) {
        for (final matrix in list) {
          allMatrices[matrix.id] = matrix;
        }
      }

      var matrices = allMatrices.values.toList();
      print('🔍 [EISENHOWER] Total unique matrices: ${matrices.length}');

      // Filtro client-side per isArchived
      if (!includeArchived) {
        matrices = matrices.where((m) => m.isArchived != true).toList();
      }

      // Ordina per createdAt descending
      matrices.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return matrices;
    });
  }

  // ============================================================
  // ARCHIVIAZIONE - Attivita'
  // ============================================================

  /// Marca un'attivita' come completata
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita' da completare
  Future<bool> markActivityCompleted(String matrixId, String activityId) async {
    try {
      await _activitiesRef(matrixId).doc(activityId).update({
        'isCompleted': true,
        'completedAt': Timestamp.fromDate(DateTime.now()),
      });

      await _matricesRef.doc(matrixId).update({
        'completedActivityCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('✅ Attivita completata: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore markActivityCompleted: $e');
      return false;
    }
  }

  /// Rimuove lo stato completato da un'attivita'
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita'
  Future<bool> markActivityIncomplete(String matrixId, String activityId) async {
    try {
      await _activitiesRef(matrixId).doc(activityId).update({
        'isCompleted': false,
        'completedAt': null,
      });

      await _matricesRef.doc(matrixId).update({
        'completedActivityCount': FieldValue.increment(-1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('⏪ Attivita riaperta: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore markActivityIncomplete: $e');
      return false;
    }
  }

  /// Archivia un'attivita'
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita' da archiviare
  Future<bool> archiveActivity(String matrixId, String activityId) async {
    try {
      await _activitiesRef(matrixId).doc(activityId).update({
        'isArchived': true,
        'archivedAt': Timestamp.fromDate(DateTime.now()),
      });

      await _matricesRef.doc(matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('🗄️ Attivita archiviata: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore archiveActivity: $e');
      return false;
    }
  }

  /// Ripristina un'attivita' archiviata
  ///
  /// [matrixId] - ID della matrice
  /// [activityId] - ID dell'attivita' da ripristinare
  Future<bool> restoreActivity(String matrixId, String activityId) async {
    try {
      await _activitiesRef(matrixId).doc(activityId).update({
        'isArchived': false,
        'archivedAt': null,
      });

      await _matricesRef.doc(matrixId).update({
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      print('📦 Attivita ripristinata: $activityId');
      return true;
    } catch (e) {
      print('❌ Errore restoreActivity: $e');
      return false;
    }
  }

  /// Stream delle attivita' con filtro archivio/completamento
  ///
  /// [matrixId] - ID della matrice
  /// [includeArchived] - Se true, include anche le archiviate
  /// [includeCompleted] - Se true, include anche le completate
  Stream<List<EisenhowerActivityModel>> streamActivitiesFiltered({
    required String matrixId,
    bool includeArchived = false,
    bool includeCompleted = true,
  }) {
    Query<Map<String, dynamic>> query = _activitiesRef(matrixId)
        .orderBy('createdAt', descending: false);

    // Nota: Firestore non supporta query multiple con != su campi diversi
    // Quindi filtriamo lato client se necessario per combinazioni complesse
    return query.snapshots().map((snapshot) {
      var activities = snapshot.docs
          .map((doc) => EisenhowerActivityModel.fromFirestore(doc, matrixId))
          .toList();

      if (!includeArchived) {
        activities = activities.where((a) => !a.isArchived).toList();
      }
      if (!includeCompleted) {
        activities = activities.where((a) => !a.isCompleted).toList();
      }

      return activities;
    });
  }
}
