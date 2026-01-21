import 'package:cloud_firestore/cloud_firestore.dart';
import 'eisenhower_participant_model.dart';
import 'raci_models.dart';
import '../l10n/app_localizations.dart';

/// Modello per la Matrice di Eisenhower
///
/// La matrice organizza le attività in 4 quadranti basati su Urgenza e Importanza:
/// - Q1 (DO): Urgente + Importante → Fare subito
/// - Q2 (SCHEDULE): Non Urgente + Importante → Pianificare
/// - Q3 (DELEGATE): Urgente + Non Importante → Delegare
/// - Q4 (DELETE): Non Urgente + Non Importante → Eliminare
class EisenhowerMatrixModel {
  final String id;
  final String title;
  final String description;
  final String createdBy; // Email dell'utente che ha creato la matrice
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Partecipanti alla matrice
  /// Key: email escapata (usando _DOT_ al posto di .)
  /// Value: dati partecipante (nome, ruolo, online status)
  final Map<String, EisenhowerParticipantModel> participants;

  final int activityCount; // Contatore attività (denormalizzato per lista)
  final List<String> pendingEmails; // New: Pending invites

  // Colonne RACI
  final List<RaciColumn> raciColumns;

  // 🆕 Integrazioni con il resto della webapp
  final String? teamId; // ID del team associato (opzionale)
  final String? teamName; // Nome team (denormalizzato per visualizzazione)
  final String? businessUnitId; // ID della business unit (opzionale)
  final String? businessUnitName; // Nome BU (denormalizzato per visualizzazione)
  final String? projectId; // ID del progetto associato (opzionale)
  final String? projectName; // Nome progetto (denormalizzato per visualizzazione)
  final String? projectCode; // Codice progetto (es. "GDMS")

  // 🗄️ Archiviazione
  final bool isArchived;
  final DateTime? archivedAt;

  EisenhowerMatrixModel({
    required this.id,
    required this.title,
    this.description = '',
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.participants = const {},
    this.activityCount = 0,
    this.raciColumns = const [],
    this.pendingEmails = const [],
    this.teamId,
    this.teamName,
    this.businessUnitId,
    this.businessUnitName,
    this.projectId,
    this.projectName,
    this.projectCode,
    this.isArchived = false,
    this.archivedAt,
  });

  /// Crea un'istanza da documento Firestore
  factory EisenhowerMatrixModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Parsing dei partecipanti (Map con email escapata come chiave)
    final participantsMap = <String, EisenhowerParticipantModel>{};
    final participantsData = data['participants'];

    if (participantsData is Map<String, dynamic>) {
      // Nuovo formato: Map<escapedEmail, participantData>
      participantsData.forEach((escapedEmail, value) {
        if (value is Map<String, dynamic>) {
          // Unescape e normalizza a lowercase per consistenza nel match
          final email = EisenhowerParticipantModel.unescapeEmail(escapedEmail).toLowerCase();
          participantsMap[email] = EisenhowerParticipantModel.fromMap(email, value);
        }
      });
    } else if (participantsData is List) {
      // Backward compatibility: vecchio formato List<String> (solo nomi)
      for (final name in participantsData) {
        if (name is String && name.isNotEmpty) {
          // Crea un partecipante fake con solo il nome (senza email reale)
          final fakeEmail = '${name.toLowerCase().replaceAll(' ', '.')}@legacy.local';
          participantsMap[fakeEmail] = EisenhowerParticipantModel(
            email: fakeEmail,
            name: name,
            role: EisenhowerParticipantRole.voter,
            joinedAt: DateTime.now(),
          );
        }
      }
    }

    // Parsing RACI columns
    final raciColumnsList = <RaciColumn>[];
    final raciColumnsData = data['raciColumns'];
    if (raciColumnsData is List) {
      for (final colData in raciColumnsData) {
        if (colData is Map<String, dynamic>) {
          raciColumnsList.add(RaciColumn.fromMap(colData));
        }
      }
    }

    return EisenhowerMatrixModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      createdBy: (data['createdBy'] ?? '').toString().toLowerCase(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      participants: participantsMap,
      activityCount: data['activityCount'] ?? 0,
      raciColumns: raciColumnsList,
      pendingEmails: List<String>.from(data['pendingEmails'] ?? []),
      // 🆕 Integrazioni
      teamId: data['teamId'],
      teamName: data['teamName'],
      businessUnitId: data['businessUnitId'],
      businessUnitName: data['businessUnitName'],
      projectId: data['projectId'],
      projectName: data['projectName'],
      projectCode: data['projectCode'],
      isArchived: data['isArchived'] ?? false,
      archivedAt: (data['archivedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Converte in Map per Firestore
  Map<String, dynamic> toFirestore() {
    // Serializza partecipanti con email escapata come chiave
    final participantsData = <String, dynamic>{};
    participants.forEach((email, participant) {
      final escapedEmail = EisenhowerParticipantModel.escapeEmail(email);
      participantsData[escapedEmail] = participant.toMap();
    });

    // Serializza RACI columns
    final raciColumnsData = raciColumns.map((col) => col.toMap()).toList();

    return {
      'title': title,
      'description': description,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'participants': participantsData,
      'activityCount': activityCount,
      'raciColumns': raciColumnsData,
      'pendingEmails': pendingEmails,
      // 🆕 Integrazioni (solo se valorizzati)
      if (teamId != null) 'teamId': teamId,
      if (teamName != null) 'teamName': teamName,
      if (businessUnitId != null) 'businessUnitId': businessUnitId,
      if (businessUnitName != null) 'businessUnitName': businessUnitName,
      if (projectId != null) 'projectId': projectId,
      if (projectName != null) 'projectName': projectName,
      if (projectCode != null) 'projectCode': projectCode,
      // 🗄️ Archiviazione
      'isArchived': isArchived,
      if (archivedAt != null) 'archivedAt': Timestamp.fromDate(archivedAt!),
    };
  }

  /// Crea una copia con modifiche
  EisenhowerMatrixModel copyWith({
    String? id,
    String? title,
    String? description,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, EisenhowerParticipantModel>? participants,
    int? activityCount,
    List<RaciColumn>? raciColumns,
    List<String>? pendingEmails,
    String? teamId,
    String? teamName,
    String? businessUnitId,
    String? businessUnitName,
    String? projectId,
    String? projectName,
    String? projectCode,
    bool? isArchived,
    DateTime? archivedAt,
  }) {
    return EisenhowerMatrixModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      participants: participants ?? this.participants,
      activityCount: activityCount ?? this.activityCount,
      raciColumns: raciColumns ?? this.raciColumns,
      pendingEmails: pendingEmails ?? this.pendingEmails,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      businessUnitId: businessUnitId ?? this.businessUnitId,
      businessUnitName: businessUnitName ?? this.businessUnitName,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      projectCode: projectCode ?? this.projectCode,
      isArchived: isArchived ?? this.isArchived,
      archivedAt: archivedAt ?? this.archivedAt,
    );
  }

  /// True se la matrice è associata a un progetto
  bool get hasProject => projectId != null && projectId!.isNotEmpty;

  /// True se la matrice è associata a un team
  bool get hasTeam => teamId != null && teamId!.isNotEmpty;

  /// True se la matrice è associata a una business unit
  bool get hasBusinessUnit => businessUnitId != null && businessUnitId!.isNotEmpty;

  // ============================================================
  // HELPER per Partecipanti
  // ============================================================

  /// Numero totale di partecipanti
  int get participantCount => participants.length;

  /// True se ci sono partecipanti
  bool get hasParticipants => participants.isNotEmpty;

  /// Lista email di tutti i partecipanti
  List<String> get participantEmails => participants.keys.toList();

  /// Lista nomi di tutti i partecipanti
  List<String> get participantNames =>
      participants.values.map((p) => p.name).toList();

  /// Ottiene un partecipante per email
  EisenhowerParticipantModel? getParticipant(String email) => participants[email];

  /// Verifica se un utente è partecipante
  bool isParticipant(String email) => participants.containsKey(email);

  /// Email dei soli votanti (facilitator + voter, esclusi observer)
  ///
  /// 🔧 BACKWARD COMPATIBILITY: Include il creator SOLO se non è nella lista partecipanti
  List<String> get voterEmails {
    final voters = participants.entries
        .where((e) => e.value.canVote)
        .map((e) => e.key)
        .toList();

    // Aggiungi il creator SOLO se non è nella lista partecipanti (fallback)
    final creatorInParticipants = participants.keys.any(
      (k) => k.toLowerCase() == createdBy.toLowerCase(),
    );
    if (!creatorInParticipants) {
      voters.add(createdBy);
    }

    return voters;
  }

  /// Numero di votanti
  int get voterCount => voterEmails.length;

  /// Email dei facilitatori
  ///
  /// 🔧 BACKWARD COMPATIBILITY: Include il creator SOLO se non è nella lista partecipanti
  List<String> get facilitatorEmails {
    final facilitators = participants.entries
        .where((e) => e.value.isFacilitator)
        .map((e) => e.key)
        .toList();

    // Aggiungi il creator SOLO se non è nella lista partecipanti (fallback)
    final creatorInParticipants = participants.keys.any(
      (k) => k.toLowerCase() == createdBy.toLowerCase(),
    );
    if (!creatorInParticipants) {
      facilitators.add(createdBy);
    }

    return facilitators;
  }

  /// Verifica se un utente è facilitatore
  ///
  /// Logica:
  /// 1. Se l'utente è nella lista partecipanti → usa il ruolo esplicito da Firestore
  /// 2. Se l'utente NON è nella lista E è il creator → fallback a facilitatore
  bool isFacilitator(String email) {
    final normalizedEmail = email.toLowerCase();

    // Cerca il partecipante (case-insensitive)
    for (final entry in participants.entries) {
      if (entry.key.toLowerCase() == normalizedEmail) {
        return entry.value.isFacilitator;
      }
    }

    // Non trovato: fallback al creator
    return normalizedEmail == createdBy.toLowerCase();
  }

  /// Verifica se un utente può votare
  ///
  /// 🔧 BACKWARD COMPATIBILITY: Il creator può sempre votare, anche se non
  /// è nella lista partecipanti (matrici create prima del sistema ruoli).
  bool canUserVote(String email) {
    final normalizedEmail = email.toLowerCase();

    // Cerca il partecipante (case-insensitive)
    EisenhowerParticipantModel? participant;
    for (final entry in participants.entries) {
      if (entry.key.toLowerCase() == normalizedEmail) {
        participant = entry.value;
        break;
      }
    }

    // Se è nella lista partecipanti, usa il ruolo esplicito
    if (participant != null) return participant.canVote;

    // Fallback: il creator può sempre votare
    return email.toLowerCase() == createdBy.toLowerCase();
  }

  /// Partecipanti online
  List<EisenhowerParticipantModel> get onlineParticipants =>
      participants.values.where((p) => p.isOnline).toList();

  /// Numero partecipanti online
  int get onlineCount => onlineParticipants.length;

  /// Crea una copia con un nuovo partecipante aggiunto
  EisenhowerMatrixModel withParticipant(EisenhowerParticipantModel participant) {
    final newParticipants = Map<String, EisenhowerParticipantModel>.from(participants);
    newParticipants[participant.email] = participant;
    return copyWith(
      participants: newParticipants,
      updatedAt: DateTime.now(),
    );
  }

  /// Crea una copia senza un partecipante
  EisenhowerMatrixModel withoutParticipant(String email) {
    final newParticipants = Map<String, EisenhowerParticipantModel>.from(participants);
    newParticipants.remove(email);
    return copyWith(
      participants: newParticipants,
      updatedAt: DateTime.now(),
    );
  }

  /// Crea una copia con un partecipante aggiornato
  EisenhowerMatrixModel withUpdatedParticipant(EisenhowerParticipantModel participant) {
    if (!participants.containsKey(participant.email)) return this;
    final newParticipants = Map<String, EisenhowerParticipantModel>.from(participants);
    newParticipants[participant.email] = participant;
    return copyWith(
      participants: newParticipants,
      updatedAt: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'EisenhowerMatrixModel(id: $id, title: $title, participants: ${participants.length}, '
        'activities: $activityCount, project: $projectCode, team: $teamName, bu: $businessUnitName)';
  }
}

/// Enum per i quadranti della matrice
enum EisenhowerQuadrant {
  q1, // DO - Urgente + Importante
  q2, // SCHEDULE - Non Urgente + Importante
  q3, // DELEGATE - Urgente + Non Importante
  q4, // DELETE - Non Urgente + Non Importante
}

/// Extension per proprietà dei quadranti
extension EisenhowerQuadrantExtension on EisenhowerQuadrant {
  /// Nome del quadrante
  String get name {
    switch (this) {
      case EisenhowerQuadrant.q1:
        return 'Q1';
      case EisenhowerQuadrant.q2:
        return 'Q2';
      case EisenhowerQuadrant.q3:
        return 'Q3';
      case EisenhowerQuadrant.q4:
        return 'Q4';
    }
  }

  /// Titolo descrittivo
  String get title {
    switch (this) {
      case EisenhowerQuadrant.q1:
        return 'FAI SUBITO';
      case EisenhowerQuadrant.q2:
        return 'PIANIFICA';
      case EisenhowerQuadrant.q3:
        return 'DELEGA';
      case EisenhowerQuadrant.q4:
        return 'ELIMINA';
    }
  }

  /// Sottotitolo con descrizione
  String get subtitle {
    switch (this) {
      case EisenhowerQuadrant.q1:
        return 'Urgente + Importante';
      case EisenhowerQuadrant.q2:
        return 'Non Urgente + Importante';
      case EisenhowerQuadrant.q3:
        return 'Urgente + Non Importante';
      case EisenhowerQuadrant.q4:
        return 'Non Urgente + Non Importante';
    }
  }

  /// Titolo localizzato
  String localizedTitle(AppLocalizations l10n) {
    switch (this) {
      case EisenhowerQuadrant.q1:
        return l10n.quadrantQ1Title;
      case EisenhowerQuadrant.q2:
        return l10n.quadrantQ2Title;
      case EisenhowerQuadrant.q3:
        return l10n.quadrantQ3Title;
      case EisenhowerQuadrant.q4:
        return l10n.quadrantQ4Title;
    }
  }

  /// Sottotitolo localizzato
  String localizedSubtitle(AppLocalizations l10n) {
    switch (this) {
      case EisenhowerQuadrant.q1:
        return l10n.quadrantQ1Subtitle;
      case EisenhowerQuadrant.q2:
        return l10n.quadrantQ2Subtitle;
      case EisenhowerQuadrant.q3:
        return l10n.quadrantQ3Subtitle;
      case EisenhowerQuadrant.q4:
        return l10n.quadrantQ4Subtitle;
    }
  }

  /// Azione consigliata
  String get action {
    switch (this) {
      case EisenhowerQuadrant.q1:
        return 'DO';
      case EisenhowerQuadrant.q2:
        return 'SCHEDULE';
      case EisenhowerQuadrant.q3:
        return 'DELEGATE';
      case EisenhowerQuadrant.q4:
        return 'DELETE';
    }
  }

  /// Colore del quadrante (codice esadecimale)
  int get colorValue {
    switch (this) {
      case EisenhowerQuadrant.q1:
        return 0xFFE53935; // Rosso
      case EisenhowerQuadrant.q2:
        return 0xFF43A047; // Verde
      case EisenhowerQuadrant.q3:
        return 0xFFFDD835; // Giallo
      case EisenhowerQuadrant.q4:
        return 0xFF9E9E9E; // Grigio
    }
  }

  /// Icona del quadrante
  String get iconName {
    switch (this) {
      case EisenhowerQuadrant.q1:
        return 'priority_high';
      case EisenhowerQuadrant.q2:
        return 'schedule';
      case EisenhowerQuadrant.q3:
        return 'group';
      case EisenhowerQuadrant.q4:
        return 'delete_outline';
    }
  }

  /// Crea quadrante da stringa
  static EisenhowerQuadrant? fromString(String? value) {
    if (value == null) return null;
    switch (value.toUpperCase()) {
      case 'Q1':
        return EisenhowerQuadrant.q1;
      case 'Q2':
        return EisenhowerQuadrant.q2;
      case 'Q3':
        return EisenhowerQuadrant.q3;
      case 'Q4':
        return EisenhowerQuadrant.q4;
      default:
        return null;
    }
  }

  /// Calcola il quadrante basato sui valori di urgenza e importanza
  static EisenhowerQuadrant calculateQuadrant(double urgency, double importance, {double threshold = 5.5}) {
    final isUrgent = urgency >= threshold;
    final isImportant = importance >= threshold;

    if (isUrgent && isImportant) {
      return EisenhowerQuadrant.q1; // DO
    } else if (!isUrgent && isImportant) {
      return EisenhowerQuadrant.q2; // SCHEDULE
    } else if (isUrgent && !isImportant) {
      return EisenhowerQuadrant.q3; // DELEGATE
    } else {
      return EisenhowerQuadrant.q4; // DELETE
    }
  }
}
