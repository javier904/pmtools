import 'package:flutter/material.dart';

/// Framework Agile supportati
enum AgileFramework {
  scrum,
  kanban,
  hybrid;

  String get displayName {
    switch (this) {
      case AgileFramework.scrum:
        return 'Scrum';
      case AgileFramework.kanban:
        return 'Kanban';
      case AgileFramework.hybrid:
        return 'Hybrid';
    }
  }

  String get description {
    switch (this) {
      case AgileFramework.scrum:
        return 'Sprint-based with ceremonies';
      case AgileFramework.kanban:
        return 'Continuous flow with WIP limits';
      case AgileFramework.hybrid:
        return 'Mix of Scrum and Kanban';
    }
  }

  IconData get icon {
    switch (this) {
      case AgileFramework.scrum:
        return Icons.loop;
      case AgileFramework.kanban:
        return Icons.view_column;
      case AgileFramework.hybrid:
        return Icons.merge_type;
    }
  }

  /// Descrizione dettagliata per tooltip
  String get detailedDescription {
    switch (this) {
      case AgileFramework.scrum:
        return '''SCRUM
• Sprint a tempo fisso (1-4 settimane)
• Cerimonie: Sprint Planning, Daily Standup, Sprint Review, Retrospettiva
• Ruoli definiti: Product Owner, Scrum Master, Team
• Backlog prioritizzato con Story Points
• Velocity tracking e Burndown chart
• Ideale per: progetti con requisiti che evolvono e team dedicati''';
      case AgileFramework.kanban:
        return '''KANBAN
• Flusso continuo senza iterazioni fisse
• Visualizzazione del lavoro su board a colonne
• Limiti WIP (Work In Progress) per colonna
• Focus su Lead Time e Cycle Time
• Pull system: nuovi task solo quando c'è capacità
• Ideale per: supporto, manutenzione, flussi operativi continui''';
      case AgileFramework.hybrid:
        return '''HYBRID (Scrumban)
• Combina Sprint di Scrum con flusso Kanban
• Sprint opzionali per pianificazione
• Board Kanban con limiti WIP
• Cerimonie semplificate
• Metriche sia di velocity che di flow
• Ideale per: team in transizione o progetti con mix di feature e supporto''';
    }
  }
}

/// Priorità MoSCoW per user stories
enum StoryPriority {
  must,
  should,
  could,
  wont;

  String get displayName {
    switch (this) {
      case StoryPriority.must:
        return 'Must Have';
      case StoryPriority.should:
        return 'Should Have';
      case StoryPriority.could:
        return 'Could Have';
      case StoryPriority.wont:
        return "Won't Have";
    }
  }

  String get shortName {
    switch (this) {
      case StoryPriority.must:
        return 'M';
      case StoryPriority.should:
        return 'S';
      case StoryPriority.could:
        return 'C';
      case StoryPriority.wont:
        return 'W';
    }
  }

  Color get color {
    switch (this) {
      case StoryPriority.must:
        return const Color(0xFFE53935); // Red
      case StoryPriority.should:
        return const Color(0xFFFB8C00); // Orange
      case StoryPriority.could:
        return const Color(0xFF43A047); // Green
      case StoryPriority.wont:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  int get sortOrder {
    switch (this) {
      case StoryPriority.must:
        return 0;
      case StoryPriority.should:
        return 1;
      case StoryPriority.could:
        return 2;
      case StoryPriority.wont:
        return 3;
    }
  }

  IconData get icon {
    switch (this) {
      case StoryPriority.must:
        return Icons.priority_high;
      case StoryPriority.should:
        return Icons.arrow_upward;
      case StoryPriority.could:
        return Icons.arrow_downward;
      case StoryPriority.wont:
        return Icons.block;
    }
  }
}

/// Status delle user stories nel flusso Kanban
enum StoryStatus {
  backlog,
  ready,
  inSprint,
  inProgress,
  inReview,
  done;

  String get displayName {
    switch (this) {
      case StoryStatus.backlog:
        return 'Backlog';
      case StoryStatus.ready:
        return 'Ready';
      case StoryStatus.inSprint:
        return 'In Sprint';
      case StoryStatus.inProgress:
        return 'In Progress';
      case StoryStatus.inReview:
        return 'In Review';
      case StoryStatus.done:
        return 'Done';
    }
  }

  Color get color {
    switch (this) {
      case StoryStatus.backlog:
        return const Color(0xFF9E9E9E); // Grey
      case StoryStatus.ready:
        return const Color(0xFF2196F3); // Blue
      case StoryStatus.inSprint:
        return const Color(0xFF7B1FA2); // Purple
      case StoryStatus.inProgress:
        return const Color(0xFFFB8C00); // Orange
      case StoryStatus.inReview:
        return const Color(0xFF00ACC1); // Cyan
      case StoryStatus.done:
        return const Color(0xFF43A047); // Green
    }
  }

  IconData get icon {
    switch (this) {
      case StoryStatus.backlog:
        return Icons.inventory_2_outlined;
      case StoryStatus.ready:
        return Icons.check_circle_outline;
      case StoryStatus.inSprint:
        return Icons.run_circle_outlined;
      case StoryStatus.inProgress:
        return Icons.pending;
      case StoryStatus.inReview:
        return Icons.rate_review_outlined;
      case StoryStatus.done:
        return Icons.task_alt;
    }
  }

  /// Verifica se la story può essere messa in uno sprint
  bool get canAddToSprint => this == StoryStatus.ready;

  /// Verifica se la story è completata
  bool get isCompleted => this == StoryStatus.done;

  /// Verifica se la story è in lavorazione
  bool get isInProgress => this == StoryStatus.inProgress || this == StoryStatus.inReview;
}

/// Status degli sprint
enum SprintStatus {
  planning,
  active,
  review,
  completed;

  String get displayName {
    switch (this) {
      case SprintStatus.planning:
        return 'Planning';
      case SprintStatus.active:
        return 'Active';
      case SprintStatus.review:
        return 'Review';
      case SprintStatus.completed:
        return 'Completed';
    }
  }

  Color get color {
    switch (this) {
      case SprintStatus.planning:
        return const Color(0xFF2196F3); // Blue
      case SprintStatus.active:
        return const Color(0xFF43A047); // Green
      case SprintStatus.review:
        return const Color(0xFFFB8C00); // Orange
      case SprintStatus.completed:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  IconData get icon {
    switch (this) {
      case SprintStatus.planning:
        return Icons.edit_calendar;
      case SprintStatus.active:
        return Icons.play_circle_outline;
      case SprintStatus.review:
        return Icons.visibility;
      case SprintStatus.completed:
        return Icons.check_circle;
    }
  }

  bool get canModifyStories => this == SprintStatus.planning;
  bool get isActive => this == SprintStatus.active;
  bool get isCompleted => this == SprintStatus.completed;
}

/// Ruoli nel team
enum TeamRole {
  productOwner,
  scrumMaster,
  developer,
  designer,
  qa,
  stakeholder;

  String get displayName {
    switch (this) {
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

  String get shortName {
    switch (this) {
      case TeamRole.productOwner:
        return 'PO';
      case TeamRole.scrumMaster:
        return 'SM';
      case TeamRole.developer:
        return 'DEV';
      case TeamRole.designer:
        return 'DES';
      case TeamRole.qa:
        return 'QA';
      case TeamRole.stakeholder:
        return 'STK';
    }
  }

  Color get color {
    switch (this) {
      case TeamRole.productOwner:
        return const Color(0xFF7B1FA2); // Purple
      case TeamRole.scrumMaster:
        return const Color(0xFF1976D2); // Blue
      case TeamRole.developer:
        return const Color(0xFF388E3C); // Green
      case TeamRole.designer:
        return const Color(0xFFE64A19); // Deep Orange
      case TeamRole.qa:
        return const Color(0xFF00796B); // Teal
      case TeamRole.stakeholder:
        return const Color(0xFF5D4037); // Brown
    }
  }

  IconData get icon {
    switch (this) {
      case TeamRole.productOwner:
        return Icons.account_circle;
      case TeamRole.scrumMaster:
        return Icons.supervised_user_circle;
      case TeamRole.developer:
        return Icons.code;
      case TeamRole.designer:
        return Icons.palette;
      case TeamRole.qa:
        return Icons.bug_report;
      case TeamRole.stakeholder:
        return Icons.business;
    }
  }

  /// Verifica se può gestire il backlog
  bool get canManageBacklog => this == TeamRole.productOwner;

  /// Verifica se può facilitare le cerimonie
  bool get canFacilitate => this == TeamRole.scrumMaster || this == TeamRole.productOwner;

  /// Verifica se può stimare
  bool get canEstimate => this == TeamRole.developer || this == TeamRole.designer || this == TeamRole.qa;
}

/// Ruoli partecipante (semplificato per permessi)
enum AgileParticipantRole {
  owner,
  admin,
  member,
  viewer;

  String get displayName {
    switch (this) {
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

  bool get canEdit => this == AgileParticipantRole.owner || this == AgileParticipantRole.admin || this == AgileParticipantRole.member;
  bool get canManage => this == AgileParticipantRole.owner || this == AgileParticipantRole.admin;
  bool get canDelete => this == AgileParticipantRole.owner;
  bool get canInvite => this == AgileParticipantRole.owner || this == AgileParticipantRole.admin;

  IconData get icon {
    switch (this) {
      case AgileParticipantRole.owner:
        return Icons.star;
      case AgileParticipantRole.admin:
        return Icons.admin_panel_settings;
      case AgileParticipantRole.member:
        return Icons.person;
      case AgileParticipantRole.viewer:
        return Icons.visibility;
    }
  }
}

/// Status degli inviti
enum AgileInviteStatus {
  pending,
  accepted,
  declined,
  expired,
  revoked;

  String get displayName {
    switch (this) {
      case AgileInviteStatus.pending:
        return 'In attesa';
      case AgileInviteStatus.accepted:
        return 'Accettato';
      case AgileInviteStatus.declined:
        return 'Rifiutato';
      case AgileInviteStatus.expired:
        return 'Scaduto';
      case AgileInviteStatus.revoked:
        return 'Revocato';
    }
  }

  Color get color {
    switch (this) {
      case AgileInviteStatus.pending:
        return const Color(0xFFFB8C00); // Orange
      case AgileInviteStatus.accepted:
        return const Color(0xFF43A047); // Green
      case AgileInviteStatus.declined:
        return const Color(0xFFE53935); // Red
      case AgileInviteStatus.expired:
        return const Color(0xFF9E9E9E); // Grey
      case AgileInviteStatus.revoked:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  IconData get icon {
    switch (this) {
      case AgileInviteStatus.pending:
        return Icons.hourglass_empty;
      case AgileInviteStatus.accepted:
        return Icons.check_circle;
      case AgileInviteStatus.declined:
        return Icons.cancel;
      case AgileInviteStatus.expired:
        return Icons.timer_off;
      case AgileInviteStatus.revoked:
        return Icons.block;
    }
  }

  bool get isPending => this == AgileInviteStatus.pending;
  bool get isAccepted => this == AgileInviteStatus.accepted;
}

/// Metodi di stima
enum EstimationType {
  planningPoker,
  tshirt,
  threePoint,
  bucket;

  String get displayName {
    switch (this) {
      case EstimationType.planningPoker:
        return 'Planning Poker';
      case EstimationType.tshirt:
        return 'T-Shirt Sizing';
      case EstimationType.threePoint:
        return 'Three-Point (PERT)';
      case EstimationType.bucket:
        return 'Bucket System';
    }
  }

  String get description {
    switch (this) {
      case EstimationType.planningPoker:
        return 'Fibonacci: 1, 2, 3, 5, 8, 13, 21';
      case EstimationType.tshirt:
        return 'XS, S, M, L, XL, XXL';
      case EstimationType.threePoint:
        return '(O + 4M + P) / 6';
      case EstimationType.bucket:
        return 'Affinity grouping';
    }
  }

  IconData get icon {
    switch (this) {
      case EstimationType.planningPoker:
        return Icons.style;
      case EstimationType.tshirt:
        return Icons.checkroom;
      case EstimationType.threePoint:
        return Icons.analytics;
      case EstimationType.bucket:
        return Icons.inventory;
    }
  }

  /// Card set per Planning Poker
  static const List<String> fibonacciCards = ['1', '2', '3', '5', '8', '13', '21', '?'];

  /// T-Shirt sizes
  static const List<String> tshirtSizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', '?'];

  /// Conversione T-Shirt -> Story Points
  static int tshirtToPoints(String size) {
    switch (size) {
      case 'XS':
        return 1;
      case 'S':
        return 2;
      case 'M':
        return 3;
      case 'L':
        return 5;
      case 'XL':
        return 8;
      case 'XXL':
        return 13;
      default:
        return 0;
    }
  }
}

/// Tipi di azione per audit log
enum AuditAction {
  create,
  update,
  delete,
  move,
  estimate,
  assign,
  complete,
  start,
  close,
  invite,
  join,
  leave;

  String get displayName {
    switch (this) {
      case AuditAction.create:
        return 'Creato';
      case AuditAction.update:
        return 'Modificato';
      case AuditAction.delete:
        return 'Eliminato';
      case AuditAction.move:
        return 'Spostato';
      case AuditAction.estimate:
        return 'Stimato';
      case AuditAction.assign:
        return 'Assegnato';
      case AuditAction.complete:
        return 'Completato';
      case AuditAction.start:
        return 'Avviato';
      case AuditAction.close:
        return 'Chiuso';
      case AuditAction.invite:
        return 'Invitato';
      case AuditAction.join:
        return 'Entrato';
      case AuditAction.leave:
        return 'Uscito';
    }
  }

  IconData get icon {
    switch (this) {
      case AuditAction.create:
        return Icons.add_circle;
      case AuditAction.update:
        return Icons.edit;
      case AuditAction.delete:
        return Icons.delete;
      case AuditAction.move:
        return Icons.swap_horiz;
      case AuditAction.estimate:
        return Icons.calculate;
      case AuditAction.assign:
        return Icons.person_add;
      case AuditAction.complete:
        return Icons.check_circle;
      case AuditAction.start:
        return Icons.play_arrow;
      case AuditAction.close:
        return Icons.stop;
      case AuditAction.invite:
        return Icons.mail;
      case AuditAction.join:
        return Icons.login;
      case AuditAction.leave:
        return Icons.logout;
    }
  }

  Color get color {
    switch (this) {
      case AuditAction.create:
        return const Color(0xFF43A047);
      case AuditAction.update:
        return const Color(0xFF1976D2);
      case AuditAction.delete:
        return const Color(0xFFE53935);
      case AuditAction.move:
        return const Color(0xFF7B1FA2);
      case AuditAction.estimate:
        return const Color(0xFF00ACC1);
      case AuditAction.assign:
        return const Color(0xFFFB8C00);
      case AuditAction.complete:
        return const Color(0xFF43A047);
      case AuditAction.start:
        return const Color(0xFF43A047);
      case AuditAction.close:
        return const Color(0xFF9E9E9E);
      case AuditAction.invite:
        return const Color(0xFF1976D2);
      case AuditAction.join:
        return const Color(0xFF43A047);
      case AuditAction.leave:
        return const Color(0xFFFB8C00);
    }
  }
}

/// Tipi di entità per audit log
enum AuditEntityType {
  project,
  story,
  sprint,
  team,
  retrospective;

  String get displayName {
    switch (this) {
      case AuditEntityType.project:
        return 'Progetto';
      case AuditEntityType.story:
        return 'User Story';
      case AuditEntityType.sprint:
        return 'Sprint';
      case AuditEntityType.team:
        return 'Team';
      case AuditEntityType.retrospective:
        return 'Retrospettiva';
    }
  }
}
