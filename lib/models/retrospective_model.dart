import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Modello per una Retrospettiva di Sprint
///
/// Rappresenta la retrospettiva post-sprint con:
/// - What went well / What to improve / Action items
/// - Team sentiment voting
/// - Sprint review data
class RetrospectiveModel {
  final String id;
  final String sprintId;
  final String projectId;
  final String sprintName;
  final int sprintNumber;

  // Retrospective items
  final List<RetroItem> wentWell;
  final List<RetroItem> toImprove;
  final List<ActionItem> actionItems;

  // Team sentiment (1-5)
  final Map<String, int> sentimentVotes; // email -> sentiment (1-5)
  final double? averageSentiment;

  // Sprint Review data
  final SprintReviewData? reviewData;

  // Metadata
  final DateTime createdAt;
  final String createdBy;
  final bool isCompleted;

  const RetrospectiveModel({
    required this.id,
    required this.sprintId,
    required this.projectId,
    this.sprintName = '',
    this.sprintNumber = 0,
    this.wentWell = const [],
    this.toImprove = const [],
    this.actionItems = const [],
    this.sentimentVotes = const {},
    this.averageSentiment,
    this.reviewData,
    required this.createdAt,
    required this.createdBy,
    this.isCompleted = false,
  });

  /// Crea da documento Firestore
  factory RetrospectiveModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return RetrospectiveModel.fromMap(doc.id, data);
  }

  /// Crea da mappa
  factory RetrospectiveModel.fromMap(String id, Map<String, dynamic> data) {
    // Parse went well items
    final wentWellList = data['wentWell'] as List<dynamic>? ?? [];
    final wentWell = wentWellList
        .map((item) => RetroItem.fromMap(item as Map<String, dynamic>))
        .toList();

    // Parse to improve items
    final toImproveList = data['toImprove'] as List<dynamic>? ?? [];
    final toImprove = toImproveList
        .map((item) => RetroItem.fromMap(item as Map<String, dynamic>))
        .toList();

    // Parse action items
    final actionItemsList = data['actionItems'] as List<dynamic>? ?? [];
    final actionItems = actionItemsList
        .map((item) => ActionItem.fromMap(item as Map<String, dynamic>))
        .toList();

    // Parse sentiment votes
    final sentimentMap = data['sentimentVotes'] as Map<String, dynamic>? ?? {};
    final sentimentVotes = sentimentMap.map(
      (key, value) => MapEntry(key, value as int),
    );

    // Parse review data
    SprintReviewData? reviewData;
    if (data['reviewData'] != null) {
      reviewData = SprintReviewData.fromMap(
        data['reviewData'] as Map<String, dynamic>,
      );
    }

    return RetrospectiveModel(
      id: id,
      sprintId: data['sprintId'] ?? '',
      projectId: data['projectId'] ?? '',
      sprintName: data['sprintName'] ?? '',
      sprintNumber: data['sprintNumber'] ?? 0,
      wentWell: wentWell,
      toImprove: toImprove,
      actionItems: actionItems,
      sentimentVotes: sentimentVotes,
      averageSentiment: (data['averageSentiment'] as num?)?.toDouble(),
      reviewData: reviewData,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: data['createdBy'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  /// Converte per Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'sprintId': sprintId,
      'projectId': projectId,
      'sprintName': sprintName,
      'sprintNumber': sprintNumber,
      'wentWell': wentWell.map((item) => item.toMap()).toList(),
      'toImprove': toImprove.map((item) => item.toMap()).toList(),
      'actionItems': actionItems.map((item) => item.toMap()).toList(),
      'sentimentVotes': sentimentVotes,
      if (averageSentiment != null) 'averageSentiment': averageSentiment,
      if (reviewData != null) 'reviewData': reviewData!.toMap(),
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
      'isCompleted': isCompleted,
    };
  }

  /// Copia con modifiche
  RetrospectiveModel copyWith({
    String? id,
    String? sprintId,
    String? projectId,
    String? sprintName,
    int? sprintNumber,
    List<RetroItem>? wentWell,
    List<RetroItem>? toImprove,
    List<ActionItem>? actionItems,
    Map<String, int>? sentimentVotes,
    double? averageSentiment,
    SprintReviewData? reviewData,
    DateTime? createdAt,
    String? createdBy,
    bool? isCompleted,
  }) {
    return RetrospectiveModel(
      id: id ?? this.id,
      sprintId: sprintId ?? this.sprintId,
      projectId: projectId ?? this.projectId,
      sprintName: sprintName ?? this.sprintName,
      sprintNumber: sprintNumber ?? this.sprintNumber,
      wentWell: wentWell ?? this.wentWell,
      toImprove: toImprove ?? this.toImprove,
      actionItems: actionItems ?? this.actionItems,
      sentimentVotes: sentimentVotes ?? this.sentimentVotes,
      averageSentiment: averageSentiment ?? this.averageSentiment,
      reviewData: reviewData ?? this.reviewData,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // =========================================================================
  // Helper per retro items
  // =========================================================================

  /// Aggiunge un item "went well"
  RetrospectiveModel withWentWellItem(RetroItem item) {
    return copyWith(wentWell: [...wentWell, item]);
  }

  /// Rimuove un item "went well"
  RetrospectiveModel withoutWentWellItem(String itemId) {
    return copyWith(
      wentWell: wentWell.where((item) => item.id != itemId).toList(),
    );
  }

  /// Aggiunge un item "to improve"
  RetrospectiveModel withToImproveItem(RetroItem item) {
    return copyWith(toImprove: [...toImprove, item]);
  }

  /// Rimuove un item "to improve"
  RetrospectiveModel withoutToImproveItem(String itemId) {
    return copyWith(
      toImprove: toImprove.where((item) => item.id != itemId).toList(),
    );
  }

  /// Aggiunge un action item
  RetrospectiveModel withActionItem(ActionItem item) {
    return copyWith(actionItems: [...actionItems, item]);
  }

  /// Rimuove un action item
  RetrospectiveModel withoutActionItem(String itemId) {
    return copyWith(
      actionItems: actionItems.where((item) => item.id != itemId).toList(),
    );
  }

  // =========================================================================
  // Helper per sentiment
  // =========================================================================

  /// Aggiunge/aggiorna voto sentiment
  RetrospectiveModel withSentimentVote(String email, int sentiment) {
    final newVotes = Map<String, int>.from(sentimentVotes);
    newVotes[email] = sentiment.clamp(1, 5);

    // Ricalcola media
    final avg = newVotes.isEmpty
        ? null
        : newVotes.values.reduce((a, b) => a + b) / newVotes.length;

    return copyWith(
      sentimentVotes: newVotes,
      averageSentiment: avg,
    );
  }

  /// Ottiene il sentiment di un utente
  int? getSentimentVote(String email) => sentimentVotes[email];

  /// Numero di voti sentiment
  int get sentimentVoteCount => sentimentVotes.length;

  /// Emoji per il sentiment medio
  String get sentimentEmoji {
    if (averageSentiment == null) return '😐';
    if (averageSentiment! >= 4.5) return '😄';
    if (averageSentiment! >= 3.5) return '🙂';
    if (averageSentiment! >= 2.5) return '😐';
    if (averageSentiment! >= 1.5) return '😕';
    return '😢';
  }

  /// Descrizione del sentiment medio
  String get sentimentDescription {
    if (averageSentiment == null) return 'Nessun voto';
    if (averageSentiment! >= 4.5) return 'Molto positivo';
    if (averageSentiment! >= 3.5) return 'Positivo';
    if (averageSentiment! >= 2.5) return 'Neutro';
    if (averageSentiment! >= 1.5) return 'Negativo';
    return 'Molto negativo';
  }

  // =========================================================================
  // Helper per statistiche
  // =========================================================================

  /// Numero totale di item
  int get totalItems => wentWell.length + toImprove.length;

  /// Numero di action item completati
  int get completedActionItems =>
      actionItems.where((item) => item.isCompleted).length;

  /// Numero di action item pending
  int get pendingActionItems =>
      actionItems.where((item) => !item.isCompleted).length;

  /// Percentuale di completamento action items
  double get actionItemsCompletionRate {
    if (actionItems.isEmpty) return 0;
    return completedActionItems / actionItems.length;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RetrospectiveModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'RetrospectiveModel(id: $id, sprintId: $sprintId)';
}

/// Item della retrospettiva (went well / to improve)
class RetroItem {
  final String id;
  final String content;
  final String authorEmail;
  final String authorName;
  final DateTime createdAt;
  final int votes; // Numero di voti/like ricevuti
  final List<String> votedBy; // Email degli utenti che hanno votato
  final RetroCategory category; // Categoria opzionale

  const RetroItem({
    required this.id,
    required this.content,
    required this.authorEmail,
    required this.authorName,
    required this.createdAt,
    this.votes = 0,
    this.votedBy = const [],
    this.category = RetroCategory.general,
  });

  factory RetroItem.fromMap(Map<String, dynamic> data) {
    return RetroItem(
      id: data['id'] ?? '',
      content: data['content'] ?? '',
      authorEmail: data['authorEmail'] ?? '',
      authorName: data['authorName'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      votes: data['votes'] ?? 0,
      votedBy: List<String>.from(data['votedBy'] ?? []),
      category: RetroCategory.values.firstWhere(
        (c) => c.name == data['category'],
        orElse: () => RetroCategory.general,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'authorEmail': authorEmail,
      'authorName': authorName,
      'createdAt': Timestamp.fromDate(createdAt),
      'votes': votes,
      'votedBy': votedBy,
      'category': category.name,
    };
  }

  /// Verifica se un utente ha votato
  bool hasVoted(String email) => votedBy.contains(email);

  /// Aggiunge un voto
  RetroItem withVote(String email) {
    if (votedBy.contains(email)) return this;
    return RetroItem(
      id: id,
      content: content,
      authorEmail: authorEmail,
      authorName: authorName,
      createdAt: createdAt,
      votes: votes + 1,
      votedBy: [...votedBy, email],
      category: category,
    );
  }

  /// Rimuove un voto
  RetroItem withoutVote(String email) {
    if (!votedBy.contains(email)) return this;
    return RetroItem(
      id: id,
      content: content,
      authorEmail: authorEmail,
      authorName: authorName,
      createdAt: createdAt,
      votes: (votes - 1).clamp(0, votes),
      votedBy: votedBy.where((e) => e != email).toList(),
      category: category,
    );
  }
}

/// Categorie per gli item della retrospettiva
enum RetroCategory {
  general,
  wentWell,
  toImprove,
  process,
  tools,
  communication,
  collaboration,
  quality,
  delivery;

  String get displayName {
    switch (this) {
      case RetroCategory.general:
        return 'Generale';
      case RetroCategory.wentWell:
        return 'Cosa è andato bene';
      case RetroCategory.toImprove:
        return 'Cosa migliorare';
      case RetroCategory.process:
        return 'Processo';
      case RetroCategory.tools:
        return 'Strumenti';
      case RetroCategory.communication:
        return 'Comunicazione';
      case RetroCategory.collaboration:
        return 'Collaborazione';
      case RetroCategory.quality:
        return 'Qualità';
      case RetroCategory.delivery:
        return 'Delivery';
    }
  }

  IconData get icon {
    switch (this) {
      case RetroCategory.general:
        return Icons.label_outline;
      case RetroCategory.wentWell:
        return Icons.thumb_up_outlined;
      case RetroCategory.toImprove:
        return Icons.build_outlined;
      case RetroCategory.process:
        return Icons.account_tree_outlined;
      case RetroCategory.tools:
        return Icons.build_outlined;
      case RetroCategory.communication:
        return Icons.chat_outlined;
      case RetroCategory.collaboration:
        return Icons.people_outline;
      case RetroCategory.quality:
        return Icons.verified_outlined;
      case RetroCategory.delivery:
        return Icons.local_shipping_outlined;
    }
  }
}

/// Action item dalla retrospettiva
class ActionItem {
  final String id;
  final String description;
  final String? assigneeEmail;
  final String? assigneeName;
  final DateTime createdAt;
  final DateTime? dueDate;
  final bool isCompleted;
  final DateTime? completedAt;
  final ActionPriority priority;

  const ActionItem({
    required this.id,
    required this.description,
    this.assigneeEmail,
    this.assigneeName,
    required this.createdAt,
    this.dueDate,
    this.isCompleted = false,
    this.completedAt,
    this.priority = ActionPriority.medium,
  });

  factory ActionItem.fromMap(Map<String, dynamic> data) {
    return ActionItem(
      id: data['id'] ?? '',
      description: data['description'] ?? '',
      assigneeEmail: data['assigneeEmail'],
      assigneeName: data['assigneeName'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
      isCompleted: data['isCompleted'] ?? false,
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      priority: ActionPriority.values.firstWhere(
        (p) => p.name == data['priority'],
        orElse: () => ActionPriority.medium,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      if (assigneeEmail != null) 'assigneeEmail': assigneeEmail,
      if (assigneeName != null) 'assigneeName': assigneeName,
      'createdAt': Timestamp.fromDate(createdAt),
      if (dueDate != null) 'dueDate': Timestamp.fromDate(dueDate!),
      'isCompleted': isCompleted,
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
      'priority': priority.name,
    };
  }

  /// Marca come completato
  ActionItem complete() {
    return ActionItem(
      id: id,
      description: description,
      assigneeEmail: assigneeEmail,
      assigneeName: assigneeName,
      createdAt: createdAt,
      dueDate: dueDate,
      isCompleted: true,
      completedAt: DateTime.now(),
      priority: priority,
    );
  }

  /// Verifica se è scaduto
  bool get isOverdue {
    if (dueDate == null || isCompleted) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  /// Alias per description (usato in UI come titolo)
  String get title => description;
}

/// Priorità degli action item
enum ActionPriority {
  low,
  medium,
  high,
  critical;

  String get displayName {
    switch (this) {
      case ActionPriority.low:
        return 'Bassa';
      case ActionPriority.medium:
        return 'Media';
      case ActionPriority.high:
        return 'Alta';
      case ActionPriority.critical:
        return 'Critica';
    }
  }

  Color get color {
    switch (this) {
      case ActionPriority.low:
        return const Color(0xFF9E9E9E);
      case ActionPriority.medium:
        return const Color(0xFF2196F3);
      case ActionPriority.high:
        return const Color(0xFFFB8C00);
      case ActionPriority.critical:
        return const Color(0xFFE53935);
    }
  }
}

/// Dati della Sprint Review
class SprintReviewData {
  final int storiesPlanned;
  final int storiesCompleted;
  final int pointsPlanned;
  final int pointsCompleted;
  final double velocity;
  final String whatWentWell;
  final String whatWentBad;
  final String demoNotes;
  final List<String> stakeholderFeedback;

  const SprintReviewData({
    this.storiesPlanned = 0,
    this.storiesCompleted = 0,
    this.pointsPlanned = 0,
    this.pointsCompleted = 0,
    this.velocity = 0,
    this.whatWentWell = '',
    this.whatWentBad = '',
    this.demoNotes = '',
    this.stakeholderFeedback = const [],
  });

  factory SprintReviewData.fromMap(Map<String, dynamic> data) {
    return SprintReviewData(
      storiesPlanned: data['storiesPlanned'] ?? 0,
      storiesCompleted: data['storiesCompleted'] ?? 0,
      pointsPlanned: data['pointsPlanned'] ?? 0,
      pointsCompleted: data['pointsCompleted'] ?? 0,
      velocity: (data['velocity'] as num?)?.toDouble() ?? 0,
      whatWentWell: data['whatWentWell'] ?? '',
      whatWentBad: data['whatWentBad'] ?? '',
      demoNotes: data['demoNotes'] ?? '',
      stakeholderFeedback: List<String>.from(data['stakeholderFeedback'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storiesPlanned': storiesPlanned,
      'storiesCompleted': storiesCompleted,
      'pointsPlanned': pointsPlanned,
      'pointsCompleted': pointsCompleted,
      'velocity': velocity,
      'whatWentWell': whatWentWell,
      'whatWentBad': whatWentBad,
      'demoNotes': demoNotes,
      'stakeholderFeedback': stakeholderFeedback,
    };
  }

  /// Percentuale di completamento stories
  double get storyCompletionRate {
    if (storiesPlanned == 0) return 0;
    return storiesCompleted / storiesPlanned;
  }

  /// Percentuale di completamento punti
  double get pointCompletionRate {
    if (pointsPlanned == 0) return 0;
    return pointsCompleted / pointsPlanned;
  }
}
