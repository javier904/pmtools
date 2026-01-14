import 'package:cloud_firestore/cloud_firestore.dart';
import 'planning_poker_participant_model.dart';
import 'estimation_mode.dart';

/// Stato di una sessione di Planning Poker
enum PlanningPokerSessionStatus {
  draft,      // Sessione creata ma non ancora avviata
  active,     // Sessione in corso
  completed,  // Sessione completata
}

extension PlanningPokerSessionStatusExtension on PlanningPokerSessionStatus {
  String get displayName {
    switch (this) {
      case PlanningPokerSessionStatus.draft:
        return 'Bozza';
      case PlanningPokerSessionStatus.active:
        return 'Attiva';
      case PlanningPokerSessionStatus.completed:
        return 'Completata';
    }
  }

  String get name {
    switch (this) {
      case PlanningPokerSessionStatus.draft:
        return 'draft';
      case PlanningPokerSessionStatus.active:
        return 'active';
      case PlanningPokerSessionStatus.completed:
        return 'completed';
    }
  }

  static PlanningPokerSessionStatus fromString(String? value) {
    switch (value) {
      case 'active':
        return PlanningPokerSessionStatus.active;
      case 'completed':
        return PlanningPokerSessionStatus.completed;
      default:
        return PlanningPokerSessionStatus.draft;
    }
  }
}

/// Set di carte predefiniti per Planning Poker
class PlanningPokerCardSet {
  /// Set Fibonacci standard
  static const List<String> fibonacci = [
    '0', '1', '2', '3', '5', '8', '13', '20', '40', '100', '?', '☕'
  ];

  /// Set semplificato
  static const List<String> simplified = [
    '1', '2', '3', '5', '8', '13', '?', '☕'
  ];

  /// Set T-shirt sizes
  static const List<String> tshirt = [
    'XS', 'S', 'M', 'L', 'XL', 'XXL', '?', '☕'
  ];

  /// Tutti i set disponibili
  static const Map<String, List<String>> all = {
    'fibonacci': fibonacci,
    'simplified': simplified,
    'tshirt': tshirt,
  };
}

/// Modello per una sessione di Planning Poker
class PlanningPokerSessionModel {
  final String id;
  final String name;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PlanningPokerSessionStatus status;

  // Configurazione
  final List<String> cardSet;
  final bool allowObservers;
  final bool autoReveal;
  final EstimationMode estimationMode;

  // Partecipanti (embedded per performance)
  final Map<String, PlanningPokerParticipantModel> participants;

  // Integrazioni (opzionali)
  final String? teamId;
  final String? teamName;
  final String? businessUnitId;
  final String? businessUnitName;
  final String? projectId;
  final String? projectName;
  final String? projectCode;

  // Statistiche denormalizzate
  final int storyCount;
  final int completedStoryCount;

  // Story corrente in votazione
  final String? currentStoryId;

  PlanningPokerSessionModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.status = PlanningPokerSessionStatus.draft,
    this.cardSet = const ['0', '1', '2', '3', '5', '8', '13', '20', '40', '100', '?', '☕'],
    this.allowObservers = true,
    this.autoReveal = true,
    this.estimationMode = EstimationMode.fibonacci,
    this.participants = const {},
    this.teamId,
    this.teamName,
    this.businessUnitId,
    this.businessUnitName,
    this.projectId,
    this.projectName,
    this.projectCode,
    this.storyCount = 0,
    this.completedStoryCount = 0,
    this.currentStoryId,
  });

  /// Crea da documento Firestore
  factory PlanningPokerSessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Parse partecipanti (unescape dei punti nelle chiavi email)
    final participantsMap = <String, PlanningPokerParticipantModel>{};
    final participantsData = data['participants'] as Map<String, dynamic>? ?? {};
    participantsData.forEach((escapedEmail, pData) {
      if (pData is Map<String, dynamic>) {
        // Unescape _DOT_ -> .
        final email = escapedEmail.replaceAll('_DOT_', '.');
        participantsMap[email] = PlanningPokerParticipantModel.fromMap(email, pData);
      }
    });

    return PlanningPokerSessionModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: PlanningPokerSessionStatusExtension.fromString(data['status']),
      cardSet: List<String>.from(data['cardSet'] ?? PlanningPokerCardSet.fibonacci),
      allowObservers: data['allowObservers'] ?? true,
      autoReveal: data['autoReveal'] ?? true,
      estimationMode: EstimationModeExtension.fromString(data['estimationMode']),
      participants: participantsMap,
      teamId: data['teamId'],
      teamName: data['teamName'],
      businessUnitId: data['businessUnitId'],
      businessUnitName: data['businessUnitName'],
      projectId: data['projectId'],
      projectName: data['projectName'],
      projectCode: data['projectCode'],
      storyCount: data['storyCount'] ?? 0,
      completedStoryCount: data['completedStoryCount'] ?? 0,
      currentStoryId: data['currentStoryId'],
    );
  }

  /// Converte in Map per Firestore
  Map<String, dynamic> toFirestore() {
    final participantsData = <String, dynamic>{};
    participants.forEach((email, participant) {
      participantsData[email] = participant.toMap();
    });

    return {
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'status': status.name,
      'cardSet': cardSet,
      'allowObservers': allowObservers,
      'autoReveal': autoReveal,
      'estimationMode': estimationMode.name,
      'participants': participantsData,
      'storyCount': storyCount,
      'completedStoryCount': completedStoryCount,
      if (currentStoryId != null) 'currentStoryId': currentStoryId,
      // Integrazioni
      if (teamId != null) 'teamId': teamId,
      if (teamName != null) 'teamName': teamName,
      if (businessUnitId != null) 'businessUnitId': businessUnitId,
      if (businessUnitName != null) 'businessUnitName': businessUnitName,
      if (projectId != null) 'projectId': projectId,
      if (projectName != null) 'projectName': projectName,
      if (projectCode != null) 'projectCode': projectCode,
    };
  }

  /// Copia con modifiche
  PlanningPokerSessionModel copyWith({
    String? id,
    String? name,
    String? description,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    PlanningPokerSessionStatus? status,
    List<String>? cardSet,
    bool? allowObservers,
    bool? autoReveal,
    EstimationMode? estimationMode,
    Map<String, PlanningPokerParticipantModel>? participants,
    String? teamId,
    String? teamName,
    String? businessUnitId,
    String? businessUnitName,
    String? projectId,
    String? projectName,
    String? projectCode,
    int? storyCount,
    int? completedStoryCount,
    String? currentStoryId,
  }) {
    return PlanningPokerSessionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      cardSet: cardSet ?? this.cardSet,
      allowObservers: allowObservers ?? this.allowObservers,
      autoReveal: autoReveal ?? this.autoReveal,
      estimationMode: estimationMode ?? this.estimationMode,
      participants: participants ?? this.participants,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      businessUnitId: businessUnitId ?? this.businessUnitId,
      businessUnitName: businessUnitName ?? this.businessUnitName,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      projectCode: projectCode ?? this.projectCode,
      storyCount: storyCount ?? this.storyCount,
      completedStoryCount: completedStoryCount ?? this.completedStoryCount,
      currentStoryId: currentStoryId ?? this.currentStoryId,
    );
  }

  // Getters utili
  bool get hasProject => projectId != null && projectId!.isNotEmpty;
  bool get hasTeam => teamId != null && teamId!.isNotEmpty;
  bool get hasBusinessUnit => businessUnitId != null && businessUnitId!.isNotEmpty;
  bool get isActive => status == PlanningPokerSessionStatus.active;
  bool get isCompleted => status == PlanningPokerSessionStatus.completed;
  bool get isDraft => status == PlanningPokerSessionStatus.draft;

  int get participantCount => participants.length;
  int get voterCount => participants.values
      .where((p) => p.role == ParticipantRole.voter || p.role == ParticipantRole.facilitator)
      .length;
  int get observerCount => participants.values
      .where((p) => p.role == ParticipantRole.observer)
      .length;

  /// Percentuale completamento
  double get completionPercentage {
    if (storyCount == 0) return 0;
    return (completedStoryCount / storyCount) * 100;
  }

  /// Verifica se un utente è facilitator
  bool isFacilitator(String email) {
    return participants[email]?.role == ParticipantRole.facilitator;
  }

  /// Verifica se un utente può votare
  bool canVote(String email) {
    final participant = participants[email];
    if (participant == null) return false;
    return participant.role == ParticipantRole.voter ||
        participant.role == ParticipantRole.facilitator;
  }

  @override
  String toString() {
    return 'PlanningPokerSession(id: $id, name: $name, status: ${status.name}, '
        'participants: $participantCount, stories: $storyCount)';
  }
}
