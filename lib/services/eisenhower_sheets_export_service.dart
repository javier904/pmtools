import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../models/eisenhower_matrix_model.dart';
import '../models/eisenhower_activity_model.dart';
import 'auth_service.dart';

/// Service per l'export della Matrice di Eisenhower su Google Sheets
///
/// Crea un nuovo foglio Google Sheets con:
/// - Sheet 1: Riepilogo attività con quadrante, urgenza, importanza
/// - Sheet 2: Dettaglio voti per partecipante
/// - Sheet 3: Matrice RACI
/// - Sheet 4: Statistiche e grafico
class EisenhowerSheetsExportService {
  static final EisenhowerSheetsExportService _instance = EisenhowerSheetsExportService._internal();
  factory EisenhowerSheetsExportService() => _instance;
  EisenhowerSheetsExportService._internal();

  static const List<String> _requiredScopes = [
    SheetsApi.spreadsheetsScope,
    'https://www.googleapis.com/auth/drive.file',
  ];

  final AuthService _authService = AuthService();

  SheetsApi? _sheetsApi;
  drive.DriveApi? _driveApi;

  /// Autentica l'utente per l'accesso a Google Sheets e Drive
  Future<bool> _authenticate() async {
    try {
      print('🔐 [EisenhowerExport] Iniziando autenticazione...');

      // Prova a riutilizzare l'account Google da AuthService
      final googleSignIn = _authService.googleSignIn;
      var googleAccount = googleSignIn.currentUser;

      if (googleAccount == null) {
        print('🔄 [EisenhowerExport] Nessun account Google, richiedo login...');
        googleAccount = await googleSignIn.signIn();

        if (googleAccount == null) {
          print('❌ [EisenhowerExport] Login annullato dall\'utente');
          return false;
        }
      }

      print('✅ [EisenhowerExport] Account: ${googleAccount.email}');

      // Ottieni headers autenticazione
      final authHeaders = await googleAccount.authHeaders;

      if (authHeaders.isEmpty) {
        print('❌ [EisenhowerExport] Headers autenticazione vuoti');
        return false;
      }

      // Crea client API
      final client = _GoogleAuthClient(authHeaders);
      _sheetsApi = SheetsApi(client);
      _driveApi = drive.DriveApi(client);

      print('✅ [EisenhowerExport] Autenticazione completata');
      return true;
    } catch (e) {
      print('❌ [EisenhowerExport] Errore autenticazione: $e');
      return false;
    }
  }

  /// Esporta la matrice su un nuovo Google Sheets
  ///
  /// Ritorna l'URL del foglio creato, o null in caso di errore
  Future<String?> exportToGoogleSheets({
    required EisenhowerMatrixModel matrix,
    required List<EisenhowerActivityModel> activities,
  }) async {
    try {
      print('📊 [EisenhowerExport] Iniziando export per: ${matrix.title}');

      // Autentica
      if (!await _authenticate()) {
        throw Exception('Autenticazione fallita');
      }

      // Crea nuovo spreadsheet
      final spreadsheet = await _createSpreadsheet(matrix.title);
      final spreadsheetId = spreadsheet.spreadsheetId!;

      print('📄 [EisenhowerExport] Spreadsheet creato: $spreadsheetId');

      // Popola i fogli
      await _populateSummarySheet(spreadsheetId, matrix, activities);
      await _populateVotesSheet(spreadsheetId, matrix, activities);
      await _populateRaciSheet(spreadsheetId, matrix, activities);
      await _populateStatsSheet(spreadsheetId, matrix, activities);

      // Applica formattazione
      await _applyFormatting(spreadsheetId, matrix);

      final url = 'https://docs.google.com/spreadsheets/d/$spreadsheetId';
      print('✅ [EisenhowerExport] Export completato: $url');

      return url;
    } catch (e) {
      print('❌ [EisenhowerExport] Errore export: $e');
      return null;
    }
  }

  /// Crea un nuovo spreadsheet con 4 fogli
  Future<Spreadsheet> _createSpreadsheet(String title) async {
    final spreadsheet = Spreadsheet()
      ..properties = (SpreadsheetProperties()
        ..title = 'Eisenhower - $title'
        ..locale = 'it_IT')
      ..sheets = [
        Sheet()
          ..properties = (SheetProperties()
            ..title = 'Riepilogo'
            ..index = 0
            ..sheetId = 0),
        Sheet()
          ..properties = (SheetProperties()
            ..title = 'Dettaglio Voti'
            ..index = 1
            ..sheetId = 1),
        Sheet()
           ..properties = (SheetProperties()
            ..title = 'Matrice RACI'
            ..index = 2
            ..sheetId = 3),
        Sheet()
          ..properties = (SheetProperties()
            ..title = 'Statistiche'
            ..index = 3
            ..sheetId = 2),
      ];

    return await _sheetsApi!.spreadsheets.create(spreadsheet);
  }

  /// Popola il foglio Riepilogo
  Future<void> _populateSummarySheet(
    String spreadsheetId,
    EisenhowerMatrixModel matrix,
    List<EisenhowerActivityModel> activities,
  ) async {
    final values = <List<dynamic>>[];

    // Header
    values.add([
      '#',
      'Attività',
      'Descrizione',
      'Quadrante',
      'Azione',
      'Urgenza (media)',
      'Importanza (media)',
      'N. Voti',
    ]);

    // Dati attività ordinate per quadrante
    final sortedActivities = List<EisenhowerActivityModel>.from(activities);
    sortedActivities.sort((a, b) {
      final aQ = a.quadrant?.name ?? 'Z';
      final bQ = b.quadrant?.name ?? 'Z';
      return aQ.compareTo(bQ);
    });

    for (var i = 0; i < sortedActivities.length; i++) {
      final activity = sortedActivities[i];
      values.add([
        i + 1,
        activity.title,
        activity.description,
        activity.quadrant?.name ?? '-',
        activity.quadrant?.action ?? '-',
        activity.hasVotes ? activity.aggregatedUrgency.toStringAsFixed(1) : '-',
        activity.hasVotes ? activity.aggregatedImportance.toStringAsFixed(1) : '-',
        activity.voteCount,
      ]);
    }

    // Scrivi dati
    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Riepilogo!A1',
      valueInputOption: 'USER_ENTERED',
    );

    print('📝 [EisenhowerExport] Riepilogo: ${activities.length} attività');
  }

  /// Popola il foglio Dettaglio Voti
  Future<void> _populateVotesSheet(
    String spreadsheetId,
    EisenhowerMatrixModel matrix,
    List<EisenhowerActivityModel> activities,
  ) async {
    final values = <List<dynamic>>[];

    // Header
    values.add([
      'Attività',
      'Partecipante',
      'Urgenza',
      'Importanza',
    ]);

    // Dati voti espansi
    for (final activity in activities) {
      for (final entry in activity.votes.entries) {
        values.add([
          activity.title,
          entry.key,
          entry.value.urgency,
          entry.value.importance,
        ]);
      }
    }

    if (values.length == 1) {
      // Solo header, aggiungi riga vuota
      values.add(['Nessun voto registrato', '', '', '']);
    }

    // Scrivi dati
    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Dettaglio Voti!A1',
      valueInputOption: 'USER_ENTERED',
    );

    print('📝 [EisenhowerExport] Dettaglio Voti: ${values.length - 1} righe');
  }

  /// Popola il foglio RACI
  Future<void> _populateRaciSheet(
    String spreadsheetId,
    EisenhowerMatrixModel matrix,
    List<EisenhowerActivityModel> activities,
  ) async {
    final values = <List<dynamic>>[];

    // Header: Activities + Column Names
    final header = ['Attività'];
    for (final col in matrix.raciColumns) {
      header.add(col.name);
    }
    values.add(header);

    // Sort aligned with UI
    final sortedActivities = List<EisenhowerActivityModel>.from(activities);
    sortedActivities.sort((a, b) {
      final qA = a.quadrant?.index ?? 99;
      final qB = b.quadrant?.index ?? 99;
      if (qA != qB) return qA.compareTo(qB);
      final scoreA = (a.aggregatedUrgency) + (a.aggregatedImportance);
      final scoreB = (b.aggregatedUrgency) + (b.aggregatedImportance);
      return scoreB.compareTo(scoreA); // Descending
    });

    // Rows
    for (final activity in sortedActivities) {
      final row = <dynamic>[activity.title];
      for (final col in matrix.raciColumns) {
        final role = activity.raciAssignments[col.id];
        row.add(role?.label ?? ''); // R, A, C, I or empty
      }
      values.add(row);
    }

    if (values.length == 1) {
      // Solo header, nessuna attività
      values.add(['Nessuna attività', '', '', '']);
    }

    // Write data
    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Matrice RACI!A1',
      valueInputOption: 'USER_ENTERED',
    );

    print('📝 [EisenhowerExport] RACI: ${values.length - 1} righe');
  }

  /// Popola il foglio Statistiche
  Future<void> _populateStatsSheet(
    String spreadsheetId,
    EisenhowerMatrixModel matrix,
    List<EisenhowerActivityModel> activities,
  ) async {
    final values = <List<dynamic>>[];

    // Info matrice
    values.add(['MATRICE EISENHOWER - ${matrix.title}']);
    values.add(['']);
    values.add(['Data export:', DateTime.now().toString().substring(0, 16)]);
    values.add(['Creato da:', matrix.createdBy]);
    values.add(['']);

    // Partecipanti
    values.add(['PARTECIPANTI (${matrix.participants.length})']);
    for (final p in matrix.participants.values) {
      values.add(['  • ${p.name} (${p.email})']);
    }
    values.add(['']);

    // Statistiche quadranti
    values.add(['DISTRIBUZIONE QUADRANTI']);
    final quadrantCounts = activities.quadrantCounts;
    values.add(['Q1 - FAI SUBITO:', quadrantCounts[EisenhowerQuadrant.q1] ?? 0]);
    values.add(['Q2 - PIANIFICA:', quadrantCounts[EisenhowerQuadrant.q2] ?? 0]);
    values.add(['Q3 - DELEGA:', quadrantCounts[EisenhowerQuadrant.q3] ?? 0]);
    values.add(['Q4 - ELIMINA:', quadrantCounts[EisenhowerQuadrant.q4] ?? 0]);
    values.add(['']);

    // Statistiche generali
    final votedCount = activities.where((a) => a.hasVotes).length;
    values.add(['STATISTICHE GENERALI']);
    values.add(['Totale attività:', activities.length]);
    values.add(['Attività votate:', votedCount]);
    values.add(['Attività da votare:', activities.length - votedCount]);
    values.add(['Completamento:', '${(votedCount / (activities.isEmpty ? 1 : activities.length) * 100).toStringAsFixed(0)}%']);
    values.add(['']);

    // Colonne RACI
    if (matrix.raciColumns.isNotEmpty) {
      values.add(['COLONNE RACI (${matrix.raciColumns.length})']);
      for (final col in matrix.raciColumns) {
        values.add(['  • ${col.name} (${col.type.name})']);
      }
      values.add(['']);
    }

    // Dati per grafico (X=Urgenza, Y=Importanza)
    values.add(['DATI GRAFICO (per Scatter Plot)']);
    values.add(['Attività', 'Urgenza', 'Importanza', 'Quadrante']);
    for (final activity in activities.where((a) => a.hasVotes)) {
      values.add([
        activity.title,
        activity.aggregatedUrgency,
        activity.aggregatedImportance,
        activity.quadrant?.name ?? '-',
      ]);
    }

    // Scrivi dati
    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Statistiche!A1',
      valueInputOption: 'USER_ENTERED',
    );

    print('📝 [EisenhowerExport] Statistiche complete');
  }

  /// Applica formattazione ai fogli
  Future<void> _applyFormatting(String spreadsheetId, EisenhowerMatrixModel matrix) async {
    try {
      final requests = <Request>[];

      // Formatta header Riepilogo (riga 1)
      requests.add(Request()
        ..repeatCell = (RepeatCellRequest()
          ..range = (GridRange()
            ..sheetId = 0
            ..startRowIndex = 0
            ..endRowIndex = 1
            ..startColumnIndex = 0
            ..endColumnIndex = 8)
          ..cell = (CellData()
            ..userEnteredFormat = (CellFormat()
              ..backgroundColor = (Color()
                ..red = 0.2
                ..green = 0.4
                ..blue = 0.8)
              ..textFormat = (TextFormat()
                ..bold = true
                ..foregroundColor = (Color()
                  ..red = 1
                  ..green = 1
                  ..blue = 1))))
          ..fields = 'userEnteredFormat(backgroundColor,textFormat)'));

      // Formatta header Dettaglio Voti
      requests.add(Request()
        ..repeatCell = (RepeatCellRequest()
          ..range = (GridRange()
            ..sheetId = 1
            ..startRowIndex = 0
            ..endRowIndex = 1
            ..startColumnIndex = 0
            ..endColumnIndex = 4)
          ..cell = (CellData()
            ..userEnteredFormat = (CellFormat()
              ..backgroundColor = (Color()
                ..red = 0.3
                ..green = 0.6
                ..blue = 0.3)
              ..textFormat = (TextFormat()
                ..bold = true
                ..foregroundColor = (Color()
                  ..red = 1
                  ..green = 1
                  ..blue = 1))))
          ..fields = 'userEnteredFormat(backgroundColor,textFormat)'));

      // Formatta header RACI (riga 1)
      requests.add(Request()
        ..repeatCell = (RepeatCellRequest()
          ..range = (GridRange()
            ..sheetId = 3
            ..startRowIndex = 0
            ..endRowIndex = 1
            ..startColumnIndex = 0
            ..endColumnIndex = matrix.raciColumns.length + 1)
          ..cell = (CellData()
            ..userEnteredFormat = (CellFormat()
              ..backgroundColor = (Color()
                ..red = 0.8
                ..green = 0.9
                ..blue = 1.0)
              ..textFormat = (TextFormat()
                ..bold = true
                ..foregroundColor = (Color()
                  ..red = 0
                  ..green = 0
                  ..blue = 0.4))))
          ..fields = 'userEnteredFormat(backgroundColor,textFormat)'));

      // Auto-resize colonne
      for (var sheetId = 0; sheetId < 4; sheetId++) {
        requests.add(Request()
          ..autoResizeDimensions = (AutoResizeDimensionsRequest()
            ..dimensions = (DimensionRange()
              ..sheetId = sheetId
              ..dimension = 'COLUMNS'
              ..startIndex = 0
              ..endIndex = 10)));
      }

      // Esegui batch update
      await _sheetsApi!.spreadsheets.batchUpdate(
        BatchUpdateSpreadsheetRequest()..requests = requests,
        spreadsheetId,
      );

      print('🎨 [EisenhowerExport] Formattazione applicata');
    } catch (e) {
      print('⚠️ [EisenhowerExport] Errore formattazione (non critico): $e');
    }
  }
}

/// Client HTTP autenticato per Google APIs
class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  _GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
