import 'package:cloud_firestore/cloud_firestore.dart';

/// Stato di una story nel Planning Poker
enum StoryStatus {
  pending,    // In attesa di votazione
  voting,     // Votazione in corso
  revealed,   // Voti rivelati
  completed,  // Stima finale assegnata
}

extension StoryStatusExtension on StoryStatus {
  String get displayName {
    switch (this) {
      case StoryStatus.pending:
        return 'In attesa';
      case StoryStatus.voting:
        return 'In votazione';
      case StoryStatus.revealed:
        return 'Rivelata';
      case StoryStatus.completed:
        return 'Completata';
    }
  }

  String get name {
    switch (this) {
      case StoryStatus.pending:
        return 'pending';
      case StoryStatus.voting:
        return 'voting';
      case StoryStatus.revealed:
        return 'revealed';
      case StoryStatus.completed:
        return 'completed';
    }
  }

  static StoryStatus fromString(String? value) {
    switch (value) {
      case 'voting':
        return StoryStatus.voting;
      case 'revealed':
        return StoryStatus.revealed;
      case 'completed':
        return StoryStatus.completed;
      default:
        return StoryStatus.pending;
    }
  }
}

/// Modello per un singolo voto
/// Supporta: voti standard, decimali, e three-point estimation (PERT)
class PlanningPokerVote {
  final String value;
  final DateTime votedAt;

  // Campi per Three-Point Estimation (PERT)
  final double? optimisticValue;  // Valore ottimistico (O)
  final double? realisticValue;   // Valore realistico (M - Most Likely)
  final double? pessimisticValue; // Valore pessimistico (P)

  // Valore decimale per modalità decimal
  final double? decimalValue;

  const PlanningPokerVote({
    required this.value,
    required this.votedAt,
    this.optimisticValue,
    this.realisticValue,
    this.pessimisticValue,
    this.decimalValue,
  });

  factory PlanningPokerVote.fromMap(Map<String, dynamic> map) {
    return PlanningPokerVote(
      value: map['value'] ?? '?',
      votedAt: (map['votedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      optimisticValue: (map['optimisticValue'] as num?)?.toDouble(),
      realisticValue: (map['realisticValue'] as num?)?.toDouble(),
      pessimisticValue: (map['pessimisticValue'] as num?)?.toDouble(),
      decimalValue: (map['decimalValue'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'votedAt': Timestamp.fromDate(votedAt),
      if (optimisticValue != null) 'optimisticValue': optimisticValue,
      if (realisticValue != null) 'realisticValue': realisticValue,
      if (pessimisticValue != null) 'pessimisticValue': pessimisticValue,
      if (decimalValue != null) 'decimalValue': decimalValue,
    };
  }

  /// Verifica se il voto ha un valore numerico intero
  bool get isNumeric => int.tryParse(value) != null;

  /// Verifica se il voto ha un valore numerico (intero o decimale)
  bool get isNumericOrDecimal =>
      int.tryParse(value) != null ||
      double.tryParse(value) != null ||
      decimalValue != null;

  /// Ottiene il valore numerico intero (null se non numerico)
  int? get numericValue => int.tryParse(value);

  /// Ottiene il valore come double (supporta interi, decimali e PERT)
  double? get numericValueAsDouble {
    // Prima controlla se c'è un valore decimale esplicito
    if (decimalValue != null) return decimalValue;
    // Poi controlla se è un three-point (usa PERT value)
    if (isThreePoint) return pertValue;
    // Infine prova a parsare il value
    return double.tryParse(value);
  }

  /// Verifica se è un voto three-point
  bool get isThreePoint =>
      optimisticValue != null &&
      realisticValue != null &&
      pessimisticValue != null;

  /// Calcola il valore PERT: (O + 4M + P) / 6
  double? get pertValue {
    if (!isThreePoint) return null;
    return (optimisticValue! + (4 * realisticValue!) + pessimisticValue!) / 6;
  }

  /// Calcola la deviazione standard: (P - O) / 6
  double? get standardDeviation {
    if (!isThreePoint) return null;
    return (pessimisticValue! - optimisticValue!) / 6;
  }

  /// Calcola la varianza
  double? get variance {
    final sd = standardDeviation;
    if (sd == null) return null;
    return sd * sd;
  }

  /// Crea un voto standard (per Fibonacci, T-Shirt, Five Fingers)
  factory PlanningPokerVote.standard(String value) {
    return PlanningPokerVote(
      value: value,
      votedAt: DateTime.now(),
    );
  }

  /// Crea un voto decimale
  factory PlanningPokerVote.decimal(double value) {
    // Formatta senza decimali se è un numero intero, altrimenti con max 2 decimali
    String formattedValue;
    if (value == value.truncateToDouble()) {
      formattedValue = value.toInt().toString();
    } else {
      formattedValue = value.toStringAsFixed(2);
    }
    return PlanningPokerVote(
      value: formattedValue,
      votedAt: DateTime.now(),
      decimalValue: value,
    );
  }

  /// Crea un voto three-point (PERT)
  factory PlanningPokerVote.threePoint({
    required double optimistic,
    required double realistic,
    required double pessimistic,
  }) {
    final pert = (optimistic + (4 * realistic) + pessimistic) / 6;
    // Formatta senza decimali se è un numero intero, altrimenti con max 2 decimali
    String formattedValue;
    if (pert == pert.truncateToDouble()) {
      formattedValue = pert.toInt().toString();
    } else {
      formattedValue = pert.toStringAsFixed(2);
    }
    return PlanningPokerVote(
      value: formattedValue,
      votedAt: DateTime.now(),
      optimisticValue: optimistic,
      realisticValue: realistic,
      pessimisticValue: pessimistic,
    );
  }

  /// Copia con modifiche
  PlanningPokerVote copyWith({
    String? value,
    DateTime? votedAt,
    double? optimisticValue,
    double? realisticValue,
    double? pessimisticValue,
    double? decimalValue,
  }) {
    return PlanningPokerVote(
      value: value ?? this.value,
      votedAt: votedAt ?? this.votedAt,
      optimisticValue: optimisticValue ?? this.optimisticValue,
      realisticValue: realisticValue ?? this.realisticValue,
      pessimisticValue: pessimisticValue ?? this.pessimisticValue,
      decimalValue: decimalValue ?? this.decimalValue,
    );
  }

  @override
  String toString() {
    if (isThreePoint) {
      return 'Vote(O:$optimisticValue, M:$realisticValue, P:$pessimisticValue → PERT:${pertValue?.toStringAsFixed(2)})';
    }
    if (decimalValue != null) {
      return 'Vote(decimal: $decimalValue)';
    }
    return 'Vote($value)';
  }
}

/// Statistiche dei voti
/// Supporta: voti standard, decimali e three-point estimation (PERT)
class VoteStatistics {
  final double? numericAverage;
  final double? numericMedian;
  final String? mode;
  final Map<String, int> distribution;
  final bool consensus;
  final int totalVoters;
  final int numericVotersCount;

  // Statistiche aggiuntive per three-point (PERT)
  final double? averagePertValue;
  final double? averageStandardDeviation;
  final double? totalVariance;
  final int threePointVotersCount;

  // Range dei voti (per visualizzazione)
  final double? minValue;
  final double? maxValue;

  const VoteStatistics({
    this.numericAverage,
    this.numericMedian,
    this.mode,
    this.distribution = const {},
    this.consensus = false,
    this.totalVoters = 0,
    this.numericVotersCount = 0,
    this.averagePertValue,
    this.averageStandardDeviation,
    this.totalVariance,
    this.threePointVotersCount = 0,
    this.minValue,
    this.maxValue,
  });

  factory VoteStatistics.fromMap(Map<String, dynamic> map) {
    return VoteStatistics(
      numericAverage: (map['numericAverage'] as num?)?.toDouble(),
      numericMedian: (map['numericMedian'] as num?)?.toDouble(),
      mode: map['mode'],
      distribution: Map<String, int>.from(map['distribution'] ?? {}),
      consensus: map['consensus'] ?? false,
      totalVoters: map['totalVoters'] ?? 0,
      numericVotersCount: map['numericVotersCount'] ?? 0,
      averagePertValue: (map['averagePertValue'] as num?)?.toDouble(),
      averageStandardDeviation: (map['averageStandardDeviation'] as num?)?.toDouble(),
      totalVariance: (map['totalVariance'] as num?)?.toDouble(),
      threePointVotersCount: map['threePointVotersCount'] ?? 0,
      minValue: (map['minValue'] as num?)?.toDouble(),
      maxValue: (map['maxValue'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (numericAverage != null) 'numericAverage': numericAverage,
      if (numericMedian != null) 'numericMedian': numericMedian,
      if (mode != null) 'mode': mode,
      'distribution': distribution,
      'consensus': consensus,
      'totalVoters': totalVoters,
      'numericVotersCount': numericVotersCount,
      if (averagePertValue != null) 'averagePertValue': averagePertValue,
      if (averageStandardDeviation != null) 'averageStandardDeviation': averageStandardDeviation,
      if (totalVariance != null) 'totalVariance': totalVariance,
      'threePointVotersCount': threePointVotersCount,
      if (minValue != null) 'minValue': minValue,
      if (maxValue != null) 'maxValue': maxValue,
    };
  }

  /// Calcola statistiche da una mappa di voti
  /// Supporta voti standard (interi), decimali e three-point (PERT)
  factory VoteStatistics.calculate(Map<String, PlanningPokerVote> votes) {
    if (votes.isEmpty) {
      return const VoteStatistics();
    }

    // Distribuzione (usa il value string per raggruppamento)
    final distribution = <String, int>{};
    for (final vote in votes.values) {
      distribution[vote.value] = (distribution[vote.value] ?? 0) + 1;
    }

    // Valori numerici (supporta interi, decimali e PERT)
    final numericValues = <double>[];
    final pertValues = <double>[];
    final sdValues = <double>[];
    final varianceValues = <double>[];

    for (final vote in votes.values) {
      // Usa numericValueAsDouble che gestisce tutti i tipi
      final numValue = vote.numericValueAsDouble;
      if (numValue != null) {
        numericValues.add(numValue);
      }

      // Statistiche specifiche per three-point
      if (vote.isThreePoint) {
        if (vote.pertValue != null) pertValues.add(vote.pertValue!);
        if (vote.standardDeviation != null) sdValues.add(vote.standardDeviation!);
        if (vote.variance != null) varianceValues.add(vote.variance!);
      }
    }

    numericValues.sort();

    // Media
    double? average;
    if (numericValues.isNotEmpty) {
      average = numericValues.reduce((a, b) => a + b) / numericValues.length;
    }

    // Mediana
    double? median;
    if (numericValues.isNotEmpty) {
      final mid = numericValues.length ~/ 2;
      if (numericValues.length.isOdd) {
        median = numericValues[mid];
      } else {
        median = (numericValues[mid - 1] + numericValues[mid]) / 2;
      }
    }

    // Moda (valore piu' frequente)
    String? mode;
    int maxCount = 0;
    distribution.forEach((value, count) {
      if (count > maxCount) {
        maxCount = count;
        mode = value;
      }
    });

    // Consenso (tutti stesso voto)
    final consensus = distribution.length == 1;

    // Min e Max
    double? minValue;
    double? maxValue;
    if (numericValues.isNotEmpty) {
      minValue = numericValues.first;
      maxValue = numericValues.last;
    }

    // Statistiche PERT aggregate
    double? averagePert;
    double? averageSd;
    double? totalVar;
    if (pertValues.isNotEmpty) {
      averagePert = pertValues.reduce((a, b) => a + b) / pertValues.length;
    }
    if (sdValues.isNotEmpty) {
      averageSd = sdValues.reduce((a, b) => a + b) / sdValues.length;
    }
    if (varianceValues.isNotEmpty) {
      // Per PERT, la varianza totale è la somma delle varianze
      totalVar = varianceValues.reduce((a, b) => a + b);
    }

    return VoteStatistics(
      numericAverage: average,
      numericMedian: median,
      mode: mode,
      distribution: distribution,
      consensus: consensus,
      totalVoters: votes.length,
      numericVotersCount: numericValues.length,
      averagePertValue: averagePert,
      averageStandardDeviation: averageSd,
      totalVariance: totalVar,
      threePointVotersCount: pertValues.length,
      minValue: minValue,
      maxValue: maxValue,
    );
  }

  /// Verifica se ci sono voti three-point
  bool get hasThreePointVotes => threePointVotersCount > 0;

  /// Range dei voti
  double? get range {
    if (minValue == null || maxValue == null) return null;
    return maxValue! - minValue!;
  }

  @override
  String toString() {
    final sb = StringBuffer('Statistics(');
    sb.write('avg: ${numericAverage?.toStringAsFixed(2)}, ');
    sb.write('median: ${numericMedian?.toStringAsFixed(2)}, ');
    sb.write('mode: $mode, ');
    sb.write('consensus: $consensus, ');
    sb.write('voters: $totalVoters');
    if (hasThreePointVotes) {
      sb.write(', PERT avg: ${averagePertValue?.toStringAsFixed(2)}');
      sb.write(', SD avg: ${averageStandardDeviation?.toStringAsFixed(2)}');
    }
    sb.write(')');
    return sb.toString();
  }
}

/// Modello per una story da stimare
class PlanningPokerStoryModel {
  final String id;
  final String sessionId;
  final String title;
  final String description;
  final int order;
  final StoryStatus status;
  final DateTime createdAt;

  // Collegamento opzionale a task Gantt
  final String? linkedTaskId;
  final String? linkedTaskTitle;

  // Voti (nascosti fino al reveal)
  final Map<String, PlanningPokerVote> votes;

  // Risultati (dopo reveal)
  final bool isRevealed;
  final DateTime? revealedAt;
  final String? finalEstimate;
  final VoteStatistics? statistics;

  // Note di discussione
  final String? notes;

  // Dettaglio/motivazione della stima finale (salvato con la stima)
  final String? explanationDetail;

  PlanningPokerStoryModel({
    required this.id,
    required this.sessionId,
    required this.title,
    this.description = '',
    this.order = 0,
    this.status = StoryStatus.pending,
    required this.createdAt,
    this.linkedTaskId,
    this.linkedTaskTitle,
    this.votes = const {},
    this.isRevealed = false,
    this.revealedAt,
    this.finalEstimate,
    this.statistics,
    this.notes,
    this.explanationDetail,
  });

  /// Crea da documento Firestore
  factory PlanningPokerStoryModel.fromFirestore(DocumentSnapshot doc, String sessionId) {
    final data = doc.data() as Map<String, dynamic>;

    // Parse voti
    final votesMap = <String, PlanningPokerVote>{};
    final votesData = data['votes'] as Map<String, dynamic>? ?? {};
    votesData.forEach((email, voteData) {
      if (voteData is Map<String, dynamic>) {
        votesMap[email] = PlanningPokerVote.fromMap(voteData);
      }
    });

    // Parse statistiche
    VoteStatistics? stats;
    final statsData = data['statistics'] as Map<String, dynamic>?;
    if (statsData != null) {
      stats = VoteStatistics.fromMap(statsData);
    }

    return PlanningPokerStoryModel(
      id: doc.id,
      sessionId: sessionId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      order: data['order'] ?? 0,
      status: StoryStatusExtension.fromString(data['status']),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      linkedTaskId: data['linkedTaskId'],
      linkedTaskTitle: data['linkedTaskTitle'],
      votes: votesMap,
      isRevealed: data['isRevealed'] ?? false,
      revealedAt: (data['revealedAt'] as Timestamp?)?.toDate(),
      finalEstimate: data['finalEstimate'],
      statistics: stats,
      notes: data['notes'],
      explanationDetail: data['explanationDetail'],
    );
  }

  /// Converte in Map per Firestore
  Map<String, dynamic> toFirestore() {
    final votesData = <String, dynamic>{};
    votes.forEach((email, vote) {
      votesData[email] = vote.toMap();
    });

    return {
      'title': title,
      'description': description,
      'order': order,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'votes': votesData,
      'voteCount': votes.length,
      'isRevealed': isRevealed,
      if (linkedTaskId != null) 'linkedTaskId': linkedTaskId,
      if (linkedTaskTitle != null) 'linkedTaskTitle': linkedTaskTitle,
      if (revealedAt != null) 'revealedAt': Timestamp.fromDate(revealedAt!),
      if (finalEstimate != null) 'finalEstimate': finalEstimate,
      if (statistics != null) 'statistics': statistics!.toMap(),
      if (notes != null) 'notes': notes,
      if (explanationDetail != null) 'explanationDetail': explanationDetail,
    };
  }

  /// Copia con modifiche
  PlanningPokerStoryModel copyWith({
    String? id,
    String? sessionId,
    String? title,
    String? description,
    int? order,
    StoryStatus? status,
    DateTime? createdAt,
    String? linkedTaskId,
    String? linkedTaskTitle,
    Map<String, PlanningPokerVote>? votes,
    bool? isRevealed,
    DateTime? revealedAt,
    String? finalEstimate,
    VoteStatistics? statistics,
    String? notes,
    String? explanationDetail,
  }) {
    return PlanningPokerStoryModel(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      title: title ?? this.title,
      description: description ?? this.description,
      order: order ?? this.order,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      linkedTaskId: linkedTaskId ?? this.linkedTaskId,
      linkedTaskTitle: linkedTaskTitle ?? this.linkedTaskTitle,
      votes: votes ?? this.votes,
      isRevealed: isRevealed ?? this.isRevealed,
      revealedAt: revealedAt ?? this.revealedAt,
      finalEstimate: finalEstimate ?? this.finalEstimate,
      statistics: statistics ?? this.statistics,
      notes: notes ?? this.notes,
      explanationDetail: explanationDetail ?? this.explanationDetail,
    );
  }

  // Getters utili
  int get voteCount => votes.length;
  bool get hasVotes => votes.isNotEmpty;
  bool get hasLinkedTask => linkedTaskId != null && linkedTaskId!.isNotEmpty;
  bool get isCompleted => status == StoryStatus.completed;
  bool get isPending => status == StoryStatus.pending;
  bool get isVoting => status == StoryStatus.voting;

  /// Verifica se un utente ha votato
  bool hasUserVoted(String email) => votes.containsKey(email);

  /// Ottiene il voto di un utente
  PlanningPokerVote? getUserVote(String email) => votes[email];

  /// Aggiunge un voto
  PlanningPokerStoryModel withVote(String email, PlanningPokerVote vote) {
    final newVotes = Map<String, PlanningPokerVote>.from(votes);
    newVotes[email] = vote;
    return copyWith(votes: newVotes);
  }

  /// Rimuove un voto
  PlanningPokerStoryModel withoutVote(String email) {
    final newVotes = Map<String, PlanningPokerVote>.from(votes);
    newVotes.remove(email);
    return copyWith(votes: newVotes);
  }

  /// Resetta tutti i voti
  PlanningPokerStoryModel withClearedVotes() {
    return copyWith(
      votes: {},
      isRevealed: false,
      revealedAt: null,
      statistics: null,
      status: StoryStatus.pending,
    );
  }

  /// Calcola le statistiche
  VoteStatistics calculateStatistics() {
    return VoteStatistics.calculate(votes);
  }

  @override
  String toString() {
    return 'Story(id: $id, title: $title, status: ${status.name}, '
        'votes: $voteCount, estimate: $finalEstimate)';
  }
}

/// Extension per lista di stories
extension PlanningPokerStoryListExtension on List<PlanningPokerStoryModel> {
  /// Stories ordinate per ordine
  List<PlanningPokerStoryModel> get sorted {
    final list = List<PlanningPokerStoryModel>.from(this);
    list.sort((a, b) => a.order.compareTo(b.order));
    return list;
  }

  /// Stories in attesa
  List<PlanningPokerStoryModel> get pending =>
      where((s) => s.status == StoryStatus.pending).toList();

  /// Stories completate
  List<PlanningPokerStoryModel> get completed =>
      where((s) => s.status == StoryStatus.completed).toList();

  /// Stories con stima finale
  List<PlanningPokerStoryModel> get estimated =>
      where((s) => s.finalEstimate != null).toList();

  /// Story in votazione o rivelata (dovrebbe essere al massimo una)
  /// Include sia 'voting' che 'revealed' per mantenere la story visibile
  /// fino a quando il facilitatore non assegna la stima finale
  PlanningPokerStoryModel? get currentlyVoting {
    try {
      // Prima cerca 'voting', poi 'revealed'
      return firstWhere((s) => s.status == StoryStatus.voting || s.status == StoryStatus.revealed);
    } catch (e) {
      return null;
    }
  }

  /// Prossima story da votare
  PlanningPokerStoryModel? get nextPending {
    try {
      return sorted.firstWhere((s) => s.status == StoryStatus.pending);
    } catch (e) {
      return null;
    }
  }

  /// Somma totale delle stime (solo valori numerici, supporta decimali)
  double get totalEstimate {
    return where((s) => s.finalEstimate != null && double.tryParse(s.finalEstimate!) != null)
        .map((s) => double.parse(s.finalEstimate!))
        .fold(0.0, (sum, val) => sum + val);
  }

  /// Somma totale delle stime come intero (arrotondato)
  int get totalEstimateRounded => totalEstimate.round();
}
