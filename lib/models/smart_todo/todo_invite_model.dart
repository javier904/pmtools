import 'package:cloud_firestore/cloud_firestore.dart';
import 'todo_participant_model.dart';

enum TodoInviteStatus {
  pending,
  accepted,
  declined,
  revoked,
  expired,
}

class TodoInviteModel {
  final String id;
  final String listId;
  final String email;
  final TodoParticipantRole role;
  final TodoInviteStatus status;
  final String invitedBy;
  final String invitedByName;
  final DateTime invitedAt;
  final DateTime expiresAt;
  final String token;
  final DateTime? acceptedAt;
  final DateTime? declinedAt;

  const TodoInviteModel({
    required this.id,
    required this.listId,
    required this.email,
    required this.role,
    required this.status,
    required this.invitedBy,
    required this.invitedByName,
    required this.invitedAt,
    required this.expiresAt,
    required this.token,
    this.acceptedAt,
    this.declinedAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isPending => status == TodoInviteStatus.pending && !isExpired;

  String generateInviteLink(String baseUrl) {
    return '$baseUrl/smart-todo/invite?token=$token';
  }

  Map<String, dynamic> toFirestore() {
    return {
      'listId': listId,
      'email': email,
      'role': role.name,
      'status': status.name,
      'invitedBy': invitedBy,
      'invitedByName': invitedByName,
      'invitedAt': Timestamp.fromDate(invitedAt),
      'expiresAt': Timestamp.fromDate(expiresAt),
      'token': token,
      'acceptedAt': acceptedAt != null ? Timestamp.fromDate(acceptedAt!) : null,
      'declinedAt': declinedAt != null ? Timestamp.fromDate(declinedAt!) : null,
    };
  }

  factory TodoInviteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoInviteModel(
      id: doc.id,
      listId: data['listId'] ?? '',
      email: data['email'] ?? '',
      role: TodoParticipantRole.values.firstWhere(
        (e) => e.name == data['role'],
        orElse: () => TodoParticipantRole.viewer,
      ),
      status: TodoInviteStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => TodoInviteStatus.pending,
      ),
      invitedBy: data['invitedBy'] ?? '',
      invitedByName: data['invitedByName'] ?? '',
      invitedAt: (data['invitedAt'] as Timestamp).toDate(),
      expiresAt: (data['expiresAt'] as Timestamp).toDate(),
      token: data['token'] ?? '',
      acceptedAt: (data['acceptedAt'] as Timestamp?)?.toDate(),
      declinedAt: (data['declinedAt'] as Timestamp?)?.toDate(),
    );
  }
    
  TodoInviteModel copyWith({
    String? token,
    DateTime? expiresAt,
    TodoInviteStatus? status,
  }) {
    return TodoInviteModel(
      id: id,
      listId: listId,
      email: email,
      role: role,
      status: status ?? this.status,
      invitedBy: invitedBy,
      invitedByName: invitedByName,
      invitedAt: invitedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      token: token ?? this.token,
      acceptedAt: acceptedAt,
      declinedAt: declinedAt,
    );
  }
}
