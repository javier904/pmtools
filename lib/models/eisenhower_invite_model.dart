import 'package:cloud_firestore/cloud_firestore.dart';
import 'eisenhower_participant_model.dart';

/// Status possibili per un invito
enum EisenhowerInviteStatus {
  pending,   // Invito inviato, in attesa di risposta
  accepted,  // Invito accettato
  declined,  // Invito rifiutato
  expired,   // Invito scaduto
  revoked,   // Invito revocato dal facilitatore
}

/// Modello per un invito a una Matrice di Eisenhower
class EisenhowerInviteModel {
  final String id;
  final String matrixId;
  final String email;
  final EisenhowerParticipantRole role;
  final EisenhowerInviteStatus status;
  final String invitedBy;       // Email di chi ha invitato
  final String invitedByName;   // Nome di chi ha invitato
  final DateTime invitedAt;
  final DateTime expiresAt;
  final String token;           // Token univoco per il link
  final DateTime? acceptedAt;
  final DateTime? declinedAt;
  final String? declineReason;

  const EisenhowerInviteModel({
    required this.id,
    required this.matrixId,
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
      status == EisenhowerInviteStatus.pending &&
      DateTime.now().isBefore(expiresAt);

  /// Verifica se l'invito è scaduto
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Verifica se l'invito è stato accettato
  bool get isAccepted => status == EisenhowerInviteStatus.accepted;

  /// Verifica se l'invito è in attesa
  bool get isPending => status == EisenhowerInviteStatus.pending;

  /// Giorni rimanenti prima della scadenza
  int get daysUntilExpiration {
    final diff = expiresAt.difference(DateTime.now());
    return diff.inDays;
  }

  /// Genera il link di invito
  String generateInviteLink(String baseUrl) {
    return '$baseUrl/eisenhower/invite/$token';
  }

  /// Crea da documento Firestore
  factory EisenhowerInviteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EisenhowerInviteModel(
      id: doc.id,
      matrixId: data['matrixId'] ?? '',
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
  factory EisenhowerInviteModel.fromMap(Map<String, dynamic> data, String id) {
    return EisenhowerInviteModel(
      id: id,
      matrixId: data['matrixId'] ?? '',
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
      'matrixId': matrixId,
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
  EisenhowerInviteModel copyWith({
    String? id,
    String? matrixId,
    String? email,
    EisenhowerParticipantRole? role,
    EisenhowerInviteStatus? status,
    String? invitedBy,
    String? invitedByName,
    DateTime? invitedAt,
    DateTime? expiresAt,
    String? token,
    DateTime? acceptedAt,
    DateTime? declinedAt,
    String? declineReason,
  }) {
    return EisenhowerInviteModel(
      id: id ?? this.id,
      matrixId: matrixId ?? this.matrixId,
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
  static EisenhowerParticipantRole _parseRole(String? role) {
    switch (role) {
      case 'facilitator':
        return EisenhowerParticipantRole.facilitator;
      case 'observer':
        return EisenhowerParticipantRole.observer;
      case 'voter':
      default:
        return EisenhowerParticipantRole.voter;
    }
  }

  /// Parse status from string
  static EisenhowerInviteStatus _parseStatus(String? status) {
    switch (status) {
      case 'accepted':
        return EisenhowerInviteStatus.accepted;
      case 'declined':
        return EisenhowerInviteStatus.declined;
      case 'expired':
        return EisenhowerInviteStatus.expired;
      case 'revoked':
        return EisenhowerInviteStatus.revoked;
      case 'pending':
      default:
        return EisenhowerInviteStatus.pending;
    }
  }

  /// Genera un token random di 32 caratteri
  static String generateToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().microsecondsSinceEpoch;
    final buffer = StringBuffer();
    for (var i = 0; i < 32; i++) {
      buffer.write(chars[(random + i * 7) % chars.length]);
    }
    return buffer.toString();
  }

  @override
  String toString() {
    return 'EisenhowerInviteModel(id: $id, email: $email, role: $role, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EisenhowerInviteModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Extension per ottenere label italiano dello status
extension EisenhowerInviteStatusExtension on EisenhowerInviteStatus {
  String get label {
    switch (this) {
      case EisenhowerInviteStatus.pending:
        return 'In attesa';
      case EisenhowerInviteStatus.accepted:
        return 'Accettato';
      case EisenhowerInviteStatus.declined:
        return 'Rifiutato';
      case EisenhowerInviteStatus.expired:
        return 'Scaduto';
      case EisenhowerInviteStatus.revoked:
        return 'Revocato';
    }
  }

  String get icon {
    switch (this) {
      case EisenhowerInviteStatus.pending:
        return '⏳';
      case EisenhowerInviteStatus.accepted:
        return '✅';
      case EisenhowerInviteStatus.declined:
        return '❌';
      case EisenhowerInviteStatus.expired:
        return '⌛';
      case EisenhowerInviteStatus.revoked:
        return '🚫';
    }
  }
}
