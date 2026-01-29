import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import '../models/agile_project_model.dart';
import '../models/user_story_model.dart';
import '../models/sprint_model.dart';
import '../models/team_member_model.dart';
import '../models/retrospective_model.dart';
import '../models/agile_enums.dart';
import '../models/framework_features.dart';
import 'package:agile_tools/models/team_member_model.dart';
import 'package:agile_tools/screens/retrospective_board_screen.dart';
import 'package:agile_tools/services/agile_firestore_service.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import '../services/agile_audit_service.dart';
import '../services/agile_sheets_service.dart';
import '../services/auth_service.dart';
import '../widgets/agile/backlog_list_widget.dart';
import '../widgets/agile/story_form_dialog.dart';
import '../widgets/agile/story_detail_dialog.dart';
import '../widgets/agile/story_estimation_dialog.dart';
import '../widgets/retrospective/retro_list_widget.dart';
import '../widgets/retrospective/retro_board_widget.dart';
import '../widgets/agile/sprint_widgets.dart';
import '../widgets/agile/kanban_board_widget.dart';
import '../widgets/agile/team_list_widget.dart';
import '../widgets/agile/team_member_form_dialog.dart';
// ParticipantInviteDialog è AgileParticipantInviteDialog
import '../widgets/agile/participant_invite_dialog.dart' show AgileParticipantInviteDialog;
import '../widgets/agile/burndown_chart_widget.dart';
import '../widgets/agile/capacity_chart_widget.dart';
import '../widgets/agile/team_capacity_widget.dart';
import '../widgets/agile/skill_matrix_widget.dart';

import '../widgets/agile/metrics_dashboard_widget.dart';
import '../widgets/agile/sprint_health_card_widget.dart';
import '../widgets/agile/sprint_burndown_live_widget.dart';
import '../widgets/agile/team_workload_widget.dart';
import '../widgets/agile/audit_log_viewer.dart';
import '../widgets/agile/methodology_guide_dialog.dart';
import '../widgets/agile/setup_checklist_widget.dart';
import '../widgets/agile/sprint_review_history_widget.dart';

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
  final RetrospectiveFirestoreService _retroService = RetrospectiveFirestoreService();
  final AgileAuditService _auditService = AgileAuditService();
  final AgileSheetsService _sheetsService = AgileSheetsService();
  final AuthService _authService = AuthService();
  bool _filterByActiveSprint = true;
  SwimlaneType _currentSwimlaneType = SwimlaneType.none;

  late TabController _tabController;
  late FrameworkFeatures _features;

  // Dati
  List<UserStoryModel> _stories = [];
  List<SprintModel> _sprints = [];
  List<TeamMemberModel> _teamMembers = [];
  final List<RetrospectiveModel> _retrospectives = [];

  String get _currentUserEmail => _authService.currentUser?.email?.trim().toLowerCase() ?? '';
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
    final l10n = AppLocalizations.of(context)!;
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
            tooltip: l10n.actionGuide(widget.project.framework.displayName),
            onPressed: () => MethodologyGuideDialog.show(
              context,
              framework: widget.project.framework,
            ),
          ),
          // Export to Sheets
          IconButton(
            icon: const Icon(Icons.table_chart),
            tooltip: l10n.actionExportSheets,
            onPressed: _exportToSheets,
          ),
          // Audit log
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: l10n.actionAuditLog,
            onPressed: () => AuditLogViewer.show(context, widget.project.id),
          ),
          // Settings
          // SCRUM PERMISSIONS: Menu mostra solo opzioni per cui l'utente ha permesso
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              // Solo PO/SM possono invitare membri
              if (widget.project.canInviteMembers(_currentUserEmail))
                PopupMenuItem(
                  value: 'invite',
                  child: ListTile(
                    leading: const Icon(Icons.person_add),
                    title: Text(l10n.actionInviteMember),
                  ),
                ),
              PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(l10n.actionSettings),
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'invite') {
                _showInviteDialog();
              } else if (value == 'settings') {
                _showProjectSettingsDialog();
              }
            },
          ),
          const SizedBox(width: 8),
          // Home button - sempre ultimo a destra
          IconButton(
            icon: const Icon(Icons.home_rounded),
            tooltip: l10n.navHome,
            color: const Color(0xFF8B5CF6), // Viola come icona app
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
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
      body: StreamBuilder<AgileProjectModel?>(
        stream: _firestoreService.streamProject(widget.project.id),
        builder: (context, projectSnapshot) {
          final project = projectSnapshot.data ?? widget.project;

          return StreamBuilder<List<UserStoryModel>>(
            stream: _firestoreService.streamProjectStories(project.id),
            builder: (context, storiesSnapshot) {
              if (storiesSnapshot.hasData) {
                _stories = storiesSnapshot.data!;
              }

              return StreamBuilder<List<SprintModel>>(
                stream: _firestoreService.streamProjectSprints(project.id),
                builder: (context, sprintsSnapshot) {
                  if (sprintsSnapshot.hasData) {
                    _sprints = sprintsSnapshot.data!;
                  }

                  // Team members sono nei participants del progetto
                  _teamMembers = project.participants.values.toList();

                  return TabBarView(
                    controller: _tabController,
                    children: _features.visibleTabs.map((tab) => _buildTabContent(tab, project)).toList(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB CONTENT BUILDER
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildTabContent(AgileTab tab, AgileProjectModel project) {
    switch (tab) {
      case AgileTab.backlog:
        return _buildBacklogTab(project);
      case AgileTab.sprint:
        return _buildSprintTab(project);
      case AgileTab.kanban:
        return _buildKanbanTab(project);
      case AgileTab.team:
        return _buildTeamTab(project);
      case AgileTab.metrics:
        return _buildMetricsTab();
      case AgileTab.retro:
        return _buildRetroTab();
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 1: BACKLOG
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildBacklogTab(AgileProjectModel project) {
    final isSetupComplete = _isProjectSetupComplete(project);
    final hasActiveSprint = _sprints.any((s) => s.status == SprintStatus.active);
    final hasWipLimits = project.kanbanColumns.any((c) => c.wipLimit != null);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Setup checklist per progetti nuovi
                // SCRUM PERMISSIONS: I callback sono abilitati solo se l'utente ha il permesso appropriato
                if (!isSetupComplete) ...[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SetupChecklistWidget(
                      project: project,
                      stories: _stories,
                      sprints: _sprints,
                      onAddTeamMember: project.canInviteMembers(_currentUserEmail)
                          ? _showInviteDialog
                          : null,
                      onAddStory: project.canCreateStory(_currentUserEmail)
                          ? _showCreateStoryDialog
                          : null,
                      onStartSprint: _features.showSprintTab && project.canManageSprints(_currentUserEmail)
                          ? _showCreateSprintDialog
                          : null,
                      onConfigureWip: _features.hasWipLimits && project.canManageSprints(_currentUserEmail)
                          ? () => _tabController.animateTo(
                              _features.visibleTabs.indexOf(AgileTab.kanban),
                            )
                          : null,
                    ),
                  ),
                ] else ...[
                  // Suggerimento prossimo passo per progetti attivi
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: NextStepWidget(
                      framework: project.framework,
                      project: project,
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
                // SCRUM PERMISSIONS:
                // - canEdit: PO può creare/editare/eliminare/riordinare stories
                // - onStoryEstimate: Dev Team può stimare (controllato nel dialog)
                BacklogListWidget(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                    stories: _stories,
                    sprints: _sprints,
                    projectId: project.id,
                    onStoryTap: (story) => _showStoryDetail(story),
                    onReorder: project.canPrioritizeBacklog(_currentUserEmail)
                        ? (newOrder) => _reorderStories(newOrder)
                        : null,
                    onStoryEstimate: project.canEstimate(_currentUserEmail)
                        ? _showEstimateStoryDialog
                        : null,
                    onAddToSprint: _addToSprint,
                    onAddStory: project.canCreateStory(_currentUserEmail)
                        ? _showCreateStoryDialog
                        : null,
                    canEdit: project.canEditStory(_currentUserEmail),
                ),
        ],
      ),
    );
  }

  /// Verifica se il setup del progetto è completato
  bool _isProjectSetupComplete(AgileProjectModel project) {
    // Criteri base: almeno 3 stories e team > 1
    if (_stories.length < 3) return false;
    if (project.participantCount <= 1) return false;

    // Per Scrum/Hybrid: almeno uno sprint
    if (_features.showSprintTab && _sprints.isEmpty) return false;

    // Per Kanban/Hybrid: WIP limits configurati
    if (_features.hasWipLimits) {
      final hasWip = project.kanbanColumns.any((c) => c.wipLimit != null);
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
    // SCRUM PERMISSIONS:
    // - onEdit: Solo PO può modificare le stories
    // - onStatusChange: Dev Team può spostare le proprie stories (gestito nel widget)
    await StoryDetailDialog.show(
      context: context,
      story: story,
      onEdit: widget.project.canEditStory(_currentUserEmail)
          ? () => _showEditStoryDialog(story)
          : null,
      onStatusChange: (status) => _updateStoryStatus(story, status),
      onCriterionToggle: (index, completed) => _toggleAcceptanceCriterion(story, index, completed),
      onAssigneeChange: (email) => _updateStoryAssignee(story, email),
      teamMembers: _teamMembers.map((m) => m.email).toList(),
      sprints: _sprints,
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

  Future<void> _showEstimateStoryDialog(UserStoryModel story) async {
    final result = await StoryEstimationDialog.show(
      context: context,
      story: story,
      currentUserEmail: _currentUserEmail,
    );

    if (result != null && mounted) {
      try {
        // Aggiungi stima alla story
        final updatedEstimates = Map<String, StoryEstimate>.from(story.estimates);
        updatedEstimates[_currentUserEmail] = result;
        
        // Calcola stima finale se siamo in Planning Poker e tutti hanno votato
        // O semplicemente aggiorna la stima personale per ora
        // Se l'utente è scrum master/owner potrebbe finalizzare la stima
        // Per ora salviamo solo il voto e se è numerico aggiorniamo i punti (semplificazione)
        
        int? newPoints;
        if (int.tryParse(result.value) != null) {
          newPoints = int.parse(result.value);
        }

        final updated = story.copyWith(
          estimates: updatedEstimates,
          storyPoints: newPoints ?? story.storyPoints, // Aggiorna punti se è un numero
          isEstimated: true, // Marca come stimata
        );

        await _firestoreService.updateStory(widget.project.id, updated);
        
        // Audit log
        await _auditService.logEstimate(
          projectId: widget.project.id,
          entityId: story.id, // Usa ID interno
          entityName: story.title,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
          estimationType: 'Story Points',
          newEstimate: result.value,
        );
        
        _showSuccess('Stima registrata!');
      } catch (e) {
        _showError('Errore salvataggio stima: $e');
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

  Future<void> _toggleAcceptanceCriterion(UserStoryModel story, int index, bool completed) async {
    try {
      final criteria = List<String>.from(story.acceptanceCriteria);
      if (index < 0 || index >= criteria.length) return;

      final criterion = criteria[index];
      final cleanText = criterion.replaceAll(RegExp(r'^\[[xX]\]\s*|^✓\s*'), '');

      criteria[index] = completed ? '[x] $cleanText' : cleanText;

      final updated = story.copyWith(acceptanceCriteria: criteria);
      await _firestoreService.updateStory(widget.project.id, updated);
    } catch (e) {
      _showError('Errore aggiornamento criterio: $e');
    }
  }

  Future<void> _updateStoryAssignee(UserStoryModel story, String? email) async {
    try {
      final updated = story.copyWith(assigneeEmail: email ?? '');
      // If email is null, we need to clear the field in Firestore
      if (email == null) {
        await _firestoreService.updateStoryFields(widget.project.id, story.id, {
          'assigneeEmail': null,
        });
      } else {
        await _firestoreService.updateStory(widget.project.id, updated);
      }
      if (mounted) {
        Navigator.of(context).pop(); // Close the detail dialog to refresh
      }
    } catch (e) {
      _showError('Errore aggiornamento assegnatario: $e');
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

  Future<void> _startSprint(String sprintId) async {
    final sprint = _sprints.firstWhere((s) => s.id == sprintId);
    final stories = _stories.where((s) => s.status == StoryStatus.ready || s.status == StoryStatus.backlog).toList();
    
    // Mostra il wizard di pianificazione
    final selectedStoryIds = await SprintPlanningWizard.show(
      context: context,
      sprint: sprint,
      backlogStories: stories,
      averageVelocity: _calculateAverageVelocity(),
      totalCapacityHours: sprint.totalCapacityHours,
    );

    if (selectedStoryIds != null && mounted) {
      try {
        final now = DateTime.now();
        
        // Crea una copia aggiornata dello sprint
        final updatedSprint = sprint.copyWith(
          status: SprintStatus.active,
          storyIds: selectedStoryIds,
          startDate: now,
          endDate: now.add(Duration(days: sprint.durationDays)),
        );
        
        // Aggiorna lo sprint
        await _firestoreService.updateSprint(widget.project.id, updatedSprint);

        // Aggiorna le stories selezionate (spostale in sprint)
        for (final storyId in selectedStoryIds) {
           await _firestoreService.updateStoryStatus(
             widget.project.id, 
             storyId, 
             StoryStatus.inSprint, // Reset status to In Sprint (Todo) for new sprint
             sprintId: sprint.id
           );
        }
        
        // Log audit
        await _auditService.logSprintStart(
          projectId: widget.project.id,
          sprintId: sprint.id,
          sprintName: sprint.name,
          performedBy: _currentUserEmail,
          performedByName: _currentUserEmail.split('@')[0], // Nome semplificato
          storyCount: selectedStoryIds.length,
          plannedPoints: sprint.plannedPoints, // Potrebbe dover essere ricalcolato
        );

        _showSuccess('Sprint avviato con ${selectedStoryIds.length} stories');
      } catch (e) {
        _showError('Errore avvio sprint: $e');
      }
    }
  }

  Future<void> _completeSprint(String sprintId) async {
    final sprint = _sprints.firstWhere((s) => s.id == sprintId);
    await _completeSprintConfirm(sprint);
  }

  Future<void> _addToSprint(UserStoryModel story) async {
    // Trova sprint pianificati o attivi
    final availableSprints = _sprints.where((s) => 
      s.status == SprintStatus.planning || s.status == SprintStatus.active
    ).toList();

    if (availableSprints.isEmpty) {
      _showError('Nessuno sprint attivo o in planning disponibile');
      return;
    }

    // Mostra dialog scelta sprint
    final selectedSprint = await showDialog<SprintModel>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Aggiungi allo Sprint'),
        children: availableSprints.map((sprint) {
          final isActive = sprint.status == SprintStatus.active;
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, sprint),
            child: Row(
              children: [
                Icon(
                  isActive ? Icons.directions_run : Icons.date_range,
                  color: isActive ? Colors.green : Colors.blue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    sprint.name,
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                if (isActive)
                  const Chip(
                    label: Text('ATTIVO', style: TextStyle(fontSize: 10)),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.green,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selectedSprint != null && mounted) {
      if (selectedSprint.storyIds.contains(story.id)) {
        _showError('La storia è già in questo sprint');
        return;
      }

      try {
        final updatedStoryIds = List<String>.from(selectedSprint.storyIds)..add(story.id);
        
        // Aggiorna lo sprint con la nuova lista di storie
        final updatedSprint = selectedSprint.copyWith(
          storyIds: updatedStoryIds,
        );
        
        await _firestoreService.updateSprint(widget.project.id, updatedSprint);
        
        // Aggiorna anche la story per puntare allo sprint
        await _firestoreService.updateStoryStatus(
          widget.project.id, 
          story.id, 
          story.status, // Mantiene lo status attuale
          sprintId: selectedSprint.id,
        );
        
        // Log
        await _auditService.logMove(
          projectId: widget.project.id,
          entityId: story.id,
          entityName: story.title,
          performedBy: _currentUserEmail,
          performedByName: _currentUserEmail.split('@')[0],
          fromStatus: story.status.name,
          toStatus: story.status.name,
          toSprintId: selectedSprint.id,
        );

        _showSuccess('Aggiunta a ${selectedSprint.name}');
      } catch (e) {
        _showError('Errore aggiunta a sprint: $e');
      }
    }
  }

  Widget _buildSprintTab(AgileProjectModel project) {
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
                framework: project.framework,
                onLearnMore: () => MethodologyGuideDialog.show(
                  context,
                  framework: project.framework,
                ),
              ),
            ),

          // Sprint attivo
          if (activeSprint != null) ...[
            _buildActiveSprintCard(activeSprint, project),
            const SizedBox(height: 24),
            // Burndown chart
            BurndownChartWidget(
              sprint: activeSprint,
              burndownData: activeSprint.burndownData,
            ),
            const SizedBox(height: 24),
          ],

          // Lista sprint
          // SCRUM PERMISSIONS: Solo SM può gestire gli sprint
          SprintListWidget(
            sprints: _sprints,
            onSprintTap: (sprint) => _showSprintDetail(sprint),
            onAddSprint: project.canManageSprints(_currentUserEmail)
                ? _showCreateSprintDialog
                : null,
            onSprintStart: project.canManageSprints(_currentUserEmail)
                ? _startSprint
                : null,
            onSprintComplete: project.canManageSprints(_currentUserEmail)
                ? _completeSprint
                : null,
            canEdit: project.canManageSprints(_currentUserEmail),
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

          // Sprint Review History (mostra tutte le review passate)
          if (_sprints.any((s) => s.hasSprintReview)) ...[
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SprintReviewHistoryWidget(
                  sprints: _sprints,
                  onEdit: (sprint) => _showSprintReviewDialog(sprint),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActiveSprintCard(SprintModel sprint, AgileProjectModel project) {
    final l10n = AppLocalizations.of(context)!;
    
    // Calcola statistiche in tempo reale dalle storie caricate
    final sprintStories = _stories.where((s) => s.sprintId == sprint.id).toList();
    final completedPoints = sprintStories
        .where((s) => s.status == StoryStatus.done)
        .fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
    final plannedPoints = sprintStories
        .fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
    
    final daysRemaining = sprint.daysRemaining;
    final progress = plannedPoints > 0
        ? completedPoints / plannedPoints
        : 0.0;

    return Card(
      color: context.surfaceVariantColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.flag, color: AppColors.primary),
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
                '${l10n.agileSprintGoal}: ${sprint.goal}',
                style: TextStyle(color: context.textSecondaryColor),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSprintStat(l10n.agileDaysLabel, '$daysRemaining', l10n.agileStatRemaining),
                _buildSprintStat(l10n.agileStatsCompletedLabel, '$completedPoints', l10n.agileStatsPoints),
                _buildSprintStat(l10n.agileStatsPlannedLabel, '$plannedPoints', l10n.agileStatsPoints),
                _buildSprintStat(l10n.agileProgressLabel, '${(progress * 100).round()}', '%'),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: context.surfaceVariantColor,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                minHeight: 8,
              ),
            ),
            


            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                if (!sprint.hasSprintReview)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showSprintReviewDialog(sprint),
                      icon: const Icon(Icons.rate_review, size: 18),
                      label: Text(l10n.agileRecordReview),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        side: const BorderSide(color: Colors.orange),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showSprintReviewDialog(sprint),
                      icon: const Icon(Icons.check_circle, size: 18, color: Colors.green),
                      label: Text(l10n.agileSprintReviewCompleted),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _completeSprintConfirm(sprint),
                    icon: const Icon(Icons.flag_circle),
                    label: Text(l10n.agileCompleteSprintAction),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
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
                style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
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
    final l10n = AppLocalizations.of(context)!;
    final sprintStories = _stories.where((s) => sprint.storyIds.contains(s.id)).toList();
    final completedStories = sprintStories.where((s) => s.status == StoryStatus.done).toList();
    
    // Calcola punti reali per la visualizzazione
    final currentCompletedPoints = completedStories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
    final currentPlannedPoints = sprintStories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));

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
                    l10n.agileSprintGoal,
                    style: TextStyle(fontWeight: FontWeight.bold, color: context.textSecondaryColor),
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
                        l10n.agileStartDate,
                        '${sprint.startDate.day}/${sprint.startDate.month}/${sprint.startDate.year}',
                        Icons.calendar_today,
                      ),
                    ),
                    Expanded(
                      child: _buildSprintInfoTile(
                        l10n.agileEndDate,
                        '${sprint.endDate.day}/${sprint.endDate.month}/${sprint.endDate.year}',
                        Icons.event,
                      ),
                    ),
                    Expanded(
                      child: _buildSprintInfoTile(
                        l10n.agileDurationLabel,
                        '${sprint.endDate.difference(sprint.startDate).inDays} ${l10n.agileDaysLabel.toLowerCase()}',
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
                        l10n.agilePointsLabel,
                        '$currentCompletedPoints/$currentPlannedPoints',
                        Icons.stars,
                      ),
                    ),
                    Expanded(
                      child: _buildSprintInfoTile(
                        l10n.agileStoriesLabel,
                        '${completedStories.length}/${sprintStories.length}',
                        Icons.list_alt,
                      ),
                    ),
                    if (sprint.velocity != null)
                      Expanded(
                        child: _buildSprintInfoTile(
                          l10n.agileVelocityLabel,
                          sprint.velocity!.toStringAsFixed(1),
                          Icons.speed,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Stories list
                Text(
                  l10n.agileStoriesLabel,
                  style: TextStyle(fontWeight: FontWeight.bold, color: context.textSecondaryColor),
                ),
                const SizedBox(height: 8),
                if (sprintStories.isEmpty)
                  Text(l10n.stateEmpty, style: TextStyle(color: context.textTertiaryColor))
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
            child: Text(l10n.actionClose),
          ),
          // SCRUM PERMISSIONS: Solo SM può completare sprint
          if (sprint.status == SprintStatus.active && widget.project.canManageSprints(_currentUserEmail))
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _completeSprintConfirm(sprint);
              },
              icon: const Icon(Icons.check),
              label: Text(l10n.agileCompleteSprint),
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
    final l10n = AppLocalizations.of(context)!;
    // Calcola completedPoints REALI dalle stories Done in questo sprint
    final sprintStories = _stories.where((s) => s.sprintId == sprint.id).toList();
    final completedStories = sprintStories.where((s) => s.status == StoryStatus.done).toList();
    final actualCompletedPoints = completedStories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
    final totalStories = sprintStories.length;
    final completedCount = completedStories.length;
    final incompleteCount = totalStories - completedCount;
    final hasSprintReview = sprint.hasSprintReview;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.agileCompleteSprint),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.agileSprintCompleteConfirm(sprint.name)),
            const SizedBox(height: 16),
            // Warning Sprint Review (Scrum Guide 2020)
            if (!hasSprintReview)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.orange, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.agileMissingReview,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.agileReviewScrumGuide,
                            style: TextStyle(fontSize: 12, color: context.textTertiaryColor),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, false);
                              _showSprintReviewDialog(sprint);
                            },
                            icon: const Icon(Icons.rate_review, size: 16),
                            label: Text(l10n.agileRecordReview),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.orange,
                              side: const BorderSide(color: Colors.orange),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    Text('Sprint Review completata il ${_formatDate(sprint.sprintReview!.date)}',
                        style: const TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            // Riepilogo sprint
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📊 ${l10n.agileSprintSummary}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('• ${l10n.agileStoriesTotal}: $totalStories'),
                  Text('• ${l10n.agileStoriesCompleted}: $completedCount', style: const TextStyle(color: Colors.green)),
                  Text('• ${l10n.agilePointsCompletedLabel}: $actualCompletedPoints ${l10n.agileStatsPoints}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  if (incompleteCount > 0)
                    Text('• ${l10n.agileStoriesIncomplete}: $incompleteCount ${l10n.agileIncompleteReturnToBacklog}', style: const TextStyle(color: Colors.orange)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.agileCompleteSprint),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        // Calcola velocity = completedPoints / durata in settimane
        final durationWeeks = sprint.endDate.difference(sprint.startDate).inDays / 7;
        final velocity = durationWeeks > 0
            ? actualCompletedPoints / durationWeeks
            : actualCompletedPoints.toDouble();

        await _firestoreService.completeSprint(
          widget.project.id,
          sprint.id,
          completedPoints: actualCompletedPoints,
          velocity: velocity,
        );

        // Riporta stories incomplete nel backlog
        for (final story in sprintStories.where((s) => s.status != StoryStatus.done)) {
          final updated = story.copyWith(
            sprintId: null,
            status: StoryStatus.backlog,
          );
          await _firestoreService.updateStory(widget.project.id, updated);
        }

        _showSuccess(l10n.agileSprintCompleteSuccess(velocity.toStringAsFixed(1)));
      } catch (e) {
        _showError(l10n.errorGeneric(e.toString()));
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Dialog per condurre la Sprint Review (Scrum Guide 2020) - ENHANCED
  Future<void> _showSprintReviewDialog(SprintModel sprint) async {
    final l10n = AppLocalizations.of(context)!;
    final sprintStories = _stories.where((s) => s.sprintId == sprint.id).toList();
    final completedStories = sprintStories.where((s) => s.status == StoryStatus.done).toList();
    final incompleteStories = sprintStories.where((s) => s.status != StoryStatus.done).toList();
    final actualCompletedPoints = completedStories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));

    final demoNotesController = TextEditingController();
    final feedbackController = TextEditingController();
    final nextSprintFocusController = TextEditingController();
    final backlogUpdateController = TextEditingController();
    final backlogUpdates = <String>[];

    // NEW: Story outcomes (valutazione per-story)
    final storyOutcomes = <String, ReviewOutcomeType>{};
    for (final story in completedStories) {
      storyOutcomes[story.id] = ReviewOutcomeType.approved; // Default: approvata
    }
    for (final story in incompleteStories) {
      storyOutcomes[story.id] = ReviewOutcomeType.needsRefinement; // Default: da rifinire
    }

    // NEW: Attendees con ruoli
    final attendees = <ReviewAttendee>[];
    for (final member in _teamMembers) {
      attendees.add(ReviewAttendee(
        email: member.email,
        name: member.name,
        role: member.teamRole.name,
        isPresent: true,
      ));
    }

    // NEW: Decisioni formali
    final decisions = <ReviewDecision>[];
    final decisionController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.rate_review, color: Colors.blue),
              const SizedBox(width: 8),
              Expanded(child: Text('${l10n.agileRecordReview}: ${sprint.name}')),
            ],
          ),
          content: SizedBox(
            width: 600,
            height: 500,
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.blue,
                    tabs: [
                      Tab(text: l10n.agileStoryEvaluations),
                      Tab(text: l10n.agileFeedback),
                      Tab(text: l10n.agileDecisions),
                      Tab(text: l10n.agileAttendees),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // TAB 1: Story Evaluations
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.agileEvaluateStories,
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 12),
                              // Completed stories
                              if (completedStories.isNotEmpty) ...[
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('✅ ${l10n.agileStatsCompleted}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      ...completedStories.map((story) => _buildStoryEvaluationRow(
                                        story,
                                        storyOutcomes[story.id]!,
                                        (outcome) => setDialogState(() => storyOutcomes[story.id] = outcome),
                                      )),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                              // Incomplete stories
                              if (incompleteStories.isNotEmpty) ...[
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('⏳ ${l10n.agileStatsNotCompleted}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      ...incompleteStories.map((story) => _buildStoryEvaluationRow(
                                        story,
                                        storyOutcomes[story.id]!,
                                        (outcome) => setDialogState(() => storyOutcomes[story.id] = outcome),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        // TAB 2: Feedback & Notes
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                controller: demoNotesController,
                                decoration: InputDecoration(
                                  labelText: l10n.agileDemoNotes,
                                  hintText: l10n.agileReviewDemoHint,
                                  border: const OutlineInputBorder(),
                                ),
                                maxLines: 3,
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: feedbackController,
                                decoration: InputDecoration(
                                  labelText: l10n.agileFeedback,
                                  hintText: l10n.agileReviewFeedbackHint,
                                  border: const OutlineInputBorder(),
                                ),
                                maxLines: 3,
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: nextSprintFocusController,
                                decoration: InputDecoration(
                                  labelText: l10n.agileReviewNextFocus,
                                  hintText: l10n.agileReviewNextFocusHint,
                                  border: const OutlineInputBorder(),
                                ),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 12),
                              // Backlog updates
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: backlogUpdateController,
                                      decoration: InputDecoration(
                                        hintText: l10n.agileReviewBacklogHint,
                                        isDense: true,
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle, color: Colors.green),
                                    onPressed: () {
                                      if (backlogUpdateController.text.trim().isNotEmpty) {
                                        setDialogState(() {
                                          backlogUpdates.add(backlogUpdateController.text.trim());
                                          backlogUpdateController.clear();
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                              ...backlogUpdates.asMap().entries.map((e) => ListTile(
                                dense: true,
                                leading: const Icon(Icons.arrow_right, size: 16),
                                title: Text(e.value, style: const TextStyle(fontSize: 12)),
                                trailing: IconButton(
                                  icon: const Icon(Icons.close, size: 14, color: Colors.red),
                                  onPressed: () => setDialogState(() => backlogUpdates.removeAt(e.key)),
                                ),
                              )),
                            ],
                          ),
                        ),
                        // TAB 3: Decisions
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: decisionController,
                                      decoration: InputDecoration(
                                        hintText: l10n.agileAddDecision,
                                        isDense: true,
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      if (decisionController.text.trim().isNotEmpty) {
                                        setDialogState(() {
                                          decisions.add(ReviewDecision(
                                            description: decisionController.text.trim(),
                                            type: ReviewDecisionType.actionItem,
                                          ));
                                          decisionController.clear();
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.add, size: 16),
                                    label: Text(l10n.actionAdd),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ...decisions.asMap().entries.map((e) => Card(
                                child: ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Color(e.value.type.colorValue).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      e.value.type.displayName,
                                      style: TextStyle(fontSize: 10, color: Color(e.value.type.colorValue)),
                                    ),
                                  ),
                                  title: Text(e.value.description, style: const TextStyle(fontSize: 13)),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                    onPressed: () => setDialogState(() => decisions.removeAt(e.key)),
                                  ),
                                ),
                              )),
                              if (decisions.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Text(
                                    'Nessuna decisione aggiunta',
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // TAB 4: Attendees
                        SingleChildScrollView(
                          child: Column(
                            children: attendees.map((attendee) => CheckboxListTile(
                              value: attendee.isPresent,
                              onChanged: (value) {
                                setDialogState(() {
                                  final index = attendees.indexWhere((a) => a.email == attendee.email);
                                  attendees[index] = ReviewAttendee(
                                    email: attendee.email,
                                    name: attendee.name,
                                    role: attendee.role,
                                    isPresent: value ?? true,
                                  );
                                });
                              },
                              title: Text(attendee.name),
                              subtitle: Text('${attendee.roleIcon} ${attendee.roleDisplayName}'),
                              secondary: CircleAvatar(
                                child: Text(attendee.name.isNotEmpty ? attendee.name[0].toUpperCase() : '?'),
                              ),
                            )).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.actionCancel),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.check),
              label: Text(l10n.agileSaveReview),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final currentUser = widget.project.participants[_currentUserEmail];

        // Convert story outcomes to StoryReviewOutcome list
        final storyOutcomesList = storyOutcomes.entries.map((entry) {
          final story = sprintStories.firstWhere((s) => s.id == entry.key);
          return StoryReviewOutcome(
            storyId: entry.key,
            storyTitle: story.title,
            outcome: entry.value,
            storyPoints: story.storyPoints,
          );
        }).toList();

        final sprintReview = SprintReview(
          date: DateTime.now(),
          conductedBy: _currentUserEmail,
          conductedByName: currentUser?.name ?? _currentUserEmail.split('@').first,
          attendees: attendees.where((a) => a.isPresent).map((a) => a.email).toList(),
          attendeesWithRoles: attendees.where((a) => a.isPresent).toList(),
          demoNotes: demoNotesController.text,
          feedback: feedbackController.text,
          backlogUpdates: backlogUpdates,
          nextSprintFocus: nextSprintFocusController.text,
          storiesCompleted: completedStories.length,
          storiesNotCompleted: incompleteStories.length,
          pointsCompleted: actualCompletedPoints,
          decisions: decisions,
          storyOutcomes: storyOutcomesList,
        );

        final updatedSprint = sprint.copyWith(sprintReview: sprintReview);
        await _firestoreService.updateSprint(widget.project.id, updatedSprint);

        // Auto-move stories needing refinement back to backlog
        final storiesToMoveBack = storyOutcomesList
            .where((o) => o.outcome == ReviewOutcomeType.needsRefinement || o.outcome == ReviewOutcomeType.rejected)
            .map((o) => o.storyId)
            .toList();

        for (final storyId in storiesToMoveBack) {
          final story = _stories.firstWhere((s) => s.id == storyId);
          final updatedStory = story.copyWith(sprintId: null, status: StoryStatus.backlog);
          await _firestoreService.updateStory(widget.project.id, updatedStory);
        }

        if (storiesToMoveBack.isNotEmpty) {
          _showSuccess('${l10n.agileSprintReviewSaveSuccess} (${storiesToMoveBack.length} storie riportate al backlog)');
        } else {
          _showSuccess(l10n.agileSprintReviewSaveSuccess);
        }
      } catch (e) {
        _showError(l10n.errorGeneric(e.toString()));
      }
    }
  }

  /// Riga per valutare una singola story nella Sprint Review
  Widget _buildStoryEvaluationRow(
    UserStoryModel story,
    ReviewOutcomeType currentOutcome,
    ValueChanged<ReviewOutcomeType> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.title,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (story.storyPoints != null)
                  Text(
                    '${story.storyPoints} SP',
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
              ],
            ),
          ),
          SegmentedButton<ReviewOutcomeType>(
            segments: [
              ButtonSegment(
                value: ReviewOutcomeType.approved,
                label: const Text('✅', style: TextStyle(fontSize: 16)),
              ),
              ButtonSegment(
                value: ReviewOutcomeType.needsRefinement,
                label: const Text('🔄', style: TextStyle(fontSize: 16)),
              ),
              ButtonSegment(
                value: ReviewOutcomeType.rejected,
                label: const Text('❌', style: TextStyle(fontSize: 16)),
              ),
            ],
            selected: {currentOutcome},
            onSelectionChanged: (selected) => onChanged(selected.first),
            showSelectedIcon: false,
          ),
        ],
      ),
    );
  }


  // ══════════════════════════════════════════════════════════════════════════
  // TAB 3: KANBAN
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildKanbanTab(AgileProjectModel project) {
    final l10n = AppLocalizations.of(context)!;
    final activeSprint = _sprints.where((s) => s.status == SprintStatus.active).firstOrNull;
    var storiesToShow = _stories;

    if (_filterByActiveSprint && activeSprint != null) {
      // Robust filter: include stories in sprint.storyIds OR stories pointing to this sprint
      storiesToShow = _stories.where((s) =>
        activeSprint.storyIds.contains(s.id) || s.sprintId == activeSprint.id
      ).toList();
    }

    return Column(
      children: [
        // Kanban Header con filtro sprint
        // Mostra quando c'è sprint attivo O quando il filtro è disattivato (per poterlo riattivare)
        if (activeSprint != null || !_filterByActiveSprint)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF1E1E1E),
            child: Row(
              children: [
                const Icon(Icons.filter_list, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  activeSprint != null ? l10n.agileFilterActiveSprint : '${l10n.agileFilterActiveSprint.split(':').first}: ',
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
                Text(
                  activeSprint?.name ?? l10n.agileNoActiveSprint,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: activeSprint != null ? null : Colors.grey[500],
                  ),
                ),
                const Spacer(),
                Switch(
                  value: _filterByActiveSprint,
                  onChanged: (val) => setState(() => _filterByActiveSprint = val),
                  activeColor: Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                 _filterByActiveSprint ? l10n.agileFilterActive : l10n.agileFilterAll,
                 style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

        // Messaggio esplicativo quando non c'è uno sprint attivo
        if (activeSprint == null && _filterByActiveSprint)
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, size: 48, color: Colors.blue),
                const SizedBox(height: 12),
                Text(
                  l10n.agileNoActiveSprint,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.agileKanbanBoardHint,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[400]),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildKanbanInfoChip(Icons.play_arrow, l10n.agileStartSprintFromTab),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildKanbanInfoChip(Icons.visibility, l10n.agileDisableFilterHint),
                  ],
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => setState(() => _filterByActiveSprint = false),
                  icon: const Icon(Icons.visibility_off),
                  label: Text(l10n.agileShowAllStories),
                ),
              ],
            ),
          ),

        // SCRUM PERMISSIONS:
        // - canEdit: PO/SM possono spostare qualsiasi card, Dev Team solo le proprie
        // - showWipConfig: Solo SM può configurare WIP limits
        // - onPoliciesChange: SM/PO possono modificare le policy delle colonne (Kanban Practice #4)
        // - swimlanes: Raggruppamento visuale per Kanban/Hybrid
        Expanded(
          child: KanbanBoardWidget(
            stories: activeSprint == null && _filterByActiveSprint ? [] : storiesToShow,
            columns: project.effectiveKanbanColumns,
            framework: project.framework,
            onStatusChange: (storyId, newStatus) => _updateStoryStatusById(storyId, newStatus),
            onStoryTap: (story) => _showStoryDetail(story),
            onWipLimitChange: _features.hasWipLimits && project.canManageSprints(_currentUserEmail)
                ? _updateWipLimit
                : null,
            onPoliciesChange: project.canManageSprints(_currentUserEmail)
                ? _updateColumnPolicies
                : null,
            swimlaneType: _currentSwimlaneType,
            onSwimlaneChange: _features.hasWipLimits
                ? (type) => setState(() => _currentSwimlaneType = type)
                : null,
            canEdit: project.canMoveAnyStory(_currentUserEmail) ||
                     project.canMoveOwnStory(_currentUserEmail),
            showWipConfig: _features.hasWipLimits && project.canManageSprints(_currentUserEmail),
            showPolicies: _features.hasWipLimits, // Mostra policy solo per Kanban/Hybrid
            onAssigneeChange: (story, email) => _updateStoryAssignee(story, email),
            teamMembers: _teamMembers.map((m) => m.email).toList(),
            sprints: _sprints,
          ),
        ),
      ],
    );
  }

  Widget _buildKanbanInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey[300]),
          ),
        ],
      ),
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

  /// Aggiorna le policy esplicite di una colonna Kanban
  /// (Kanban Practice #4 - Make Policies Explicit)
  Future<void> _updateColumnPolicies(String columnId, List<String> policies) async {
    try {
      // Aggiorna la colonna con le nuove policy
      final updatedColumns = widget.project.effectiveKanbanColumns.map((col) {
        if (col.id == columnId) {
          return col.copyWith(policies: policies);
        }
        return col;
      }).toList();

      // Salva su Firestore
      await _firestoreService.updateProjectFields(
        widget.project.id,
        {'kanbanColumns': updatedColumns.map((c) => c.toFirestore()).toList()},
      );

      _showSuccess('Policy aggiornate');
    } catch (e) {
      _showError('Errore aggiornamento policy: $e');
    }
  }

  Future<void> _updateStoryStatusById(String storyId, StoryStatus status) async {
    final story = _stories.firstWhere((s) => s.id == storyId);
    await _updateStoryStatus(story, status);
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 4: TEAM
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildTeamTab(AgileProjectModel project) {
    final assignedHours = _calculateAssignedHours();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team list
          // SCRUM PERMISSIONS:
          // - isOwnerOrAdmin: Per visualizzazione capacità/skills (mantiene accesso base)
          // - onInvite: PO/SM possono invitare membri
          // - onEdit: Gestione ruoli riservata a PO
          TeamListWidget(
            participants: project.participants,
            currentUserEmail: _currentUserEmail,
            isOwnerOrAdmin: project.canManage(_currentUserEmail),
            onEdit: project.canChangeRoles(_currentUserEmail)
                ? (member) => _showMemberDetail(member)
                : null,
            onInvite: project.canInviteMembers(_currentUserEmail)
                ? _showInviteDialog
                : null,
          ),
          const SizedBox(height: 24),

          // Team Capacity - Doppia vista: Story Points (Scrum) / Ore
          TeamCapacityWidget(
            teamMembers: _teamMembers,
            sprints: _sprints,
            stories: _stories,
            currentSprint: _sprints.where((s) => s.status == SprintStatus.active).firstOrNull,
            assignedHours: assignedHours,
          ),
          const SizedBox(height: 24),

          // Team Workload - Distribuzione carico per persona
          TeamWorkloadWidget(
            teamMembers: _teamMembers,
            stories: _stories,
            currentSprint: _sprints.where((s) => s.status == SprintStatus.active).firstOrNull,
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

  /// Calcola le ore assegnate a ciascun membro del team
  /// Considera le stories nello sprint attivo (o in lavorazione se non c'è sprint)
  /// Usa actualHours se disponibile, altrimenti storyPoints × 8
  Map<String, int> _calculateAssignedHours() {
    final hours = <String, int>{};

    // Trova lo sprint attivo
    final activeSprint = _sprints.where((s) => s.status == SprintStatus.active).firstOrNull;

    // Filtra le stories
    final relevantStories = _stories.where((story) {
      // Deve avere un assegnatario
      if (story.assigneeEmail == null) return false;

      // Non contare le storie completate
      if (story.status == StoryStatus.done) return false;

      // Se c'è uno sprint attivo, considera solo le stories di quello sprint
      if (activeSprint != null) {
        return story.sprintId == activeSprint.id;
      }

      // Se non c'è sprint attivo, considera tutte le stories in lavorazione
      return story.status == StoryStatus.inProgress ||
             story.status == StoryStatus.inSprint ||
             story.status == StoryStatus.inReview;
    });

    for (final story in relevantStories) {
      final email = story.assigneeEmail!;

      // Usa actualHours se disponibile, altrimenti storyPoints × 8h
      int storyHours;
      if (story.actualHours != null && story.actualHours! > 0) {
        storyHours = story.actualHours!;
      } else if (story.storyPoints != null && story.storyPoints! > 0) {
        storyHours = story.storyPoints! * 8; // 8h per punto come fallback
      } else {
        storyHours = 8; // Default minimo per story senza stime
      }

      hours[email] = (hours[email] ?? 0) + storyHours;
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
    final activeSprint = _sprints.where((s) => s.status == SprintStatus.active).firstOrNull;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sprint Health Summary Card
          SprintHealthCardWidget(
            currentSprint: activeSprint,
            stories: _stories,
            sprints: _sprints,
          ),
          const SizedBox(height: 16),

          // Sprint Burndown (live from stories)
          SprintBurndownLiveWidget(
            currentSprint: activeSprint,
            stories: _stories,
          ),
          const SizedBox(height: 16),

          // Existing Metrics Dashboard
          MetricsDashboardWidget(
            sprints: _sprints,
            stories: _stories,
            teamAssignedHours: assignedHours,
            framework: widget.project.framework,
          ),
        ],
      ),
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

    // Per Kanban: le retro si chiamano "Operations Review" e non richiedono sprint
    final isKanban = widget.project.framework == AgileFramework.kanban;

    // Stream delle retrospettive
    return StreamBuilder<List<RetrospectiveModel>>(
      stream: _retroService.streamProjectRetrospectives(widget.project.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final retrospectives = snapshot.data ?? [];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Lista retro esistenti
              RetroListWidget(
                retrospectives: retrospectives,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onTap: (retro) => _showRetroDetail(retro),
                // Kanban: può sempre creare retro (Operations Review)
                // Scrum/Hybrid: richiede sprint completato
                onCreateNew: isKanban
                    ? _createKanbanRetro
                    : (latestSprint != null
                        ? () { _createNewRetro(latestSprint!); }
                        : () => _showNoSprintForRetroWarning()),
                currentUserEmail: _currentUserEmail,
                onDelete: _confirmDeleteRetro,
              ),
              const SizedBox(height: 24),

              // Board ultima retro o nuova (mostra ultima se esiste, altrimenti placeholder)
              if (retrospectives.isNotEmpty)
                RetroBoardWidget(
                  retro: retrospectives.first, // Mostra la più recente (ordinata per data)
                  currentUserEmail: _currentUserEmail,
                  currentUserName: _currentUserEmail.split('@').first,
                  isIncognito: false,
                )
              else
                _buildEmptyRetroState(),
            ],
          ),
        );
      },
    );
  }

  void _confirmDeleteRetro(RetrospectiveModel retro) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina Retrospettiva'),
        content: Text(
            'Sei sicuro di voler eliminare definitivamente la retrospettiva "${retro.sprintName}"?\n\nQuesta azione è irreversibile e cancellerà tutti i dati associati.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.pop(context); // Close dialog
              try {
                await _retroService.deleteRetrospective(retro.id);
                messenger.showSnackBar(const SnackBar(content: Text('Retrospettiva eliminata')));
              } catch (e) {
                messenger.showSnackBar(SnackBar(content: Text('Errore durante l\'eliminazione: $e')));
              }
            },
            child: const Text('Elimina', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyRetroState() {
    final isKanban = widget.project.framework == AgileFramework.kanban;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              isKanban ? 'Nessuna Operations Review' : 'Nessuna retrospettiva',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              isKanban
                  ? 'Crea una Operations Review per migliorare il flusso di lavoro'
                  : 'Completa uno sprint per creare la prima retrospettiva',
              style: TextStyle(color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
            if (isKanban) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _createKanbanRetro,
                icon: const Icon(Icons.add),
                label: const Text('Crea Operations Review'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _features.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
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
            if (!retro.isCompleted)
              IconButton(
                icon: const Icon(Icons.launch, color: Colors.blue),
                tooltip: 'Apri Board Interattiva',
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RetroBoardScreen(
                        retroId: retro.id,
                        currentUserEmail: 'user@example.com', // TODO: Get real user
                        currentUserName: 'User', // TODO: Get real user
                      ),
                    ),
                  );
                },
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
        final now = DateTime.now();
        
        // Costruisci le colonne default
        final columns = RetroTemplateExt(RetroTemplate.startStopContinue).defaultColumns;
        final col1Id = columns.isNotEmpty ? columns[0].id : 'col_1';
        final col2Id = columns.length > 1 ? columns[1].id : 'col_2';

        // Costruisci gli items
        final wentWellItems = wentWell.map((content) => RetroItem(
          id: '${now.millisecondsSinceEpoch}_${content.hashCode}',
          columnId: col1Id,
          content: content,
          authorEmail: _currentUserEmail,
          authorName: _currentUserName,
          createdAt: now,
        )).toList();

        final toImproveItems = toImprove.map((content) => RetroItem(
          id: '${now.millisecondsSinceEpoch}_${content.hashCode}',
          columnId: col2Id,
          content: content,
          authorEmail: _currentUserEmail,
          authorName: _currentUserName,
          createdAt: now,
        )).toList();

        final updatedActionItemsList = actionItems.map((description) => ActionItem(
          id: '${now.millisecondsSinceEpoch}_${description.hashCode}',
          description: description,
          ownerEmail: _currentUserEmail, // Needs owner now
          createdAt: now,
        )).toList();

        // Crea il modello completo
        final retro = RetrospectiveModel(
          id: '', // Verrà generato dal servizio
          projectId: widget.project.id,
          sprintId: sprint.id,
          sprintName: sprint.name,
          sprintNumber: _sprints.indexOf(sprint) + 1,
          createdAt: now,
          createdBy: _currentUserEmail,
          status: RetroStatus.draft,
          currentPhase: RetroPhase.icebreaker,
          columns: columns,
          items: [...wentWellItems, ...toImproveItems],
          actionItems: updatedActionItemsList,
          timer: RetroTimer(durationMinutes: 60),
        );

        // Salva usando il service corretto (Root Collection)
        await _retroService.createRetrospective(retro);

        _showSuccess('Retrospettiva creata!');
      } catch (e) {
        _showError('Errore creazione retrospettiva: $e');
      }
    }
  }

  /// Crea una Operations Review per Kanban (senza sprint)
  /// In Kanban, le retrospettive sono chiamate "Operations Review" o "Service Delivery Review"
  /// e fanno parte della practice "Feedback Loops" (David Anderson)
  Future<void> _createKanbanRetro() async {
    final wentWell = <String>[];
    final toImprove = <String>[];
    final actionItems = <String>[];

    // Calcola il numero della review basandosi sulle retro esistenti
    final existingRetros = await _retroService.streamProjectRetrospectives(widget.project.id).first;
    final reviewNumber = existingRetros.length + 1;

    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.psychology, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(child: Text('Operations Review #$reviewNumber')),
            ],
          ),
          content: SizedBox(
            width: 600,
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Descrizione Kanban-specific
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Le Operations Review fanno parte delle Feedback Loops di Kanban. '
                            'Analizza il flusso di lavoro e identifica miglioramenti.',
                            style: TextStyle(fontSize: 12, color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // What went well
                  _buildRetroInput(
                    'Cosa ha funzionato bene?',
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
                    'Cosa migliorare nel flusso?',
                    'Aggiungi un punto da migliorare...',
                    Icons.trending_up,
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
              label: const Text('Salva Operations Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final now = DateTime.now();

        // Costruisci le colonne default
        final columns = RetroTemplateExt(RetroTemplate.startStopContinue).defaultColumns;
        final col1Id = columns.isNotEmpty ? columns[0].id : 'col_1';
        final col2Id = columns.length > 1 ? columns[1].id : 'col_2';

        // Costruisci gli items
        final wentWellItems = wentWell.map((content) => RetroItem(
          id: '${now.millisecondsSinceEpoch}_${content.hashCode}',
          columnId: col1Id,
          content: content,
          authorEmail: _currentUserEmail,
          authorName: _currentUserName,
          createdAt: now,
        )).toList();

        final toImproveItems = toImprove.map((content) => RetroItem(
          id: '${now.millisecondsSinceEpoch}_${content.hashCode}',
          columnId: col2Id,
          content: content,
          authorEmail: _currentUserEmail,
          authorName: _currentUserName,
          createdAt: now,
        )).toList();

        final updatedActionItemsList = actionItems.map((description) => ActionItem(
          id: '${now.millisecondsSinceEpoch}_${description.hashCode}',
          description: description,
          ownerEmail: _currentUserEmail,
          createdAt: now,
        )).toList();

        // Crea il modello senza sprint (Kanban)
        final retro = RetrospectiveModel(
          id: '',
          projectId: widget.project.id,
          sprintId: null, // Kanban: no sprint
          sprintName: 'Operations Review #$reviewNumber',
          sprintNumber: reviewNumber,
          createdAt: now,
          createdBy: _currentUserEmail,
          status: RetroStatus.draft,
          currentPhase: RetroPhase.icebreaker,
          columns: columns,
          items: [...wentWellItems, ...toImproveItems],
          actionItems: updatedActionItemsList,
          timer: RetroTimer(durationMinutes: 60),
        );

        await _retroService.createRetrospective(retro);

        _showSuccess('Operations Review creata!');
      } catch (e) {
        _showError('Errore creazione Operations Review: $e');
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

  // ══════════════════════════════════════════════════════════════════════════
  // HELPER DIALOGS
  // ══════════════════════════════════════════════════════════════════════════

  /// Mostra un avviso quando si tenta di creare una retrospettiva senza sprint completati
  void _showNoSprintForRetroWarning() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange[700]),
            const SizedBox(width: 8),
            Expanded(child: Text(l10n.retroNoSprintWarningTitle)),
          ],
        ),
        content: Text(l10n.retroNoSprintWarningMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionClose),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // Naviga alla tab Sprint
              final sprintTabIndex = _features.visibleTabs.indexOf(AgileTab.sprint);
              if (sprintTabIndex >= 0) {
                _tabController.animateTo(sprintTabIndex);
              }
            },
            icon: const Icon(Icons.directions_run, size: 18),
            label: Text(l10n.agileGoToSprints),
          ),
        ],
      ),
    );
  }

  /// Mostra il dialog delle impostazioni del progetto
  void _showProjectSettingsDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.settings, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(child: Text('${l10n.actionSettings}: ${widget.project.name}')),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(widget.project.framework.icon),
                title: Text(l10n.agileFramework),
                subtitle: Text(widget.project.framework.displayName),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(l10n.agileSprintDuration),
                subtitle: Text('${widget.project.sprintDurationDays} giorni'),
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: Text(l10n.teamMembers),
                subtitle: Text('${_teamMembers.length} membri'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('ID Progetto'),
                subtitle: SelectableText(widget.project.id, style: const TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionClose),
          ),
        ],
      ),
    );
  }
}

