import 'dart:convert';
import 'dart:html' as html; // Web-only import
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/user_story_model.dart';
import '../models/sprint_model.dart';
import '../models/team_member_model.dart';
import '../models/agile_enums.dart';

/// Service for exporting Agile Project data to CSV
class AgileCsvExportService {
  static final AgileCsvExportService _instance = AgileCsvExportService._internal();
  factory AgileCsvExportService() => _instance;
  AgileCsvExportService._internal();

  /// Exports Product Backlog to CSV
  Future<void> exportBacklogToCsv(String projectName, List<UserStoryModel> stories) async {
    final rows = _generateBacklogRows(stories);
    await _downloadCsv(rows, 'Backlog_${projectName.replaceAll(' ', '_')}');
  }

  /// Exports Sprints to CSV
  Future<void> exportSprintsToCsv(String projectName, List<SprintModel> sprints, List<UserStoryModel> stories) async {
    final rows = _generateSprintRows(sprints, stories);
    await _downloadCsv(rows, 'Sprints_${projectName.replaceAll(' ', '_')}');
  }

  /// Exports Team to CSV
  Future<void> exportTeamToCsv(String projectName, List<TeamMemberModel> members) async {
    final rows = _generateTeamRows(members);
    await _downloadCsv(rows, 'Team_${projectName.replaceAll(' ', '_')}');
  }

  /// Exports Kanban Board to CSV
  Future<void> exportKanbanToCsv(String projectName, List<UserStoryModel> stories) async {
    final rows = _generateKanbanRows(stories);
    await _downloadCsv(rows, 'Kanban_${projectName.replaceAll(' ', '_')}');
  }

  /// Exports Metrics to CSV
  Future<void> exportMetricsToCsv(String projectName, List<SprintModel> sprints, List<UserStoryModel> stories) async {
    final rows = _generateMetricsRows(sprints, stories);
    await _downloadCsv(rows, 'Metrics_${projectName.replaceAll(' ', '_')}');
  }

  /// Exports ALL Data to a single CSV with sections
  Future<void> exportAllDataToCsv(
    String projectName,
    List<UserStoryModel> stories,
    List<SprintModel> sprints,
    List<TeamMemberModel> members,
  ) async {
    List<List<dynamic>> allRows = [];

    // Backlog Section
    allRows.add(['=== BACKLOG / USER STORIES ===']);
    allRows.addAll(_generateBacklogRows(stories));
    allRows.add([]); // Empty row as separator

    // Sprints Section
    allRows.add(['=== SPRINTS ===']);
    allRows.addAll(_generateSprintRows(sprints, stories));
    allRows.add([]);

    // Team Section
    allRows.add(['=== TEAM ===']);
    allRows.addAll(_generateTeamRows(members));
    allRows.add([]);

    // Kanban Section
    allRows.add(['=== KANBAN BOARD ===']);
    allRows.addAll(_generateKanbanRows(stories));
    allRows.add([]);

    // Metrics Section
    allRows.add(['=== METRICS ===']);
    allRows.addAll(_generateMetricsRows(sprints, stories));

    await _downloadCsv(allRows, 'AgileProject_Full_${projectName.replaceAll(' ', '_')}');
  }

  // --------------------------------------------------------------------------
  // ROW GENERATORS
  // --------------------------------------------------------------------------

  List<List<dynamic>> _generateBacklogRows(List<UserStoryModel> stories) {
    final headers = [
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
    ];

    List<List<dynamic>> rows = [headers];

    // Sort by order
    final sortedStories = List<UserStoryModel>.from(stories)
      ..sort((a, b) => a.order.compareTo(b.order));

    for (var story in sortedStories) {
      rows.add([
        story.storyId,
        story.title,
        story.description,
        story.priority.displayName,
        story.status.displayName,
        story.storyPoints ?? '',
        story.businessValue,
        story.tags.join('; '),
        story.assigneeEmail ?? '',
        story.sprintId ?? '',
        _formatDate(story.createdAt),
        story.completedAt != null ? _formatDate(story.completedAt!) : '',
      ]);
    }
    return rows;
  }

  List<List<dynamic>> _generateSprintRows(List<SprintModel> sprints, List<UserStoryModel> stories) {
    final headers = [
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
    ];

    List<List<dynamic>> rows = [headers];

    final sortedSprints = List<SprintModel>.from(sprints)
      ..sort((a, b) => a.number.compareTo(b.number));

    for (var sprint in sortedSprints) {
      final sprintStories = stories.where((s) => s.sprintId == sprint.id).length;
      rows.add([
        sprint.number,
        sprint.name,
        sprint.goal,
        sprint.status.displayName,
        _formatDate(sprint.startDate),
        _formatDate(sprint.endDate),
        sprint.plannedPoints,
        sprint.completedPoints,
        sprint.velocity?.toStringAsFixed(1) ?? '',
        sprintStories,
      ]);
    }
    return rows;
  }

  List<List<dynamic>> _generateTeamRows(List<TeamMemberModel> members) {
    final headers = [
      'Nome',
      'Email',
      'Ruolo Partecipante',
      'Ruolo Team',
      'Capacità (h/giorno)',
      'Competenze',
    ];

    List<List<dynamic>> rows = [headers];

    for (var member in members) {
      rows.add([
        member.name ?? member.email,
        member.email,
        member.participantRole.displayName,
        member.role.displayName,
        member.capacityHoursPerDay,
        member.skills.join('; '),
      ]);
    }
    return rows;
  }

  List<List<dynamic>> _generateKanbanRows(List<UserStoryModel> stories) {
    // Kanban export typically emphasizes Status (Columns)
    final headers = [
      'Titolo',
      'Assegnato a',
      'Status (Colonna)',
      'Story Points',
      'Priorità',
    ];

    List<List<dynamic>> rows = [headers];

    // Group by status order
    final sortedStories = List<UserStoryModel>.from(stories)
      ..sort((a, b) {
        // Sort by status index first, then order
        int statusCompare = a.status.index.compareTo(b.status.index);
        if (statusCompare != 0) return statusCompare;
        return a.order.compareTo(b.order);
      });

    for (var story in sortedStories) {
      rows.add([
        story.title,
        story.assigneeEmail ?? '',
        story.status.displayName,
        story.storyPoints ?? '',
        story.priority.displayName,
      ]);
    }
    return rows;
  }

  List<List<dynamic>> _generateMetricsRows(List<SprintModel> sprints, List<UserStoryModel> stories) {
    List<List<dynamic>> rows = [];

    // ==========================================
    // 1. GENERAL METRICS
    // ==========================================
    rows.add(['=== GENERAL SNAPSHOT ===']);
    rows.add(['Metrica', 'Valore', 'Descrizione']);

    final completedSprints = sprints.where((s) => s.status == SprintStatus.completed).toList();
    
    // Average Velocity
    double avgVelocity = 0;
    if (completedSprints.isNotEmpty) {
      avgVelocity = completedSprints.fold(0, (sum, s) => sum + (s.completedPoints ?? 0)) / completedSprints.length;
    }

    // Total Story Points Completed
    int totalPoints = completedSprints.fold(0, (sum, s) => sum + (s.completedPoints ?? 0));

    // Total Stories Completed
    int totalStories = stories.where((s) => s.status == StoryStatus.done).length;

    rows.add(['Media Velocity', avgVelocity.toStringAsFixed(1), 'Media dei punti completati per sprint']);
    rows.add(['Totale Story Points', totalPoints.toString(), 'Totale punti completati in tutti gli sprint chiusi']);
    rows.add(['Totale Storie Completate', totalStories.toString(), 'Numero totale di User Stories nello stato Done']);
    rows.add(['Sprint Completati', completedSprints.length.toString(), 'Numero di sprint conclusi']);
    rows.add([]); // Spaziatore

    // ==========================================
    // 2. FLOW EFFICIENCY
    // ==========================================
    rows.add(['=== FLOW EFFICIENCY ===']);
    rows.add(['Metrica', 'Valore', 'Descrizione']);
    
    final flowStories = stories.where((s) => s.cycleTimeDays != null && s.leadTimeDays != null).toList();
    double avgCycleTime = 0;
    double avgLeadTime = 0;
    double flowEfficiency = 0;

    if (flowStories.isNotEmpty) {
      avgCycleTime = flowStories.fold(0, (sum, s) => sum + s.cycleTimeDays!) / flowStories.length;
      avgLeadTime = flowStories.fold(0, (sum, s) => sum + s.leadTimeDays!) / flowStories.length;
      if (avgLeadTime > 0) {
        flowEfficiency = (avgCycleTime / avgLeadTime * 100);
      }
    }

    rows.add(['Stories with Flow Data', flowStories.length.toString(), 'Storie con date di inizio e fine valide']);
    rows.add(['Avg Cycle Time (Days)', avgCycleTime.toStringAsFixed(1), 'Tempo medio di lavorazione attiva (In Progress -> Done)']);
    rows.add(['Avg Lead Time (Days)', avgLeadTime.toStringAsFixed(1), 'Tempo medio dalla creazione al completamento']);
    rows.add(['Flow Efficiency', '${flowEfficiency.toStringAsFixed(1)}%', 'Rapporto tra tempo attivo e tempo totale (target > 15%)']);
    rows.add([]);

    // ==========================================
    // 3. WIP ANALYSIS
    // ==========================================
    rows.add(['=== WIP (WORK IN PROGRESS) ===']);
    rows.add(['Status', 'Count', 'Descrizione']);
    
    final wipMap = <StoryStatus, int>{};
    for (final s in stories) {
      if (s.status == StoryStatus.backlog || s.status == StoryStatus.done) continue;
      wipMap[s.status] = (wipMap[s.status] ?? 0) + 1;
    }
    
    if (wipMap.isEmpty) {
      rows.add(['Nessun WIP', '0', 'Nessuna storia in lavorazione attiva']);
    } else {
      // Ordine logico degli status
      final statusOrder = [
        StoryStatus.refinement,
        StoryStatus.ready,
        StoryStatus.inSprint,
        StoryStatus.inProgress,
        StoryStatus.inReview,
      ];
      
      for (final status in statusOrder) {
        if (wipMap.containsKey(status)) {
           rows.add([status.displayName, wipMap[status], 'Storie attualmente in questo stato']);
        }
      }
    }
    rows.add([]);

    // ==========================================
    // 4. COMMITMENT TREND
    // ==========================================
    rows.add(['=== COMMITMENT TREND (SPRINT HISTORY) ===']);
    rows.add(['Sprint', 'Planned Points', 'Completed Points', 'Commitment Ratio', 'Stories Count']);
    
    // Assicuriamoci che siano ordinati
    completedSprints.sort((a, b) => a.number.compareTo(b.number));
    
    if (completedSprints.isEmpty) {
      rows.add(['Nessuno sprint completato', '-', '-', '-', '-']);
    } else {
      for (var sprint in completedSprints) {
        double ratio = 0;
        if (sprint.plannedPoints > 0) {
          ratio = (sprint.completedPoints / sprint.plannedPoints) * 100;
        }
        // Conta storie nello sprint
        final sprintStoriesCount = stories.where((s) => s.sprintId == sprint.id).length;

        rows.add([
          sprint.name,
          sprint.plannedPoints,
          sprint.completedPoints,
          '${ratio.toStringAsFixed(1)}%',
          sprintStoriesCount
        ]);
      }
    }

    return rows;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _downloadCsv(List<List<dynamic>> rows, String filename) async {
    String csvContent = const ListToCsvConverter().convert(rows);

    if (kIsWeb) {
      // Add UTF-8 BOM for Excel compatibility
      final bytes = utf8.encode('\uFEFF$csvContent');
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "$filename.csv")
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      print('CSV Export not implemented for Mobile');
      // Typically use path_provider and share_plus
    }
  }
}

