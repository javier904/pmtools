import 'package:cloud_firestore/cloud_firestore.dart';
import 'agile_enums.dart';

/// Modello per uno Sprint in un progetto Agile
///
/// Rappresenta un ciclo di sviluppo con goal, timeline,
/// stories assegnate e metriche di performance.
class SprintModel {
  final String id;
  final String projectId;
  final String name;
  final String goal;
  final int number; // Sprint number (1, 2, 3...)

  // Timeline
  final DateTime startDate;
  final DateTime endDate;
  final SprintStatus status;

  // Stories in sprint
  final List<String> storyIds;
  final int plannedPoints;
  final int completedPoints;

  // Team capacity
  final Map<String, int> teamCapacity; // email -> total hours for sprint
  final int totalCapacityHours;

  // Metrics
  final double? velocity; // Story points completed
  final List<BurndownPoint> burndownData;

  // Daily standup notes
  final List<StandupNote> standupNotes;

  // Sprint Review (Scrum Guide 2020 - evento separato dalla Retrospective)
  final SprintReview? sprintReview;

  // Metadata
  final DateTime createdAt;
  final String createdBy;
  final DateTime? startedAt;
  final DateTime? completedAt;

  const SprintModel({
    required this.id,
    required this.projectId,
    required this.name,
    this.goal = '',
    this.number = 1,
    required this.startDate,
    required this.endDate,
    this.status = SprintStatus.planning,
    this.storyIds = const [],
    this.plannedPoints = 0,
    this.completedPoints = 0,
    this.teamCapacity = const {},
    this.totalCapacityHours = 0,
    this.velocity,
    this.burndownData = const [],
    this.standupNotes = const [],
    this.sprintReview,
    required this.createdAt,
    required this.createdBy,
    this.startedAt,
    this.completedAt,
  });

  /// Crea da documento Firestore
  factory SprintModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return SprintModel.fromMap(doc.id, data);
  }

  /// Crea da mappa
  factory SprintModel.fromMap(String id, Map<String, dynamic> data) {
    // Parse burndown data
    final burndownList = data['burndownData'] as List<dynamic>? ?? [];
    final burndownData = burndownList
        .map((b) => BurndownPoint.fromMap(b as Map<String, dynamic>))
        .toList();

    // Parse standup notes
    final standupList = data['standupNotes'] as List<dynamic>? ?? [];
    final standupNotes = standupList
        .map((s) => StandupNote.fromMap(s as Map<String, dynamic>))
        .toList();

    // Parse sprint review
    SprintReview? sprintReview;
    if (data['sprintReview'] != null) {
      sprintReview = SprintReview.fromMap(data['sprintReview'] as Map<String, dynamic>);
    }

    // Parse team capacity
    final capacityMap = data['teamCapacity'] as Map<String, dynamic>? ?? {};
    final teamCapacity = capacityMap.map(
      (key, value) => MapEntry(key, value as int),
    );

    return SprintModel(
      id: id,
      projectId: data['projectId'] ?? '',
      name: data['name'] ?? '',
      goal: data['goal'] ?? '',
      number: data['number'] ?? 1,
      startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (data['endDate'] as Timestamp?)?.toDate() ??
               DateTime.now().add(const Duration(days: 14)),
      status: SprintStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => SprintStatus.planning,
      ),
      storyIds: List<String>.from(data['storyIds'] ?? []),
      plannedPoints: data['plannedPoints'] ?? 0,
      completedPoints: data['completedPoints'] ?? 0,
      teamCapacity: teamCapacity,
      totalCapacityHours: data['totalCapacityHours'] ?? 0,
      velocity: (data['velocity'] as num?)?.toDouble(),
      burndownData: burndownData,
      standupNotes: standupNotes,
      sprintReview: sprintReview,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: data['createdBy'] ?? '',
      startedAt: (data['startedAt'] as Timestamp?)?.toDate(),
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Converte per Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'projectId': projectId,
      'name': name,
      'goal': goal,
      'number': number,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'status': status.name,
      'storyIds': storyIds,
      'plannedPoints': plannedPoints,
      'completedPoints': completedPoints,
      'teamCapacity': teamCapacity,
      'totalCapacityHours': totalCapacityHours,
      if (velocity != null) 'velocity': velocity,
      'burndownData': burndownData.map((b) => b.toMap()).toList(),
      'standupNotes': standupNotes.map((s) => s.toMap()).toList(),
      if (sprintReview != null) 'sprintReview': sprintReview!.toMap(),
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
      if (startedAt != null) 'startedAt': Timestamp.fromDate(startedAt!),
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
    };
  }

  /// Copia con modifiche
  SprintModel copyWith({
    String? id,
    String? projectId,
    String? name,
    String? goal,
    int? number,
    DateTime? startDate,
    DateTime? endDate,
    SprintStatus? status,
    List<String>? storyIds,
    int? plannedPoints,
    int? completedPoints,
    Map<String, int>? teamCapacity,
    int? totalCapacityHours,
    double? velocity,
    List<BurndownPoint>? burndownData,
    List<StandupNote>? standupNotes,
    SprintReview? sprintReview,
    DateTime? createdAt,
    String? createdBy,
    DateTime? startedAt,
    DateTime? completedAt,
  }) {
    return SprintModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      goal: goal ?? this.goal,
      number: number ?? this.number,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      storyIds: storyIds ?? this.storyIds,
      plannedPoints: plannedPoints ?? this.plannedPoints,
      completedPoints: completedPoints ?? this.completedPoints,
      teamCapacity: teamCapacity ?? this.teamCapacity,
      totalCapacityHours: totalCapacityHours ?? this.totalCapacityHours,
      velocity: velocity ?? this.velocity,
      burndownData: burndownData ?? this.burndownData,
      standupNotes: standupNotes ?? this.standupNotes,
      sprintReview: sprintReview ?? this.sprintReview,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  // =========================================================================
  // Helper per timeline
  // =========================================================================

  /// Durata dello sprint in giorni
  int get durationDays => endDate.difference(startDate).inDays + 1;

  /// Giorni lavorativi nello sprint (esclude weekend)
  int get workingDays {
    int count = 0;
    DateTime current = startDate;
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      if (current.weekday != DateTime.saturday &&
          current.weekday != DateTime.sunday) {
        count++;
      }
      current = current.add(const Duration(days: 1));
    }
    return count;
  }

  /// Giorni rimanenti
  int get daysRemaining {
    if (status == SprintStatus.completed) return 0;
    final now = DateTime.now();
    if (now.isBefore(startDate)) return durationDays;
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inDays + 1;
  }

  /// Giorni trascorsi
  int get daysElapsed {
    final now = DateTime.now();
    if (now.isBefore(startDate)) return 0;
    if (now.isAfter(endDate)) return durationDays;
    return now.difference(startDate).inDays;
  }

  /// Percentuale di completamento temporale
  double get timeProgress {
    if (durationDays == 0) return 0;
    return (daysElapsed / durationDays).clamp(0.0, 1.0);
  }

  /// Verifica se lo sprint è attivo
  bool get isActive => status == SprintStatus.active;

  /// Verifica se lo sprint è in planning
  bool get isPlanning => status == SprintStatus.planning;

  /// Verifica se lo sprint è completato
  bool get isCompleted => status == SprintStatus.completed;

  /// Verifica se si può modificare il contenuto
  bool get canModifyStories => status.canModifyStories;

  /// Verifica se la Sprint Review è stata effettuata
  bool get hasSprintReview => sprintReview != null;

  /// Verifica se lo sprint può essere chiuso (Sprint Review è consigliata ma non obbligatoria)
  bool get canClose => isActive;

  /// Verifica se manca la Sprint Review prima della chiusura
  bool get missingSprintReviewWarning => isActive && !hasSprintReview;

  // =========================================================================
  // Helper per stories
  // =========================================================================

  /// Numero di stories nello sprint
  int get storyCount => storyIds.length;

  /// Verifica se una story è nello sprint
  bool hasStory(String storyId) => storyIds.contains(storyId);

  /// Aggiunge una story allo sprint
  SprintModel withStory(String storyId, int storyPoints) {
    if (storyIds.contains(storyId)) return this;
    return copyWith(
      storyIds: [...storyIds, storyId],
      plannedPoints: plannedPoints + storyPoints,
    );
  }

  /// Rimuove una story dallo sprint
  SprintModel withoutStory(String storyId, int storyPoints) {
    if (!storyIds.contains(storyId)) return this;
    return copyWith(
      storyIds: storyIds.where((id) => id != storyId).toList(),
      plannedPoints: (plannedPoints - storyPoints).clamp(0, plannedPoints),
    );
  }

  // =========================================================================
  // Helper per metriche
  // =========================================================================

  /// Percentuale di completamento basata sui punti
  double get completionRate {
    if (plannedPoints == 0) return 0;
    return (completedPoints / plannedPoints).clamp(0.0, 1.0);
  }

  /// Alias per completionRate (usato in UI)
  double get progress => completionRate;

  /// Punti rimanenti
  int get remainingPoints => (plannedPoints - completedPoints).clamp(0, plannedPoints);

  /// Velocità giornaliera (punti per giorno)
  double get dailyVelocity {
    if (daysElapsed == 0) return 0;
    return completedPoints / daysElapsed;
  }

  /// Punti ideali rimanenti per giorno (linea ideale burndown)
  double idealRemainingAtDay(int day) {
    if (workingDays == 0) return plannedPoints.toDouble();
    final idealDailyBurn = plannedPoints / workingDays;
    return (plannedPoints - (idealDailyBurn * day)).clamp(0, plannedPoints.toDouble());
  }

  /// Previsione di completamento
  DateTime? get predictedCompletionDate {
    if (dailyVelocity == 0 || remainingPoints == 0) return null;
    final daysNeeded = (remainingPoints / dailyVelocity).ceil();
    return DateTime.now().add(Duration(days: daysNeeded));
  }

  /// Verifica se lo sprint è a rischio
  bool get isAtRisk {
    if (!isActive) return false;
    // A rischio se il progresso effettivo è inferiore al 80% dell'ideale
    final idealCompletion = timeProgress;
    return completionRate < (idealCompletion * 0.8);
  }

  // =========================================================================
  // Helper per capacity
  // =========================================================================

  /// Capacity utilizzata (in punti stimati)
  double get capacityUsage {
    if (totalCapacityHours == 0) return 0;
    // Assumendo 1 story point = 4 ore
    final estimatedHours = plannedPoints * 4;
    return (estimatedHours / totalCapacityHours).clamp(0.0, 2.0);
  }

  /// Verifica se lo sprint è overcommitted
  bool get isOvercommitted => capacityUsage > 1.0;

  /// Ottiene la capacity di un membro del team
  int getMemberCapacity(String email) => teamCapacity[email] ?? 0;

  // =========================================================================
  // Helper per burndown
  // =========================================================================

  /// Aggiunge un punto al burndown
  SprintModel withBurndownPoint(BurndownPoint point) {
    return copyWith(
      burndownData: [...burndownData, point],
    );
  }

  /// Ottiene l'ultimo punto del burndown
  BurndownPoint? get lastBurndownPoint {
    if (burndownData.isEmpty) return null;
    return burndownData.last;
  }

  // =========================================================================
  // Helper per standup
  // =========================================================================

  /// Aggiunge una nota di standup
  SprintModel withStandupNote(StandupNote note) {
    return copyWith(
      standupNotes: [...standupNotes, note],
    );
  }

  /// Ottiene le note di standup per una data
  List<StandupNote> getStandupNotesForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return standupNotes.where((note) {
      final noteDate = DateTime(note.date.year, note.date.month, note.date.day);
      return noteDate.isAtSameMomentAs(normalizedDate);
    }).toList();
  }

  /// Ottiene l'ultima nota di standup di un utente
  StandupNote? getLastStandupNoteForUser(String email) {
    final userNotes = standupNotes
        .where((note) => note.userEmail == email)
        .toList();
    if (userNotes.isEmpty) return null;
    userNotes.sort((a, b) => b.date.compareTo(a.date));
    return userNotes.first;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SprintModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'SprintModel(id: $id, name: $name, number: $number)';
}

/// Punto dati per il burndown chart
class BurndownPoint {
  final DateTime date;
  final int remainingPoints;
  final int completedPoints;
  final String? note;

  const BurndownPoint({
    required this.date,
    required this.remainingPoints,
    this.completedPoints = 0,
    this.note,
  });

  factory BurndownPoint.fromMap(Map<String, dynamic> data) {
    return BurndownPoint(
      date: (data['date'] as Timestamp).toDate(),
      remainingPoints: data['remainingPoints'] ?? 0,
      completedPoints: data['completedPoints'] ?? 0,
      note: data['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'remainingPoints': remainingPoints,
      'completedPoints': completedPoints,
      if (note != null) 'note': note,
    };
  }
}

/// Nota del daily standup
class StandupNote {
  final String userEmail;
  final String userName;
  final DateTime date;
  final String yesterday; // Cosa ho fatto ieri
  final String today; // Cosa farò oggi
  final String blockers; // Impedimenti/blocchi

  const StandupNote({
    required this.userEmail,
    required this.userName,
    required this.date,
    this.yesterday = '',
    this.today = '',
    this.blockers = '',
  });

  factory StandupNote.fromMap(Map<String, dynamic> data) {
    return StandupNote(
      userEmail: data['userEmail'] ?? '',
      userName: data['userName'] ?? '',
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      yesterday: data['yesterday'] ?? '',
      today: data['today'] ?? '',
      blockers: data['blockers'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'userName': userName,
      'date': Timestamp.fromDate(date),
      'yesterday': yesterday,
      'today': today,
      'blockers': blockers,
    };
  }

  /// Verifica se ci sono blockers
  bool get hasBlockers => blockers.isNotEmpty;
}

/// Sprint Review (Scrum Guide 2020)
///
/// La Sprint Review è l'evento in cui il team ispeziona l'outcome dello Sprint
/// e determina gli adattamenti futuri. Il team presenta il lavoro svolto
/// agli stakeholder e discute i progressi verso il Product Goal.
class SprintReview {
  final DateTime date;
  final String conductedBy; // Email di chi ha condotto la review
  final String conductedByName;

  // Partecipanti (email list)
  final List<String> attendees;

  // Contenuto della review
  final String demoNotes; // Note sulla demo del lavoro completato
  final String feedback; // Feedback ricevuto dagli stakeholder
  final List<String> backlogUpdates; // Modifiche al Product Backlog discusse
  final String nextSprintFocus; // Focus suggerito per il prossimo sprint

  // Metriche presentate
  final int storiesCompleted;
  final int storiesNotCompleted;
  final int pointsCompleted;
  final String marketConditionsNotes; // Note su cambiamenti di mercato/business

  const SprintReview({
    required this.date,
    required this.conductedBy,
    required this.conductedByName,
    this.attendees = const [],
    this.demoNotes = '',
    this.feedback = '',
    this.backlogUpdates = const [],
    this.nextSprintFocus = '',
    this.storiesCompleted = 0,
    this.storiesNotCompleted = 0,
    this.pointsCompleted = 0,
    this.marketConditionsNotes = '',
  });

  factory SprintReview.fromMap(Map<String, dynamic> data) {
    return SprintReview(
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      conductedBy: data['conductedBy'] ?? '',
      conductedByName: data['conductedByName'] ?? '',
      attendees: List<String>.from(data['attendees'] ?? []),
      demoNotes: data['demoNotes'] ?? '',
      feedback: data['feedback'] ?? '',
      backlogUpdates: List<String>.from(data['backlogUpdates'] ?? []),
      nextSprintFocus: data['nextSprintFocus'] ?? '',
      storiesCompleted: data['storiesCompleted'] ?? 0,
      storiesNotCompleted: data['storiesNotCompleted'] ?? 0,
      pointsCompleted: data['pointsCompleted'] ?? 0,
      marketConditionsNotes: data['marketConditionsNotes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'conductedBy': conductedBy,
      'conductedByName': conductedByName,
      'attendees': attendees,
      'demoNotes': demoNotes,
      'feedback': feedback,
      'backlogUpdates': backlogUpdates,
      'nextSprintFocus': nextSprintFocus,
      'storiesCompleted': storiesCompleted,
      'storiesNotCompleted': storiesNotCompleted,
      'pointsCompleted': pointsCompleted,
      'marketConditionsNotes': marketConditionsNotes,
    };
  }

  /// Verifica se la review ha contenuto significativo
  bool get hasContent =>
      demoNotes.isNotEmpty ||
      feedback.isNotEmpty ||
      backlogUpdates.isNotEmpty ||
      nextSprintFocus.isNotEmpty;

  /// Verifica se ci sono aggiornamenti al backlog
  bool get hasBacklogUpdates => backlogUpdates.isNotEmpty;
}
