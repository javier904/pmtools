import 'package:cloud_firestore/cloud_firestore.dart';

/// Ruolo di un partecipante nella matrice Eisenhower
enum EisenhowerParticipantRole {
  facilitator,  // Gestisce la matrice, reveal, etc.
  voter,        // Partecipa alla votazione
  observer,     // Solo visualizzazione
}

extension EisenhowerParticipantRoleExtension on EisenhowerParticipantRole {
  String get displayName {
    switch (this) {
      case EisenhowerParticipantRole.facilitator:
        return 'Facilitatore';
      case EisenhowerParticipantRole.voter:
        return 'Votante';
      case EisenhowerParticipantRole.observer:
        return 'Osservatore';
    }
  }

  String get name {
    switch (this) {
      case EisenhowerParticipantRole.facilitator:
        return 'facilitator';
      case EisenhowerParticipantRole.voter:
        return 'voter';
      case EisenhowerParticipantRole.observer:
        return 'observer';
    }
  }

  static EisenhowerParticipantRole fromString(String? value) {
    switch (value) {
      case 'facilitator':
        return EisenhowerParticipantRole.facilitator;
      case 'observer':
        return EisenhowerParticipantRole.observer;
      default:
        return EisenhowerParticipantRole.voter;
    }
  }
}

/// Modello per un partecipante alla Matrice di Eisenhower
class EisenhowerParticipantModel {
  final String email;
  final String name;
  final EisenhowerParticipantRole role;
  final DateTime joinedAt;
  final bool isOnline;
  final DateTime? lastActivity;

  EisenhowerParticipantModel({
    required this.email,
    required this.name,
    this.role = EisenhowerParticipantRole.voter,
    required this.joinedAt,
    this.isOnline = false,
    this.lastActivity,
  });

  /// Crea da Map (embedded in matrice)
  factory EisenhowerParticipantModel.fromMap(String email, Map<String, dynamic> map) {
    return EisenhowerParticipantModel(
      email: email,
      name: map['name'] ?? email.split('@').first,
      role: EisenhowerParticipantRoleExtension.fromString(map['role']),
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
  EisenhowerParticipantModel copyWith({
    String? email,
    String? name,
    EisenhowerParticipantRole? role,
    DateTime? joinedAt,
    bool? isOnline,
    DateTime? lastActivity,
  }) {
    return EisenhowerParticipantModel(
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isOnline: isOnline ?? this.isOnline,
      lastActivity: lastActivity ?? this.lastActivity,
    );
  }

  /// Verifica se il partecipante può votare
  bool get canVote => role == EisenhowerParticipantRole.voter || role == EisenhowerParticipantRole.facilitator;

  /// Verifica se il partecipante e' facilitator
  bool get isFacilitator => role == EisenhowerParticipantRole.facilitator;

  /// Verifica se il partecipante e' osservatore
  bool get isObserver => role == EisenhowerParticipantRole.observer;

  /// Iniziale del nome per avatar
  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';

  @override
  String toString() {
    return 'EisenhowerParticipant(email: $email, name: $name, role: ${role.name}, online: $isOnline)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EisenhowerParticipantModel && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;

  /// Escapa email per uso come chiave Firestore
  static String escapeEmail(String email) => email.replaceAll('.', '_DOT_');

  /// Unescapa email da chiave Firestore
  static String unescapeEmail(String escapedEmail) => escapedEmail.replaceAll('_DOT_', '.');
}
