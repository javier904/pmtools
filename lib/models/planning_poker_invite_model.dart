import 'package:cloud_firestore/cloud_firestore.dart';
import 'planning_poker_participant_model.dart';

/// Status possibili per un invito
enum InviteStatus {
  pending,   // Invito inviato, in attesa di risposta
  accepted,  // Invito accettato
  declined,  // Invito rifiutato
  expired,   // Invito scaduto
  revoked,   // Invito revocato dal facilitatore
}

/// Modello per un invito a una sessione di Planning Poker
class PlanningPokerInviteModel {
  final String id;
  final String sessionId;
  final String email;
  final ParticipantRole role;
  final InviteStatus status;
  final String invitedBy;       // Email di chi ha invitato
  final String invitedByName;   // Nome di chi ha invitato
  final DateTime invitedAt;
  final DateTime expiresAt;
  final String token;           // Token univoco per il link
  final DateTime? acceptedAt;
  final DateTime? declinedAt;
  final String? declineReason;

  const PlanningPokerInviteModel({
    required this.id,
    required this.sessionId,
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
    this.declineReason,
  });

  /// Durata default di validità dell'invito (7 giorni)
  static const Duration defaultExpiration = Duration(days: 7);

  /// Verifica se l'invito è ancora valido (non scaduto e pending)
  bool get isValid =>
      status == InviteStatus.pending &&
      DateTime.now().isBefore(expiresAt);

  /// Verifica se l'invito è scaduto
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Verifica se l'invito è stato accettato
  bool get isAccepted => status == InviteStatus.accepted;

  /// Verifica se l'invito è in attesa
  bool get isPending => status == InviteStatus.pending;

  /// Giorni rimanenti prima della scadenza
  int get daysUntilExpiration {
    final diff = expiresAt.difference(DateTime.now());
    return diff.inDays;
  }

  /// Genera il link di invito - nuovo formato deep link
  String generateInviteLink(String baseUrl) {
    return '$baseUrl/#/invite/estimation-room/$sessionId';
  }

  /// Crea da documento Firestore
  factory PlanningPokerInviteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PlanningPokerInviteModel(
      id: doc.id,
      sessionId: data['sessionId'] ?? '',
      email: data['email'] ?? '',
      role: _parseRole(data['role']),
      status: _parseStatus(data['status']),
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

  /// Crea da Map (per dati inline)
  factory PlanningPokerInviteModel.fromMap(Map<String, dynamic> data, String id) {
    return PlanningPokerInviteModel(
      id: id,
      sessionId: data['sessionId'] ?? '',
      email: data['email'] ?? '',
      role: _parseRole(data['role']),
      status: _parseStatus(data['status']),
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
      'sessionId': sessionId,
      'email': email.toLowerCase(),
      'role': role.name,
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

  /// Crea copia con modifiche
  PlanningPokerInviteModel copyWith({
    String? id,
    String? sessionId,
    String? email,
    ParticipantRole? role,
    InviteStatus? status,
    String? invitedBy,
    String? invitedByName,
    DateTime? invitedAt,
    DateTime? expiresAt,
    String? token,
    DateTime? acceptedAt,
    DateTime? declinedAt,
    String? declineReason,
  }) {
    return PlanningPokerInviteModel(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      email: email ?? this.email,
      role: role ?? this.role,
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

  /// Parse role from string
  static ParticipantRole _parseRole(String? role) {
    switch (role) {
      case 'facilitator':
        return ParticipantRole.facilitator;
      case 'observer':
        return ParticipantRole.observer;
      case 'voter':
      default:
        return ParticipantRole.voter;
    }
  }

  /// Parse status from string
  static InviteStatus _parseStatus(String? status) {
    switch (status) {
      case 'accepted':
        return InviteStatus.accepted;
      case 'declined':
        return InviteStatus.declined;
      case 'expired':
        return InviteStatus.expired;
      case 'revoked':
        return InviteStatus.revoked;
      case 'pending':
      default:
        return InviteStatus.pending;
    }
  }

  @override
  String toString() {
    return 'PlanningPokerInviteModel(id: $id, email: $email, role: $role, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlanningPokerInviteModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Extension per ottenere label italiano dello status
extension InviteStatusExtension on InviteStatus {
  String get label {
    switch (this) {
      case InviteStatus.pending:
        return 'In attesa';
      case InviteStatus.accepted:
        return 'Accettato';
      case InviteStatus.declined:
        return 'Rifiutato';
      case InviteStatus.expired:
        return 'Scaduto';
      case InviteStatus.revoked:
        return 'Revocato';
    }
  }

  String get icon {
    switch (this) {
      case InviteStatus.pending:
        return '⏳';
      case InviteStatus.accepted:
        return '✅';
      case InviteStatus.declined:
        return '❌';
      case InviteStatus.expired:
        return '⌛';
      case InviteStatus.revoked:
        return '🚫';
    }
  }
}
