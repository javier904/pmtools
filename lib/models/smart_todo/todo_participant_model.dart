enum TodoParticipantRole {
  owner,
  editor,
  viewer,
}

class TodoParticipant {
  final String email;
  final String? displayName;
  final TodoParticipantRole role;
  final DateTime joinedAt;

  const TodoParticipant({
    required this.email,
    this.displayName,
    required this.role,
    required this.joinedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'role': role.name,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }

  factory TodoParticipant.fromMap(Map<String, dynamic> map) {
    return TodoParticipant(
      email: map['email'] ?? '',
      displayName: map['displayName'],
      role: TodoParticipantRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => TodoParticipantRole.viewer,
      ),
      joinedAt: _parseDate(map['joinedAt']),
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    // Handle Firestore Timestamp if imported, or dynamic check
    if (value != null && value.runtimeType.toString() == 'Timestamp') {
       return (value as dynamic).toDate(); 
    }
    return DateTime.now();
  }

  TodoParticipant copyWith({
    String? email,
    String? displayName,
    TodoParticipantRole? role,
    DateTime? joinedAt,
  }) {
    return TodoParticipant(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
