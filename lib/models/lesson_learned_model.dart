import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

enum LessonCategory {
  process,
  technical,
  team,
  communication,
  tools,
  quality,
  estimation;
}

extension LessonCategoryExt on LessonCategory {
  String get displayName {
    switch (this) {
      case LessonCategory.process: return 'Process';
      case LessonCategory.technical: return 'Technical';
      case LessonCategory.team: return 'Team';
      case LessonCategory.communication: return 'Communication';
      case LessonCategory.tools: return 'Tools';
      case LessonCategory.quality: return 'Quality';
      case LessonCategory.estimation: return 'Estimation';
    }
  }

  String getLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case LessonCategory.process: return l10n.lessonCategoryProcess;
      case LessonCategory.technical: return l10n.lessonCategoryTechnical;
      case LessonCategory.team: return l10n.lessonCategoryTeam;
      case LessonCategory.communication: return l10n.lessonCategoryCommunication;
      case LessonCategory.tools: return l10n.lessonCategoryTools;
      case LessonCategory.quality: return l10n.lessonCategoryQuality;
      case LessonCategory.estimation: return l10n.lessonCategoryEstimation;
    }
  }

  Color get color {
    switch (this) {
      case LessonCategory.process: return const Color(0xFF2196F3);
      case LessonCategory.technical: return const Color(0xFF9C27B0);
      case LessonCategory.team: return const Color(0xFF4CAF50);
      case LessonCategory.communication: return const Color(0xFFFF9800);
      case LessonCategory.tools: return const Color(0xFF607D8B);
      case LessonCategory.quality: return const Color(0xFFE91E63);
      case LessonCategory.estimation: return const Color(0xFF00BCD4);
    }
  }

  IconData get icon {
    switch (this) {
      case LessonCategory.process: return Icons.settings;
      case LessonCategory.technical: return Icons.code;
      case LessonCategory.team: return Icons.group;
      case LessonCategory.communication: return Icons.chat;
      case LessonCategory.tools: return Icons.build;
      case LessonCategory.quality: return Icons.verified;
      case LessonCategory.estimation: return Icons.timer;
    }
  }
}

enum LessonType {
  strength,
  weakness,
  recommendation;
}

extension LessonTypeExt on LessonType {
  String get displayName {
    switch (this) {
      case LessonType.strength: return 'Strength';
      case LessonType.weakness: return 'Weakness';
      case LessonType.recommendation: return 'Recommendation';
    }
  }

  String getLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case LessonType.strength: return l10n.lessonTypeStrength;
      case LessonType.weakness: return l10n.lessonTypeWeakness;
      case LessonType.recommendation: return l10n.lessonTypeRecommendation;
    }
  }

  Color get color {
    switch (this) {
      case LessonType.strength: return const Color(0xFF4CAF50);
      case LessonType.weakness: return const Color(0xFFF44336);
      case LessonType.recommendation: return const Color(0xFF2196F3);
    }
  }

  IconData get icon {
    switch (this) {
      case LessonType.strength: return Icons.thumb_up;
      case LessonType.weakness: return Icons.warning;
      case LessonType.recommendation: return Icons.lightbulb;
    }
  }
}

class LessonLearnedModel {
  final String id;
  final String projectId;
  final String? retroId;
  final String? sprintId;
  final String? sprintName;
  final LessonCategory category;
  final LessonType type;
  final String title;
  final String description;
  final String? rootCause;
  final String? recommendation;
  final List<String> sourceCardIds;
  final List<String> sourceActionItemIds;
  final List<String> tags;
  final bool isRecurring;
  final int occurrenceCount;
  final bool isResolved;
  final DateTime? resolvedAt;
  final String? importedFromProjectId;
  final String? importedFromProjectName;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LessonLearnedModel({
    required this.id,
    required this.projectId,
    this.retroId,
    this.sprintId,
    this.sprintName,
    required this.category,
    required this.type,
    required this.title,
    required this.description,
    this.rootCause,
    this.recommendation,
    this.sourceCardIds = const [],
    this.sourceActionItemIds = const [],
    this.tags = const [],
    this.isRecurring = false,
    this.occurrenceCount = 1,
    this.isResolved = false,
    this.resolvedAt,
    this.importedFromProjectId,
    this.importedFromProjectName,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LessonLearnedModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LessonLearnedModel.fromMap(data, doc.id);
  }

  factory LessonLearnedModel.fromMap(Map<String, dynamic> data, [String? docId]) {
    return LessonLearnedModel(
      id: docId ?? data['id'] ?? '',
      projectId: data['projectId'] ?? '',
      retroId: data['retroId'],
      sprintId: data['sprintId'],
      sprintName: data['sprintName'],
      category: LessonCategory.values.firstWhere(
        (c) => c.name == data['category'],
        orElse: () => LessonCategory.process,
      ),
      type: LessonType.values.firstWhere(
        (t) => t.name == data['type'],
        orElse: () => LessonType.recommendation,
      ),
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      rootCause: data['rootCause'],
      recommendation: data['recommendation'],
      sourceCardIds: List<String>.from(data['sourceCardIds'] ?? []),
      sourceActionItemIds: List<String>.from(data['sourceActionItemIds'] ?? []),
      tags: List<String>.from(data['tags'] ?? []),
      isRecurring: data['isRecurring'] ?? false,
      occurrenceCount: data['occurrenceCount'] ?? 1,
      isResolved: data['isResolved'] ?? false,
      resolvedAt: (data['resolvedAt'] as Timestamp?)?.toDate(),
      importedFromProjectId: data['importedFromProjectId'],
      importedFromProjectName: data['importedFromProjectName'],
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'projectId': projectId,
      if (retroId != null) 'retroId': retroId,
      if (sprintId != null) 'sprintId': sprintId,
      if (sprintName != null) 'sprintName': sprintName,
      'category': category.name,
      'type': type.name,
      'title': title,
      'description': description,
      if (rootCause != null) 'rootCause': rootCause,
      if (recommendation != null) 'recommendation': recommendation,
      'sourceCardIds': sourceCardIds,
      'sourceActionItemIds': sourceActionItemIds,
      'tags': tags,
      'isRecurring': isRecurring,
      'occurrenceCount': occurrenceCount,
      'isResolved': isResolved,
      if (resolvedAt != null) 'resolvedAt': Timestamp.fromDate(resolvedAt!),
      if (importedFromProjectId != null) 'importedFromProjectId': importedFromProjectId,
      if (importedFromProjectName != null) 'importedFromProjectName': importedFromProjectName,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  LessonLearnedModel copyWith({
    String? id,
    String? projectId,
    String? retroId,
    String? sprintId,
    String? sprintName,
    LessonCategory? category,
    LessonType? type,
    String? title,
    String? description,
    String? rootCause,
    String? recommendation,
    List<String>? sourceCardIds,
    List<String>? sourceActionItemIds,
    List<String>? tags,
    bool? isRecurring,
    int? occurrenceCount,
    bool? isResolved,
    DateTime? resolvedAt,
    String? importedFromProjectId,
    String? importedFromProjectName,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LessonLearnedModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      retroId: retroId ?? this.retroId,
      sprintId: sprintId ?? this.sprintId,
      sprintName: sprintName ?? this.sprintName,
      category: category ?? this.category,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      rootCause: rootCause ?? this.rootCause,
      recommendation: recommendation ?? this.recommendation,
      sourceCardIds: sourceCardIds ?? this.sourceCardIds,
      sourceActionItemIds: sourceActionItemIds ?? this.sourceActionItemIds,
      tags: tags ?? this.tags,
      isRecurring: isRecurring ?? this.isRecurring,
      occurrenceCount: occurrenceCount ?? this.occurrenceCount,
      isResolved: isResolved ?? this.isResolved,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      importedFromProjectId: importedFromProjectId ?? this.importedFromProjectId,
      importedFromProjectName: importedFromProjectName ?? this.importedFromProjectName,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
