import 'package:cloud_firestore/cloud_firestore.dart';
import 'agile_enums.dart';
import 'team_member_model.dart';
import 'framework_features.dart';

/// Modello per un progetto Agile
///
/// Rappresenta un progetto gestito con metodologia Agile (Scrum, Kanban o Hybrid).
/// Contiene configurazione, team, e statistiche aggregate.
class AgileProjectModel {
  final String id;
  final String name;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Configuration
  final AgileFramework framework;
  final int sprintDurationDays; // default 14
  final int workingHoursPerDay; // default 8
  final List<DateTime> holidays;

  // Participants (pattern da Eisenhower)
  final Map<String, TeamMemberModel> participants;

  // Stats (denormalizzati)
  final int backlogCount;
  final int sprintCount;
  final int completedSprintCount;
  final double? averageVelocity;

  // Current state
  final String? activeSprintId;

  // Kanban configuration (per Kanban e Hybrid)
  final List<KanbanColumnConfig> kanbanColumns;

  // Key Roles (riferimenti email ai membri con ruoli chiave)
  final String? productOwnerEmail;
  final String? scrumMasterEmail;
  final List<String> developmentTeamEmails;
  final List<String> pendingEmails; // Inviti in attesa

  // 🗄️ Archiviazione
  final bool isArchived;
  final DateTime? archivedAt;

  const AgileProjectModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.framework = AgileFramework.scrum,
    this.sprintDurationDays = 14,
    this.workingHoursPerDay = 8,
    this.holidays = const [],
    this.participants = const {},
    this.backlogCount = 0,
    this.sprintCount = 0,
    this.completedSprintCount = 0,
    this.averageVelocity,
    this.activeSprintId,
    this.kanbanColumns = const [],
    this.productOwnerEmail,
    this.scrumMasterEmail,
    this.developmentTeamEmails = const [],
    this.pendingEmails = const [],
    this.isArchived = false,
    this.archivedAt,
  });

  /// Crea da documento Firestore
  factory AgileProjectModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return AgileProjectModel.fromMap(doc.id, data);
  }

  /// Crea da mappa
  factory AgileProjectModel.fromMap(String id, Map<String, dynamic> data) {
    // Parse participants map
    final participantsData = data['participants'] as Map<String, dynamic>? ?? {};
    final participants = participantsData.map(
      (key, value) => MapEntry(
        _unescapeEmailKey(key).toLowerCase(),
        TeamMemberModel.fromFirestore(value as Map<String, dynamic>),
      ),
    );

    // Parse holidays
    final holidaysData = data['holidays'] as List<dynamic>? ?? [];
    final holidays = holidaysData
        .map((h) => (h as Timestamp).toDate())
        .toList();

    // Parse kanban columns
    final kanbanColumnsData = data['kanbanColumns'] as List<dynamic>? ?? [];
    final kanbanColumns = kanbanColumnsData
        .map((c) => KanbanColumnConfig.fromFirestore(c as Map<String, dynamic>))
        .toList();

    return AgileProjectModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      framework: AgileFramework.values.firstWhere(
        (f) => f.name == data['framework'],
        orElse: () => AgileFramework.scrum,
      ),
      sprintDurationDays: data['sprintDurationDays'] ?? 14,
      workingHoursPerDay: data['workingHoursPerDay'] ?? 8,
      holidays: holidays,
      participants: participants,
      backlogCount: data['backlogCount'] ?? 0,
      sprintCount: data['sprintCount'] ?? 0,
      completedSprintCount: data['completedSprintCount'] ?? 0,
      averageVelocity: (data['averageVelocity'] as num?)?.toDouble(),
      activeSprintId: data['activeSprintId'],
      kanbanColumns: kanbanColumns,
      productOwnerEmail: data['productOwnerEmail'],
      scrumMasterEmail: data['scrumMasterEmail'],
      developmentTeamEmails: List<String>.from(data['developmentTeamEmails'] ?? []),
      pendingEmails: List<String>.from(data['pendingEmails'] ?? []),
      isArchived: data['isArchived'] ?? false,
      archivedAt: (data['archivedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Converte per Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'framework': framework.name,
      'sprintDurationDays': sprintDurationDays,
      'workingHoursPerDay': workingHoursPerDay,
      'holidays': holidays.map((h) => Timestamp.fromDate(h)).toList(),
      'participants': participants.map(
        (email, member) => MapEntry(
          _escapeEmailKey(email.toLowerCase()),
          member.toFirestore(),
        ),
      ),
      'backlogCount': backlogCount,
      'sprintCount': sprintCount,
      'completedSprintCount': completedSprintCount,
      if (averageVelocity != null) 'averageVelocity': averageVelocity,
      if (activeSprintId != null) 'activeSprintId': activeSprintId,
      'kanbanColumns': kanbanColumns.map((c) => c.toFirestore()).toList(),
      // Key Roles
      if (productOwnerEmail != null) 'productOwnerEmail': productOwnerEmail,
      if (scrumMasterEmail != null) 'scrumMasterEmail': scrumMasterEmail,
      'developmentTeamEmails': developmentTeamEmails,
      'pendingEmails': pendingEmails,
      // Per query
      'participantEmails': participants.keys.map((e) => e.toLowerCase()).toList(),
      // 🗄️ Archiviazione
      'isArchived': isArchived,
      if (archivedAt != null) 'archivedAt': Timestamp.fromDate(archivedAt!),
    };
  }

  /// Restituisce le feature disponibili per questo progetto in base al framework
  FrameworkFeatures get features => FrameworkFeatures(framework);

  /// Restituisce le colonne Kanban effettive (salvate o default per framework)
  List<KanbanColumnConfig> get effectiveKanbanColumns {
    if (kanbanColumns.isNotEmpty) return kanbanColumns;
    return features.defaultKanbanColumns;
  }

  /// Copia con modifiche
  AgileProjectModel copyWith({
    String? id,
    String? name,
    String? description,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    AgileFramework? framework,
    int? sprintDurationDays,
    int? workingHoursPerDay,
    List<DateTime>? holidays,
    Map<String, TeamMemberModel>? participants,
    int? backlogCount,
    int? sprintCount,
    int? completedSprintCount,
    double? averageVelocity,
    String? activeSprintId,
    List<KanbanColumnConfig>? kanbanColumns,
    String? productOwnerEmail,
    String? scrumMasterEmail,
    List<String>? developmentTeamEmails,
    List<String>? pendingEmails,
    bool? isArchived,
    DateTime? archivedAt,
  }) {
    return AgileProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      framework: framework ?? this.framework,
      sprintDurationDays: sprintDurationDays ?? this.sprintDurationDays,
      workingHoursPerDay: workingHoursPerDay ?? this.workingHoursPerDay,
      holidays: holidays ?? this.holidays,
      participants: participants ?? this.participants,
      backlogCount: backlogCount ?? this.backlogCount,
      sprintCount: sprintCount ?? this.sprintCount,
      completedSprintCount: completedSprintCount ?? this.completedSprintCount,
      averageVelocity: averageVelocity ?? this.averageVelocity,
      activeSprintId: activeSprintId ?? this.activeSprintId,
      kanbanColumns: kanbanColumns ?? this.kanbanColumns,
      productOwnerEmail: productOwnerEmail ?? this.productOwnerEmail,
      scrumMasterEmail: scrumMasterEmail ?? this.scrumMasterEmail,
      developmentTeamEmails: developmentTeamEmails ?? this.developmentTeamEmails,
      pendingEmails: pendingEmails ?? this.pendingEmails,
      isArchived: isArchived ?? this.isArchived,
      archivedAt: archivedAt ?? this.archivedAt,
    );
  }

  // =========================================================================
  // Helper per Key Roles
  // =========================================================================

  /// Ottiene il Product Owner
  TeamMemberModel? get productOwner =>
      productOwnerEmail != null ? participants[productOwnerEmail] : null;

  /// Ottiene lo Scrum Master
  TeamMemberModel? get scrumMaster =>
      scrumMasterEmail != null ? participants[scrumMasterEmail] : null;

  /// Ottiene il Development Team
  List<TeamMemberModel> get developmentTeam =>
      developmentTeamEmails
          .where((email) => participants.containsKey(email))
          .map((email) => participants[email]!)
          .toList();

  /// Verifica se ha tutti i ruoli chiave assegnati (per Scrum)
  bool get hasKeyRolesAssigned =>
      productOwnerEmail != null && scrumMasterEmail != null;

  // =========================================================================
  // Helper per participants
  // =========================================================================

  /// Lista email partecipanti
  List<String> get participantEmails => participants.keys.toList();

  /// Lista nomi partecipanti
  List<String> get participantNames => participants.values.map((p) => p.name).toList();

  /// Numero partecipanti
  int get participantCount => participants.length;

  /// Verifica se l'utente è partecipante
  bool hasParticipant(String email) => participants.containsKey(email);

  /// Ottiene un partecipante per email
  TeamMemberModel? getParticipant(String email) => participants[email.toLowerCase()];

  /// Verifica se l'utente è owner (per email o perché creatore)
  bool isOwner(String email) {
    if (email.isEmpty) return false;
    final normalized = email.trim().toLowerCase();
    if (createdBy.trim().toLowerCase() == normalized) return true;
    return participants[normalized]?.participantRole == AgileParticipantRole.owner;
  }

  /// Verifica se l'utente può gestire il progetto
  bool canManage(String email) =>
      participants[email.toLowerCase()]?.participantRole.canManage ?? false;

  /// Verifica se l'utente può modificare
  bool canEdit(String email) =>
      participants[email]?.participantRole.canEdit ?? false;

  /// Ottiene partecipanti con un ruolo specifico
  List<TeamMemberModel> getParticipantsByRole(TeamRole role) =>
      participants.values.where((p) => p.teamRole == role).toList();

  // =========================================================================
  // PERMESSI SCRUM-COMPLIANT
  // Combinano AgileParticipantRole (accesso) + TeamRole (funzione)
  // =========================================================================

  /// Helper: ottiene il TeamRole di un utente
  TeamRole? getTeamRole(String email) => participants[email.toLowerCase()]?.teamRole;

  // ---------------------------------------------------------------------------
  // BACKLOG MANAGEMENT (Solo Product Owner)
  // ---------------------------------------------------------------------------

  /// Può creare user stories
  /// - Scrum: Solo PO
  /// - Kanban: PO/SRM, SM/SDM e anche il Team (bugs, tech tasks)
  bool canCreateStory(String email) {
    if (isOwner(email)) return true;
    final p = participants[email];
    if (p == null) return false;
    
    // In Kanban, anche il team può creare card (es. bug, tech task)
    if (framework == AgileFramework.kanban) {
       return p.participantRole.canEdit; // Basta permesso di edit base
    }

    // In Scrum, rigorosamente il PO
    return p.participantRole.canEdit && p.teamRole.canCreateStory;
  }

  /// Può configurare la board (WIP limits, Policies, Colonne)
  /// - Solo ruoli di gestione (PO/SM/SRM/SDM)
  bool canConfigureBoard(String email) {
    if (isOwner(email)) return true;
    final p = participants[email];
    if (p == null) return false;
    
    // Developer NO, Stakeholder NO
    // Solo PO(SRM) o SM(SDM)
    return p.participantRole.canManage || 
           (p.participantRole.canEdit && (p.teamRole == TeamRole.productOwner || p.teamRole == TeamRole.scrumMaster || p.teamRole == TeamRole.serviceRequestManager || p.teamRole == TeamRole.serviceDeliveryManager));
  }

  /// Può modificare user stories - Richiede accesso + ruolo PO
  /// In Kanban estendiamo a chi ha creato? Per ora manteniamo standard.
  bool canEditStory(String email) {
    final p = participants[email];
    if (p == null) return false;

    // In Kanban, il team può modificare le card (aggiornare stato, dettagli)
    if (framework == AgileFramework.kanban) {
       return p.participantRole.canEdit;
    }

    return p.participantRole.canEdit && p.teamRole.canEditStory;
  }

  /// Può eliminare user stories - Richiede accesso + ruolo PO/SM
  bool canDeleteStory(String email) {
    if (isOwner(email)) return true;
    final p = participants[email];
    if (p == null) return false;
    
    // Developer NON può eliminare. Solo PO, SM, SRM, SDM
    return p.participantRole.canManage ||
           p.teamRole == TeamRole.productOwner ||
           p.teamRole == TeamRole.scrumMaster ||
           p.teamRole == TeamRole.serviceRequestManager ||
           p.teamRole == TeamRole.serviceDeliveryManager;
  }

  /// Può riordinare/prioritizzare backlog - Richiede accesso + ruolo PO
  bool canPrioritizeBacklog(String email) {
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canEdit && p.teamRole.canPrioritizeBacklog;
  }

  // ---------------------------------------------------------------------------
  // SPRINT MANAGEMENT (Solo Scrum Master)
  // ---------------------------------------------------------------------------

  /// Può gestire sprint (creare, avviare, completare) - Limitato a SM, Owner
  bool canManageSprints(String email) {
    if (email.isEmpty) return false;
    final normalized = email.trim().toLowerCase();
    
    // Il creatore del progetto o l'owner hanno sempre permessi completi
    if (isOwner(normalized)) return true;
    
    final p = participants[normalized];
    if (p == null) return false;
    
    // Solo Scrum Master o chi ha permessi di gestione espliciti
    return p.participantRole.canManage || 
           p.teamRole == TeamRole.scrumMaster ||
           p.teamRole == TeamRole.serviceDeliveryManager;
  }

  /// Può avviare/modificare la Sprint Review - Limitato a SM, Owner
  bool canStartSprintReview(String email) {
      return canManageSprints(email);
  }



  // ---------------------------------------------------------------------------
  // ESTIMATION (Solo Development Team)
  // ---------------------------------------------------------------------------

  /// Può stimare (votare) - Richiede accesso + ruolo Dev Team
  bool canEstimate(String email) {
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canEdit && p.teamRole.canEstimate;
  }

  /// Può impostare la stima finale - Richiede accesso + ruolo PO
  bool canSetFinalEstimate(String email) {
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canEdit && p.teamRole.canSetFinalEstimate;
  }

  // ---------------------------------------------------------------------------
  // KANBAN BOARD & TASK ASSIGNMENT
  // ---------------------------------------------------------------------------

  /// Può spostare le proprie story - Richiede accesso + non stakeholder
  bool canMoveOwnStory(String email) {
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canEdit && p.teamRole.canMoveOwnStory;
  }

  /// Può spostare qualsiasi story - Richiede accesso + ruolo PO/SM
  bool canMoveAnyStory(String email) {
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canEdit && p.teamRole.canMoveAnyStory;
  }

  /// Può auto-assegnarsi - Richiede accesso + ruolo Dev Team
  bool canSelfAssign(String email) {
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canEdit && p.teamRole.canSelfAssign;
  }

  /// Può assegnare task ad altri - Richiede accesso + ruolo PO
  bool canAssignOthers(String email) {
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canEdit && p.teamRole.canAssignOthers;
  }

  // ---------------------------------------------------------------------------
  // TEAM MANAGEMENT
  // ---------------------------------------------------------------------------

  /// Può invitare membri - Richiede gestione + ruolo PO/SM
  bool canInviteMembers(String email) {
    if (isOwner(email)) return true;
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canInvite && p.teamRole.canInviteMembers;
  }

  /// Può rimuovere membri - Richiede owner + ruolo PO
  bool canRemoveMembers(String email) {
    final p = participants[email];
    if (p == null) return false;
    // Owner può sempre rimuovere, oppure PO con permesso admin
    return isOwner(email) || (p.participantRole.canManage && p.teamRole.canRemoveMembers);
  }

  /// Può cambiare ruoli - Richiede owner + ruolo PO
  bool canChangeRoles(String email) {
    final p = participants[email];
    if (p == null) return false;
    return isOwner(email) || (p.participantRole.canManage && p.teamRole.canChangeRoles);
  }

  // ---------------------------------------------------------------------------
  // DAILY STANDUP & RETROSPECTIVE
  // ---------------------------------------------------------------------------

  /// Può aggiungere note standup - Richiede accesso + non stakeholder
  bool canAddStandupNote(String email) {
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canEdit && p.teamRole.canAddStandupNote;
  }

  /// Può facilitare retrospettiva - Richiede accesso + ruolo SM
  bool canFacilitateRetro(String email) {
    if (isOwner(email)) return true;
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canManage && p.teamRole.canFacilitateRetro;
  }

  /// Può partecipare a retrospettiva - Richiede accesso + non stakeholder
  bool canParticipateRetro(String email) {
    final p = participants[email];
    if (p == null) return false;
    return p.participantRole.canEdit && p.teamRole.canParticipateRetro;
  }

  // ---------------------------------------------------------------------------
  // NEW SPECIFIC PERMISSIONS (Restrictive)
  // ---------------------------------------------------------------------------

  /// Può aggiungere storie allo sprint?
  /// Limitato a PO, SM, SRM, SDM, Owner.
  /// DEV/Team Member NON possono farlo.
  bool canAddToSprint(String email) {
    if (isOwner(email)) return true;
    final p = participants[email];
    if (p == null) return false;
    
    // Solo ruoli di gestione
    return p.participantRole.canManage || 
           p.teamRole == TeamRole.productOwner || 
           p.teamRole == TeamRole.scrumMaster || 
           p.teamRole == TeamRole.serviceRequestManager || 
           p.teamRole == TeamRole.serviceDeliveryManager;
  }

  /// Può spostare storie nel backlog?
  /// Limitato a PO, SM, SRM, SDM, Owner.
  /// DEV/Team Member NON possono farlo.
  bool canMoveToBacklog(String email) {
      return canAddToSprint(email); // Stessi permessi di add to sprint
  }

  /// Può marcare una story come Ready (Definition of Ready soddisfatta)?
  /// In Scrum: Solo il PO (o Owner) può farlo.
  /// In Kanban: Tutta la squadra (tranne Stakeholder) può farlo per favorire il flusso.
  bool canMarkAsReady(String email) {
    if (isOwner(email)) return true;
    final p = participants[email];
    if (p == null) return false;
    
    // In Kanban, tutti i membri operativi possono marcare come Ready
    if (framework == AgileFramework.kanban) {
      return p.teamRole != TeamRole.stakeholder;
    }
    
    // In Scrum, seguiamo la regola del gatekeeping del PO
    return p.teamRole.canMarkAsReady;
  }



  /// Può gestire retrospettive (creare, eliminare)?
  /// Limitato a SM, SDM, Owner (e forse PO/SRM se necessario).
  /// DEV NON possono.
  bool canManageRetrospectives(String email) {
    if (isOwner(email)) return true;
    final p = participants[email];
    if (p == null) return false;

    // SM e SDM sono i facilitatori naturali. PO/SRM possono se necessario.
    return p.participantRole.canManage || 
           p.teamRole == TeamRole.scrumMaster || 
           p.teamRole == TeamRole.serviceDeliveryManager ||
           p.teamRole == TeamRole.productOwner || 
           p.teamRole == TeamRole.serviceRequestManager;
  }

  /// Può vedere l'Audit Log?
  /// Limitato a PO, SM, SRM, SDM, Admin, Owner.
  /// DEV NON possono.
  bool canViewAuditLog(String email) {
     return canAddToSprint(email); // Stessi permessi di gestione
  }

  // ---------------------------------------------------------------------------
  // UTILITY
  // ---------------------------------------------------------------------------

  /// Verifica se l'utente è Scrum Master
  bool isScrumMaster(String email) =>
      participants[email.toLowerCase()]?.teamRole == TeamRole.scrumMaster;
      
  /// Verifica se l'utente è Product Owner
  bool isProductOwner(String email) =>
      participants[email.toLowerCase()]?.teamRole == TeamRole.productOwner;

  /// Verifica se l'utente è nel Development Team
  bool isDevelopmentTeam(String email) =>
      participants[email.toLowerCase()]?.teamRole.isDevelopmentTeam ?? false;

  /// Verifica se l'utente è nello Scrum Team (non stakeholder)
  bool isScrumTeam(String email) =>
      participants[email.toLowerCase()]?.teamRole.isScrumTeam ?? false;

  /// Aggiunge un partecipante
  AgileProjectModel withParticipant(TeamMemberModel participant) {
    return copyWith(
      participants: {...participants, participant.email: participant},
      updatedAt: DateTime.now(),
    );
  }

  /// Rimuove un partecipante
  AgileProjectModel withoutParticipant(String email) {
    final newParticipants = Map<String, TeamMemberModel>.from(participants);
    newParticipants.remove(email);
    return copyWith(
      participants: newParticipants,
      updatedAt: DateTime.now(),
    );
  }

  // =========================================================================
  // Helper per capacity
  // =========================================================================

  /// Capacità totale giornaliera del team
  int get dailyTeamCapacity =>
      participants.values.fold(0, (sum, m) => sum + m.capacityHoursPerDay);

  /// Capacità del team per uno sprint
  int getSprintCapacity({List<DateTime>? sprintDates}) {
    if (sprintDates == null || sprintDates.isEmpty) {
      // Calcolo semplice basato su giorni lavorativi
      final workingDays = (sprintDurationDays * 5 / 7).floor();
      return dailyTeamCapacity * workingDays;
    }

    // Calcolo dettagliato considerando ferie individuali
    int totalHours = 0;
    for (final member in participants.values) {
      for (final date in sprintDates) {
        if (member.isAvailableOn(date) && !holidays.contains(date)) {
          totalHours += member.capacityHoursPerDay;
        }
      }
    }
    return totalHours;
  }

  // =========================================================================
  // Helper per statistiche
  // =========================================================================

  /// Verifica se ha sprint attivo
  bool get hasActiveSprint => activeSprintId != null;

  /// Percentuale sprint completati
  double get sprintCompletionRate =>
      sprintCount > 0 ? completedSprintCount / sprintCount : 0;

  // =========================================================================
  // Email escaping per Firestore
  // =========================================================================

  static String _escapeEmailKey(String email) => email.replaceAll('.', '_DOT_');
  static String _unescapeEmailKey(String key) => key.replaceAll('_DOT_', '.');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AgileProjectModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'AgileProjectModel(id: $id, name: $name)';
}
