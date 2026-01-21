import 'package:cloud_firestore/cloud_firestore.dart';

/// Status possibili per un invito Retrospective
enum RetroInviteStatus {
  pending,   // Invito inviato, in attesa di risposta
  accepted,  // Invito accettato
  declined,  // Invito rifiutato
  expired,   // Invito scaduto
  revoked,   // Invito revocato dal facilitatore
}

/// Ruoli possibili per partecipante Retrospective
enum RetroParticipantRole {
  facilitator,  // Gestisce la sessione, timer, fasi
  participant,  // Partecipa attivamente (scrive cards, vota)
  observer,     // Visualizza senza interagire
}

/// Modello per un invito a una Retrospective Board
class RetroInviteModel {
  final String id;
  final String boardId;          // ID della retrospettiva
  final String email;
  final RetroParticipantRole role;
  final RetroInviteStatus status;
  final String invitedBy;        // Email di chi ha invitato
  final String invitedByName;    // Nome di chi ha invitato
  final DateTime invitedAt;
  final DateTime expiresAt;
  final String token;            // Token univoco per il link
  final DateTime? acceptedAt;
  final DateTime? declinedAt;
  final String? declineReason;

  const RetroInviteModel({
    required this.id,
    required this.boardId,
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
      status == RetroInviteStatus.pending &&
      DateTime.now().isBefore(expiresAt);

  /// Verifica se l'invito è scaduto
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Verifica se l'invito è stato accettato
  bool get isAccepted => status == RetroInviteStatus.accepted;

  /// Verifica se l'invito è in attesa
  bool get isPending => status == RetroInviteStatus.pending;

  /// Giorni rimanenti prima della scadenza
  int get daysUntilExpiration {
    final diff = expiresAt.difference(DateTime.now());
    return diff.inDays;
  }

  /// Genera il link di invito - deep link format
  String generateInviteLink(String baseUrl) {
    return '$baseUrl/#/invite/retro/$boardId';
  }

  /// Crea da documento Firestore
  factory RetroInviteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RetroInviteModel(
      id: doc.id,
      boardId: data['boardId'] ?? '',
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
  factory RetroInviteModel.fromMap(Map<String, dynamic> data, String id) {
    return RetroInviteModel(
      id: id,
      boardId: data['boardId'] ?? '',
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
      'boardId': boardId,
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
  RetroInviteModel copyWith({
    String? id,
    String? boardId,
    String? email,
    RetroParticipantRole? role,
    RetroInviteStatus? status,
    String? invitedBy,
    String? invitedByName,
    DateTime? invitedAt,
    DateTime? expiresAt,
    String? token,
    DateTime? acceptedAt,
    DateTime? declinedAt,
    String? declineReason,
  }) {
    return RetroInviteModel(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
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
  static RetroParticipantRole _parseRole(String? role) {
    switch (role) {
      case 'facilitator':
        return RetroParticipantRole.facilitator;
      case 'observer':
        return RetroParticipantRole.observer;
      case 'participant':
      default:
        return RetroParticipantRole.participant;
    }
  }

  /// Parse status from string
  static RetroInviteStatus _parseStatus(String? status) {
    switch (status) {
      case 'accepted':
        return RetroInviteStatus.accepted;
      case 'declined':
        return RetroInviteStatus.declined;
      case 'expired':
        return RetroInviteStatus.expired;
      case 'revoked':
        return RetroInviteStatus.revoked;
      case 'pending':
      default:
        return RetroInviteStatus.pending;
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
    return 'RetroInviteModel(id: $id, email: $email, role: $role, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RetroInviteModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Extension per ottenere label italiano dello status
extension RetroInviteStatusExtension on RetroInviteStatus {
  String get label {
    switch (this) {
      case RetroInviteStatus.pending:
        return 'In attesa';
      case RetroInviteStatus.accepted:
        return 'Accettato';
      case RetroInviteStatus.declined:
        return 'Rifiutato';
      case RetroInviteStatus.expired:
        return 'Scaduto';
      case RetroInviteStatus.revoked:
        return 'Revocato';
    }
  }

  String get icon {
    switch (this) {
      case RetroInviteStatus.pending:
        return '⏳';
      case RetroInviteStatus.accepted:
        return '✅';
      case RetroInviteStatus.declined:
        return '❌';
      case RetroInviteStatus.expired:
        return '⌛';
      case RetroInviteStatus.revoked:
        return '🚫';
    }
  }
}

/// Extension per ottenere label italiano del ruolo
extension RetroParticipantRoleExtension on RetroParticipantRole {
  String get label {
    switch (this) {
      case RetroParticipantRole.facilitator:
        return 'Facilitatore';
      case RetroParticipantRole.participant:
        return 'Partecipante';
      case RetroParticipantRole.observer:
        return 'Osservatore';
    }
  }

  String get description {
    switch (this) {
      case RetroParticipantRole.facilitator:
        return 'Gestisce la sessione, controlla timer e fasi';
      case RetroParticipantRole.participant:
        return 'Partecipa attivamente: scrive cards, vota, discute';
      case RetroParticipantRole.observer:
        return 'Visualizza la sessione senza interagire';
    }
  }

  String get icon {
    switch (this) {
      case RetroParticipantRole.facilitator:
        return '👑';
      case RetroParticipantRole.participant:
        return '✍️';
      case RetroParticipantRole.observer:
        return '👁️';
    }
  }
}
