import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/models/retro_methodology_guide.dart';
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

  /// Exports the retrospective to a new Google Sheet or updates an existing one
  Future<String?> exportToGoogleSheets(RetrospectiveModel retro, {String? existingUrl}) async {
    try {
      if (!await _authenticate()) throw Exception('Authentication failed');

      String spreadsheetId;
      String url;

      // Get methodology-specific export configuration
      final exportConfig = RetroMethodologyGuide.getExportConfig(retro.template);

      if (existingUrl != null && existingUrl.isNotEmpty) {
        // Update existing spreadsheet
        spreadsheetId = _extractSpreadsheetId(existingUrl);
        print('📄 [RetroExport] Updating existing spreadsheet: $spreadsheetId');
        await _clearAndUpdateSheets(spreadsheetId, retro, exportConfig);
        url = existingUrl;
      } else {
        // Create new spreadsheet with methodology-specific sheets
        final spreadsheet = await _createSpreadsheet(
          retro.sprintName.isNotEmpty ? retro.sprintName : 'Retrospective',
          retro.template,
          exportConfig,
        );
        spreadsheetId = spreadsheet.spreadsheetId!;

        await _populateOverviewSheet(spreadsheetId, retro, exportConfig);
        await _populateActionItemsSheet(spreadsheetId, retro, exportConfig);
        await _populateBoardSheet(spreadsheetId, retro);
        await _populateIcebreakerSheet(spreadsheetId, retro);

        // Populate methodology-specific sheets
        await _populateMethodologySpecificSheet(spreadsheetId, retro, exportConfig);

        await _applyFormatting(spreadsheetId, retro, exportConfig);

        url = 'https://docs.google.com/spreadsheets/d/$spreadsheetId';
      }

      print('✅ [RetroExport] Export complete: $url');
      return url;
    } catch (e) {
      print('❌ [RetroExport] Export error: $e');
      return null;
    }
  }

  /// Extracts spreadsheet ID from a Google Sheets URL
  String _extractSpreadsheetId(String url) {
    final regex = RegExp(r'/d/([a-zA-Z0-9-_]+)');
    final match = regex.firstMatch(url);
    if (match != null) {
      return match.group(1)!;
    }
    throw Exception('URL spreadsheet non valido');
  }

  /// Clears existing sheets and repopulates with updated data
  Future<void> _clearAndUpdateSheets(String spreadsheetId, RetrospectiveModel retro, ExportConfig exportConfig) async {
    try {
      // Clear existing data from all sheets
      await _sheetsApi!.spreadsheets.values.clear(
        sheets.ClearValuesRequest(),
        spreadsheetId,
        'Overview!A:Z',
      );
      await _sheetsApi!.spreadsheets.values.clear(
        sheets.ClearValuesRequest(),
        spreadsheetId,
        'Action Items!A:Z',
      );
      await _sheetsApi!.spreadsheets.values.clear(
        sheets.ClearValuesRequest(),
        spreadsheetId,
        'Board Items!A:Z',
      );
      await _sheetsApi!.spreadsheets.values.clear(
        sheets.ClearValuesRequest(),
        spreadsheetId,
        'Icebreakers!A:Z',
      );

      // Clear methodology-specific sheet
      final methodologySheetName = _getMethodologySheetName(retro.template);
      if (methodologySheetName != null) {
        try {
          await _sheetsApi!.spreadsheets.values.clear(
            sheets.ClearValuesRequest(),
            spreadsheetId,
            '$methodologySheetName!A:Z',
          );
        } catch (_) {
          // Sheet might not exist in older exports
        }
      }

      // Repopulate with updated data
      await _populateOverviewSheet(spreadsheetId, retro, exportConfig);
      await _populateActionItemsSheet(spreadsheetId, retro, exportConfig);
      await _populateActionItemsSheet(spreadsheetId, retro, exportConfig);
      await _populateBoardSheet(spreadsheetId, retro);
      await _populateIcebreakerSheet(spreadsheetId, retro);
      await _populateMethodologySpecificSheet(spreadsheetId, retro, exportConfig);
      await _applyFormatting(spreadsheetId, retro, exportConfig);
    } catch (e) {
      print('❌ [RetroExport] Error updating spreadsheet: $e');
      rethrow;
    }
  }

  /// Gets the methodology-specific sheet name
  String? _getMethodologySheetName(RetroTemplate template) {
    switch (template) {
      case RetroTemplate.madSadGlad:
        return 'Team Health';
      case RetroTemplate.fourLs:
        return 'Lessons Learned';
      case RetroTemplate.sailboat:
        return 'Risk Register';
      case RetroTemplate.starfish:
        return 'Calibration Matrix';
      case RetroTemplate.daki:
        return 'Decision Log';
      case RetroTemplate.startStopContinue:
      default:
        return null;
    }
  }

  Future<sheets.Spreadsheet> _createSpreadsheet(String title, RetroTemplate template, ExportConfig exportConfig) async {
    final sheetsList = <sheets.Sheet>[
      sheets.Sheet()..properties = (sheets.SheetProperties()..title = 'Overview'..index = 0..sheetId = 0),
      sheets.Sheet()..properties = (sheets.SheetProperties()..title = 'Action Items'..index = 1..sheetId = 1),
      sheets.Sheet()..properties = (sheets.SheetProperties()..title = 'Board Items'..index = 2..sheetId = 2),
      sheets.Sheet()..properties = (sheets.SheetProperties()..title = 'Icebreakers'..index = 3..sheetId = 3),
    ];

    // Add methodology-specific sheet based on template
    final methodologySheetName = _getMethodologySheetName(template);
    if (methodologySheetName != null) {
      sheetsList.add(
        sheets.Sheet()..properties = (sheets.SheetProperties()
          ..title = methodologySheetName
          ..index = 4
          ..sheetId = 4),
      );
    }

    final spreadsheet = sheets.Spreadsheet()
      ..properties = (sheets.SpreadsheetProperties()..title = 'Retro - $title'..locale = 'it_IT')
      ..sheets = sheetsList;
    return await _sheetsApi!.spreadsheets.create(spreadsheet);
  }

  Future<void> _populateOverviewSheet(String spreadsheetId, RetrospectiveModel retro, ExportConfig exportConfig) async {
    // Get methodology focus description
    final methodologyFocus = RetroMethodologyGuide.getMethodologyFocus(retro.template);
    final focusDescription = _getMethodologyFocusDescription(methodologyFocus);

    final values = [
      ['RETROSPECTIVE REPORT'],
      [''],
      ['Title:', retro.sprintName],
      ['Date:', retro.createdAt.toString().split(' ')[0]],
      ['Template:', retro.template.displayName],
      ['Methodology Focus:', focusDescription],
      ['Sentiments (Avg):', retro.averageSentiment?.toStringAsFixed(1) ?? 'N/A'],
      [''],
      ['PARTICIPANTS (${retro.participantEmails.length})'],
      ...retro.participantEmails.map((e) => ['• $e']),
      [''],
      ['SUMMARY'],
      ['Total Items:', retro.items.length],
      ['Action Items:', retro.actionItems.length],
      [''],
      ['Suggested Follow-up:', _getSuggestedFollowUpDescription(exportConfig.suggestedFollowUp)],
    ];

    await _sheetsApi!.spreadsheets.values.update(
      sheets.ValueRange()..values = values,
      spreadsheetId,
      'Overview!A1',
      valueInputOption: 'USER_ENTERED',
    );
  }

  String _getMethodologyFocusDescription(MethodologyFocus focus) {
    switch (focus) {
      case MethodologyFocus.actionOriented:
        return 'Action-oriented: focuses on concrete behavioral changes';
      case MethodologyFocus.emotionFocused:
        return 'Emotion-focused: explores team feelings to build psychological safety';
      case MethodologyFocus.learningReflective:
        return 'Learning-reflective: emphasizes knowledge capture and sharing';
      case MethodologyFocus.riskAndGoal:
        return 'Risk & Goal: balances enablers, blockers, risks, and objectives';
      case MethodologyFocus.calibration:
        return 'Calibration: uses gradations (more/less) for nuanced adjustment';
      case MethodologyFocus.decisional:
        return 'Decisional: drives clear team decisions on practices';
    }
  }

  String _getSuggestedFollowUpDescription(String followUp) {
    switch (followUp) {
      case 'team_health_check':
        return 'Schedule a Team Health Check to monitor emotional trends';
      case 'knowledge_base_update':
        return 'Update team knowledge base with lessons learned';
      case 'risk_review':
        return 'Review risk register in next sprint planning';
      case 'calibration_check':
        return 'Monitor calibrated practices in daily standups';
      case 'decision_review':
        return 'Review decision effectiveness in next retrospective';
      case 'action_review':
      default:
        return 'Review action item progress in next sprint';
    }
  }

  Future<void> _populateActionItemsSheet(String spreadsheetId, RetrospectiveModel retro, ExportConfig exportConfig) async {
    final values = <List<dynamic>>[];

    // Header - includes Source Column, Resources and Monitoring
    values.add([
      'Source Column',
      'Action Type',
      'Description',
      'Linked Card',
      'Owner',
      'Assignee',
      'Priority',
      'Due Date',
      'Resources',
      'Monitoring',
      'Status',
    ]);

    // Group action items by action type for better organization
    final groupedItems = <ActionType?, List<ActionItem>>{};
    for (final item in retro.actionItems) {
      groupedItems.putIfAbsent(item.actionType, () => []).add(item);
    }

    // Sort by action type (items with type first, then null types)
    final sortedKeys = groupedItems.keys.toList()
      ..sort((a, b) {
        if (a == null && b == null) return 0;
        if (a == null) return 1;
        if (b == null) return -1;
        return a.displayName.compareTo(b.displayName);
      });

    for (final actionType in sortedKeys) {
      final items = groupedItems[actionType]!;
      for (final item in items) {
        // Get column title from sourceColumnId
        String sourceColumnTitle = '-';
        if (item.sourceColumnId != null && item.sourceColumnId!.isNotEmpty) {
          final column = retro.columns.where((c) => c.id == item.sourceColumnId).firstOrNull;
          sourceColumnTitle = column?.title ?? item.sourceColumnId!;
        }

        values.add([
          sourceColumnTitle,
          item.actionType?.displayName ?? '-',
          item.description,
          item.sourceRefContent ?? '-',
          item.ownerEmail,
          item.assigneeEmail ?? '-',
          item.priority.name,
          item.dueDate?.toString().split(' ')[0] ?? '-',
          item.resources ?? '-',
          item.monitoring ?? '-',
          item.isCompleted ? 'Completed' : 'Pending',
        ]);
      }
    }

    if (values.length == 1) values.add(['No action items', '', '', '', '', '', '', '', '', '', '']);

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

  Future<void> _populateIcebreakerSheet(String spreadsheetId, RetrospectiveModel retro) async {
    final values = <List<dynamic>>[];
    
    // One Word Check-in
    values.add(['ONE WORD CHECK-IN']);
    values.add(['Participant', 'Word']);
    
    if (retro.oneWordVotes.isEmpty) {
      values.add(['No entries recorded', '']);
    } else {
      retro.oneWordVotes.forEach((email, word) {
        values.add([email, word]);
      });
    }

    values.add(['']); // Gap
    values.add(['']); 

    // Weather Report
    values.add(['WEATHER REPORT']);
    values.add(['Participant', 'Weather']);

    if (retro.weatherVotes.isEmpty) {
      values.add(['No entries recorded', '']);
    } else {
      retro.weatherVotes.forEach((email, weather) {
        // Weather is stored as code (sunny, cloudy...). Convert to readable if needed, or just export capitalised.
        values.add([email, weather.toUpperCase()]);
      });
    }

    await _sheetsApi!.spreadsheets.values.update(
      sheets.ValueRange()..values = values,
      spreadsheetId,
      'Icebreakers!A1',
      valueInputOption: 'USER_ENTERED',
    );
  }

  /// Populates methodology-specific sheet based on template
  Future<void> _populateMethodologySpecificSheet(String spreadsheetId, RetrospectiveModel retro, ExportConfig exportConfig) async {
    final sheetName = _getMethodologySheetName(retro.template);
    if (sheetName == null) return;

    List<List<dynamic>> values;

    switch (retro.template) {
      case RetroTemplate.madSadGlad:
        values = _buildTeamHealthSheet(retro, exportConfig);
        break;
      case RetroTemplate.fourLs:
        values = _buildLessonsLearnedSheet(retro, exportConfig);
        break;
      case RetroTemplate.sailboat:
        values = _buildRiskRegisterSheet(retro, exportConfig);
        break;
      case RetroTemplate.starfish:
        values = _buildCalibrationMatrixSheet(retro, exportConfig);
        break;
      case RetroTemplate.daki:
        values = _buildDecisionLogSheet(retro, exportConfig);
        break;
      case RetroTemplate.startStopContinue:
      default:
        return;
    }

    await _sheetsApi!.spreadsheets.values.update(
      sheets.ValueRange()..values = values,
      spreadsheetId,
      '$sheetName!A1',
      valueInputOption: 'USER_ENTERED',
    );
  }

  /// Builds Team Health Analysis sheet for Mad/Sad/Glad
  List<List<dynamic>> _buildTeamHealthSheet(RetrospectiveModel retro, ExportConfig exportConfig) {
    final madItems = retro.getItemsForColumn('mad');
    final sadItems = retro.getItemsForColumn('sad');
    final gladItems = retro.getItemsForColumn('glad');

    // Determine team health recommendation
    final totalItems = madItems.length + sadItems.length + gladItems.length;
    String recommendation;
    if (totalItems == 0) {
      recommendation = 'Insufficient data to assess team health.';
    } else {
      final frustrationRatio = (madItems.length + sadItems.length) / totalItems;
      if (frustrationRatio > 0.7) {
        recommendation = 'High frustration level detected. Consider facilitating a focused problem-solving session.';
      } else if (frustrationRatio < 0.3) {
        recommendation = 'Positive team morale. Leverage this energy for challenging improvements.';
      } else {
        recommendation = 'Balanced emotional state. Team shows healthy reflection capabilities.';
      }
    }

    final values = <List<dynamic>>[
      ['TEAM HEALTH ANALYSIS'],
      [''],
      ['Emotional Distribution'],
      ['Mad items:', madItems.length],
      ['Sad items:', sadItems.length],
      ['Glad items:', gladItems.length],
      [''],
      ['Team Health Recommendation:', recommendation],
      [''],
      ['FRUSTRATIONS (Mad)', 'Votes', 'DISAPPOINTMENTS (Sad)', 'Votes', 'CELEBRATIONS (Glad)', 'Votes'],
    ];

    // Build rows with all three columns
    final maxRows = [madItems.length, sadItems.length, gladItems.length].reduce((a, b) => a > b ? a : b);
    for (int i = 0; i < maxRows; i++) {
      values.add([
        i < madItems.length ? madItems[i].content : '',
        i < madItems.length ? madItems[i].votes : '',
        i < sadItems.length ? sadItems[i].content : '',
        i < sadItems.length ? sadItems[i].votes : '',
        i < gladItems.length ? gladItems[i].content : '',
        i < gladItems.length ? gladItems[i].votes : '',
      ]);
    }

    if (maxRows == 0) {
      values.add(['No items', '', 'No items', '', 'No items', '']);
    }

    return values;
  }

  /// Builds Lessons Learned Register for 4Ls
  List<List<dynamic>> _buildLessonsLearnedSheet(RetrospectiveModel retro, ExportConfig exportConfig) {
    final likedItems = retro.getItemsForColumn('liked');
    final learnedItems = retro.getItemsForColumn('learned');
    final lackedItems = retro.getItemsForColumn('lacked');
    final longedItems = retro.getItemsForColumn('longed');

    // Identify knowledge sharing needs
    final documentationNeeded = lackedItems.where((i) =>
      i.content.toLowerCase().contains('document') ||
      i.content.toLowerCase().contains('doc') ||
      i.content.toLowerCase().contains('wiki')).toList();
    final trainingNeeded = lackedItems.where((i) =>
      i.content.toLowerCase().contains('train') ||
      i.content.toLowerCase().contains('learn') ||
      i.content.toLowerCase().contains('skill')).toList();

    final values = <List<dynamic>>[
      ['LESSONS LEARNED REGISTER'],
      [''],
      ['WHAT WORKED (Liked)', 'Votes', 'NEW SKILLS & INSIGHTS (Learned)', 'Votes'],
    ];

    final maxLikedLearned = [likedItems.length, learnedItems.length].reduce((a, b) => a > b ? a : b);
    for (int i = 0; i < maxLikedLearned; i++) {
      values.add([
        i < likedItems.length ? likedItems[i].content : '',
        i < likedItems.length ? likedItems[i].votes : '',
        i < learnedItems.length ? learnedItems[i].content : '',
        i < learnedItems.length ? learnedItems[i].votes : '',
      ]);
    }

    values.addAll([
      [''],
      ['GAPS & MISSING ELEMENTS (Lacked)', 'Votes', 'FUTURE ASPIRATIONS (Longed For)', 'Votes'],
    ]);

    final maxLackedLonged = [lackedItems.length, longedItems.length].reduce((a, b) => a > b ? a : b);
    for (int i = 0; i < maxLackedLonged; i++) {
      values.add([
        i < lackedItems.length ? lackedItems[i].content : '',
        i < lackedItems.length ? lackedItems[i].votes : '',
        i < longedItems.length ? longedItems[i].content : '',
        i < longedItems.length ? longedItems[i].votes : '',
      ]);
    }

    // Knowledge sharing section
    values.addAll([
      [''],
      ['KNOWLEDGE SHARING ACTIONS'],
      ['Documentation Needed:', documentationNeeded.isEmpty ? 'None identified' : documentationNeeded.map((i) => i.content).join('; ')],
      ['Training/Sharing Needed:', trainingNeeded.isEmpty ? 'None identified' : trainingNeeded.map((i) => i.content).join('; ')],
    ]);

    return values;
  }

  /// Builds Risk & Enabler Register for Sailboat
  List<List<dynamic>> _buildRiskRegisterSheet(RetrospectiveModel retro, ExportConfig exportConfig) {
    final windItems = retro.getItemsForColumn('wind');
    final anchorItems = retro.getItemsForColumn('anchor');
    final rockItems = retro.getItemsForColumn('rock');
    final goalItems = retro.getItemsForColumn('goal');

    final values = <List<dynamic>>[
      ['RISK & ENABLER REGISTER'],
      [''],
      ['GOALS (Island)', 'Priority'],
    ];

    for (final item in goalItems) {
      values.add([item.content, '${item.votes} votes']);
    }
    if (goalItems.isEmpty) values.add(['No goals defined', '']);

    values.addAll([
      [''],
      ['ENABLERS (Wind)', 'Votes', 'BLOCKERS (Anchor)', 'Votes'],
    ]);

    final maxEnablersBlockers = [windItems.length, anchorItems.length].reduce((a, b) => a > b ? a : b);
    for (int i = 0; i < maxEnablersBlockers; i++) {
      values.add([
        i < windItems.length ? windItems[i].content : '',
        i < windItems.length ? windItems[i].votes : '',
        i < anchorItems.length ? anchorItems[i].content : '',
        i < anchorItems.length ? anchorItems[i].votes : '',
      ]);
    }
    if (maxEnablersBlockers == 0) values.add(['No enablers', '', 'No blockers', '']);

    values.addAll([
      [''],
      ['RISKS (Rocks)', 'Votes', 'Potential Impact', 'Mitigation Status'],
    ]);

    for (final item in rockItems) {
      values.add([item.content, item.votes, 'To be assessed', 'Pending']);
    }
    if (rockItems.isEmpty) values.add(['No risks identified', '', '', '']);

    values.addAll([
      [''],
      ['Goal Alignment Check:', 'Review if current actions align with stated goals.'],
    ]);

    return values;
  }

  /// Builds Calibration Matrix for Starfish
  List<List<dynamic>> _buildCalibrationMatrixSheet(RetrospectiveModel retro, ExportConfig exportConfig) {
    final keepItems = retro.getItemsForColumn('keep');
    final moreItems = retro.getItemsForColumn('more');
    final lessItems = retro.getItemsForColumn('less');
    final stopItems = retro.getItemsForColumn('stop');
    final startItems = retro.getItemsForColumn('start');

    final values = <List<dynamic>>[
      ['CALIBRATION MATRIX'],
      [''],
      ['Note:', 'Calibration focuses on fine-tuning existing practices rather than wholesale changes.'],
      [''],
      ['KEEP DOING', 'Votes', 'DO MORE', 'Votes', 'DO LESS', 'Votes'],
    ];

    final maxKML = [keepItems.length, moreItems.length, lessItems.length].reduce((a, b) => a > b ? a : b);
    for (int i = 0; i < maxKML; i++) {
      values.add([
        i < keepItems.length ? keepItems[i].content : '',
        i < keepItems.length ? keepItems[i].votes : '',
        i < moreItems.length ? moreItems[i].content : '',
        i < moreItems.length ? moreItems[i].votes : '',
        i < lessItems.length ? lessItems[i].content : '',
        i < lessItems.length ? lessItems[i].votes : '',
      ]);
    }
    if (maxKML == 0) values.add(['No items', '', 'No items', '', 'No items', '']);

    values.addAll([
      [''],
      ['STOP DOING', 'Votes', 'START DOING', 'Votes'],
    ]);

    final maxStopStart = [stopItems.length, startItems.length].reduce((a, b) => a > b ? a : b);
    for (int i = 0; i < maxStopStart; i++) {
      values.add([
        i < stopItems.length ? stopItems[i].content : '',
        i < stopItems.length ? stopItems[i].votes : '',
        i < startItems.length ? startItems[i].content : '',
        i < startItems.length ? startItems[i].votes : '',
      ]);
    }
    if (maxStopStart == 0) values.add(['No items', '', 'No items', '']);

    return values;
  }

  /// Builds Decision Log for DAKI
  List<List<dynamic>> _buildDecisionLogSheet(RetrospectiveModel retro, ExportConfig exportConfig) {
    final dropItems = retro.getItemsForColumn('drop');
    final addItems = retro.getItemsForColumn('add');
    final keepItems = retro.getItemsForColumn('keep');
    final improveItems = retro.getItemsForColumn('improve');

    final values = <List<dynamic>>[
      ['DECISION LOG'],
      [''],
      ['Prioritization Recommendation:', 'Focus on DROP decisions first to free capacity, then ADD new practices.'],
      [''],
      ['DECISIONS TO DROP', 'Votes', 'Rationale'],
    ];

    for (final item in dropItems) {
      values.add([item.content, item.votes, 'To be documented']);
    }
    if (dropItems.isEmpty) values.add(['No items to drop', '', '']);

    values.addAll([
      [''],
      ['DECISIONS TO ADD', 'Votes', 'Owner', 'Deadline'],
    ]);

    for (final item in addItems) {
      values.add([item.content, item.votes, 'TBD', 'TBD']);
    }
    if (addItems.isEmpty) values.add(['No items to add', '', '', '']);

    values.addAll([
      [''],
      ['DECISIONS TO KEEP', 'Votes', 'DECISIONS TO IMPROVE', 'Votes'],
    ]);

    final maxKeepImprove = [keepItems.length, improveItems.length].reduce((a, b) => a > b ? a : b);
    for (int i = 0; i < maxKeepImprove; i++) {
      values.add([
        i < keepItems.length ? keepItems[i].content : '',
        i < keepItems.length ? keepItems[i].votes : '',
        i < improveItems.length ? improveItems[i].content : '',
        i < improveItems.length ? improveItems[i].votes : '',
      ]);
    }
    if (maxKeepImprove == 0) values.add(['No items', '', 'No items', '']);

    return values;
  }

  Future<void> _applyFormatting(String spreadsheetId, RetrospectiveModel retro, ExportConfig exportConfig) async {
    try {
      final requests = <sheets.Request>[];

      // Format Header Row (Overview Title is row 0, but Headers for others are row 0)
      // Overview Title
      requests.add(_boldCellRequest(0, 0, 0, 0, 1));

      // Action Items Header (Green) - 11 columns (Source Column, Action Type, Description, etc.)
      requests.add(_headerFormatRequest(
        1, 0, 1, 0, 11,
        sheets.Color()..red=0.2..green=0.6..blue=0.2
      ));

      // Board Items Header (Blue)
      requests.add(_headerFormatRequest(
        2, 0, 1, 0, retro.columns.length,
        sheets.Color()..red=0.3..green=0.4..blue=0.8
      ));

      // Methodology-specific sheet header (Purple) - if present
      final methodologySheetName = _getMethodologySheetName(retro.template);
      if (methodologySheetName != null) {
        requests.add(_headerFormatRequest(
          3, 0, 1, 0, 6,
          _getMethodologySheetColor(retro.template),
        ));
      }

      // Auto Resize
      final sheetsCount = methodologySheetName != null ? 4 : 3;
      for (int i = 0; i < sheetsCount; i++) {
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

  sheets.Color _getMethodologySheetColor(RetroTemplate template) {
    switch (template) {
      case RetroTemplate.madSadGlad:
        return sheets.Color()..red=0.9..green=0.4..blue=0.4; // Red for emotions
      case RetroTemplate.fourLs:
        return sheets.Color()..red=0.4..green=0.7..blue=0.4; // Green for learning
      case RetroTemplate.sailboat:
        return sheets.Color()..red=0.3..green=0.5..blue=0.8; // Blue for navigation
      case RetroTemplate.starfish:
        return sheets.Color()..red=0.8..green=0.5..blue=0.2; // Orange for calibration
      case RetroTemplate.daki:
        return sheets.Color()..red=0.6..green=0.3..blue=0.7; // Purple for decisions
      case RetroTemplate.startStopContinue:
      default:
        return sheets.Color()..red=0.5..green=0.5..blue=0.5;
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
