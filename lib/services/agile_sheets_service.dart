import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import '../models/agile_project_model.dart';
import '../models/user_story_model.dart';
import '../models/sprint_model.dart';
import '../models/team_member_model.dart';
import '../models/retrospective_model.dart';
import '../models/agile_enums.dart';
import 'auth_service.dart';

/// Service per export/import dati Agile su Google Sheets
///
/// Crea fogli per:
/// - Sheet 1: Product Backlog
/// - Sheet 2: Sprint Planning
/// - Sheet 3: Team & Capacity
/// - Sheet 4: Retrospective
/// - Sheet 5: Metriche
class AgileSheetsService {
  static final AgileSheetsService _instance = AgileSheetsService._internal();
  factory AgileSheetsService() => _instance;
  AgileSheetsService._internal();

  final AuthService _authService = AuthService();

  SheetsApi? _sheetsApi;
  drive.DriveApi? _driveApi;

  /// Autentica l'utente per l'accesso a Google Sheets e Drive
  Future<bool> _authenticate() async {
    try {
      print('🔐 [AgileSheets] Iniziando autenticazione...');

      final googleSignIn = _authService.googleSignIn;
      var googleAccount = googleSignIn.currentUser;

      if (googleAccount == null) {
        print('🔄 [AgileSheets] Nessun account Google, richiedo login...');
        googleAccount = await googleSignIn.signIn();

        if (googleAccount == null) {
          print('❌ [AgileSheets] Login annullato dall\'utente');
          return false;
        }
      }

      print('✅ [AgileSheets] Account: ${googleAccount.email}');

      final authHeaders = await googleAccount.authHeaders;

      if (authHeaders.isEmpty) {
        print('❌ [AgileSheets] Headers autenticazione vuoti');
        return false;
      }

      final client = _GoogleAuthClient(authHeaders);
      _sheetsApi = SheetsApi(client);
      _driveApi = drive.DriveApi(client);

      print('✅ [AgileSheets] Autenticazione completata');
      return true;
    } catch (e) {
      print('❌ [AgileSheets] Errore autenticazione: $e');
      return false;
    }
  }

  /// Esporta tutti i dati del progetto su Google Sheets
  Future<String?> exportProjectToSheets({
    required AgileProjectModel project,
    required List<UserStoryModel> stories,
    required List<SprintModel> sprints,
    required List<TeamMemberModel> teamMembers,
    List<RetrospectiveModel>? retrospectives,
  }) async {
    try {
      print('📊 [AgileSheets] Iniziando export per: ${project.name}');

      if (!await _authenticate()) {
        throw Exception('Autenticazione fallita');
      }

      // Crea spreadsheet
      final spreadsheet = await _createSpreadsheet(project.name);
      final spreadsheetId = spreadsheet.spreadsheetId!;

      print('📄 [AgileSheets] Spreadsheet creato: $spreadsheetId');

      // Popola fogli
      await _populateBacklogSheet(spreadsheetId, stories);
      await _populateSprintSheet(spreadsheetId, sprints, stories);
      await _populateTeamSheet(spreadsheetId, teamMembers);
      if (retrospectives != null && retrospectives.isNotEmpty) {
        await _populateRetroSheet(spreadsheetId, retrospectives);
      }
      await _populateMetricsSheet(spreadsheetId, project, stories, sprints);

      // Formattazione
      await _applyFormatting(spreadsheetId);

      final url = 'https://docs.google.com/spreadsheets/d/$spreadsheetId';
      print('✅ [AgileSheets] Export completato: $url');

      return url;
    } catch (e) {
      print('❌ [AgileSheets] Errore export: $e');
      return null;
    }
  }

  /// Esporta solo il backlog
  Future<String?> exportBacklogToSheets({
    required String projectName,
    required List<UserStoryModel> stories,
  }) async {
    try {
      if (!await _authenticate()) {
        throw Exception('Autenticazione fallita');
      }

      final spreadsheet = Spreadsheet()
        ..properties = (SpreadsheetProperties()
          ..title = 'Backlog - $projectName'
          ..locale = 'it_IT')
        ..sheets = [
          Sheet()..properties = (SheetProperties()..title = 'Backlog'..index = 0..sheetId = 0),
        ];

      final created = await _sheetsApi!.spreadsheets.create(spreadsheet);
      final spreadsheetId = created.spreadsheetId!;

      await _populateBacklogSheet(spreadsheetId, stories);

      return 'https://docs.google.com/spreadsheets/d/$spreadsheetId';
    } catch (e) {
      print('❌ [AgileSheets] Errore export backlog: $e');
      return null;
    }
  }

  /// Crea spreadsheet con tutti i fogli
  Future<Spreadsheet> _createSpreadsheet(String projectName) async {
    final spreadsheet = Spreadsheet()
      ..properties = (SpreadsheetProperties()
        ..title = 'Agile - $projectName'
        ..locale = 'it_IT')
      ..sheets = [
        Sheet()..properties = (SheetProperties()..title = 'Product Backlog'..index = 0..sheetId = 0),
        Sheet()..properties = (SheetProperties()..title = 'Sprint Planning'..index = 1..sheetId = 1),
        Sheet()..properties = (SheetProperties()..title = 'Team'..index = 2..sheetId = 2),
        Sheet()..properties = (SheetProperties()..title = 'Retrospective'..index = 3..sheetId = 3),
        Sheet()..properties = (SheetProperties()..title = 'Metriche'..index = 4..sheetId = 4),
      ];

    return await _sheetsApi!.spreadsheets.create(spreadsheet);
  }

  /// Popola foglio Product Backlog
  Future<void> _populateBacklogSheet(String spreadsheetId, List<UserStoryModel> stories) async {
    final values = <List<dynamic>>[];

    // Header
    values.add([
      'ID',
      'Titolo',
      'Descrizione',
      'Priorità',
      'Status',
      'Story Points',
      'Business Value',
      'Tags',
      'Assegnato a',
      'Sprint',
      'Creato il',
      'Completato il',
    ]);

    // Dati
    final sortedStories = List<UserStoryModel>.from(stories)
      ..sort((a, b) => a.order.compareTo(b.order));

    for (final story in sortedStories) {
      values.add([
        story.storyId,
        story.title,
        story.description,
        story.priority.displayName,
        story.status.displayName,
        story.storyPoints ?? '-',
        story.businessValue,
        story.tags.join(', '),
        story.assigneeEmail ?? '-',
        story.sprintId ?? '-',
        _formatDate(story.createdAt),
        story.completedAt != null ? _formatDate(story.completedAt!) : '-',
      ]);
    }

    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Product Backlog!A1',
      valueInputOption: 'USER_ENTERED',
    );

    print('📝 [AgileSheets] Backlog: ${stories.length} stories');
  }

  /// Popola foglio Sprint Planning
  Future<void> _populateSprintSheet(
    String spreadsheetId,
    List<SprintModel> sprints,
    List<UserStoryModel> stories,
  ) async {
    final values = <List<dynamic>>[];

    // Header
    values.add([
      'Sprint',
      'Nome',
      'Goal',
      'Status',
      'Inizio',
      'Fine',
      'Punti Pianificati',
      'Punti Completati',
      'Velocity',
      'N. Stories',
    ]);

    // Dati sprint
    final sortedSprints = List<SprintModel>.from(sprints)
      ..sort((a, b) => a.number.compareTo(b.number));

    for (final sprint in sortedSprints) {
      final sprintStories = stories.where((s) => s.sprintId == sprint.id).length;
      values.add([
        sprint.number,
        sprint.name,
        sprint.goal,
        sprint.status.displayName,
        _formatDate(sprint.startDate),
        _formatDate(sprint.endDate),
        sprint.plannedPoints,
        sprint.completedPoints,
        sprint.velocity?.toStringAsFixed(1) ?? '-',
        sprintStories,
      ]);
    }

    if (sprints.isEmpty) {
      values.add(['Nessuno sprint', '', '', '', '', '', '', '', '', '']);
    }

    // Aggiungi dettaglio stories per sprint
    values.add(['']);
    values.add(['DETTAGLIO STORIES PER SPRINT']);
    values.add(['Sprint', 'Story ID', 'Titolo', 'Punti', 'Status']);

    for (final sprint in sortedSprints) {
      final sprintStories = stories.where((s) => s.sprintId == sprint.id).toList();
      for (final story in sprintStories) {
        values.add([
          'Sprint ${sprint.number}',
          story.storyId,
          story.title,
          story.storyPoints ?? '-',
          story.status.displayName,
        ]);
      }
    }

    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Sprint Planning!A1',
      valueInputOption: 'USER_ENTERED',
    );

    print('📝 [AgileSheets] Sprint Planning: ${sprints.length} sprint');
  }

  /// Popola foglio Team
  Future<void> _populateTeamSheet(String spreadsheetId, List<TeamMemberModel> members) async {
    final values = <List<dynamic>>[];

    // Header
    values.add([
      'Nome',
      'Email',
      'Ruolo Partecipante',
      'Ruolo Team',
      'Capacità (h/giorno)',
      'Competenze',
    ]);

    // Dati team
    for (final member in members) {
      values.add([
        member.name ?? member.email,
        member.email,
        member.participantRole.displayName,
        member.role.displayName,
        member.capacityHoursPerDay,
        member.skills.join(', '),
      ]);
    }

    if (members.isEmpty) {
      values.add(['Nessun membro', '', '', '', '', '']);
    }

    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Team!A1',
      valueInputOption: 'USER_ENTERED',
    );

    print('📝 [AgileSheets] Team: ${members.length} membri');
  }

  /// Popola foglio Retrospective
  Future<void> _populateRetroSheet(String spreadsheetId, List<RetrospectiveModel> retros) async {
    final values = <List<dynamic>>[];

    // Header
    values.add([
      'Sprint',
      'Data',
      'Sentiment Medio',
      'Positivi',
      'Miglioramenti',
      'Action Items',
    ]);

    // Dati retro
    for (final retro in retros) {
      values.add([
        'Sprint',
        _formatDate(retro.createdAt),
        retro.averageSentiment?.toStringAsFixed(1) ?? '-',
        retro.wentWell.length,
        retro.toImprove.length,
        retro.actionItems.length,
      ]);
    }

    // Dettaglio ultima retro
    if (retros.isNotEmpty) {
      final lastRetro = retros.last;
      values.add(['']);
      values.add(['ULTIMA RETROSPETTIVA']);
      values.add(['']);

      values.add(['✓ COSA È ANDATO BENE']);
      for (final item in lastRetro.wentWell) {
        values.add(['', item.content, 'Voti: ${item.votes}']);
      }

      values.add(['']);
      values.add(['✗ COSA MIGLIORARE']);
      for (final item in lastRetro.toImprove) {
        values.add(['', item.content, 'Voti: ${item.votes}']);
      }

      values.add(['']);
      values.add(['⚡ ACTION ITEMS']);
      for (final action in lastRetro.actionItems) {
        values.add([
          '',
          action.title,
          action.isCompleted ? '✓ Completato' : '○ Da fare',
          action.assigneeEmail ?? '-',
        ]);
      }
    }

    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Retrospective!A1',
      valueInputOption: 'USER_ENTERED',
    );

    print('📝 [AgileSheets] Retrospective: ${retros.length} retro');
  }

  /// Popola foglio Metriche
  Future<void> _populateMetricsSheet(
    String spreadsheetId,
    AgileProjectModel project,
    List<UserStoryModel> stories,
    List<SprintModel> sprints,
  ) async {
    final values = <List<dynamic>>[];

    // Info progetto
    values.add(['PROGETTO AGILE - ${project.name}']);
    values.add(['']);
    values.add(['Data export:', DateTime.now().toString().substring(0, 16)]);
    values.add(['Framework:', project.framework.displayName]);
    values.add(['Durata Sprint:', '${project.sprintDurationDays} giorni']);
    values.add(['']);

    // Statistiche generali
    values.add(['STATISTICHE GENERALI']);
    values.add(['Totale Stories:', stories.length]);
    values.add(['Stories Completate:', stories.where((s) => s.status == StoryStatus.done).length]);
    values.add(['Sprint Totali:', sprints.length]);
    values.add(['Sprint Completati:', sprints.where((s) => s.status == SprintStatus.completed).length]);
    values.add(['']);

    // Velocity
    final completedSprints = sprints.where((s) => s.velocity != null).toList();
    final avgVelocity = completedSprints.isEmpty
        ? 0.0
        : completedSprints.fold<double>(0, (sum, s) => sum + s.velocity!) / completedSprints.length;

    values.add(['VELOCITY']);
    values.add(['Media:', avgVelocity.toStringAsFixed(1)]);
    values.add(['']);
    values.add(['Sprint', 'Velocity']);
    for (final sprint in completedSprints) {
      values.add(['Sprint ${sprint.number}', sprint.velocity!.toStringAsFixed(1)]);
    }
    values.add(['']);

    // Distribuzione per priorità
    values.add(['DISTRIBUZIONE PER PRIORITÀ']);
    for (final priority in StoryPriority.values) {
      final count = stories.where((s) => s.priority == priority).length;
      values.add([priority.displayName, count]);
    }
    values.add(['']);

    // Distribuzione per status
    values.add(['DISTRIBUZIONE PER STATUS']);
    for (final status in StoryStatus.values) {
      final count = stories.where((s) => s.status == status).length;
      values.add([status.displayName, count]);
    }

    await _sheetsApi!.spreadsheets.values.update(
      ValueRange()..values = values,
      spreadsheetId,
      'Metriche!A1',
      valueInputOption: 'USER_ENTERED',
    );

    print('📝 [AgileSheets] Metriche complete');
  }

  /// Applica formattazione ai fogli
  Future<void> _applyFormatting(String spreadsheetId) async {
    try {
      final requests = <Request>[];

      // Formatta header per ogni foglio
      for (var sheetId = 0; sheetId < 5; sheetId++) {
        requests.add(Request()
          ..repeatCell = (RepeatCellRequest()
            ..range = (GridRange()
              ..sheetId = sheetId
              ..startRowIndex = 0
              ..endRowIndex = 1
              ..startColumnIndex = 0
              ..endColumnIndex = 12)
            ..cell = (CellData()
              ..userEnteredFormat = (CellFormat()
                ..backgroundColor = (Color()
                  ..red = 0.13
                  ..green = 0.55
                  ..blue = 0.55) // Teal
                ..textFormat = (TextFormat()
                  ..bold = true
                  ..foregroundColor = (Color()
                    ..red = 1
                    ..green = 1
                    ..blue = 1))))
            ..fields = 'userEnteredFormat(backgroundColor,textFormat)'));

        // Auto-resize colonne
        requests.add(Request()
          ..autoResizeDimensions = (AutoResizeDimensionsRequest()
            ..dimensions = (DimensionRange()
              ..sheetId = sheetId
              ..dimension = 'COLUMNS'
              ..startIndex = 0
              ..endIndex = 12)));
      }

      await _sheetsApi!.spreadsheets.batchUpdate(
        BatchUpdateSpreadsheetRequest()..requests = requests,
        spreadsheetId,
      );

      print('🎨 [AgileSheets] Formattazione applicata');
    } catch (e) {
      print('⚠️ [AgileSheets] Errore formattazione (non critico): $e');
    }
  }

  /// Importa stories da Google Sheets
  ///
  /// Formato atteso:
  /// Colonna A: Titolo
  /// Colonna B: Descrizione
  /// Colonna C: Priorità (Must/Should/Could/Won't)
  /// Colonna D: Story Points
  /// Colonna E: Tags (separati da virgola)
  Future<List<UserStoryModel>?> importStoriesFromSheets({
    required String spreadsheetId,
    required String projectId,
    String range = 'A2:E100', // Salta header
  }) async {
    try {
      if (!await _authenticate()) {
        throw Exception('Autenticazione fallita');
      }

      final response = await _sheetsApi!.spreadsheets.values.get(
        spreadsheetId,
        range,
      );

      final rows = response.values;
      if (rows == null || rows.isEmpty) {
        print('⚠️ [AgileSheets] Nessun dato da importare');
        return [];
      }

      final stories = <UserStoryModel>[];
      var order = 0;

      for (final row in rows) {
        if (row.isEmpty || (row[0] as String).trim().isEmpty) continue;

        final title = row[0].toString().trim();
        final description = row.length > 1 ? row[1].toString().trim() : '';
        final priorityStr = row.length > 2 ? row[2].toString().trim() : 'Could';
        final pointsStr = row.length > 3 ? row[3].toString().trim() : '';
        final tagsStr = row.length > 4 ? row[4].toString().trim() : '';

        final priority = _parsePriority(priorityStr);
        final points = int.tryParse(pointsStr);
        final tags = tagsStr.isNotEmpty
            ? tagsStr.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList()
            : <String>[];

        final story = UserStoryModel(
          id: 'import_${DateTime.now().millisecondsSinceEpoch}_$order',
          projectId: projectId,
          title: title,
          description: description,
          priority: priority,
          status: StoryStatus.backlog,
          storyPoints: points,
          businessValue: 5,
          tags: tags,
          acceptanceCriteria: [],
          order: order,
          createdAt: DateTime.now(),
          createdBy: 'import',
          estimates: {},
        );

        stories.add(story);
        order++;
      }

      print('✅ [AgileSheets] Importate ${stories.length} stories');
      return stories;
    } catch (e) {
      print('❌ [AgileSheets] Errore import: $e');
      return null;
    }
  }

  StoryPriority _parsePriority(String value) {
    switch (value.toLowerCase()) {
      case 'must':
      case 'must have':
        return StoryPriority.must;
      case 'should':
      case 'should have':
        return StoryPriority.should;
      case 'could':
      case 'could have':
        return StoryPriority.could;
      case 'wont':
      case 'won\'t':
      case 'won\'t have':
        return StoryPriority.wont;
      default:
        return StoryPriority.could;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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
