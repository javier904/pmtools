import 'package:cloud_firestore/cloud_firestore.dart';
import 'eisenhower_matrix_model.dart';
import 'raci_models.dart';

/// Modello per un singolo voto di un partecipante
class EisenhowerVote {
  final int urgency; // 1-10
  final int importance; // 1-10

  const EisenhowerVote({
    required this.urgency,
    required this.importance,
  });

  /// Crea da Map
  factory EisenhowerVote.fromMap(Map<String, dynamic> map) {
    return EisenhowerVote(
      urgency: (map['urgency'] ?? 5) as int,
      importance: (map['importance'] ?? 5) as int,
    );
  }

  /// Converte in Map
  Map<String, dynamic> toMap() {
    return {
      'urgency': urgency,
      'importance': importance,
    };
  }

  @override
  String toString() => 'Vote(urgency: $urgency, importance: $importance)';
}

/// Modello per un'attività nella Matrice di Eisenhower
///
/// Contiene i voti di tutti i partecipanti embedded come Map
/// e calcola automaticamente il quadrante basato sulla media dei voti.
/// Supporta sia votazione rapida (visibile) che indipendente (con reveal).
class EisenhowerActivityModel {
  final String id;
  final String matrixId;
  final String title;
  final String description;
  final DateTime createdAt;
  final List<String> tags;
  final Map<String, EisenhowerVote> votes; // {participantEmail: vote}

  // Campi per votazione indipendente
  final bool isVotingActive;       // Sessione di voto indipendente in corso
  final bool isRevealed;           // Voti sono stati rivelati
  final DateTime? votingStartedAt; // Quando è iniziata la sessione di voto
  final DateTime? revealedAt;      // Quando i voti sono stati rivelati
  final List<String> readyVoters;  // Email dei votanti che hanno completato

  // Campi RACI
  final Map<String, RaciRole> raciAssignments; // {columnId: RaciRole}

  // Campi completamento e archiviazione
  final bool isCompleted;
  final bool isArchived;
  final DateTime? completedAt;
  final DateTime? archivedAt;

  // Valori calcolati (cached)
  double? _cachedUrgency;
  double? _cachedImportance;
  EisenhowerQuadrant? _cachedQuadrant;

  EisenhowerActivityModel({
    required this.id,
    required this.matrixId,
    required this.title,
    this.description = '',
    required this.createdAt,
    this.tags = const [],
    this.votes = const {},
    this.isVotingActive = false,
    this.isRevealed = false,
    this.votingStartedAt,
    this.revealedAt,
    this.readyVoters = const [],
    this.raciAssignments = const {},
    this.isCompleted = false,
    this.isArchived = false,
    this.completedAt,
    this.archivedAt,
  });

  /// Crea un'istanza da documento Firestore
  factory EisenhowerActivityModel.fromFirestore(DocumentSnapshot doc, String matrixId) {
    final data = doc.data() as Map<String, dynamic>;

    // Parsing dei voti
    final votesMap = <String, EisenhowerVote>{};
    final votesData = data['votes'] as Map<String, dynamic>? ?? {};
    votesData.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        votesMap[key] = EisenhowerVote.fromMap(value);
      }
    });

    // Parsing RACI assignments
    final raciMap = <String, RaciRole>{};
    final raciData = data['raciAssignments'] as Map<String, dynamic>? ?? {};
    raciData.forEach((key, value) {
      if (value is String) {
        final role = RaciRole.values.where((r) => r.name == value).firstOrNull;
        if (role != null) {
          raciMap[key] = role;
        }
      }
    });

    return EisenhowerActivityModel(
      id: doc.id,
      matrixId: matrixId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      tags: List<String>.from(data['tags'] ?? []),
      votes: votesMap,
      isVotingActive: data['isVotingActive'] ?? false,
      isRevealed: data['isRevealed'] ?? false,
      votingStartedAt: (data['votingStartedAt'] as Timestamp?)?.toDate(),
      revealedAt: (data['revealedAt'] as Timestamp?)?.toDate(),
      readyVoters: List<String>.from(data['readyVoters'] ?? []),
      raciAssignments: raciMap,
      isCompleted: data['isCompleted'] ?? false,
      isArchived: data['isArchived'] ?? false,
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      archivedAt: (data['archivedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Converte in Map per Firestore
  Map<String, dynamic> toFirestore() {
    final votesData = <String, dynamic>{};
    votes.forEach((key, value) {
      votesData[key] = value.toMap();
    });

    // Serializza RACI assignments
    final raciData = <String, String>{};
    raciAssignments.forEach((key, value) {
      raciData[key] = value.name;
    });

    return {
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'tags': tags,
      'votes': votesData,
      // Salva anche i valori aggregati per query efficienti
      'aggregatedUrgency': aggregatedUrgency,
      'aggregatedImportance': aggregatedImportance,
      'quadrant': quadrant?.name,
      'voteCount': voteCount,
      // Campi votazione indipendente
      'isVotingActive': isVotingActive,
      'isRevealed': isRevealed,
      if (votingStartedAt != null) 'votingStartedAt': Timestamp.fromDate(votingStartedAt!),
      if (revealedAt != null) 'revealedAt': Timestamp.fromDate(revealedAt!),
      'readyVoters': readyVoters,
      // Campi RACI
      'raciAssignments': raciData,
      // Campi completamento e archiviazione
      'isCompleted': isCompleted,
      'isArchived': isArchived,
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
      if (archivedAt != null) 'archivedAt': Timestamp.fromDate(archivedAt!),
    };
  }

  /// Numero di voti ricevuti
  int get voteCount => votes.length;

  /// True se l'attività ha almeno un voto
  bool get hasVotes => votes.isNotEmpty;

  /// Urgenza media aggregata (1-10)
  double get aggregatedUrgency {
    if (_cachedUrgency != null) return _cachedUrgency!;
    if (votes.isEmpty) return 0;

    final sum = votes.values.fold<int>(0, (sum, vote) => sum + vote.urgency);
    _cachedUrgency = sum / votes.length;
    return _cachedUrgency!;
  }

  /// Importanza media aggregata (1-10)
  double get aggregatedImportance {
    if (_cachedImportance != null) return _cachedImportance!;
    if (votes.isEmpty) return 0;

    final sum = votes.values.fold<int>(0, (sum, vote) => sum + vote.importance);
    _cachedImportance = sum / votes.length;
    return _cachedImportance!;
  }

  /// Quadrante calcolato dalla media dei voti
  EisenhowerQuadrant? get quadrant {
    if (!hasVotes) return null;
    if (_cachedQuadrant != null) return _cachedQuadrant!;

    _cachedQuadrant = EisenhowerQuadrantExtension.calculateQuadrant(
      aggregatedUrgency,
      aggregatedImportance,
    );
    return _cachedQuadrant;
  }

  /// Lista dei partecipanti che hanno votato
  List<String> get voters => votes.keys.toList();

  /// Lista dei partecipanti che NON hanno votato (rispetto alla lista completa)
  List<String> getMissingVoters(List<String> allParticipants) {
    return allParticipants.where((p) => !votes.containsKey(p)).toList();
  }

  /// Ottiene il voto di un partecipante specifico
  EisenhowerVote? getVote(String participantName) => votes[participantName];

  /// Crea una copia con modifiche
  EisenhowerActivityModel copyWith({
    String? id,
    String? matrixId,
    String? title,
    String? description,
    DateTime? createdAt,
    List<String>? tags,
    Map<String, EisenhowerVote>? votes,
    bool? isVotingActive,
    bool? isRevealed,
    DateTime? votingStartedAt,
    DateTime? revealedAt,
    List<String>? readyVoters,
    Map<String, RaciRole>? raciAssignments,
    bool? isCompleted,
    bool? isArchived,
    DateTime? completedAt,
    DateTime? archivedAt,
  }) {
    return EisenhowerActivityModel(
      id: id ?? this.id,
      matrixId: matrixId ?? this.matrixId,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      votes: votes ?? this.votes,
      isVotingActive: isVotingActive ?? this.isVotingActive,
      isRevealed: isRevealed ?? this.isRevealed,
      votingStartedAt: votingStartedAt ?? this.votingStartedAt,
      revealedAt: revealedAt ?? this.revealedAt,
      readyVoters: readyVoters ?? this.readyVoters,
      raciAssignments: raciAssignments ?? this.raciAssignments,
      isCompleted: isCompleted ?? this.isCompleted,
      isArchived: isArchived ?? this.isArchived,
      completedAt: completedAt ?? this.completedAt,
      archivedAt: archivedAt ?? this.archivedAt,
    );
  }

  // ============================================================
  // HELPER per Votazione Indipendente
  // ============================================================

  /// Verifica se la votazione indipendente è in corso
  bool get isIndependentVotingInProgress => isVotingActive && !isRevealed;

  /// Verifica se un partecipante ha votato (nella votazione indipendente)
  bool hasVoterReady(String email) => readyVoters.contains(email);

  /// Numero di votanti pronti
  int get readyVoterCount => readyVoters.length;

  /// Verifica se tutti i partecipanti hanno votato
  bool areAllVotersReady(List<String> allVoterEmails) {
    return allVoterEmails.every((email) => readyVoters.contains(email));
  }

  /// Percentuale di completamento votazione
  double votingProgress(int totalVoters) {
    if (totalVoters == 0) return 0;
    return readyVoterCount / totalVoters;
  }

  /// Aggiunge o aggiorna un voto
  EisenhowerActivityModel withVote(String participantName, EisenhowerVote vote) {
    final newVotes = Map<String, EisenhowerVote>.from(votes);
    newVotes[participantName] = vote;
    return copyWith(votes: newVotes);
  }

  /// Rimuove un voto
  EisenhowerActivityModel withoutVote(String participantName) {
    final newVotes = Map<String, EisenhowerVote>.from(votes);
    newVotes.remove(participantName);
    return copyWith(votes: newVotes);
  }

  /// Aggiunge tutti i voti da una mappa
  EisenhowerActivityModel withAllVotes(Map<String, EisenhowerVote> newVotes) {
    return copyWith(votes: newVotes);
  }

  @override
  String toString() {
    return 'EisenhowerActivityModel(id: $id, title: $title, votes: $voteCount, quadrant: ${quadrant?.name})';
  }
}

/// Extension per utility di lista attività
extension EisenhowerActivityListExtension on List<EisenhowerActivityModel> {
  /// Filtra per quadrante
  List<EisenhowerActivityModel> byQuadrant(EisenhowerQuadrant quadrant) {
    return where((a) => a.quadrant == quadrant).toList();
  }

  /// Attività senza voti
  List<EisenhowerActivityModel> get unvoted {
    return where((a) => !a.hasVotes).toList();
  }

  /// Attività con voti
  List<EisenhowerActivityModel> get voted {
    return where((a) => a.hasVotes).toList();
  }

  /// Attività attive (non completate e non archiviate)
  List<EisenhowerActivityModel> get active {
    return where((a) => !a.isCompleted && !a.isArchived).toList();
  }

  /// Attività completate
  List<EisenhowerActivityModel> get completed {
    return where((a) => a.isCompleted).toList();
  }

  /// Attività archiviate
  List<EisenhowerActivityModel> get archived {
    return where((a) => a.isArchived).toList();
  }

  /// Ordina per urgenza (decrescente)
  List<EisenhowerActivityModel> sortedByUrgency() {
    final sorted = List<EisenhowerActivityModel>.from(this);
    sorted.sort((a, b) => b.aggregatedUrgency.compareTo(a.aggregatedUrgency));
    return sorted;
  }

  /// Ordina per importanza (decrescente)
  List<EisenhowerActivityModel> sortedByImportance() {
    final sorted = List<EisenhowerActivityModel>.from(this);
    sorted.sort((a, b) => b.aggregatedImportance.compareTo(a.aggregatedImportance));
    return sorted;
  }

  /// Conta attività per quadrante
  Map<EisenhowerQuadrant, int> get quadrantCounts {
    final counts = <EisenhowerQuadrant, int>{
      EisenhowerQuadrant.q1: 0,
      EisenhowerQuadrant.q2: 0,
      EisenhowerQuadrant.q3: 0,
      EisenhowerQuadrant.q4: 0,
    };

    for (final activity in this) {
      if (activity.quadrant != null) {
        counts[activity.quadrant!] = (counts[activity.quadrant!] ?? 0) + 1;
      }
    }

    return counts;
  }
}
