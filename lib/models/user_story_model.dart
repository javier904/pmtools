import 'package:cloud_firestore/cloud_firestore.dart';
import 'agile_enums.dart';

/// Modello per una User Story in un progetto Agile
///
/// Rappresenta una singola user story con template standard
/// "As a... I want... So that..." e tutti i metadati necessari
/// per il tracking in un flusso Scrum/Kanban.
class UserStoryModel {
  final String id;
  final String projectId;
  final String title;
  final String description; // As a... I want... So that...

  // Prioritization
  final int businessValue; // 1-10
  final int? storyPoints; // Fibonacci: 1,2,3,5,8,13,21
  final StoryPriority priority; // must, should, could, wont
  final StoryStatus status;

  // Metadata
  final List<String> tags;
  final List<String> acceptanceCriteria;
  final List<String> dependencies; // story IDs
  final String? assigneeEmail;

  // Tracking
  final int order;
  final DateTime createdAt;
  final String createdBy;
  final DateTime? startedAt;
  final DateTime? completedAt;

  // Estimation (pattern da Estimation Room)
  final Map<String, StoryEstimate> estimates; // email -> estimate
  final bool isEstimated;
  final String? finalEstimate;
  final EstimationType? estimationType;

  // Sprint assignment
  final String? sprintId;

  // Actual hours (for tracking)
  final int? actualHours;

  const UserStoryModel({
    required this.id,
    required this.projectId,
    required this.title,
    this.description = '',
    this.businessValue = 5,
    this.storyPoints,
    this.priority = StoryPriority.should,
    this.status = StoryStatus.backlog,
    this.tags = const [],
    this.acceptanceCriteria = const [],
    this.dependencies = const [],
    this.assigneeEmail,
    this.order = 0,
    required this.createdAt,
    required this.createdBy,
    this.startedAt,
    this.completedAt,
    this.estimates = const {},
    this.isEstimated = false,
    this.finalEstimate,
    this.estimationType,
    this.sprintId,
    this.actualHours,
  });

  /// Crea da documento Firestore
  factory UserStoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return UserStoryModel.fromMap(doc.id, data);
  }

  /// Crea da mappa
  factory UserStoryModel.fromMap(String id, Map<String, dynamic> data) {
    // Parse estimates map
    final estimatesData = data['estimates'] as Map<String, dynamic>? ?? {};
    final estimates = estimatesData.map(
      (key, value) => MapEntry(
        key,
        StoryEstimate.fromMap(value as Map<String, dynamic>),
      ),
    );

    return UserStoryModel(
      id: id,
      projectId: data['projectId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      businessValue: data['businessValue'] ?? 5,
      storyPoints: data['storyPoints'],
      priority: StoryPriority.values.firstWhere(
        (p) => p.name == data['priority'],
        orElse: () => StoryPriority.should,
      ),
      status: StoryStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => StoryStatus.backlog,
      ),
      tags: List<String>.from(data['tags'] ?? []),
      acceptanceCriteria: List<String>.from(data['acceptanceCriteria'] ?? []),
      dependencies: List<String>.from(data['dependencies'] ?? []),
      assigneeEmail: data['assigneeEmail'],
      order: data['order'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: data['createdBy'] ?? '',
      startedAt: (data['startedAt'] as Timestamp?)?.toDate(),
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      estimates: estimates,
      isEstimated: data['isEstimated'] ?? false,
      finalEstimate: data['finalEstimate'],
      estimationType: data['estimationType'] != null
          ? EstimationType.values.firstWhere(
              (e) => e.name == data['estimationType'],
              orElse: () => EstimationType.planningPoker,
            )
          : null,
      sprintId: data['sprintId'],
      actualHours: data['actualHours'],
    );
  }

  /// Converte per Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'projectId': projectId,
      'title': title,
      'description': description,
      'businessValue': businessValue,
      if (storyPoints != null) 'storyPoints': storyPoints,
      'priority': priority.name,
      'status': status.name,
      'tags': tags,
      'acceptanceCriteria': acceptanceCriteria,
      'dependencies': dependencies,
      if (assigneeEmail != null) 'assigneeEmail': assigneeEmail,
      'order': order,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
      if (startedAt != null) 'startedAt': Timestamp.fromDate(startedAt!),
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
      'estimates': estimates.map((k, v) => MapEntry(k, v.toMap())),
      'isEstimated': isEstimated,
      if (finalEstimate != null) 'finalEstimate': finalEstimate,
      if (estimationType != null) 'estimationType': estimationType!.name,
      if (sprintId != null) 'sprintId': sprintId,
      if (actualHours != null) 'actualHours': actualHours,
    };
  }

  /// Copia con modifiche
  UserStoryModel copyWith({
    String? id,
    String? projectId,
    String? title,
    String? description,
    int? businessValue,
    int? storyPoints,
    StoryPriority? priority,
    StoryStatus? status,
    List<String>? tags,
    List<String>? acceptanceCriteria,
    List<String>? dependencies,
    String? assigneeEmail,
    int? order,
    DateTime? createdAt,
    String? createdBy,
    DateTime? startedAt,
    DateTime? completedAt,
    Map<String, StoryEstimate>? estimates,
    bool? isEstimated,
    String? finalEstimate,
    EstimationType? estimationType,
    String? sprintId,
    int? actualHours,
  }) {
    return UserStoryModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description: description ?? this.description,
      businessValue: businessValue ?? this.businessValue,
      storyPoints: storyPoints ?? this.storyPoints,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      tags: tags ?? this.tags,
      acceptanceCriteria: acceptanceCriteria ?? this.acceptanceCriteria,
      dependencies: dependencies ?? this.dependencies,
      assigneeEmail: assigneeEmail ?? this.assigneeEmail,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      estimates: estimates ?? this.estimates,
      isEstimated: isEstimated ?? this.isEstimated,
      finalEstimate: finalEstimate ?? this.finalEstimate,
      estimationType: estimationType ?? this.estimationType,
      sprintId: sprintId ?? this.sprintId,
      actualHours: actualHours ?? this.actualHours,
    );
  }

  // =========================================================================
  // Helper per descrizione strutturata
  // =========================================================================

  /// Estrae la parte "As a [role]" dalla descrizione
  String? get asA {
    final regex = RegExp(r'As a[n]?\s+([^,]+)', caseSensitive: false);
    final match = regex.firstMatch(description);
    return match?.group(1)?.trim();
  }

  /// Estrae la parte "I want [goal]" dalla descrizione
  String? get iWant {
    final regex = RegExp(r'I want\s+(.+?)(?:,?\s+so that|$)', caseSensitive: false);
    final match = regex.firstMatch(description);
    return match?.group(1)?.trim();
  }

  /// Estrae la parte "So that [benefit]" dalla descrizione
  String? get soThat {
    final regex = RegExp(r'so that\s+(.+)', caseSensitive: false);
    final match = regex.firstMatch(description);
    return match?.group(1)?.trim();
  }

  /// Verifica se la descrizione segue il template standard
  bool get hasStandardFormat =>
      asA != null && iWant != null && soThat != null;

  // =========================================================================
  // Helper per estimation
  // =========================================================================

  /// Numero di stime ricevute
  int get estimateCount => estimates.length;

  /// Verifica se un utente ha già stimato
  bool hasEstimated(String email) => estimates.containsKey(email);

  /// Ottiene la stima di un utente
  StoryEstimate? getEstimate(String email) => estimates[email];

  /// Verifica se tutte le stime sono uguali
  bool get hasConsensus {
    if (estimates.isEmpty) return false;
    final values = estimates.values.map((e) => e.value).toSet();
    return values.length == 1 && !values.contains('?');
  }

  /// Ottiene il valore di consenso (se esiste)
  String? get consensusValue {
    if (!hasConsensus) return null;
    return estimates.values.first.value;
  }

  /// Lista dei valori di stima distinti
  List<String> get distinctEstimates {
    return estimates.values.map((e) => e.value).toSet().toList()..sort();
  }

  /// Aggiunge una stima
  UserStoryModel withEstimate(String email, StoryEstimate estimate) {
    return copyWith(
      estimates: {...estimates, email: estimate},
    );
  }

  /// Rimuove una stima
  UserStoryModel withoutEstimate(String email) {
    final newEstimates = Map<String, StoryEstimate>.from(estimates);
    newEstimates.remove(email);
    return copyWith(estimates: newEstimates);
  }

  /// Resetta tutte le stime
  UserStoryModel resetEstimates() {
    return copyWith(
      estimates: {},
      isEstimated: false,
      finalEstimate: null,
    );
  }

  // =========================================================================
  // Helper per status
  // =========================================================================

  /// Verifica se la story può essere messa in sprint
  bool get canAddToSprint => status.canAddToSprint;

  /// Verifica se la story è completata
  bool get isCompleted => status.isCompleted;

  /// Verifica se la story è in lavorazione
  bool get isInProgress => status.isInProgress;

  /// Verifica se la story è in un sprint
  bool get isInSprint => sprintId != null;

  /// Verifica se la story è bloccata da dipendenze non completate
  bool isBlockedBy(List<UserStoryModel> allStories) {
    if (dependencies.isEmpty) return false;

    for (final depId in dependencies) {
      final depStory = allStories.where((s) => s.id == depId).firstOrNull;
      if (depStory != null && !depStory.isCompleted) {
        return true;
      }
    }
    return false;
  }

  /// Ottiene la lista delle dipendenze bloccanti
  List<UserStoryModel> getBlockingDependencies(List<UserStoryModel> allStories) {
    if (dependencies.isEmpty) return [];

    return allStories
        .where((s) => dependencies.contains(s.id) && !s.isCompleted)
        .toList();
  }

  // =========================================================================
  // Helper per acceptance criteria
  // =========================================================================

  /// Aggiunge un criterio di accettazione
  UserStoryModel withAcceptanceCriterion(String criterion) {
    return copyWith(
      acceptanceCriteria: [...acceptanceCriteria, criterion],
    );
  }

  /// Rimuove un criterio di accettazione
  UserStoryModel withoutAcceptanceCriterion(int index) {
    final newCriteria = List<String>.from(acceptanceCriteria);
    if (index >= 0 && index < newCriteria.length) {
      newCriteria.removeAt(index);
    }
    return copyWith(acceptanceCriteria: newCriteria);
  }

  // =========================================================================
  // Helper per tags
  // =========================================================================

  /// Aggiunge un tag
  UserStoryModel withTag(String tag) {
    if (tags.contains(tag)) return this;
    return copyWith(tags: [...tags, tag]);
  }

  /// Rimuove un tag
  UserStoryModel withoutTag(String tag) {
    return copyWith(tags: tags.where((t) => t != tag).toList());
  }

  // =========================================================================
  // Helper per calcoli
  // =========================================================================

  /// Calcola il tempo di ciclo (da inProgress a done)
  int? get cycleTimeDays {
    if (startedAt == null || completedAt == null) return null;
    return completedAt!.difference(startedAt!).inDays;
  }

  /// Calcola il lead time (da creazione a done)
  int? get leadTimeDays {
    if (completedAt == null) return null;
    return completedAt!.difference(createdAt).inDays;
  }

  /// Calcola la differenza tra stima e ore effettive
  int? get estimationVariance {
    if (storyPoints == null || actualHours == null) return null;
    // Assumendo 1 story point = 4 ore (convenzione comune)
    final estimatedHours = storyPoints! * 4;
    return actualHours! - estimatedHours;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserStoryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  // =========================================================================
  // Helper per display
  // =========================================================================

  /// Story ID formattato (es. "US-001")
  String get storyId => 'US-${(order + 1).toString().padLeft(3, '0')}';

  /// Conta i criteri di accettazione completati (convenzione: iniziano con "[x]" o "✓")
  int get completedAcceptanceCriteria {
    return acceptanceCriteria.where((c) =>
        c.startsWith('[x]') ||
        c.startsWith('[X]') ||
        c.startsWith('✓') ||
        c.startsWith('✔')
    ).length;
  }

  @override
  String toString() => 'UserStoryModel(id: $id, title: $title)';
}

/// Modello per una singola stima di una story
class StoryEstimate {
  final String voterEmail;
  final String voterName;
  final String value; // '1', '2', '3', '5', '8', '13', '21', '?', 'XS', 'S', 'M', 'L', 'XL', 'XXL'
  final DateTime votedAt;
  final EstimationType type;

  // Per Three-Point estimation
  final int? optimistic;
  final int? realistic;
  final int? pessimistic;

  const StoryEstimate({
    required this.voterEmail,
    required this.voterName,
    required this.value,
    required this.votedAt,
    this.type = EstimationType.planningPoker,
    this.optimistic,
    this.realistic,
    this.pessimistic,
  });

  factory StoryEstimate.fromMap(Map<String, dynamic> data) {
    return StoryEstimate(
      voterEmail: data['voterEmail'] ?? '',
      voterName: data['voterName'] ?? '',
      value: data['value'] ?? '?',
      votedAt: (data['votedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      type: EstimationType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => EstimationType.planningPoker,
      ),
      optimistic: data['optimistic'],
      realistic: data['realistic'],
      pessimistic: data['pessimistic'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'voterEmail': voterEmail,
      'voterName': voterName,
      'value': value,
      'votedAt': Timestamp.fromDate(votedAt),
      'type': type.name,
      if (optimistic != null) 'optimistic': optimistic,
      if (realistic != null) 'realistic': realistic,
      if (pessimistic != null) 'pessimistic': pessimistic,
    };
  }

  /// Calcola la stima PERT per Three-Point
  double? get pertEstimate {
    if (optimistic == null || realistic == null || pessimistic == null) {
      return null;
    }
    return (optimistic! + 4 * realistic! + pessimistic!) / 6;
  }

  /// Converte T-Shirt size in story points
  int? get storyPointsFromTShirt {
    return EstimationType.tshirtToPoints(value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StoryEstimate &&
           other.voterEmail == voterEmail &&
           other.value == value;
  }

  @override
  int get hashCode => Object.hash(voterEmail, value);
}
