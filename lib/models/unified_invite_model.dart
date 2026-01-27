import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'eisenhower_invite_model.dart';
import 'planning_poker_invite_model.dart';
import 'agile_invite_model.dart';
import 'smart_todo/todo_invite_model.dart';
import 'retro_invite_model.dart';
import 'agile_enums.dart';
import 'eisenhower_participant_model.dart';
import 'planning_poker_participant_model.dart';
import 'smart_todo/todo_participant_model.dart';

/// Tipo di strumento da cui proviene l'invito
enum InviteSourceType {
  eisenhower,
  estimationRoom,
  agileProject,
  smartTodo,
  retroBoard,
}

/// Status unificato per tutti i tipi di invito
enum UnifiedInviteStatus {
  pending,
  accepted,
  declined,
  expired,
  revoked,
}

/// Modello unificato per rappresentare qualsiasi tipo di invito
/// Permette di aggregare inviti da diverse sorgenti in un'unica lista
class UnifiedInviteModel {
  final String id;
  final String sourceId; // matrixId, sessionId, projectId, listId
  final String sourceName; // Nome della matrice/sessione/progetto/lista
  final InviteSourceType sourceType;
  final String email;
  final String role;
  final String? teamRole; // Solo per Agile Project
  final UnifiedInviteStatus status;
  final String invitedBy;
  final String invitedByName;
  final DateTime invitedAt;
  final DateTime expiresAt;
  final String token;
  final DateTime? acceptedAt;
  final DateTime? declinedAt;
  final String? declineReason;
  final bool isFavorite;

  const UnifiedInviteModel({
    required this.id,
    required this.sourceId,
    required this.sourceName,
    required this.sourceType,
    required this.email,
    required this.role,
    this.teamRole,
    required this.status,
    required this.invitedBy,
    required this.invitedByName,
    required this.invitedAt,
    required this.expiresAt,
    required this.token,
    this.acceptedAt,
    this.declinedAt,
    this.declineReason,
    this.isFavorite = false,
  });

  // ══════════════════════════════════════════════════════════════════════════════
  // FIRESTORE SERIALIZATION
  // ══════════════════════════════════════════════════════════════════════════════

  /// Genera un token univoco di 32 caratteri
  static String generateToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(32, (_) => chars[random.nextInt(chars.length)]).join();
  }

  /// Factory da Firestore DocumentSnapshot
  factory UnifiedInviteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UnifiedInviteModel(
      id: doc.id,
      sourceType: _parseSourceType(data['sourceType'] as String?),
      sourceId: data['sourceId'] as String? ?? '',
      sourceName: data['sourceName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: data['role'] as String? ?? '',
      teamRole: data['teamRole'] as String?,
      status: _parseStatus(data['status'] as String?),
      token: data['token'] as String? ?? '',
      invitedBy: data['invitedBy'] as String? ?? '',
      invitedByName: data['invitedByName'] as String? ?? '',
      invitedAt: (data['invitedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      expiresAt: (data['expiresAt'] as Timestamp?)?.toDate() ?? DateTime.now().add(const Duration(days: 7)),
      acceptedAt: (data['acceptedAt'] as Timestamp?)?.toDate(),
      declinedAt: (data['declinedAt'] as Timestamp?)?.toDate(),
      declineReason: data['declineReason'] as String?,
      isFavorite: data['isFavorite'] as bool? ?? false,
    );
  }

  /// Factory da Map (per compatibilità)
  factory UnifiedInviteModel.fromMap(Map<String, dynamic> data, {String? id}) {
    return UnifiedInviteModel(
      id: id ?? data['id'] as String? ?? '',
      sourceType: _parseSourceType(data['sourceType'] as String?),
      sourceId: data['sourceId'] as String? ?? '',
      sourceName: data['sourceName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: data['role'] as String? ?? '',
      teamRole: data['teamRole'] as String?,
      status: _parseStatus(data['status'] as String?),
      token: data['token'] as String? ?? '',
      invitedBy: data['invitedBy'] as String? ?? '',
      invitedByName: data['invitedByName'] as String? ?? '',
      invitedAt: data['invitedAt'] is Timestamp
          ? (data['invitedAt'] as Timestamp).toDate()
          : DateTime.tryParse(data['invitedAt']?.toString() ?? '') ?? DateTime.now(),
      expiresAt: data['expiresAt'] is Timestamp
          ? (data['expiresAt'] as Timestamp).toDate()
          : DateTime.tryParse(data['expiresAt']?.toString() ?? '') ?? DateTime.now().add(const Duration(days: 7)),
      acceptedAt: data['acceptedAt'] is Timestamp
          ? (data['acceptedAt'] as Timestamp).toDate()
          : DateTime.tryParse(data['acceptedAt']?.toString() ?? ''),
      declinedAt: data['declinedAt'] is Timestamp
          ? (data['declinedAt'] as Timestamp).toDate()
          : DateTime.tryParse(data['declinedAt']?.toString() ?? ''),
      declineReason: data['declineReason'] as String?,
      isFavorite: data['isFavorite'] as bool? ?? false,
    );
  }

  /// Converti a Map per Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'sourceType': sourceType.name,
      'sourceId': sourceId,
      'sourceName': sourceName,
      'email': email.toLowerCase(),
      'role': role,
      if (teamRole != null) 'teamRole': teamRole,
      'status': status.name,
      'token': token,
      'invitedBy': invitedBy.toLowerCase(),
      'invitedByName': invitedByName,
      'invitedAt': Timestamp.fromDate(invitedAt),
      'expiresAt': Timestamp.fromDate(expiresAt),
      if (acceptedAt != null) 'acceptedAt': Timestamp.fromDate(acceptedAt!),
      if (declinedAt != null) 'declinedAt': Timestamp.fromDate(declinedAt!),
      if (declineReason != null) 'declineReason': declineReason,
      'isFavorite': isFavorite,
    };
  }

  /// Converti a Map (alias per compatibilità)
  Map<String, dynamic> toMap() => toFirestore();

  /// Parse sourceType da stringa
  static InviteSourceType _parseSourceType(String? value) {
    switch (value) {
      case 'eisenhower':
        return InviteSourceType.eisenhower;
      case 'estimationRoom':
        return InviteSourceType.estimationRoom;
      case 'agileProject':
        return InviteSourceType.agileProject;
      case 'smartTodo':
        return InviteSourceType.smartTodo;
      case 'retroBoard':
        return InviteSourceType.retroBoard;
      default:
        return InviteSourceType.eisenhower;
    }
  }

  /// Parse status da stringa
  static UnifiedInviteStatus _parseStatus(String? value) {
    switch (value) {
      case 'pending':
        return UnifiedInviteStatus.pending;
      case 'accepted':
        return UnifiedInviteStatus.accepted;
      case 'declined':
        return UnifiedInviteStatus.declined;
      case 'expired':
        return UnifiedInviteStatus.expired;
      case 'revoked':
        return UnifiedInviteStatus.revoked;
      default:
        return UnifiedInviteStatus.pending;
    }
  }

  /// Verifica se l'invito è ancora valido (non scaduto e pending)
  bool get isValid =>
      status == UnifiedInviteStatus.pending &&
      DateTime.now().isBefore(expiresAt);

  /// Verifica se l'invito è scaduto
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Verifica se l'invito è in attesa
  bool get isPending => status == UnifiedInviteStatus.pending && !isExpired;

  /// Giorni rimanenti prima della scadenza
  int get daysUntilExpiration {
    final diff = expiresAt.difference(DateTime.now());
    return diff.inDays;
  }

  /// Ore rimanenti prima della scadenza
  int get hoursUntilExpiration {
    final diff = expiresAt.difference(DateTime.now());
    return diff.inHours;
  }

  /// Route per aprire direttamente l'istanza
  String get instanceRoute {
    switch (sourceType) {
      case InviteSourceType.eisenhower:
        return '/eisenhower';
      case InviteSourceType.estimationRoom:
        return '/estimation-room';
      case InviteSourceType.agileProject:
        return '/agile-project';
      case InviteSourceType.smartTodo:
        return '/smart-todo';
      case InviteSourceType.retroBoard:
        return '/retrospective-board';
    }
  }

  /// Arguments per la navigazione
  Map<String, dynamic> get routeArguments {
    switch (sourceType) {
      case InviteSourceType.eisenhower:
        return {'matrixId': sourceId};
      case InviteSourceType.estimationRoom:
        return {'sessionId': sourceId};
      case InviteSourceType.agileProject:
        return {'projectId': sourceId};
      case InviteSourceType.smartTodo:
        return {'listId': sourceId};
      case InviteSourceType.retroBoard:
        return {'id': sourceId};
    }
  }

  /// Genera il deep link per questo invito
  String generateDeepLink({String baseUrl = 'https://pm-agile-tools-app.web.app'}) {
    switch (sourceType) {
      case InviteSourceType.eisenhower:
        return '$baseUrl/#/invite/eisenhower/$token';
      case InviteSourceType.estimationRoom:
        return '$baseUrl/#/invite/estimation-room/$token';
      case InviteSourceType.agileProject:
        return '$baseUrl/#/invite/agile/$token';
      case InviteSourceType.smartTodo:
        return '$baseUrl/#/invite/smart-todo/$token';
      case InviteSourceType.retroBoard:
        return '$baseUrl/#/invite/retro/$token';
    }
  }

  /// Icona per questo tipo di sorgente
  String get sourceIcon {
    switch (sourceType) {
      case InviteSourceType.eisenhower:
        return '📊';
      case InviteSourceType.estimationRoom:
        return '🎯';
      case InviteSourceType.agileProject:
        return '📋';
      case InviteSourceType.smartTodo:
        return '✅';
      case InviteSourceType.retroBoard:
        return '🔄';
    }
  }

  /// Label localizzabile per il tipo di sorgente
  String get sourceTypeLabel {
    switch (sourceType) {
      case InviteSourceType.eisenhower:
        return 'Eisenhower Matrix';
      case InviteSourceType.estimationRoom:
        return 'Estimation Room';
      case InviteSourceType.agileProject:
        return 'Agile Project';
      case InviteSourceType.smartTodo:
        return 'Smart Todo';
      case InviteSourceType.retroBoard:
        return 'Retrospective Board';
    }
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // FACTORY METHODS per conversione da modelli specifici
  // ══════════════════════════════════════════════════════════════════════════════

  /// Crea da EisenhowerInviteModel
  factory UnifiedInviteModel.fromEisenhower(
    EisenhowerInviteModel invite, {
    String? matrixName,
  }) {
    return UnifiedInviteModel(
      id: invite.id,
      sourceId: invite.matrixId,
      sourceName: matrixName ?? 'Matrice Eisenhower',
      sourceType: InviteSourceType.eisenhower,
      email: invite.email,
      role: _eisenhowerRoleToString(invite.role),
      status: _convertEisenhowerStatus(invite.status),
      invitedBy: invite.invitedBy,
      invitedByName: invite.invitedByName,
      invitedAt: invite.invitedAt,
      expiresAt: invite.expiresAt,
      token: invite.token,
      acceptedAt: invite.acceptedAt,
      declinedAt: invite.declinedAt,
      declineReason: invite.declineReason,
    );
  }

  /// Crea da PlanningPokerInviteModel
  factory UnifiedInviteModel.fromPlanningPoker(
    PlanningPokerInviteModel invite, {
    String? sessionName,
  }) {
    return UnifiedInviteModel(
      id: invite.id,
      sourceId: invite.sessionId,
      sourceName: sessionName ?? 'Estimation Room',
      sourceType: InviteSourceType.estimationRoom,
      email: invite.email,
      role: _planningPokerRoleToString(invite.role),
      status: _convertPlanningPokerStatus(invite.status),
      invitedBy: invite.invitedBy,
      invitedByName: invite.invitedByName,
      invitedAt: invite.invitedAt,
      expiresAt: invite.expiresAt,
      token: invite.token,
      acceptedAt: invite.acceptedAt,
      declinedAt: invite.declinedAt,
      declineReason: invite.declineReason,
    );
  }

  /// Crea da AgileInviteModel
  factory UnifiedInviteModel.fromAgile(
    AgileInviteModel invite, {
    String? projectName,
  }) {
    return UnifiedInviteModel(
      id: invite.id,
      sourceId: invite.projectId,
      sourceName: projectName ?? 'Agile Project',
      sourceType: InviteSourceType.agileProject,
      email: invite.email,
      role: _agileRoleToString(invite.participantRole),
      teamRole: _agileTeamRoleToString(invite.teamRole),
      status: _convertAgileStatus(invite.status),
      invitedBy: invite.invitedBy,
      invitedByName: invite.invitedByName,
      invitedAt: invite.invitedAt,
      expiresAt: invite.expiresAt,
      token: invite.token,
      acceptedAt: invite.acceptedAt,
      declinedAt: invite.declinedAt,
      declineReason: invite.declineReason,
    );
  }

  /// Crea da TodoInviteModel
  factory UnifiedInviteModel.fromTodo(
    TodoInviteModel invite, {
    String? listName,
  }) {
    return UnifiedInviteModel(
      id: invite.id,
      sourceId: invite.listId,
      sourceName: listName ?? 'Smart Todo List',
      sourceType: InviteSourceType.smartTodo,
      email: invite.email,
      role: _todoRoleToString(invite.role),
      status: _convertTodoStatus(invite.status),
      invitedBy: invite.invitedBy,
      invitedByName: invite.invitedByName,
      invitedAt: invite.invitedAt,
      expiresAt: invite.expiresAt,
      token: invite.token,
      acceptedAt: invite.acceptedAt,
      declinedAt: invite.declinedAt,
    );
  }

  /// Crea da RetroInviteModel
  factory UnifiedInviteModel.fromRetro(
    RetroInviteModel invite, {
    String? boardName,
  }) {
    return UnifiedInviteModel(
      id: invite.id,
      sourceId: invite.boardId,
      sourceName: boardName ?? 'Retrospective Board',
      sourceType: InviteSourceType.retroBoard,
      email: invite.email,
      role: _retroRoleToString(invite.role),
      status: _convertRetroStatus(invite.status),
      invitedBy: invite.invitedBy,
      invitedByName: invite.invitedByName,
      invitedAt: invite.invitedAt,
      expiresAt: invite.expiresAt,
      token: invite.token,
      acceptedAt: invite.acceptedAt,
      declinedAt: invite.declinedAt,
      declineReason: invite.declineReason,
    );
  }

  /// Copia con modifiche
  UnifiedInviteModel copyWith({
    String? id,
    String? sourceId,
    String? sourceName,
    InviteSourceType? sourceType,
    String? email,
    String? role,
    String? teamRole,
    UnifiedInviteStatus? status,
    String? invitedBy,
    String? invitedByName,
    DateTime? invitedAt,
    DateTime? expiresAt,
    String? token,
    DateTime? acceptedAt,
    DateTime? declinedAt,
    String? declineReason,
    bool? isFavorite,
  }) {
    return UnifiedInviteModel(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName ?? this.sourceName,
      sourceType: sourceType ?? this.sourceType,
      email: email ?? this.email,
      role: role ?? this.role,
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
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // HELPER METHODS per conversione status e ruoli
  // ══════════════════════════════════════════════════════════════════════════════

  static UnifiedInviteStatus _convertEisenhowerStatus(EisenhowerInviteStatus status) {
    switch (status) {
      case EisenhowerInviteStatus.pending:
        return UnifiedInviteStatus.pending;
      case EisenhowerInviteStatus.accepted:
        return UnifiedInviteStatus.accepted;
      case EisenhowerInviteStatus.declined:
        return UnifiedInviteStatus.declined;
      case EisenhowerInviteStatus.expired:
        return UnifiedInviteStatus.expired;
      case EisenhowerInviteStatus.revoked:
        return UnifiedInviteStatus.revoked;
    }
  }

  static UnifiedInviteStatus _convertPlanningPokerStatus(InviteStatus status) {
    switch (status) {
      case InviteStatus.pending:
        return UnifiedInviteStatus.pending;
      case InviteStatus.accepted:
        return UnifiedInviteStatus.accepted;
      case InviteStatus.declined:
        return UnifiedInviteStatus.declined;
      case InviteStatus.expired:
        return UnifiedInviteStatus.expired;
      case InviteStatus.revoked:
        return UnifiedInviteStatus.revoked;
    }
  }

  static UnifiedInviteStatus _convertAgileStatus(AgileInviteStatus status) {
    switch (status) {
      case AgileInviteStatus.pending:
        return UnifiedInviteStatus.pending;
      case AgileInviteStatus.accepted:
        return UnifiedInviteStatus.accepted;
      case AgileInviteStatus.declined:
        return UnifiedInviteStatus.declined;
      case AgileInviteStatus.expired:
        return UnifiedInviteStatus.expired;
      case AgileInviteStatus.revoked:
        return UnifiedInviteStatus.revoked;
    }
  }

  static UnifiedInviteStatus _convertTodoStatus(TodoInviteStatus status) {
    switch (status) {
      case TodoInviteStatus.pending:
        return UnifiedInviteStatus.pending;
      case TodoInviteStatus.accepted:
        return UnifiedInviteStatus.accepted;
      case TodoInviteStatus.declined:
        return UnifiedInviteStatus.declined;
      case TodoInviteStatus.expired:
        return UnifiedInviteStatus.expired;
      case TodoInviteStatus.revoked:
        return UnifiedInviteStatus.revoked;
    }
  }

  static String _eisenhowerRoleToString(EisenhowerParticipantRole role) {
    switch (role) {
      case EisenhowerParticipantRole.facilitator:
        return 'Facilitator';
      case EisenhowerParticipantRole.voter:
        return 'Voter';
      case EisenhowerParticipantRole.observer:
        return 'Observer';
    }
  }

  static String _planningPokerRoleToString(ParticipantRole role) {
    switch (role) {
      case ParticipantRole.facilitator:
        return 'Facilitator';
      case ParticipantRole.voter:
        return 'Voter';
      case ParticipantRole.observer:
        return 'Observer';
    }
  }

  static String _agileRoleToString(AgileParticipantRole role) {
    switch (role) {
      case AgileParticipantRole.owner:
        return 'Owner';
      case AgileParticipantRole.admin:
        return 'Admin';
      case AgileParticipantRole.member:
        return 'Member';
      case AgileParticipantRole.viewer:
        return 'Viewer';
    }
  }

  static String _agileTeamRoleToString(TeamRole role) {
    switch (role) {
      case TeamRole.productOwner:
        return 'Product Owner';
      case TeamRole.scrumMaster:
        return 'Scrum Master';
      case TeamRole.developer:
        return 'Developer';
      case TeamRole.designer:
        return 'Designer';
      case TeamRole.qa:
        return 'QA';
      case TeamRole.stakeholder:
        return 'Stakeholder';
    }
  }

  static String _todoRoleToString(TodoParticipantRole role) {
    switch (role) {
      case TodoParticipantRole.owner:
        return 'Owner';
      case TodoParticipantRole.editor:
        return 'Editor';
      case TodoParticipantRole.viewer:
        return 'Viewer';
    }
  }

  static UnifiedInviteStatus _convertRetroStatus(RetroInviteStatus status) {
    switch (status) {
      case RetroInviteStatus.pending:
        return UnifiedInviteStatus.pending;
      case RetroInviteStatus.accepted:
        return UnifiedInviteStatus.accepted;
      case RetroInviteStatus.declined:
        return UnifiedInviteStatus.declined;
      case RetroInviteStatus.expired:
        return UnifiedInviteStatus.expired;
      case RetroInviteStatus.revoked:
        return UnifiedInviteStatus.revoked;
    }
  }

  static String _retroRoleToString(RetroParticipantRole role) {
    switch (role) {
      case RetroParticipantRole.facilitator:
        return 'Facilitator';
      case RetroParticipantRole.participant:
        return 'Participant';
      case RetroParticipantRole.observer:
        return 'Observer';
    }
  }

  @override
  String toString() {
    return 'UnifiedInviteModel(id: $id, sourceType: $sourceType, sourceName: $sourceName, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UnifiedInviteModel &&
        other.id == id &&
        other.sourceType == sourceType;
  }

  @override
  int get hashCode => id.hashCode ^ sourceType.hashCode;
}

/// Extension per ottenere label dello status
extension UnifiedInviteStatusExtension on UnifiedInviteStatus {
  String get label {
    switch (this) {
      case UnifiedInviteStatus.pending:
        return 'Pending';
      case UnifiedInviteStatus.accepted:
        return 'Accepted';
      case UnifiedInviteStatus.declined:
        return 'Declined';
      case UnifiedInviteStatus.expired:
        return 'Expired';
      case UnifiedInviteStatus.revoked:
        return 'Revoked';
    }
  }

  String get icon {
    switch (this) {
      case UnifiedInviteStatus.pending:
        return '⏳';
      case UnifiedInviteStatus.accepted:
        return '✅';
      case UnifiedInviteStatus.declined:
        return '❌';
      case UnifiedInviteStatus.expired:
        return '⌛';
      case UnifiedInviteStatus.revoked:
        return '🚫';
    }
  }
}
