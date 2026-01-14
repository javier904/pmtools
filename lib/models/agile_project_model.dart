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
        _unescapeEmailKey(key),
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
          _escapeEmailKey(email),
          member.toFirestore(),
        ),
      ),
      'backlogCount': backlogCount,
      'sprintCount': sprintCount,
      'completedSprintCount': completedSprintCount,
      if (averageVelocity != null) 'averageVelocity': averageVelocity,
      if (activeSprintId != null) 'activeSprintId': activeSprintId,
      'kanbanColumns': kanbanColumns.map((c) => c.toFirestore()).toList(),
      // Per query
      'participantEmails': participants.keys.toList(),
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
    );
  }

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
  TeamMemberModel? getParticipant(String email) => participants[email];

  /// Verifica se l'utente è owner
  bool isOwner(String email) =>
      participants[email]?.participantRole == AgileParticipantRole.owner;

  /// Verifica se l'utente può gestire il progetto
  bool canManage(String email) =>
      participants[email]?.participantRole.canManage ?? false;

  /// Verifica se l'utente può modificare
  bool canEdit(String email) =>
      participants[email]?.participantRole.canEdit ?? false;

  /// Ottiene partecipanti con un ruolo specifico
  List<TeamMemberModel> getParticipantsByRole(TeamRole role) =>
      participants.values.where((p) => p.teamRole == role).toList();

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
