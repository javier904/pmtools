import 'package:cloud_firestore/cloud_firestore.dart';
import 'agile_enums.dart';

/// Modello per un invito a un Progetto Agile
class AgileInviteModel {
  final String id;
  final String projectId;
  final String email;
  final AgileParticipantRole participantRole;
  final TeamRole teamRole;
  final AgileInviteStatus status;
  final String invitedBy;
  final String invitedByName;
  final DateTime invitedAt;
  final DateTime expiresAt;
  final String token;
  final DateTime? acceptedAt;
  final DateTime? declinedAt;
  final String? declineReason;

  const AgileInviteModel({
    required this.id,
    required this.projectId,
    required this.email,
    required this.participantRole,
    this.teamRole = TeamRole.developer,
    required this.status,
    required this.invitedBy,
    required this.invitedByName,
    required this.invitedAt,
    required this.expiresAt,
    required this.token,
    this.acceptedAt,
    this.declinedAt,
    this.declineReason,
  });

  /// Durata default validità invito (7 giorni)
  static const Duration defaultExpiration = Duration(days: 7);

  /// Verifica se l'invito è valido
  bool get isValid =>
      status == AgileInviteStatus.pending && DateTime.now().isBefore(expiresAt);

  /// Verifica se è scaduto
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Verifica se è stato accettato
  bool get isAccepted => status == AgileInviteStatus.accepted;

  /// Verifica se è in attesa
  bool get isPending => status == AgileInviteStatus.pending;

  /// Giorni rimanenti prima della scadenza
  int get daysUntilExpiration {
    final diff = expiresAt.difference(DateTime.now());
    return diff.inDays;
  }

  /// Genera il link di invito
  String generateInviteLink(String baseUrl) {
    return '$baseUrl/agile/invite/$token';
  }

  /// Crea da documento Firestore
  factory AgileInviteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AgileInviteModel.fromMap(data, doc.id);
  }

  /// Crea da Map
  factory AgileInviteModel.fromMap(Map<String, dynamic> data, String id) {
    return AgileInviteModel(
      id: id,
      projectId: data['projectId'] ?? '',
      email: data['email'] ?? '',
      participantRole: AgileParticipantRole.values.firstWhere(
        (r) => r.name == data['participantRole'],
        orElse: () => AgileParticipantRole.member,
      ),
      teamRole: TeamRole.values.firstWhere(
        (r) => r.name == data['teamRole'],
        orElse: () => TeamRole.developer,
      ),
      status: AgileInviteStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => AgileInviteStatus.pending,
      ),
      invitedBy: data['invitedBy'] ?? '',
      invitedByName: data['invitedByName'] ?? '',
      invitedAt: (data['invitedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      expiresAt: (data['expiresAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      token: data['token'] ?? '',
      acceptedAt: (data['acceptedAt'] as Timestamp?)?.toDate(),
      declinedAt: (data['declinedAt'] as Timestamp?)?.toDate(),
      declineReason: data['declineReason'],
    );
  }

  /// Converti a Map per Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'projectId': projectId,
      'email': email.toLowerCase(),
      'participantRole': participantRole.name,
      'teamRole': teamRole.name,
      'status': status.name,
      'invitedBy': invitedBy,
      'invitedByName': invitedByName,
      'invitedAt': Timestamp.fromDate(invitedAt),
      'expiresAt': Timestamp.fromDate(expiresAt),
      'token': token,
      if (acceptedAt != null) 'acceptedAt': Timestamp.fromDate(acceptedAt!),
      if (declinedAt != null) 'declinedAt': Timestamp.fromDate(declinedAt!),
      if (declineReason != null) 'declineReason': declineReason,
    };
  }

  /// Copia con modifiche
  AgileInviteModel copyWith({
    String? id,
    String? projectId,
    String? email,
    AgileParticipantRole? participantRole,
    TeamRole? teamRole,
    AgileInviteStatus? status,
    String? invitedBy,
    String? invitedByName,
    DateTime? invitedAt,
    DateTime? expiresAt,
    String? token,
    DateTime? acceptedAt,
    DateTime? declinedAt,
    String? declineReason,
  }) {
    return AgileInviteModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      email: email ?? this.email,
      participantRole: participantRole ?? this.participantRole,
      teamRole: teamRole ?? this.teamRole,
      status: status ?? this.status,
      invitedBy: invitedBy ?? this.invitedBy,
      invitedByName: invitedByName ?? this.invitedByName,
      invitedAt: invitedAt ?? this.invitedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      token: token ?? this.token,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      declinedAt: declinedAt ?? this.declinedAt,
      declineReason: declineReason ?? this.declineReason,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AgileInviteModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'AgileInviteModel(id: $id, email: $email, status: $status)';
}
