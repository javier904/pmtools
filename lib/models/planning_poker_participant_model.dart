import 'package:cloud_firestore/cloud_firestore.dart';

/// Ruolo di un partecipante nella sessione
enum ParticipantRole {
  facilitator,  // Gestisce la sessione, reveal, etc.
  voter,        // Partecipa alla votazione
  observer,     // Solo visualizzazione
}

extension ParticipantRoleExtension on ParticipantRole {
  String get displayName {
    switch (this) {
      case ParticipantRole.facilitator:
        return 'Facilitatore';
      case ParticipantRole.voter:
        return 'Votante';
      case ParticipantRole.observer:
        return 'Osservatore';
    }
  }

  String get name {
    switch (this) {
      case ParticipantRole.facilitator:
        return 'facilitator';
      case ParticipantRole.voter:
        return 'voter';
      case ParticipantRole.observer:
        return 'observer';
    }
  }

  static ParticipantRole fromString(String? value) {
    switch (value) {
      case 'facilitator':
        return ParticipantRole.facilitator;
      case 'observer':
        return ParticipantRole.observer;
      default:
        return ParticipantRole.voter;
    }
  }
}

/// Modello per un partecipante alla sessione di Planning Poker
class PlanningPokerParticipantModel {
  final String email;
  final String name;
  final ParticipantRole role;
  final DateTime joinedAt;
  final bool isOnline;
  final DateTime? lastActivity;

  PlanningPokerParticipantModel({
    required this.email,
    required this.name,
    this.role = ParticipantRole.voter,
    required this.joinedAt,
    this.isOnline = false,
    this.lastActivity,
  });

  /// Crea da Map (embedded in sessione)
  factory PlanningPokerParticipantModel.fromMap(String email, Map<String, dynamic> map) {
    return PlanningPokerParticipantModel(
      email: email,
      name: map['name'] ?? email.split('@').first,
      role: ParticipantRoleExtension.fromString(map['role']),
      joinedAt: (map['joinedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isOnline: map['isOnline'] ?? false,
      lastActivity: (map['lastActivity'] as Timestamp?)?.toDate(),
    );
  }

  /// Converte in Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role.name,
      'joinedAt': Timestamp.fromDate(joinedAt),
      'isOnline': isOnline,
      if (lastActivity != null) 'lastActivity': Timestamp.fromDate(lastActivity!),
    };
  }

  /// Copia con modifiche
  PlanningPokerParticipantModel copyWith({
    String? email,
    String? name,
    ParticipantRole? role,
    DateTime? joinedAt,
    bool? isOnline,
    DateTime? lastActivity,
  }) {
    return PlanningPokerParticipantModel(
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isOnline: isOnline ?? this.isOnline,
      lastActivity: lastActivity ?? this.lastActivity,
    );
  }

  /// Verifica se il partecipante può votare
  bool get canVote => role == ParticipantRole.voter || role == ParticipantRole.facilitator;

  /// Verifica se il partecipante e' facilitator
  bool get isFacilitator => role == ParticipantRole.facilitator;

  /// Verifica se il partecipante e' osservatore
  bool get isObserver => role == ParticipantRole.observer;

  /// Iniziale del nome per avatar
  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';

  @override
  String toString() {
    return 'Participant(email: $email, name: $name, role: ${role.name}, online: $isOnline)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlanningPokerParticipantModel && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
