import 'package:flutter/material.dart';
import '../models/agile_project_model.dart';
import '../models/user_story_model.dart';
import '../models/sprint_model.dart';
import '../models/team_member_model.dart';
import '../models/retrospective_model.dart';
import '../models/agile_enums.dart';
import '../models/framework_features.dart';
import '../services/agile_firestore_service.dart';
import '../services/agile_audit_service.dart';
import '../services/agile_sheets_service.dart';
import '../services/auth_service.dart';
import '../widgets/agile/backlog_list_widget.dart';
import '../widgets/agile/story_form_dialog.dart';
import '../widgets/agile/story_detail_dialog.dart';
// story_estimation_dialog usato nel dettaglio story (futuro)
import '../widgets/agile/sprint_widgets.dart';
import '../widgets/agile/kanban_board_widget.dart';
import '../widgets/agile/team_list_widget.dart';
import '../widgets/agile/team_member_form_dialog.dart';
// ParticipantInviteDialog è AgileParticipantInviteDialog
import '../widgets/agile/participant_invite_dialog.dart' show AgileParticipantInviteDialog;
import '../widgets/agile/burndown_chart_widget.dart';
import '../widgets/agile/capacity_chart_widget.dart';
import '../widgets/agile/skill_matrix_widget.dart';
import '../widgets/agile/retrospective_widgets.dart';
import '../widgets/agile/metrics_dashboard_widget.dart';
import '../widgets/agile/audit_log_viewer.dart';
import '../widgets/agile/methodology_guide_dialog.dart';
import '../widgets/agile/setup_checklist_widget.dart';

/// Screen di dettaglio per un progetto Agile
///
/// Tabs:
/// 1. Backlog - Product backlog con user stories
/// 2. Sprint - Sprint planning e gestione
/// 3. Kanban - Board visuale
/// 4. Team - Gestione team e capacità
/// 5. Metrics - Dashboard metriche
/// 6. Retro - Retrospettive
class AgileProjectDetailScreen extends StatefulWidget {
  final AgileProjectModel project;
  final VoidCallback onBack;

  const AgileProjectDetailScreen({
    super.key,
    required this.project,
    required this.onBack,
  });

  @override
  State<AgileProjectDetailScreen> createState() => _AgileProjectDetailScreenState();
}

class _AgileProjectDetailScreenState extends State<AgileProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  final AgileFirestoreService _firestoreService = AgileFirestoreService();
  final AgileAuditService _auditService = AgileAuditService();
  final AgileSheetsService _sheetsService = AgileSheetsService();
  final AuthService _authService = AuthService();

  late TabController _tabController;
  late FrameworkFeatures _features;

  // Dati
  List<UserStoryModel> _stories = [];
  List<SprintModel> _sprints = [];
  List<TeamMemberModel> _teamMembers = [];
  final List<RetrospectiveModel> _retrospectives = [];

  String get _currentUserEmail => _authService.currentUser?.email ?? '';
  String get _currentUserName => _authService.currentUser?.displayName ?? 'Utente';

  @override
  void initState() {
    super.initState();
    _features = FrameworkFeatures(widget.project.framework);
    _tabController = TabController(length: _features.visibleTabCount, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Row(
          children: [
            Icon(widget.project.framework.icon, size: 24),
            const SizedBox(width: 8),
            Text(widget.project.name),
          ],
        ),
        actions: [
          // Guida metodologia
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Guida ${widget.project.framework.displayName}',
            onPressed: () => MethodologyGuideDialog.show(
              context,
              framework: widget.project.framework,
            ),
          ),
          // Export to Sheets
          IconButton(
            icon: const Icon(Icons.table_chart),
            tooltip: 'Esporta su Google Sheets',
            onPressed: _exportToSheets,
          ),
          // Audit log
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Audit Log',
            onPressed: () => AuditLogViewer.show(context, widget.project.id),
          ),
          // Settings
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'invite',
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Invita Membro'),
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Impostazioni'),
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'invite') {
                _showInviteDialog();
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _features.visibleTabs.map((tab) => Tab(
            icon: Icon(tab.icon),
            text: tab.displayName,
          )).toList(),
        ),
      ),
      body: StreamBuilder<List<UserStoryModel>>(
        stream: _firestoreService.streamProjectStories(widget.project.id),
        builder: (context, storiesSnapshot) {
          if (storiesSnapshot.hasData) {
            _stories = storiesSnapshot.data!;
          }

          return StreamBuilder<List<SprintModel>>(
            stream: _firestoreService.streamProjectSprints(widget.project.id),
            builder: (context, sprintsSnapshot) {
              if (sprintsSnapshot.hasData) {
                _sprints = sprintsSnapshot.data!;
              }

              // Team members sono nei participants del progetto
              _teamMembers = widget.project.participants.values.toList();

              return TabBarView(
                controller: _tabController,
                children: _features.visibleTabs.map((tab) => _buildTabContent(tab)).toList(),
              );
            },
          );
        },
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB CONTENT BUILDER
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildTabContent(AgileTab tab) {
    switch (tab) {
      case AgileTab.backlog:
        return _buildBacklogTab();
      case AgileTab.sprint:
        return _buildSprintTab();
      case AgileTab.kanban:
        return _buildKanbanTab();
      case AgileTab.team:
        return _buildTeamTab();
      case AgileTab.metrics:
        return _buildMetricsTab();
      case AgileTab.retro:
        return _buildRetroTab();
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 1: BACKLOG
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildBacklogTab() {
    final isSetupComplete = _isProjectSetupComplete();
    final hasActiveSprint = _sprints.any((s) => s.status == SprintStatus.active);
    final hasWipLimits = widget.project.kanbanColumns.any((c) => c.wipLimit != null);

    return Column(
      children: [
        // Setup checklist per progetti nuovi
        if (!isSetupComplete) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: SetupChecklistWidget(
              project: widget.project,
              stories: _stories,
              sprints: _sprints,
              onAddTeamMember: _showInviteDialog,
              onAddStory: _showCreateStoryDialog,
              onStartSprint: _features.showSprintTab ? _showCreateSprintDialog : null,
              onConfigureWip: _features.hasWipLimits ? () => _tabController.animateTo(
                _features.visibleTabs.indexOf(AgileTab.kanban),
              ) : null,
            ),
          ),
        ] else ...[
          // Suggerimento prossimo passo per progetti attivi
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: NextStepWidget(
              framework: widget.project.framework,
              project: widget.project,
              stories: _stories,
              sprints: _sprints,
              onAction: () {
                // Azione contestuale
              },
            ),
          ),
        ],

        // Tips framework-specific
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FrameworkTipsWidget(
            framework: widget.project.framework,
            storiesCount: _stories.length,
            completedStoriesCount: _stories.where((s) => s.status == StoryStatus.done).length,
            hasActiveSprint: hasActiveSprint,
            hasWipLimits: hasWipLimits,
          ),
        ),

        // Backlog list
        Expanded(
          child: BacklogListWidget(
            stories: _stories,
            projectId: widget.project.id,
            onStoryTap: (story) => _showStoryDetail(story),
            onReorder: (newOrder) => _reorderStories(newOrder),
            onAddStory: _showCreateStoryDialog,
            canEdit: widget.project.canManage(_currentUserEmail),
          ),
        ),
      ],
    );
  }

  /// Verifica se il setup del progetto è completato
  bool _isProjectSetupComplete() {
    // Criteri base: almeno 3 stories e team > 1
    if (_stories.length < 3) return false;
    if (widget.project.participantCount <= 1) return false;

    // Per Scrum/Hybrid: almeno uno sprint
    if (_features.showSprintTab && _sprints.isEmpty) return false;

    // Per Kanban/Hybrid: WIP limits configurati
    if (_features.hasWipLimits) {
      final hasWip = widget.project.kanbanColumns.any((c) => c.wipLimit != null);
      if (!hasWip) return false;
    }

    // Se tutte le condizioni sono soddisfatte
    return true;
  }

  Future<void> _showCreateStoryDialog() async {
    final result = await StoryFormDialog.show(
      context: context,
      projectId: widget.project.id,
      teamMembers: _teamMembers.map((m) => m.email).toList(),
    );

    if (result != null && mounted) {
      try {
        final story = await _firestoreService.createStory(
          projectId: widget.project.id,
          title: result.title,
          description: result.description,
          createdBy: _currentUserEmail,
          priority: result.priority,
          businessValue: result.businessValue,
          tags: result.tags,
          acceptanceCriteria: result.acceptanceCriteria,
        );
        await _auditService.logCreate(
          projectId: widget.project.id,
          entityType: AuditEntityType.story,
          entityId: story.id,
          entityName: story.title,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
        );
        _showSuccess('Story "${story.title}" creata!');
      } catch (e) {
        _showError('Errore creazione story: $e');
      }
    }
  }

  Future<void> _showStoryDetail(UserStoryModel story) async {
    await StoryDetailDialog.show(
      context: context,
      story: story,
      onEdit: widget.project.canManage(_currentUserEmail)
          ? () => _showEditStoryDialog(story)
          : null,
      onStatusChange: (status) => _updateStoryStatus(story, status),
    );
  }

  Future<void> _showEditStoryDialog(UserStoryModel story) async {
    final result = await StoryFormDialog.show(
      context: context,
      projectId: widget.project.id,
      story: story,
      teamMembers: _teamMembers.map((m) => m.email).toList(),
    );

    if (result != null && mounted) {
      try {
        await _firestoreService.updateStory(widget.project.id, result);
        _showSuccess('Story aggiornata!');
      } catch (e) {
        _showError('Errore aggiornamento: $e');
      }
    }
  }

  Future<void> _updateStoryStatus(UserStoryModel story, StoryStatus status) async {
    try {
      final updated = story.copyWith(
        status: status,
        startedAt: status == StoryStatus.inProgress && story.startedAt == null
            ? DateTime.now()
            : story.startedAt,
        completedAt: status == StoryStatus.done ? DateTime.now() : story.completedAt,
      );
      await _firestoreService.updateStory(widget.project.id, updated);
    } catch (e) {
      _showError('Errore aggiornamento status: $e');
    }
  }

  Future<void> _reorderStories(List<String> newOrder) async {
    // Aggiorna l'ordine delle stories su Firestore
    try {
      await _firestoreService.updateStoriesOrder(widget.project.id, newOrder);
    } catch (e) {
      _showError('Errore riordino backlog: $e');
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 2: SPRINT
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildSprintTab() {
    final activeSprint = _sprints.where((s) => s.status == SprintStatus.active).firstOrNull;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick methodology info per nuovi utenti
          if (_sprints.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MethodologyQuickInfo(
                framework: widget.project.framework,
                onLearnMore: () => MethodologyGuideDialog.show(
                  context,
                  framework: widget.project.framework,
                ),
              ),
            ),

          // Sprint attivo
          if (activeSprint != null) ...[
            _buildActiveSprintCard(activeSprint),
            const SizedBox(height: 24),
            // Burndown chart
            BurndownChartWidget(
              sprint: activeSprint,
              burndownData: activeSprint.burndownData,
            ),
            const SizedBox(height: 24),
          ],

          // Lista sprint
          SprintListWidget(
            sprints: _sprints,
            onSprintTap: (sprint) => _showSprintDetail(sprint),
            onAddSprint: _showCreateSprintDialog,
            canEdit: widget.project.canManage(_currentUserEmail),
          ),

          const SizedBox(height: 24),

          // Velocity chart
          if (_sprints.where((s) => s.velocity != null).isNotEmpty)
            VelocityChartWidget(
              velocityData: _sprints
                  .where((s) => s.velocity != null)
                  .map((s) => SprintVelocityData.fromSprint(s))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildActiveSprintCard(SprintModel sprint) {
    final daysRemaining = sprint.daysRemaining;
    final progress = sprint.plannedPoints > 0
        ? sprint.completedPoints / sprint.plannedPoints
        : 0.0;

    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flag, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  sprint.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'ATTIVO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (sprint.goal.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Goal: ${sprint.goal}',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSprintStat('Giorni', '$daysRemaining', 'rimasti'),
                _buildSprintStat('Completati', '${sprint.completedPoints}', 'pts'),
                _buildSprintStat('Pianificati', '${sprint.plannedPoints}', 'pts'),
                _buildSprintStat('Progresso', '${(progress * 100).round()}', '%'),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSprintStat(String label, String value, String unit) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  double _calculateAverageVelocity() {
    final completed = _sprints.where((s) => s.velocity != null).toList();
    if (completed.isEmpty) return 0;
    return completed.fold<double>(0, (sum, s) => sum + s.velocity!) / completed.length;
  }

  Future<void> _showCreateSprintDialog() async {
    final avgVelocity = _calculateAverageVelocity();
    final teamCapacity = <String, int>{
      for (final member in _teamMembers)
        member.email: member.capacityHoursPerDay * widget.project.sprintDurationDays
    };

    final result = await SprintFormDialog.show(
      context: context,
      projectId: widget.project.id,
      suggestedDuration: widget.project.sprintDurationDays,
      averageVelocity: avgVelocity > 0 ? avgVelocity : null,
      teamCapacity: teamCapacity,
    );

    if (result != null && mounted) {
      try {
        final sprint = await _firestoreService.createSprint(
          projectId: widget.project.id,
          name: result.name,
          goal: result.goal,
          startDate: result.startDate,
          endDate: result.endDate,
          createdBy: _currentUserEmail,
          storyIds: result.storyIds,
          plannedPoints: result.plannedPoints,
          teamCapacity: result.teamCapacity,
        );
        _showSuccess('Sprint "${sprint.name}" creato!');
      } catch (e) {
        _showError('Errore creazione sprint: $e');
      }
    }
  }

  Future<void> _showSprintDetail(SprintModel sprint) async {
    final sprintStories = _stories.where((s) => sprint.storyIds.contains(s.id)).toList();
    final completedStories = sprintStories.where((s) => s.status == StoryStatus.done).toList();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              sprint.status == SprintStatus.active ? Icons.flag : Icons.flag_outlined,
              color: sprint.status == SprintStatus.active ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(sprint.name)),
            _buildSprintStatusBadge(sprint.status),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Goal
                if (sprint.goal.isNotEmpty) ...[
                  Text(
                    'Sprint Goal',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(sprint.goal),
                  const SizedBox(height: 16),
                ],

                // Date
                Row(
                  children: [
                    Expanded(
                      child: _buildSprintInfoTile(
                        'Inizio',
                        '${sprint.startDate.day}/${sprint.startDate.month}/${sprint.startDate.year}',
                        Icons.calendar_today,
                      ),
                    ),
                    Expanded(
                      child: _buildSprintInfoTile(
                        'Fine',
                        '${sprint.endDate.day}/${sprint.endDate.month}/${sprint.endDate.year}',
                        Icons.event,
                      ),
                    ),
                    Expanded(
                      child: _buildSprintInfoTile(
                        'Durata',
                        '${sprint.endDate.difference(sprint.startDate).inDays} giorni',
                        Icons.timelapse,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Progress
                Row(
                  children: [
                    Expanded(
                      child: _buildSprintInfoTile(
                        'Story Points',
                        '${sprint.completedPoints}/${sprint.plannedPoints}',
                        Icons.stars,
                      ),
                    ),
                    Expanded(
                      child: _buildSprintInfoTile(
                        'Stories',
                        '${completedStories.length}/${sprintStories.length}',
                        Icons.list_alt,
                      ),
                    ),
                    if (sprint.velocity != null)
                      Expanded(
                        child: _buildSprintInfoTile(
                          'Velocity',
                          sprint.velocity!.toStringAsFixed(1),
                          Icons.speed,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Stories list
                Text(
                  'Stories nello Sprint',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                if (sprintStories.isEmpty)
                  Text('Nessuna story assegnata', style: TextStyle(color: Colors.grey[500]))
                else
                  ...sprintStories.map((story) => ListTile(
                    dense: true,
                    leading: Icon(
                      story.status == StoryStatus.done ? Icons.check_circle : Icons.circle_outlined,
                      color: story.status == StoryStatus.done ? Colors.green : Colors.grey,
                      size: 20,
                    ),
                    title: Text(
                      story.title,
                      style: TextStyle(
                        decoration: story.status == StoryStatus.done
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: story.storyPoints != null
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${story.storyPoints} pts',
                              style: TextStyle(fontSize: 12, color: Colors.blue[700]),
                            ),
                          )
                        : null,
                  )),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Chiudi'),
          ),
          if (sprint.status == SprintStatus.active && widget.project.canManage(_currentUserEmail))
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _completeSprintConfirm(sprint);
              },
              icon: const Icon(Icons.check),
              label: const Text('Completa Sprint'),
            ),
        ],
      ),
    );
  }

  Widget _buildSprintStatusBadge(SprintStatus status) {
    Color color;
    String label;
    switch (status) {
      case SprintStatus.planning:
        color = Colors.orange;
        label = 'Planning';
        break;
      case SprintStatus.active:
        color = Colors.green;
        label = 'Attivo';
        break;
      case SprintStatus.review:
        color = Colors.blue;
        label = 'Review';
        break;
      case SprintStatus.completed:
        color = Colors.grey;
        label = 'Completato';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSprintInfoTile(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }

  Future<void> _completeSprintConfirm(SprintModel sprint) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Completa Sprint'),
        content: Text('Sei sicuro di voler completare "${sprint.name}"?\n\n'
            'Le stories non completate verranno riportate nel backlog.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Completa'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        // Calcola velocity = completedPoints / durata in settimane
        final durationWeeks = sprint.endDate.difference(sprint.startDate).inDays / 7;
        final velocity = durationWeeks > 0
            ? sprint.completedPoints / durationWeeks
            : sprint.completedPoints.toDouble();

        await _firestoreService.completeSprint(
          widget.project.id,
          sprint.id,
          completedPoints: sprint.completedPoints,
          velocity: velocity,
        );
        _showSuccess('Sprint completato!');
      } catch (e) {
        _showError('Errore completamento sprint: $e');
      }
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 3: KANBAN
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildKanbanTab() {
    return KanbanBoardWidget(
      stories: _stories,
      columns: widget.project.effectiveKanbanColumns,
      framework: widget.project.framework,
      onStatusChange: (storyId, newStatus) => _updateStoryStatusById(storyId, newStatus),
      onStoryTap: (story) => _showStoryDetail(story),
      onWipLimitChange: _features.hasWipLimits ? _updateWipLimit : null,
      canEdit: widget.project.canManage(_currentUserEmail),
      showWipConfig: _features.hasWipLimits && widget.project.canManage(_currentUserEmail),
    );
  }

  Future<void> _updateWipLimit(String columnId, int? newLimit) async {
    try {
      // Aggiorna la colonna con il nuovo WIP limit
      final updatedColumns = widget.project.effectiveKanbanColumns.map((col) {
        if (col.id == columnId) {
          return col.copyWith(wipLimit: newLimit, clearWipLimit: newLimit == null);
        }
        return col;
      }).toList();

      // Salva su Firestore
      await _firestoreService.updateProjectFields(
        widget.project.id,
        {'kanbanColumns': updatedColumns.map((c) => c.toFirestore()).toList()},
      );

      _showSuccess('WIP limit aggiornato');
    } catch (e) {
      _showError('Errore aggiornamento WIP: $e');
    }
  }

  Future<void> _updateStoryStatusById(String storyId, StoryStatus status) async {
    final story = _stories.firstWhere((s) => s.id == storyId);
    await _updateStoryStatus(story, status);
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 4: TEAM
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildTeamTab() {
    final assignedHours = _calculateAssignedHours();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team list
          TeamListWidget(
            participants: widget.project.participants,
            currentUserEmail: _currentUserEmail,
            isOwnerOrAdmin: widget.project.canManage(_currentUserEmail),
            onEdit: (member) => _showMemberDetail(member),
            onInvite: widget.project.canManage(_currentUserEmail)
                ? _showInviteDialog
                : null,
          ),
          const SizedBox(height: 24),

          // Capacity chart
          CapacityChartWidget(
            teamMembers: _teamMembers,
            currentSprint: _sprints.where((s) => s.status == SprintStatus.active).firstOrNull,
            assignedHours: assignedHours,
          ),
          const SizedBox(height: 24),

          // Skill matrix
          SkillMatrixWidget(
            teamMembers: _teamMembers,
            onSkillTap: (member, skill) {
              // Mostra info sulla skill del membro
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${member.name}: $skill'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Dettagli',
                    onPressed: () => _showMemberDetail(member),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Map<String, int> _calculateAssignedHours() {
    final hours = <String, int>{};
    for (final story in _stories.where((s) =>
        s.status != StoryStatus.done && s.assigneeEmail != null)) {
      final email = story.assigneeEmail!;
      hours[email] = (hours[email] ?? 0) + (story.storyPoints ?? 0) * 8; // Assume 8h per punto
    }
    return hours;
  }

  Future<void> _showMemberDetail(TeamMemberModel member) async {
    final updated = await TeamMemberFormDialog.show(
      context: context,
      member: member,
    );
    if (updated != null && mounted) {
      try {
        await _firestoreService.updateParticipant(widget.project.id, updated);
        _showSuccess('Membro aggiornato!');
      } catch (e) {
        _showError('Errore aggiornamento: $e');
      }
    }
  }

  Future<void> _showInviteDialog() async {
    await AgileParticipantInviteDialog.show(
      context: context,
      projectId: widget.project.id,
      projectName: widget.project.name,
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 5: METRICS
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildMetricsTab() {
    final assignedHours = _calculateAssignedHours();

    return MetricsDashboardWidget(
      sprints: _sprints,
      stories: _stories,
      teamAssignedHours: assignedHours,
      framework: widget.project.framework,
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 6: RETROSPECTIVE
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildRetroTab() {
    final lastCompletedSprint = _sprints
        .where((s) => s.status == SprintStatus.completed)
        .toList()
      ..sort((a, b) => b.endDate.compareTo(a.endDate));

    final latestSprint = lastCompletedSprint.isNotEmpty ? lastCompletedSprint.first : null;

    // Per ora mostra un placeholder - i dati retrospective andrebbero caricati
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Lista retro esistenti
          RetroListWidget(
            retrospectives: _retrospectives,
            onTap: (retro) => _showRetroDetail(retro),
            onCreateNew: latestSprint != null ? () => _createNewRetro(latestSprint) : null,
          ),
          const SizedBox(height: 24),

          // Board ultima retro o nuova
          if (_retrospectives.isNotEmpty)
            RetroBoardWidget(
              retrospective: _retrospectives.last,
              sprint: latestSprint,
              currentUserEmail: _currentUserEmail,
              onAddItem: (item, category) {
                // Implementa aggiunta item
              },
              onSentimentVote: (sentiment) {
                // Implementa voto sentiment
              },
            )
          else
            _buildEmptyRetroState(),
        ],
      ),
    );
  }

  Widget _buildEmptyRetroState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'Nessuna retrospettiva',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Completa uno sprint per creare la prima retrospettiva',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showRetroDetail(RetrospectiveModel retro) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.psychology, color: Colors.purple),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Retrospettiva'),
                  Text(
                    'Creata il ${retro.createdAt.day}/${retro.createdAt.month}/${retro.createdAt.year}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 600,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sentiment medio
                if (retro.averageSentiment != null) ...[
                  Card(
                    color: _getSentimentColor(retro.averageSentiment!).withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            _getSentimentIcon(retro.averageSentiment!),
                            color: _getSentimentColor(retro.averageSentiment!),
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Sentiment del Team', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                '${retro.averageSentiment!.toStringAsFixed(1)}/5 - ${_getSentimentLabel(retro.averageSentiment!)}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // What went well
                _buildRetroSection(
                  'Cosa è andato bene',
                  retro.wentWell,
                  Icons.thumb_up,
                  Colors.green,
                ),
                const SizedBox(height: 16),

                // What to improve
                _buildRetroSection(
                  'Cosa migliorare',
                  retro.toImprove,
                  Icons.thumb_down,
                  Colors.orange,
                ),
                const SizedBox(height: 16),

                // Action items
                _buildActionItemsSection(retro.actionItems),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );
  }

  Widget _buildRetroSection(String title, List<RetroItem> items, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 8),
        if (items.isEmpty)
          Text('Nessun elemento', style: TextStyle(color: Colors.grey[500], fontStyle: FontStyle.italic))
        else
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle, size: 8, color: color.withValues(alpha: 0.5)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.content),
                      if (item.votes > 0)
                        Text(
                          '+${item.votes} voti',
                          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )),
      ],
    );
  }

  Widget _buildActionItemsSection(List<ActionItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.assignment_turned_in, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            const Text('Action Items', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 8),
        if (items.isEmpty)
          Text('Nessun action item', style: TextStyle(color: Colors.grey[500], fontStyle: FontStyle.italic))
        else
          ...items.map((item) => Card(
            child: ListTile(
              dense: true,
              leading: Checkbox(
                value: item.isCompleted,
                onChanged: null, // Read-only in detail view
              ),
              title: Text(
                item.description,
                style: TextStyle(
                  decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: item.assigneeEmail != null
                  ? Text('Assegnato a: ${item.assigneeEmail}')
                  : null,
            ),
          )),
      ],
    );
  }

  Color _getSentimentColor(double sentiment) {
    if (sentiment >= 4) return Colors.green;
    if (sentiment >= 3) return Colors.amber;
    return Colors.red;
  }

  IconData _getSentimentIcon(double sentiment) {
    if (sentiment >= 4) return Icons.sentiment_very_satisfied;
    if (sentiment >= 3) return Icons.sentiment_neutral;
    return Icons.sentiment_dissatisfied;
  }

  String _getSentimentLabel(double sentiment) {
    if (sentiment >= 4.5) return 'Eccellente';
    if (sentiment >= 4) return 'Buono';
    if (sentiment >= 3) return 'Nella norma';
    if (sentiment >= 2) return 'Da migliorare';
    return 'Critico';
  }

  Future<void> _createNewRetro(SprintModel sprint) async {
    // Dialog per creare una nuova retrospettiva
    final wentWell = <String>[];
    final toImprove = <String>[];
    final actionItems = <String>[];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.psychology, color: Colors.purple),
              const SizedBox(width: 8),
              Expanded(child: Text('Retrospettiva - ${sprint.name}')),
            ],
          ),
          content: SizedBox(
            width: 600,
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // What went well
                  _buildRetroInput(
                    'Cosa è andato bene?',
                    'Aggiungi un punto positivo...',
                    Icons.thumb_up,
                    Colors.green,
                    wentWell,
                    (value) => setState(() => wentWell.add(value)),
                    (index) => setState(() => wentWell.removeAt(index)),
                  ),
                  const SizedBox(height: 24),

                  // What to improve
                  _buildRetroInput(
                    'Cosa migliorare?',
                    'Aggiungi un punto da migliorare...',
                    Icons.thumb_down,
                    Colors.orange,
                    toImprove,
                    (value) => setState(() => toImprove.add(value)),
                    (index) => setState(() => toImprove.removeAt(index)),
                  ),
                  const SizedBox(height: 24),

                  // Action items
                  _buildRetroInput(
                    'Action Items',
                    'Aggiungi un action item...',
                    Icons.assignment_turned_in,
                    Colors.blue,
                    actionItems,
                    (value) => setState(() => actionItems.add(value)),
                    (index) => setState(() => actionItems.removeAt(index)),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Annulla'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.save),
              label: const Text('Salva Retrospettiva'),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && mounted) {
      try {
        // Crea la retrospettiva vuota
        var retro = await _firestoreService.createRetrospective(
          projectId: widget.project.id,
          sprintId: sprint.id,
          sprintName: sprint.name,
          sprintNumber: _sprints.indexOf(sprint) + 1,
          createdBy: _currentUserEmail,
        );

        // Aggiungi gli items
        for (final content in wentWell) {
          retro = retro.withWentWellItem(RetroItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: content,
            authorEmail: _currentUserEmail,
            authorName: _currentUserName,
            createdAt: DateTime.now(),
          ));
        }

        for (final content in toImprove) {
          retro = retro.withToImproveItem(RetroItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: content,
            authorEmail: _currentUserEmail,
            authorName: _currentUserName,
            createdAt: DateTime.now(),
          ));
        }

        for (final description in actionItems) {
          retro = retro.withActionItem(ActionItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            description: description,
            createdAt: DateTime.now(),
          ));
        }

        // Salva gli aggiornamenti
        await _firestoreService.updateRetrospective(widget.project.id, retro);

        _showSuccess('Retrospettiva creata!');
      } catch (e) {
        _showError('Errore creazione retrospettiva: $e');
      }
    }
  }

  Widget _buildRetroInput(
    String title,
    String hint,
    IconData icon,
    Color color,
    List<String> items,
    ValueChanged<String> onAdd,
    ValueChanged<int> onRemove,
  ) {
    final controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hint,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    onAdd(value.trim());
                    controller.clear();
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.add_circle, color: color),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  onAdd(controller.text.trim());
                  controller.clear();
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...items.asMap().entries.map((entry) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Icon(Icons.circle, size: 8, color: color.withValues(alpha: 0.5)),
              const SizedBox(width: 8),
              Expanded(child: Text(entry.value)),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 18),
                onPressed: () => onRemove(entry.key),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        )),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // FAB
  // ══════════════════════════════════════════════════════════════════════════

  Widget? _buildFAB() {
    // FAB diverso in base alla tab
    switch (_tabController.index) {
      case 0: // Backlog
        return FloatingActionButton.extended(
          onPressed: _showCreateStoryDialog,
          icon: const Icon(Icons.add),
          label: const Text('Nuova Story'),
        );
      case 1: // Sprint
        return FloatingActionButton.extended(
          onPressed: _showCreateSprintDialog,
          icon: const Icon(Icons.add),
          label: const Text('Nuovo Sprint'),
        );
      case 3: // Team
        return FloatingActionButton.extended(
          onPressed: _showInviteDialog,
          icon: const Icon(Icons.person_add),
          label: const Text('Invita'),
        );
      default:
        return null;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // EXPORT
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _exportToSheets() async {
    _showSuccess('Esportazione in corso...');

    final url = await _sheetsService.exportProjectToSheets(
      project: widget.project,
      stories: _stories,
      sprints: _sprints,
      teamMembers: _teamMembers,
      retrospectives: _retrospectives,
    );

    if (url != null && mounted) {
      _showSuccess('Export completato! Apri: $url');
    } else if (mounted) {
      _showError('Errore durante l\'export');
    }
  }
}
