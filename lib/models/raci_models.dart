import 'package:flutter/material.dart';

/// Ruoli standard RACI
enum RaciRole {
  responsible, // R - Responsible (Esegue il lavoro)
  accountable, // A - Accountable (Approva il lavoro e ne risponde)
  consulted,   // C - Consulted (Consultato prima o durante il lavoro)
  informed;    // I - Informed (Informato a lavoro finito)

  String get id => name;

  String get label {
    switch (this) {
      case RaciRole.responsible: return 'R';
      case RaciRole.accountable: return 'A';
      case RaciRole.consulted: return 'C';
      case RaciRole.informed: return 'I';
    }
  }

  String get fullName {
    switch (this) {
      case RaciRole.responsible: return 'Responsible';
      case RaciRole.accountable: return 'Accountable';
      case RaciRole.consulted: return 'Consulted';
      case RaciRole.informed: return 'Informed';
    }
  }

  String get description {
    switch (this) {
      case RaciRole.responsible: return 'Coloro che svolgono il lavoro per completare il compito.';
      case RaciRole.accountable: return 'L\'unica persona che risponde del corretto completamento del compito. Delega il lavoro ai Responsible.';
      case RaciRole.consulted: return 'Coloro le cui opinioni sono richieste; comunicazione bidirezionale.';
      case RaciRole.informed: return 'Coloro che vengono tenuti aggiornati sul progresso; comunicazione unidirezionale.';
    }
  }

  Color get color {
    switch (this) {
      case RaciRole.responsible: return Colors.blue;
      case RaciRole.accountable: return Colors.red;
      case RaciRole.consulted: return Colors.orange;
      case RaciRole.informed: return Colors.green;
    }
  }
}

/// Tipo di colonna RACI
enum RaciColumnType {
  person,       // Un partecipante specifico
  team,         // Un intero team
  custom,       // Testo libero
}

/// Definizione di una colonna nella tabella RACI
class RaciColumn {
  final String id;
  final String name;
  final RaciColumnType type;
  final String? referenceId; // ID dell'utente/team se applicabile

  const RaciColumn({
    required this.id,
    required this.name,
    required this.type,
    this.referenceId,
  });

  factory RaciColumn.fromMap(Map<String, dynamic> map) {
    return RaciColumn(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: RaciColumnType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => RaciColumnType.custom,
      ),
      referenceId: map['referenceId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'referenceId': referenceId,
    };
  }
}
