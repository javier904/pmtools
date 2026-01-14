import 'package:cloud_firestore/cloud_firestore.dart';
import 'agile_enums.dart';

/// Modello per un membro del team in un progetto Agile
///
/// Estende i dati base del partecipante con informazioni specifiche
/// per la gestione del team Agile: capacità, skills, ruolo nel team.
class TeamMemberModel {
  final String email;
  final String name;
  final AgileParticipantRole participantRole; // owner, admin, member, viewer
  final TeamRole teamRole; // PO, SM, DEV, etc.
  final DateTime joinedAt;
  final bool isOnline;
  final DateTime? lastActivity;

  // Capacity
  final int capacityHoursPerDay; // default 8
  final List<String> skills;
  final List<DateRange> unavailableDates; // Ferie, malattia, etc.

  const TeamMemberModel({
    required this.email,
    required this.name,
    this.participantRole = AgileParticipantRole.member,
    this.teamRole = TeamRole.developer,
    required this.joinedAt,
    this.isOnline = false,
    this.lastActivity,
    this.capacityHoursPerDay = 8,
    this.skills = const [],
    this.unavailableDates = const [],
  });

  /// Crea da documento Firestore
  factory TeamMemberModel.fromFirestore(Map<String, dynamic> data) {
    return TeamMemberModel(
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      participantRole: AgileParticipantRole.values.firstWhere(
        (r) => r.name == data['participantRole'],
        orElse: () => AgileParticipantRole.member,
      ),
      teamRole: TeamRole.values.firstWhere(
        (r) => r.name == data['teamRole'],
        orElse: () => TeamRole.developer,
      ),
      joinedAt: (data['joinedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isOnline: data['isOnline'] ?? false,
      lastActivity: (data['lastActivity'] as Timestamp?)?.toDate(),
      capacityHoursPerDay: data['capacityHoursPerDay'] ?? 8,
      skills: List<String>.from(data['skills'] ?? []),
      unavailableDates: (data['unavailableDates'] as List<dynamic>?)
              ?.map((d) => DateRange.fromMap(d as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Converte per Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'participantRole': participantRole.name,
      'teamRole': teamRole.name,
      'joinedAt': Timestamp.fromDate(joinedAt),
      'isOnline': isOnline,
      if (lastActivity != null) 'lastActivity': Timestamp.fromDate(lastActivity!),
      'capacityHoursPerDay': capacityHoursPerDay,
      'skills': skills,
      'unavailableDates': unavailableDates.map((d) => d.toMap()).toList(),
    };
  }

  /// Copia con modifiche
  TeamMemberModel copyWith({
    String? email,
    String? name,
    AgileParticipantRole? participantRole,
    TeamRole? teamRole,
    DateTime? joinedAt,
    bool? isOnline,
    DateTime? lastActivity,
    int? capacityHoursPerDay,
    List<String>? skills,
    List<DateRange>? unavailableDates,
  }) {
    return TeamMemberModel(
      email: email ?? this.email,
      name: name ?? this.name,
      participantRole: participantRole ?? this.participantRole,
      teamRole: teamRole ?? this.teamRole,
      joinedAt: joinedAt ?? this.joinedAt,
      isOnline: isOnline ?? this.isOnline,
      lastActivity: lastActivity ?? this.lastActivity,
      capacityHoursPerDay: capacityHoursPerDay ?? this.capacityHoursPerDay,
      skills: skills ?? this.skills,
      unavailableDates: unavailableDates ?? this.unavailableDates,
    );
  }

  /// Calcola le ore disponibili in un periodo
  int getAvailableHours(DateTime start, DateTime end) {
    int totalDays = 0;
    DateTime current = start;

    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      // Escludi weekend
      if (current.weekday != DateTime.saturday && current.weekday != DateTime.sunday) {
        // Verifica se non è in un periodo di indisponibilità
        final isUnavailable = unavailableDates.any(
          (range) => range.contains(current),
        );
        if (!isUnavailable) {
          totalDays++;
        }
      }
      current = current.add(const Duration(days: 1));
    }

    return totalDays * capacityHoursPerDay;
  }

  /// Verifica se è disponibile in una data
  bool isAvailableOn(DateTime date) {
    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      return false;
    }
    return !unavailableDates.any((range) => range.contains(date));
  }

  /// Email key per Firestore (escaping dei punti)
  String get escapedEmailKey => email.replaceAll('.', '_DOT_');

  /// Iniziali del nome
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  /// Alias per teamRole (usato in UI)
  TeamRole get role => teamRole;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeamMemberModel && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

/// Range di date per indisponibilità
class DateRange {
  final DateTime start;
  final DateTime end;
  final String? reason; // Ferie, Malattia, etc.

  const DateRange({
    required this.start,
    required this.end,
    this.reason,
  });

  factory DateRange.fromMap(Map<String, dynamic> data) {
    return DateRange(
      start: (data['start'] as Timestamp).toDate(),
      end: (data['end'] as Timestamp).toDate(),
      reason: data['reason'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': Timestamp.fromDate(start),
      'end': Timestamp.fromDate(end),
      if (reason != null) 'reason': reason,
    };
  }

  /// Verifica se una data è nel range
  bool contains(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedStart = DateTime(start.year, start.month, start.day);
    final normalizedEnd = DateTime(end.year, end.month, end.day);

    return !normalizedDate.isBefore(normalizedStart) &&
        !normalizedDate.isAfter(normalizedEnd);
  }

  /// Numero di giorni nel range
  int get days => end.difference(start).inDays + 1;
}
