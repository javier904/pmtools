/// Risultato del parsing CSV con dettagli su errori e righe saltate
class CsvParseResult {
  final List<CsvActivityRow> activities;
  final List<CsvParseError> errors;
  final int totalRows;
  final int skippedRows;

  CsvParseResult({
    required this.activities,
    this.errors = const [],
    required this.totalRows,
    this.skippedRows = 0,
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get hasActivities => activities.isNotEmpty;
}

/// Errore di parsing con dettagli sulla riga
class CsvParseError {
  final int rowNumber;
  final String message;
  final String? rawContent;

  CsvParseError({
    required this.rowNumber,
    required this.message,
    this.rawContent,
  });

  @override
  String toString() => 'Riga $rowNumber: $message';
}

/// Riga di attività parsata da CSV
class CsvActivityRow {
  final int index;
  final String title;
  final String description;
  final String quadrant;
  final String action;
  final double urgency;
  final double importance;
  final int voteCount;
  bool selected;
  String? warning; // Warning non bloccante

  CsvActivityRow({
    required this.index,
    required this.title,
    this.description = '',
    this.quadrant = '',
    this.action = '',
    required this.urgency,
    required this.importance,
    this.voteCount = 1,
    this.selected = true,
    this.warning,
  });

  /// Converte urgenza in int (1-10)
  int get urgencyInt => urgency.round().clamp(1, 10);

  /// Converte importanza in int (1-10)
  int get importanceInt => importance.round().clamp(1, 10);

  bool get hasWarning => warning != null && warning!.isNotEmpty;

  @override
  String toString() =>
      'CsvActivityRow(title: $title, urgency: $urgency, importance: $importance)';
}

/// Codici di errore per traduzioni
enum CsvErrorCode {
  emptyFile,
  noHeader,
  missingTitleColumn,
  invalidRow,
  emptyTitle,
  invalidUrgency,
  invalidImportance,
  encodingError,
}

/// Servizio per importare attività da file CSV
///
/// Supporta il formato esportato da Google Sheets con colonne:
/// #, Attività, Descrizione, Quadrante, Azione, Urgenza (media), Importanza (media), N. Voti
class CsvImportService {
  /// Colonne attese nel CSV (case-insensitive matching)
  static const _columnMappings = {
    'attività': 'title',
    'attivita': 'title',
    'activity': 'title',
    'title': 'title',
    'titolo': 'title',
    'nombre': 'title',
    'activité': 'title',
    'descrizione': 'description',
    'description': 'description',
    'descripción': 'description',
    'quadrante': 'quadrant',
    'quadrant': 'quadrant',
    'cuadrante': 'quadrant',
    'azione': 'action',
    'action': 'action',
    'acción': 'action',
    'urgenza': 'urgency',
    'urgenza (media)': 'urgency',
    'urgency': 'urgency',
    'urgency (avg)': 'urgency',
    'urgencia': 'urgency',
    'importanza': 'importance',
    'importanza (media)': 'importance',
    'importance': 'importance',
    'importance (avg)': 'importance',
    'importancia': 'importance',
    'n. voti': 'voteCount',
    'votes': 'voteCount',
    'vote count': 'voteCount',
    'votos': 'voteCount',
  };

  /// Colonne richieste (almeno una di queste deve essere presente per il titolo)
  static const requiredTitleColumns = ['attività', 'attivita', 'activity', 'title', 'titolo', 'nombre', 'activité'];

  /// Parse il contenuto CSV e ritorna risultato dettagliato
  static CsvParseResult parseCsvWithDetails(String content) {
    final errors = <CsvParseError>[];
    final activities = <CsvActivityRow>[];

    // Verifica contenuto vuoto
    if (content.trim().isEmpty) {
      return CsvParseResult(
        activities: [],
        errors: [CsvParseError(rowNumber: 0, message: 'EMPTY_FILE')],
        totalRows: 0,
      );
    }

    // Normalizza line endings (Windows → Unix)
    final normalizedContent = content.replaceAll('\r\n', '\n').replaceAll('\r', '\n');

    // Split per righe, gestendo campi multilinea tra virgolette
    final rows = _splitCsvRows(normalizedContent);

    if (rows.isEmpty) {
      return CsvParseResult(
        activities: [],
        errors: [CsvParseError(rowNumber: 0, message: 'EMPTY_FILE')],
        totalRows: 0,
      );
    }

    // Prima riga = header
    final headerRow = rows.first;
    final headers = _parseCsvLine(headerRow);

    if (headers.isEmpty) {
      return CsvParseResult(
        activities: [],
        errors: [CsvParseError(rowNumber: 1, message: 'NO_HEADER')],
        totalRows: rows.length,
      );
    }

    // Mappa indici colonne
    final columnIndices = <String, int>{};
    for (var i = 0; i < headers.length; i++) {
      final normalizedHeader = headers[i].toLowerCase().trim();
      final mappedName = _columnMappings[normalizedHeader];
      if (mappedName != null) {
        columnIndices[mappedName] = i;
      }
    }

    // Verifica colonne obbligatorie
    if (!columnIndices.containsKey('title')) {
      return CsvParseResult(
        activities: [],
        errors: [
          CsvParseError(
            rowNumber: 1,
            message: 'MISSING_TITLE_COLUMN',
            rawContent: 'Colonne trovate: ${headers.join(", ")}',
          )
        ],
        totalRows: rows.length,
      );
    }

    // Parse righe dati
    int skippedRows = 0;
    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.trim().isEmpty) {
        skippedRows++;
        continue;
      }

      final fields = _parseCsvLine(row);
      if (fields.isEmpty) {
        skippedRows++;
        continue;
      }

      try {
        final result = _parseRowWithValidation(fields, columnIndices, i + 1);
        if (result.activity != null) {
          activities.add(result.activity!);
        }
        if (result.error != null) {
          errors.add(result.error!);
          skippedRows++;
        }
      } catch (e) {
        errors.add(CsvParseError(
          rowNumber: i + 1,
          message: 'INVALID_ROW',
          rawContent: e.toString(),
        ));
        skippedRows++;
      }
    }

    return CsvParseResult(
      activities: activities,
      errors: errors,
      totalRows: rows.length - 1, // Escludi header
      skippedRows: skippedRows,
    );
  }

  /// Parsing legacy per compatibilità
  static List<CsvActivityRow> parseCsv(String content) {
    final result = parseCsvWithDetails(content);
    if (result.errors.isNotEmpty && result.activities.isEmpty) {
      final firstError = result.errors.first;
      throw FormatException('${firstError.message}: ${firstError.rawContent ?? ""}');
    }
    return result.activities;
  }

  /// Split del CSV in righe, gestendo campi multilinea tra virgolette
  static List<String> _splitCsvRows(String content) {
    final rows = <String>[];
    final buffer = StringBuffer();
    var inQuotes = false;

    for (var i = 0; i < content.length; i++) {
      final char = content[i];

      if (char == '"') {
        // Gestisce escaped quotes ("") 
        if (i + 1 < content.length && content[i + 1] == '"') {
          buffer.write('""');
          i++; // Skip next quote
        } else {
          inQuotes = !inQuotes;
          buffer.write(char);
        }
      } else if (char == '\n' && !inQuotes) {
        rows.add(buffer.toString());
        buffer.clear();
      } else {
        buffer.write(char);
      }
    }

    // Aggiungi ultima riga se non vuota
    if (buffer.isNotEmpty) {
      rows.add(buffer.toString());
    }

    return rows;
  }

  /// Parse una singola linea CSV, gestendo virgolette e escape
  static List<String> _parseCsvLine(String line) {
    final fields = <String>[];
    final buffer = StringBuffer();
    var inQuotes = false;

    for (var i = 0; i < line.length; i++) {
      final char = line[i];

      if (char == '"') {
        if (i + 1 < line.length && line[i + 1] == '"') {
          // Escaped quote
          buffer.write('"');
          i++;
        } else {
          inQuotes = !inQuotes;
        }
      } else if (char == ',' && !inQuotes) {
        fields.add(buffer.toString().trim());
        buffer.clear();
      } else {
        buffer.write(char);
      }
    }

    // Aggiungi ultimo campo
    fields.add(buffer.toString().trim());

    return fields;
  }

  /// Risultato parsing di una singola riga
  static ({CsvActivityRow? activity, CsvParseError? error}) _parseRowWithValidation(
    List<String> fields,
    Map<String, int> columnIndices,
    int rowNumber,
  ) {
    String getField(String name) {
      final index = columnIndices[name];
      if (index == null || index >= fields.length) return '';
      return fields[index].trim();
    }

    double parseDouble(String value) {
      if (value.isEmpty) return 5.0; // Default medio
      // Gestisce sia punto che virgola come separatore decimale
      final normalized = value.replaceAll(',', '.');
      return double.tryParse(normalized) ?? 5.0;
    }

    int parseInt(String value) {
      if (value.isEmpty) return 1;
      return int.tryParse(value) ?? 1;
    }

    // Validazione titolo
    final title = getField('title');
    if (title.isEmpty) {
      return (
        activity: null,
        error: CsvParseError(
          rowNumber: rowNumber,
          message: 'EMPTY_TITLE',
        ),
      );
    }

    // Parse valori con warning per valori fuori range
    String? warning;
    final urgencyRaw = getField('urgency');
    final importanceRaw = getField('importance');

    var urgency = parseDouble(urgencyRaw);
    var importance = parseDouble(importanceRaw);

    // Valida range e correggi
    if (urgency < 1 || urgency > 10) {
      warning = 'Urgenza corretta: $urgency → ${urgency.clamp(1, 10)}';
      urgency = urgency.clamp(1.0, 10.0);
    }
    if (importance < 1 || importance > 10) {
      final corrected = importance.clamp(1.0, 10.0);
      warning = '${warning ?? ""}Importanza corretta: $importance → $corrected';
      importance = corrected;
    }

    return (
      activity: CsvActivityRow(
        index: rowNumber,
        title: title,
        description: getField('description'),
        quadrant: getField('quadrant'),
        action: getField('action'),
        urgency: urgency,
        importance: importance,
        voteCount: parseInt(getField('voteCount')),
        warning: warning,
      ),
      error: null,
    );
  }

  /// Formato CSV atteso (per istruzioni utente)
  static String getExpectedFormat() {
    return '''
Attività,Descrizione,Urgenza,Importanza
"Nome attività","Descrizione opzionale",8.5,7.2
''';
  }

  /// Lista colonne supportate
  static List<String> getSupportedColumns() {
    return ['Attività/Title', 'Descrizione/Description', 'Urgenza/Urgency (1-10)', 'Importanza/Importance (1-10)'];
  }
}
