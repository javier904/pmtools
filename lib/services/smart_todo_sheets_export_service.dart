import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../models/smart_todo/todo_list_model.dart';
import '../models/smart_todo/todo_task_model.dart';
import 'auth_service.dart';

/// Service per l'export delle Liste Smart Todo su Google Sheets
class SmartTodoSheetsExportService {
  static final SmartTodoSheetsExportService _instance = SmartTodoSheetsExportService._internal();
  factory SmartTodoSheetsExportService() => _instance;
  SmartTodoSheetsExportService._internal();

  final AuthService _authService = AuthService();

  SheetsApi? _sheetsApi;
  drive.DriveApi? _driveApi;

  /// Autentica l'utente per l'accesso a Google Sheets e Drive
  Future<bool> _authenticate() async {
    try {
      print('🔐 [SmartTodoExport] Iniziando autenticazione...');

      // Prova a riutilizzare l'account Google da AuthService
      final googleSignIn = _authService.googleSignIn;
      var googleAccount = googleSignIn.currentUser;

      if (googleAccount == null) {
        print('🔄 [SmartTodoExport] Nessun account Google, richiedo login...');
        googleAccount = await googleSignIn.signIn();

        if (googleAccount == null) {
          print('❌ [SmartTodoExport] Login annullato dall\'utente');
          return false;
        }
      }

      print('✅ [SmartTodoExport] Account: ${googleAccount.email}');

      // Ottieni headers autenticazione
      final authHeaders = await googleAccount.authHeaders;

      if (authHeaders.isEmpty) {
        print('❌ [SmartTodoExport] Headers autenticazione vuoti');
        return false;
      }

      // Crea client API
      final client = _GoogleAuthClient(authHeaders);
      _sheetsApi = SheetsApi(client);
      _driveApi = drive.DriveApi(client);

      print('✅ [SmartTodoExport] Autenticazione completata');
      return true;
    } catch (e) {
      print('❌ [SmartTodoExport] Errore autenticazione: $e');
      return false;
    }
  }

  /// Esporta la lista su un nuovo Google Sheets
  Future<String?> exportTodoListToGoogleSheets({
    required TodoListModel list,
    required List<TodoTaskModel> tasks,
  }) async {
    try {
      print('📊 [SmartTodoExport] Iniziando export per: ${list.title}');

      // Autentica
      if (!await _authenticate()) {
        throw Exception('Autenticazione fallita');
      }

      // Crea nuovo spreadsheet
      final spreadsheet = await _createSpreadsheet(list.title);
      final spreadsheetId = spreadsheet.spreadsheetId!;

      print('📄 [SmartTodoExport] Spreadsheet creato: $spreadsheetId');

      // Popola i fogli
      await _populateTasksSheet(spreadsheetId, list, tasks);
      
      // Applica formattazione
      await _applyFormatting(spreadsheetId);

      final url = 'https://docs.google.com/spreadsheets/d/$spreadsheetId';
      print('✅ [SmartTodoExport] Export completato: $url');

      return url;
    } catch (e) {
      print('❌ [SmartTodoExport] Errore export: $e');
      return null;
    }
  }

  Future<Spreadsheet> _createSpreadsheet(String title) async {
    final spreadsheet = Spreadsheet()
      ..properties = (SpreadsheetProperties()
        ..title = 'Agile Tools - $title'
        ..locale = 'it_IT')
      ..sheets = [
        Sheet()
          ..properties = (SheetProperties()
            ..title = 'Tasks'
            ..index = 0
            ..sheetId = 0),
      ];

    return await _sheetsApi!.spreadsheets.create(spreadsheet);
  }

  Future<void> _populateTasksSheet(
    String spreadsheetId,
    TodoListModel list,
    List<TodoTaskModel> tasks,
  ) async {
    final values = <List<dynamic>>[];

    // Header
    values.add([
      'Titolo',
      'Descrizione',
      'Stato',
      'Priorità',
      'Scadenza',
      'Assegnatario',
      'Tag',
      'Creato Il',
    ]);

    // Map column IDs to Titles
    final statusMap = {for (var c in list.columns) c.id: c.title};

    for (var task in tasks) {
      values.add([
        task.title,
        task.description,
        statusMap[task.statusId] ?? task.statusId,
        task.priority.name.toUpperCase(),
        task.dueDate?.toIso8601String().split('T')[0] ?? '',
        task.assignedTo.join(', '),
        task.tags.map((t) => t.title).join(', '),
        task.createdAt.toIso8601String().split('T')[0],
      ]);
    }

    // Scrivi dati
    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Tasks!A1',
      valueInputOption: 'USER_ENTERED',
    );
  }

  Future<void> _applyFormatting(String spreadsheetId) async {
    try {
      final requests = <Request>[];

      // Formatta header (riga 1)
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

      // Auto-resize
      requests.add(Request()
        ..autoResizeDimensions = (AutoResizeDimensionsRequest()
          ..dimensions = (DimensionRange()
            ..sheetId = 0
            ..dimension = 'COLUMNS'
            ..startIndex = 0
            ..endIndex = 8)));

      await _sheetsApi!.spreadsheets.batchUpdate(
        BatchUpdateSpreadsheetRequest()..requests = requests,
        spreadsheetId,
      );
    } catch (e) {
      print('⚠️ [SmartTodoExport] Errore formattazione: $e');
    }
  }
}

class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  _GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
