import 'package:flutter/material.dart';

enum TodoTaskStatus {
  todo,
  in_progress,
  done,
}

enum TodoTaskPriority {
  low,
  medium,
  high,
}

// ══════════════════════════════════════════════════════════════════════════════
// HELPER MODELS
// ══════════════════════════════════════════════════════════════════════════════

class TodoLabel {
  final String id;
  final String title;
  final int colorValue;

  const TodoLabel({
    required this.id, 
    required this.title, 
    required this.colorValue
  });

  Map<String, dynamic> toMap() => {
    'id': id, 
    'title': title, 
    'colorValue': colorValue
  };

  factory TodoLabel.fromMap(Map<String, dynamic> map) {
    return TodoLabel(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(), // Fallback if missing
      title: map['title'] ?? map['name'] ?? '', // Handle legacy 'name'
      colorValue: map['colorValue'] ?? 0xFF000000, 
    );
  }
  
  // Getter for name compatibility if needed elsewhere
  String get name => title;
}

class TodoSubtask {
  final String id;
  final String title;
  final bool isCompleted;

  const TodoSubtask({required this.id, required this.title, this.isCompleted = false});

  Map<String, dynamic> toMap() => {'id': id, 'title': title, 'isCompleted': isCompleted};

  factory TodoSubtask.fromMap(Map<String, dynamic> map) {
    return TodoSubtask(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  TodoSubtask copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return TodoSubtask(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TodoComment {
  final String id;
  final String authorEmail;
  final String authorName;
  final String text;
  final String? imageUrl; // Added field for image attachment
  final DateTime timestamp;

  const TodoComment({
    required this.id,
    required this.authorEmail,
    required this.authorName,
    required this.text,
    this.imageUrl,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorEmail': authorEmail,
      'authorName': authorName,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory TodoComment.fromMap(Map<String, dynamic> map) {
    return TodoComment(
      id: map['id'] ?? '',
      authorEmail: map['authorEmail'] ?? '',
      authorName: map['authorName'] ?? '',
      text: map['text'] ?? '',
      imageUrl: map['imageUrl'],
      timestamp: DateTime.tryParse(map['timestamp'] ?? '') ?? DateTime.now(),
    );
  }
}

class TodoAttachment {
  final String id;
  final String name;
  final String url;
  final String type; // 'link', 'drive', 'sheet', etc.

  const TodoAttachment({
    required this.id,
    required this.name,
    required this.url,
    this.type = 'link',
  });

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'url': url, 'type': type};

  factory TodoAttachment.fromMap(Map<String, dynamic> map) {
    return TodoAttachment(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      type: map['type'] ?? 'link',
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// MAIN MODEL
// ══════════════════════════════════════════════════════════════════════════════

class TodoTaskModel {
  final String id;
  final String listId;
  final String title;
  final String description;
  final String statusId; // Changed from enum to String
  final TodoTaskPriority priority;
  final List<String> assignedTo;
  final List<TodoLabel> tags;
  final DateTime? startDate;
  final DateTime? dueDate;
  final int? effort; // Story Points or Hours
  final List<TodoAttachment> attachments;
  final List<TodoSubtask> subtasks;
  final List<TodoComment> comments;
  final DateTime createdAt;
  final DateTime updatedAt;

  // 🗄️ Archiviazione
  final bool isArchived;
  final DateTime? archivedAt;

  const TodoTaskModel({
    required this.id,
    required this.listId,
    required this.title,
    this.description = '',
    this.statusId = 'todo', // Default to 'todo' id
    this.priority = TodoTaskPriority.medium,
    this.assignedTo = const [],
    this.tags = const [],
    this.startDate,
    this.dueDate,
    this.effort,
    this.attachments = const [],
    this.subtasks = const [],
    this.comments = const [],
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
    this.archivedAt,
  });

  // Helpers
  bool get isCompleted => statusId == 'done' || statusId == 'completed';
  int get completedSubtasks => subtasks.where((s) => s.isCompleted).length;
  double get progress => subtasks.isEmpty ? 0 : completedSubtasks / subtasks.length;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'listId': listId,
      'title': title,
      'description': description,
      'statusId': statusId,
      'priority': priority.name,
      'assignedTo': assignedTo,
      'tags': tags.map((t) => t.toMap()).toList(),
      'startDate': startDate?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'effort': effort,
      'attachments': attachments.map((a) => a.toMap()).toList(),
      'subtasks': subtasks.map((s) => s.toMap()).toList(),
      'comments': comments.map((c) => c.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isArchived': isArchived,
      if (archivedAt != null) 'archivedAt': archivedAt!.toIso8601String(),
    };
  }

  factory TodoTaskModel.fromMap(Map<String, dynamic> map, String docId) {
    return TodoTaskModel(
      id: docId,
      listId: map['listId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      statusId: map['statusId'] ?? map['status'] ?? 'todo', // Fallback to old 'status' field or 'todo'
      priority: TodoTaskPriority.values.firstWhere(
        (e) => e.name == map['priority'], 
        orElse: () => TodoTaskPriority.medium
      ),
      assignedTo: List<String>.from(map['assignedTo'] ?? []),
      tags: (map['tags'] as List?)
          ?.map((item) => TodoLabel.fromMap(item))
          .toList() ?? [],
      startDate: map['startDate'] != null ? DateTime.tryParse(map['startDate']) : null,
      dueDate: map['dueDate'] != null ? DateTime.tryParse(map['dueDate']) : null,
      effort: map['effort'],
      attachments: (map['attachments'] as List?)
          ?.map((item) => TodoAttachment.fromMap(item))
          .toList() ?? [],
      subtasks: (map['subtasks'] as List?)
          ?.map((item) => TodoSubtask.fromMap(item))
          .toList() ?? [],
      comments: (map['comments'] as List?)
          ?.map((item) => TodoComment.fromMap(item))
          .toList() ?? [],
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updatedAt'] ?? '') ?? DateTime.now(),
      isArchived: map['isArchived'] ?? false,
      archivedAt: map['archivedAt'] != null ? DateTime.tryParse(map['archivedAt']) : null,
    );
  }

  TodoTaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? statusId,
    TodoTaskPriority? priority,
    List<String>? assignedTo,
    List<TodoLabel>? tags,
    DateTime? startDate,
    DateTime? dueDate,
    int? effort,
    List<TodoAttachment>? attachments,
    List<TodoSubtask>? subtasks,
    List<TodoComment>? comments,
    DateTime? updatedAt,
    bool? isArchived,
    DateTime? archivedAt,
  }) {
    return TodoTaskModel(
      id: id ?? this.id,
      listId: listId,
      title: title ?? this.title,
      description: description ?? this.description,
      statusId: statusId ?? this.statusId,
      priority: priority ?? this.priority,
      assignedTo: assignedTo ?? this.assignedTo,
      tags: tags ?? this.tags,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      effort: effort ?? this.effort,
      attachments: attachments ?? this.attachments,
      subtasks: subtasks ?? this.subtasks,
      comments: comments ?? this.comments,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      isArchived: isArchived ?? this.isArchived,
      archivedAt: archivedAt ?? this.archivedAt,
    );
  }
}
