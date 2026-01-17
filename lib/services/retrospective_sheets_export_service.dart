import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/auth_service.dart';

/// Service for exporting Retrospective to Google Sheets
class RetrospectiveSheetsExportService {
  static final RetrospectiveSheetsExportService _instance = RetrospectiveSheetsExportService._internal();
  factory RetrospectiveSheetsExportService() => _instance;
  RetrospectiveSheetsExportService._internal();

  final AuthService _authService = AuthService();
  sheets.SheetsApi? _sheetsApi;
  drive.DriveApi? _driveApi;

  /// Authenticates user for Sheets and Drive access
  Future<bool> _authenticate() async {
    try {
      print('🔐 [RetroExport] Starting authentication...');
      final googleSignIn = _authService.googleSignIn;
      var googleAccount = googleSignIn.currentUser;

      if (googleAccount == null) {
        print('🔄 [RetroExport] No Google account, requesting sign in...');
        googleAccount = await googleSignIn.signIn();
        if (googleAccount == null) return false;
      }

      final authHeaders = await googleAccount.authHeaders;
      if (authHeaders.isEmpty) return false;

      final client = _GoogleAuthClient(authHeaders);
      _sheetsApi = sheets.SheetsApi(client);
      _driveApi = drive.DriveApi(client);

      print('✅ [RetroExport] Authentication complete');
      return true;
    } catch (e) {
      print('❌ [RetroExport] Authentication error: $e');
      return false;
    }
  }

  /// Exports the retrospective to a new Google Sheet
  Future<String?> exportToGoogleSheets(RetrospectiveModel retro) async {
    try {
      if (!await _authenticate()) throw Exception('Authentication failed');

      final spreadsheet = await _createSpreadsheet(retro.sprintName.isNotEmpty ? retro.sprintName : 'Retrospective');
      final spreadsheetId = spreadsheet.spreadsheetId!;

      await _populateOverviewSheet(spreadsheetId, retro);
      await _populateActionItemsSheet(spreadsheetId, retro);
      await _populateBoardSheet(spreadsheetId, retro);
      await _applyFormatting(spreadsheetId, retro);

      final url = 'https://docs.google.com/spreadsheets/d/$spreadsheetId';
      print('✅ [RetroExport] Export complete: $url');
      return url;
    } catch (e) {
      print('❌ [RetroExport] Export error: $e');
      return null;
    }
  }

  Future<sheets.Spreadsheet> _createSpreadsheet(String title) async {
    final spreadsheet = sheets.Spreadsheet()
      ..properties = (sheets.SpreadsheetProperties()..title = 'Retro - $title'..locale = 'it_IT')
      ..sheets = [
        sheets.Sheet()..properties = (sheets.SheetProperties()..title = 'Overview'..index = 0..sheetId = 0),
        sheets.Sheet()..properties = (sheets.SheetProperties()..title = 'Action Items'..index = 1..sheetId = 1),
        sheets.Sheet()..properties = (sheets.SheetProperties()..title = 'Board Items'..index = 2..sheetId = 2),
      ];
    return await _sheetsApi!.spreadsheets.create(spreadsheet);
  }

  Future<void> _populateOverviewSheet(String spreadsheetId, RetrospectiveModel retro) async {
    final values = [
      ['RETROSPECTIVE REPORT'],
      [''],
      ['Title:', retro.sprintName],
      ['Date:', retro.createdAt.toString().split(' ')[0]],
      ['Template:', retro.template.displayName],
      ['Sentiments (Avg):', retro.averageSentiment?.toStringAsFixed(1) ?? 'N/A'],
      [''],
      ['PARTICIPANTS (${retro.participantEmails.length})'],
      ...retro.participantEmails.map((e) => ['• $e']),
      [''],
      ['SUMMARY'],
      ['Total Items:', retro.items.length],
      ['Action Items:', retro.actionItems.length],
    ];

    await _sheetsApi!.spreadsheets.values.update(
      sheets.ValueRange()..values = values,
      spreadsheetId,
      'Overview!A1',
      valueInputOption: 'USER_ENTERED',
    );
  }

  Future<void> _populateActionItemsSheet(String spreadsheetId, RetrospectiveModel retro) async {
    final values = [
      ['Description', 'Owner', 'Assignee', 'Priority', 'Due Date', 'Status'],
      ...retro.actionItems.map((item) => [
        item.description,
        item.ownerEmail,
        item.assigneeEmail ?? '-',
        item.priority.name,
        item.dueDate?.toString().split(' ')[0] ?? '-',
        item.isCompleted ? 'Completed' : 'Pending',
      ])
    ];

    if (values.length == 1) values.add(['No action items', '', '', '', '', '']);

    await _sheetsApi!.spreadsheets.values.update(
      sheets.ValueRange()..values = values,
      spreadsheetId,
      'Action Items!A1',
      valueInputOption: 'USER_ENTERED',
    );
  }

  Future<void> _populateBoardSheet(String spreadsheetId, RetrospectiveModel retro) async {
    final values = <List<dynamic>>[];
    
    // Headers (Columns)
    final headers = retro.columns.map((c) => c.title.toUpperCase()).toList();
    values.add(headers);

    // Find max items count to know how many rows
    int maxRows = 0;
    final columnItems = <String, List<RetroItem>>{};
    
    for (var col in retro.columns) {
      final items = retro.getItemsForColumn(col.id);
      columnItems[col.id] = items;
      if (items.length > maxRows) maxRows = items.length;
    }

    // Populate rows
    for (int i = 0; i < maxRows; i++) {
        final row = <String>[];
        for (var col in retro.columns) {
           final items = columnItems[col.id]!;
           if (i < items.length) {
             final item = items[i];
             row.add('${item.content} (${item.votes} votes)');
           } else {
             row.add('');
           }
        }
        values.add(row);
    }
  
    if (values.length == 1) values.add(['No items recorded']);

    await _sheetsApi!.spreadsheets.values.update(
      sheets.ValueRange()..values = values,
      spreadsheetId,
      'Board Items!A1',
      valueInputOption: 'USER_ENTERED',
    );
  }

  Future<void> _applyFormatting(String spreadsheetId, RetrospectiveModel retro) async {
    try {
      final requests = <sheets.Request>[];

      // Format Header Row (Overview Title is row 0, but Headers for others are row 0)
      // Overview Title
      requests.add(_boldCellRequest(0, 0, 0, 0, 1));
      
      // Action Items Header (Green)
      requests.add(_headerFormatRequest(
        1, 0, 1, 0, 6, 
        sheets.Color()..red=0.2..green=0.6..blue=0.2
      )); 
      
      // Board Items Header (Blue)
      requests.add(_headerFormatRequest(
        2, 0, 1, 0, retro.columns.length, 
        sheets.Color()..red=0.3..green=0.4..blue=0.8
      ));

      // Auto Resize
      for (int i = 0; i < 3; i++) {
        requests.add(sheets.Request()..autoResizeDimensions = (sheets.AutoResizeDimensionsRequest()
          ..dimensions = (sheets.DimensionRange()..sheetId = i..dimension = 'COLUMNS'..startIndex = 0..endIndex = 10)));
      }

      await _sheetsApi!.spreadsheets.batchUpdate(
        sheets.BatchUpdateSpreadsheetRequest()..requests = requests,
        spreadsheetId,
      );
    } catch (e) {
      print('Formatting error: $e');
    }
  }

  sheets.Request _headerFormatRequest(int sheetId, int startRow, int endRow, int startCol, int endCol, sheets.Color color) {
    return sheets.Request()
      ..repeatCell = (sheets.RepeatCellRequest()
        ..range = (sheets.GridRange()..sheetId = sheetId..startRowIndex = startRow..endRowIndex = endRow..startColumnIndex = startCol..endColumnIndex = endCol)
        ..cell = (sheets.CellData()
          ..userEnteredFormat = (sheets.CellFormat()
            ..backgroundColor = color
            ..textFormat = (sheets.TextFormat()..bold = true..foregroundColor = (sheets.Color()..red=1..green=1..blue=1))))
        ..fields = 'userEnteredFormat(backgroundColor,textFormat)');
  }

  sheets.Request _boldCellRequest(int sheetId, int startRow, int endRow, int startCol, int endCol) {
     return sheets.Request()
      ..repeatCell = (sheets.RepeatCellRequest()
        ..range = (sheets.GridRange()..sheetId = sheetId..startRowIndex = startRow..endRowIndex = endRow..startColumnIndex = startCol..endColumnIndex = endCol)
        ..cell = (sheets.CellData()..userEnteredFormat = (sheets.CellFormat()..textFormat = (sheets.TextFormat()..bold = true)))
        ..fields = 'userEnteredFormat(textFormat)');
  }
}

class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();
  _GoogleAuthClient(this._headers);
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) => _client.send(request..headers.addAll(_headers));
}
