import 'todo_participant_model.dart';
import 'todo_task_model.dart';

enum TodoColumnSort {
  manual,
  priority,
  dueDate,
  createdAt,
  // alphabetical? 
}

class TodoColumn {
  final String id;
  final String title;
  final int colorValue; // For UI header color
  final bool isDone; // If tasks in this column are considered completed
  final TodoColumnSort sortBy;
  final bool sortAscending;

  const TodoColumn({
    required this.id,
    required this.title,
    this.colorValue = 0xFF2196F3, // Default blue
    this.isDone = false,
    this.sortBy = TodoColumnSort.manual,
    this.sortAscending = true,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'colorValue': colorValue,
    'isDone': isDone,
    'sortBy': sortBy.name,
    'sortAscending': sortAscending,
  };

  factory TodoColumn.fromMap(Map<String, dynamic> map) {
    return TodoColumn(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      colorValue: map['colorValue'] ?? 0xFF2196F3,
      isDone: map['isDone'] ?? false,
      sortBy: TodoColumnSort.values.firstWhere(
        (e) => e.name == map['sortBy'], 
        orElse: () => TodoColumnSort.manual
      ),
      sortAscending: map['sortAscending'] ?? true,
    );
  }
}

class TodoListModel {
  final String id;
  final String title;
  final String description;
  final String ownerId;
  final DateTime createdAt;
  final Map<String, TodoParticipant> participants;
  final List<TodoColumn> columns;
  final List<TodoLabel> availableTags;
  final List<String> pendingEmails; // New: Pending invites

  // 🗄️ Archiviazione
  final bool isArchived;
  final DateTime? archivedAt;

  const TodoListModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ownerId,
    required this.createdAt,
    required this.participants,
    this.columns = const [],
    this.availableTags = const [],
    this.pendingEmails = const [],
    this.isArchived = false,
    this.archivedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ownerId': ownerId,
      'createdAt': createdAt.toIso8601String(),
      'participants': participants.map((key, value) => MapEntry(key, value.toMap())),
      'columns': columns.map((c) => c.toMap()).toList(),
      'availableTags': availableTags.map((t) => t.toMap()).toList(),
      'participantEmails': participants.keys.map((e) => e.toLowerCase()).toList(),
      'pendingEmails': pendingEmails,
      'isArchived': isArchived,
      if (archivedAt != null) 'archivedAt': archivedAt!.toIso8601String(),
    };
  }

  factory TodoListModel.fromMap(Map<String, dynamic> map, String docId) {
    return TodoListModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      ownerId: map['ownerId'] ?? '',
      createdAt: _parseDate(map['createdAt']),
      participants: (map['participants'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, TodoParticipant.fromMap(value)),
          ) ??
          {},
      columns: (map['columns'] as List?)
          ?.map((item) => TodoColumn.fromMap(item))
          .toList() ?? 
          [
            const TodoColumn(id: 'todo', title: 'To Do', colorValue: 0xFF2196F3),
            const TodoColumn(id: 'in_progress', title: 'In Progress', colorValue: 0xFFFF9800),
            const TodoColumn(id: 'done', title: 'Done', colorValue: 0xFF4CAF50, isDone: true),
          ],
      availableTags: (map['availableTags'] as List?)
          ?.map((item) => TodoLabel.fromMap(item))
          .toList() ?? [],
      pendingEmails: List<String>.from(map['pendingEmails'] ?? []),
      isArchived: map['isArchived'] ?? false,
      archivedAt: map['archivedAt'] != null ? _parseDate(map['archivedAt']) : null,
    );
  }
  
  static DateTime _parseDate(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value != null && value.runtimeType.toString() == 'Timestamp') {
       return (value as dynamic).toDate(); 
    }
    return DateTime.now();
  }

  TodoListModel copyWith({
    String? id,
    String? title,
    String? description,
    String? ownerId,
    DateTime? createdAt,
    Map<String, TodoParticipant>? participants,
    List<TodoColumn>? columns,
    List<TodoLabel>? availableTags,
    List<String>? pendingEmails,
    bool? isArchived,
    DateTime? archivedAt,
  }) {
    return TodoListModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      participants: participants ?? this.participants,
      columns: columns ?? this.columns,
      availableTags: availableTags ?? this.availableTags,
      pendingEmails: pendingEmails ?? this.pendingEmails,
      isArchived: isArchived ?? this.isArchived,
      archivedAt: archivedAt ?? this.archivedAt,
    );
  }

  // Helpers
  bool isOwner(String email) => participants[email]?.role == TodoParticipantRole.owner;
  bool canEdit(String email) {
     // Allow any participant to edit (Owner, Editor, or even standard participant if roles are loose)
     // For now, if they are in the participants map, they can edit.
     return participants.containsKey(email);
  }
}
