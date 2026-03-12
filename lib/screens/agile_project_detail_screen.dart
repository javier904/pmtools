import 'package:flutter/material.dart';
import '../services/user_profile_service.dart';
import 'package:flutter/services.dart';
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
import '../services/agile_csv_export_service.dart';
import '../services/auth_service.dart';
import '../widgets/agile/backlog_list_widget.dart';
import '../widgets/agile/story_form_dialog.dart';
import '../widgets/agile/story_detail_dialog.dart';
import '../widgets/agile/story_estimation_dialog.dart';
import '../widgets/retrospective/retro_list_widget.dart';
import '../widgets/retrospective/retro_board_widget.dart';
import '../widgets/retrospective/retro_tab_sections_widget.dart';
import '../widgets/retrospective/retro_summary_dialog.dart';
import '../widgets/agile/sprint_widgets.dart';
import '../widgets/agile/kanban_board_widget.dart';
import '../widgets/user_display_name_widget.dart';
import '../widgets/agile/contextual_help_button.dart';
import '../widgets/agile/agile_board_widget.dart';
import '../widgets/agile/team_list_widget.dart';
import '../widgets/agile/team_member_form_dialog.dart';
// ParticipantInviteDialog è AgileParticipantInviteDialog
// ParticipantInviteDialog è AgileParticipantInviteDialog
import '../widgets/agile/participant_invite_dialog.dart' show AgileParticipantInviteDialog;
import '../services/jira_service.dart';
import '../widgets/agile/transition_fallback_dialog.dart';
import '../widgets/agile/burndown_chart_widget.dart';
import '../widgets/agile/capacity_chart_widget.dart';
import '../widgets/agile/team_capacity_widget.dart';
import '../widgets/agile/skill_matrix_widget.dart';

import '../widgets/agile/metrics_dashboard_widget.dart';
import '../widgets/agile/sprint_health_card_widget.dart';
import '../widgets/agile/sprint_burndown_live_widget.dart';
import '../widgets/agile/team_workload_widget.dart';
import '../widgets/agile/commitment_trend_widget.dart';
import '../widgets/agile/flow_efficiency_widget.dart';
import '../widgets/agile/blocked_items_widget.dart';
import '../widgets/agile/sprint_scope_widget.dart';
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
  final int initialIndex;

  const AgileProjectDetailScreen({
    super.key,
    required this.project,
    required this.onBack,
    this.initialIndex = 0,
  });

  @override
  State<AgileProjectDetailScreen> createState() => _AgileProjectDetailScreenState();
}

class _AgileProjectDetailScreenState extends State<AgileProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  final AgileFirestoreService _firestoreService = AgileFirestoreService();
  final RetrospectiveFirestoreService _retroService = RetrospectiveFirestoreService();
  final AgileAuditService _auditService = AgileAuditService();
  final AgileCsvExportService _csvService = AgileCsvExportService();
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
  bool _isCreatingRetro = false;


  // Cached streams to avoid Firestore SDK assertion errors on rebuild
  late Stream<AgileProjectModel?> _projectStream;
  late Stream<List<UserStoryModel>> _storiesStream;
  late Stream<List<SprintModel>> _sprintsStream;
  late Stream<List<RetrospectiveModel>> _retrosStream;

  String get _currentUserEmail => _authService.currentUser?.email?.trim().toLowerCase() ?? '';
  String get _currentUserName => _authService.currentUser?.displayName ?? 'Utente';

  @override
  void initState() {
    super.initState();
    _features = FrameworkFeatures(widget.project.framework);
    _tabController = TabController(length: _features.visibleTabCount, vsync: this);
    _projectStream = _firestoreService.streamProject(widget.project.id);
    _storiesStream = _firestoreService.streamProjectStories(widget.project.id);
    _sprintsStream = _firestoreService.streamProjectSprints(widget.project.id);
    _retrosStream = _retroService.streamProjectRetrospectives(widget.project.id, _currentUserEmail);

    // Ripara silenziosamente dati storici mancanti
    _firestoreService.repairProjectSprints(widget.project.id);
    
    // Listen to tab changes to update FAB
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
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

    return StreamBuilder<AgileProjectModel?>(
      stream: _projectStream,
      builder: (context, projectSnapshot) {
        final project = projectSnapshot.data ?? widget.project;

        return StreamBuilder<List<UserStoryModel>>(
          stream: _storiesStream,
          builder: (context, storiesSnapshot) {
            _stories = storiesSnapshot.data ?? [];

            return StreamBuilder<List<SprintModel>>(
              stream: _sprintsStream,
              builder: (context, sprintsSnapshot) {
                _sprints = sprintsSnapshot.data ?? [];
                
                // Team members are in project participants
                _teamMembers = project.participants.values.toList();

                return Stack(
                  children: [
                    Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: widget.onBack,
                        ),
                        title: Row(
                          children: [
                            Icon(project.framework.icon, size: 24),
                            const SizedBox(width: 8),
                            Expanded(child: _buildAppBarTitle(project, l10n)),
                          ],
                        ),
                        actions: [
                          // Contextual help
                          AnimatedBuilder(
                            animation: _tabController,
                            builder: (context, child) {
                              final currentTab = _features.visibleTabs[_tabController.index];
                              return ContextualHelpButton(
                                currentTab: currentTab,
                                framework: project.framework,
                              );
                            },
                          ),
                          // Methodology Guide
                          IconButton(
                            icon: const Icon(Icons.menu_book),
                            tooltip: l10n.actionGuide(project.framework.displayName),
                            onPressed: () => MethodologyGuideDialog.show(
                              context,
                              framework: project.framework,
                            ),
                          ),
                          // Export
                          IconButton(
                            icon: const Icon(Icons.download),
                            tooltip: l10n.actionExportCsv,
                            onPressed: _showExportDialog,
                          ),
                          // Audit log
                          if (project.canViewAuditLog(_currentUserEmail))
                            IconButton(
                              icon: const Icon(Icons.history),
                              tooltip: l10n.actionAuditLog,
                              onPressed: () => AuditLogViewer.show(context, project.id),
                            ),
                          // Settings
                          PopupMenuButton<String>(
                            itemBuilder: (context) => [
                              if (project.canInviteMembers(_currentUserEmail))
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
                                _showInviteDialog(project);
                              } else if (value == 'settings') {
                                _showProjectSettingsDialog(project);
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          // Home button
                          IconButton(
                            icon: const Icon(Icons.home_rounded),
                            tooltip: l10n.navHome,
                            color: const Color(0xFF8B5CF6),
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
                      body: Column(
                        children: [
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: _features.visibleTabs.map((tab) => _buildTabContent(tab, project)).toList(),
                            ),
                          ),
                        ],
                      ),
                      floatingActionButton: _buildFab(project),
                    ),
                    if (_isCreatingRetro)
                      Container(
                        color: Colors.black.withValues(alpha: 0.5),
                        child: const Center(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16),
                                  Text('Preparazione retrospettiva...', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        );
      },
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
        return _buildMetricsTab(project);
      case AgileTab.retro:
        return _buildRetroTab(project);
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 1: BACKLOG
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildBacklogTab(AgileProjectModel project) {
    final isSetupComplete = _isProjectSetupComplete(project);
    final hasActiveSprint = _sprints.any((s) => s.status.isActiveOrReview);
    final hasWipLimits = project.kanbanColumns.any((c) => c.wipLimit != null);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Setup checklist per progetti nuovi
                // SCRUM PERMISSIONS: I callback sono abilitati solo se l'utente ha il permesso appropriato
                  // Setup checklist (always visible, handles its own state)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SetupChecklistWidget(
                      project: project,
                      stories: _stories,
                      sprints: _sprints,
                      isSetupComplete: isSetupComplete,
                      onAddTeamMember: project.canInviteMembers(_currentUserEmail)
                          ? () => _showInviteDialog(project)
                          : null,
                      onAddStory: project.canCreateStory(_currentUserEmail)
                          ? () => _showCreateStoryDialog(project)
                          : null,
                      onStartSprint: _features.showSprintTab && project.canManageSprints(_currentUserEmail)
                          ? (isSetupComplete ? () => _tabController.animateTo(_features.visibleTabs.indexOf(AgileTab.sprint)) : () => _showCreateSprintDialog(project))
                          : null,
                      onConfigureWip: _features.hasWipLimits && project.canManageSprints(_currentUserEmail)
                          ? () => _tabController.animateTo(
                              _features.visibleTabs.indexOf(AgileTab.kanban),
                            )
                          : null,
                    ),
                  ),

                  // Suggerimento prossimo passo per progetti attivi (se setup completato)
                  if (isSetupComplete)
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: FrameworkTipsWidget(
                      framework: widget.project.framework,
                      storiesCount: _stories.length,
                      completedStoriesCount: _stories.where((s) => s.status == StoryStatus.done).length,
                      hasActiveSprint: hasActiveSprint,
                      hasAnySprint: _sprints.isNotEmpty,
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
                    onStoryTap: (story) => _showStoryDetail(project, story, isBoardContext: false),
                    onReorder: project.canPrioritizeBacklog(_currentUserEmail)
                        ? (newOrder) => _reorderStories(project, newOrder)
                        : null,
                    onStoryEstimate: project.canEstimate(_currentUserEmail)
                        ? (story) => _showEstimateStoryDialog(project, story)
                        : null,
                    onStoryDelete: project.canDeleteStory(_currentUserEmail)
                        ? (storyId) => _deleteStory(project, storyId)
                        : null,
                    onStatusChange: (id, status) {
                      final story = _stories.firstWhere((s) => s.id == id);
                      _updateStoryStatus(project, story, status);
                    },
                    onPriorityChange: project.canEditStory(_currentUserEmail)
                        ? (id, priority) => _updateStoryPriority(project, id, priority)
                        : null,
                    onTitleChange: project.canEditStory(_currentUserEmail)
                        ? (id, title) => _updateStoryTitle(project, id, title)
                        : null,
                    onStoryPointsChange: project.canEditStory(_currentUserEmail)
                        ? (id, points) => _updateStoryPoints(project, _stories.firstWhere((s) => s.id == id), points)
                        : null,
                    onAssigneeChange: project.canEditStory(_currentUserEmail)
                        ? (id, email) {
                            final story = _stories.firstWhere((s) => s.id == id);
                            _updateStoryAssignee(project, story, email);
                          }
                        : null,
                    teamMembers: _teamMembers.map((m) => m.email).toList(),
                    onAddToSprint: project.canAddToSprint(_currentUserEmail) 
                        ? (story) => _addToSprint(project, story) 
                        : null,
                    onAddStory: project.canCreateStory(_currentUserEmail)
                        ? () => _showCreateStoryDialog(project)
                        : null,
                    canEdit: project.canEditStory(_currentUserEmail),
                    framework: project.framework,
                    canMoveToBacklog: project.canMoveToBacklog(_currentUserEmail),
                    canMarkAsReady: project.canMarkAsReady(_currentUserEmail),
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

  Future<void> _showCreateStoryDialog(AgileProjectModel project) async {
    // Current project from stream is needed here if we want to be fully reactive,
    // but for creation, the framework/id from widget.project is usually enough.
    // However, to be consistent, let's use the local 'project' if we can.
    // Since _showCreateStoryDialog is usually called from a FAB that has access to 'project',
    // we should update its signature.
    
    // For now, let's see where it's called.
    final result = await StoryFormDialog.show(
      context: context,
      projectId: project.id,
      teamMembers: _teamMembers.map((m) => m.email).toList(),
      sprints: _sprints,
      framework: project.framework,
      canAddToSprint: project.canAddToSprint(_currentUserEmail),
      canMoveToBacklog: project.canMoveToBacklog(_currentUserEmail),
      canMarkAsReady: project.canMarkAsReady(_currentUserEmail),
    );

    if (result != null && mounted) {
      try {
        var status = result.status;
        // Se è stato selezionato uno sprint attivo e la storia è in backlog/ready, promuovila a In Sprint
        if (result.sprintId != null) {
          final selectedSprint = _sprints.firstWhere((s) => s.id == result.sprintId);
          if (selectedSprint.status == SprintStatus.active) {
             if (status == StoryStatus.backlog || status == StoryStatus.refinement || status == StoryStatus.ready) {
               status = StoryStatus.inSprint;
             }
          }
        }

        final story = await _firestoreService.createStory(
          projectId: project.id,
          title: result.title,
          description: result.description,
          createdBy: _currentUserEmail,
          priority: result.priority,
          businessValue: result.businessValue,
          tags: result.tags,
          acceptanceCriteria: result.acceptanceCriteria,
          sprintId: result.sprintId,
          storyPoints: result.storyPoints,
          status: status,
        );
        
        // Se assegnata a uno sprint, aggiorna anche lo sprint
        // FIX: Use withStory helper to update BOTH storyIds AND plannedPoints
        if (story.sprintId != null) {
           final sprint = _sprints.firstWhere((s) => s.id == story.sprintId);
           if (!sprint.storyIds.contains(story.id)) {
              final updatedSprint = sprint.withStory(story.id, story.storyPoints ?? 0);
              await _firestoreService.updateSprint(project.id, updatedSprint);
           }
        }

        await _auditService.logCreate(
          projectId: project.id,
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

   Future<void> _showStoryDetail(AgileProjectModel project, UserStoryModel story, {bool isBoardContext = false}) async {
    // SCRUM PERMISSIONS:
    // - onEdit: Solo PO può modificare le stories
    // - onStatusChange: Dev Team può spostare le proprie stories (gestito nel widget)
    await StoryDetailDialog.show(
      context: context,
      story: story,
      onEdit: project.canEditStory(_currentUserEmail)
          ? () => _showEditStoryDialog(project, story, isBoardContext: isBoardContext)
          : null,
      onDelete: project.canDeleteStory(_currentUserEmail)
          ? () => _deleteStory(project, story.id)
          : null,
      onStatusChange: (status) => _updateStoryStatus(project, story, status),
      onCriterionToggle: (index, completed) => _toggleAcceptanceCriterion(project, story, index, completed),
      onCriterionAdd: (text) => _addStoryAcceptanceCriterion(project, story, text),
      onCriterionDelete: (index) => _deleteStoryAcceptanceCriterion(project, story, index),
      onAssigneeChange: (email) => _updateStoryAssignee(project, story, email),
      onProgressChange: (progress) => _updateStoryProgress(project, story, progress),
      teamMembers: _teamMembers.map((m) => m.email).toList(),
      sprints: _sprints,
      onJiraSync: (story.externalIntegration?.provider == 'jira') 
          ? () => _syncStoryFromJira(project, story)
          : null,
      framework: project.framework,
      canMoveToBacklog: project.canMoveToBacklog(_currentUserEmail),
      isBoardContext: isBoardContext,
    );
  }

  Future<void> _showEditStoryDialog(AgileProjectModel project, UserStoryModel story, {bool? isBoardContext}) async {
    final result = await StoryFormDialog.show(
      context: context,
      projectId: project.id,
      story: story,
      teamMembers: _teamMembers.map((m) => m.email).toList(),
      sprints: _sprints,
      framework: project.framework,
      canAddToSprint: project.canAddToSprint(_currentUserEmail),
      canMoveToBacklog: project.canMoveToBacklog(_currentUserEmail),
      canMarkAsReady: project.canMarkAsReady(_currentUserEmail),
      isBoardContext: isBoardContext,
    );

    if (result != null && mounted) {
      try {
        await _firestoreService.updateStory(project.id, result);
        
        // Gestione cambio sprint in edit
        if (story.sprintId != result.sprintId) {
           // Rimuovi dal vecchio sprint
           if (story.sprintId != null) {
              final oldSprint = _sprints.firstWhere((s) => s.id == story.sprintId);
              // Use helper to update points too
              final updatedSprint = oldSprint.withoutStory(story.id, story.storyPoints ?? 0);
              await _firestoreService.updateSprint(project.id, updatedSprint);
           }
           // Aggiungi al nuovo sprint
           if (result.sprintId != null) {
              final newSprint = _sprints.firstWhere((s) => s.id == result.sprintId);
              final updatedSprint = newSprint.withStory(result.id, result.storyPoints ?? 0);
              await _firestoreService.updateSprint(project.id, updatedSprint);
           }
        } else if (story.sprintId != null && story.storyPoints != result.storyPoints) {
           // Same sprint, but points changed
           final sprint = _sprints.firstWhere((s) => s.id == story.sprintId);
           final diff = (result.storyPoints ?? 0) - (story.storyPoints ?? 0);
           
           // Update plannedPoints ONLY if in planning. 
           // If active, it stays as original baseline (delta will show the change).
           final updatedSprint = sprint.copyWith(
             plannedPoints: sprint.isPlanning 
                ? (sprint.plannedPoints + diff).clamp(0, 9999) 
                : sprint.plannedPoints,
           );
           await _firestoreService.updateSprint(project.id, updatedSprint);
        }

        _showSuccess('Story aggiornata!');
      } catch (e) {
        _showError('Errore aggiornamento: $e');
      }
    }
  }

  Future<void> _showEstimateStoryDialog(AgileProjectModel project, UserStoryModel story) async {
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

        await _firestoreService.updateStory(project.id, updated);
        
        // Audit log
        await _auditService.logEstimate(
          projectId: project.id,
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

  Future<void> _addToSprint(AgileProjectModel project, UserStoryModel story) async {
    // Solo chi ha i permessi può aggiungere storie agli sprint
    if (!project.canAddToSprint(_currentUserEmail)) {
      _showError('Permesso negato: Solo PO/SM possono gestire gli sprint');
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    // Mostra un dialog per selezionare lo sprint
    final selectedSprint = await showDialog<SprintModel>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.selectSprint),
        children: _sprints.map((sprint) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, sprint),
            child: Text('${sprint.name} (${sprint.status.name})'),
          );
        }).toList(),
      ),
    );

    if (selectedSprint != null) {
      try {
        // Aggiorna la story con il nuovo sprintId
        final updatedStory = story.copyWith(sprintId: selectedSprint.id);
        await _firestoreService.updateStory(project.id, updatedStory);

        // Aggiorna lo sprint aggiungendo la story
        final updatedSprint = selectedSprint.withStory(story.id, story.storyPoints ?? 0);
        await _firestoreService.updateSprint(project.id, updatedSprint);

        _showSuccess('Story "${story.title}" aggiunta a sprint "${selectedSprint.name}"');

        // Audit log
        await _auditService.logUpdate(
          projectId: project.id,
          entityType: AuditEntityType.story,
          entityId: story.id,
          entityName: story.title,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
          previousValue: {'sprintId': story.sprintId},
          newValue: {'sprintId': selectedSprint.id},
          description: 'Story added to sprint ${selectedSprint.name}',
          changedFields: ['sprintId'],
        );
      } catch (e) {
        _showError('Errore aggiunta story a sprint: $e');
      }
    }
  }

  Future<void> _deleteStory(AgileProjectModel project, String storyId) async {
    // 1. Check permissions
    if (!project.canDeleteStory(_currentUserEmail)) {
      _showError('Permesso negato: Solo PO/SM possono eliminare storie');
      return;
    }

    // 2. Confirm
    final l10n = AppLocalizations.of(context)!;
    UserStoryModel story;
    try {
      story = _stories.firstWhere((s) => s.id == storyId);
    } catch (_) {
      return; // Story not found
    }
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteStoryTitle),
        content: Text(l10n.deleteStoryConfirm(story.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _firestoreService.deleteStory(project.id, storyId);
        _showSuccess(l10n.storyDeleted);
        
        // Audit log
        await _auditService.logDelete(
          projectId: project.id,
          entityType: AuditEntityType.story,
          entityId: storyId,
          entityName: story.title,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
        );
      } catch (e) {
        _showError('${l10n.errorDeletingSession}: $e');
      }
    }
  }

  Future<void> _updateStoryStatus(AgileProjectModel project, UserStoryModel story, StoryStatus status) async {
    // Check permissions for moving to Backlog
    if (status == StoryStatus.backlog && !project.canMoveToBacklog(_currentUserEmail)) {
      _showError('Permesso negato: Solo PO/SM possono spostare nel Backlog');
      return;
    }

    try {
      // Logic for auto-assigning to active sprint if moving to In Progress/etc from Backlog
      // and not yet in a sprint.
      String? newSprintId = story.sprintId;
      
      // FIX: If moving to Backlog/Refinement/Ready, remove from Sprint
      // FIX: Only remove from sprint if moving to deep backlog/refinement.
      // 'Ready' stories can be part of a sprint (Scrum: 'Sprint Backlog' column).
      if (status == StoryStatus.backlog || 
          status == StoryStatus.refinement) {
        newSprintId = null;
      }

      bool addedToSprint = false;
      SprintModel? activeSprint;
      
      if (newSprintId == null && 
          (status == StoryStatus.inSprint || 
           status == StoryStatus.inProgress || 
           status == StoryStatus.inReview)) {
            
         // Check for active sprint
         try {
           activeSprint = _sprints.firstWhere((s) => s.status == SprintStatus.active);
           newSprintId = activeSprint.id;
           addedToSprint = true;
         } catch (_) {
           // No active sprint found, ignore
         }
      }



  // 3. Update story status using specialized service method (Stopwatch logic)
    await _firestoreService.updateStoryStatus(
      project.id, 
      story.id, 
      status, 
      sprintId: newSprintId,
    );
    
    // For local logic below, we still need an 'updated' object representing the new state
    final updated = story.copyWith(
      status: status,
      sprintId: newSprintId,
    );
      
      // Handle Sprint updates (add/remove)
      
      // 1. Remove from OLD sprint if sprintId changed (e.g. moved to Backlog)
      //    OR if status changed to something that might imply removal (though usually sprintId change covers this)
      if (story.sprintId != null && story.sprintId != newSprintId) {
         try {
           final oldSprint = _sprints.firstWhere((s) => s.id == story.sprintId);
           final updatedSprint = oldSprint.withoutStory(story.id, story.storyPoints ?? 0);
           await _firestoreService.updateSprint(project.id, updatedSprint);
         } catch (_) {}
      }

      // Self-healing: Check if active sprint metrics are out of sync and fix them
      if (activeSprint != null) {
         _reconcileActiveSprintMetrics(project, activeSprint);
      } else if (newSprintId != null) {
          // If we moved to a sprint that isn't the "active" one variable, try to find it
          try {
            final targetSprint = _sprints.firstWhere((s) => s.id == newSprintId);
            _reconcileActiveSprintMetrics(project, targetSprint);
          } catch (_) {}
      }

      // 2. Add to NEW sprint if it changed (e.g. auto-assigned)
      if (newSprintId != null && newSprintId != story.sprintId) {
         try {
            final targetSprint = (addedToSprint && activeSprint != null) 
                ? activeSprint 
                : _sprints.firstWhere((s) => s.id == newSprintId);
            
            final updatedSprint = targetSprint.withStory(updated.id, updated.storyPoints ?? 0);
            await _firestoreService.updateSprint(project.id, updatedSprint);
            
            if (addedToSprint) {
               _showSuccess('Story automatically added to active sprint: ${targetSprint.name}');
            }
         } catch (_) {}
      } else if (addedToSprint && activeSprint != null) {
         // Fallback if sprintId didn't change but we want to ensure it's added (defensive)
         final updatedSprint = activeSprint.withStory(updated.id, updated.storyPoints ?? 0);
         await _firestoreService.updateSprint(project.id, updatedSprint);
      }

      // JIRA SYNC
      if (story.externalIntegration != null && story.externalIntegration!.provider == 'jira') {
        _syncJiraTransition(story, status);
      }
      
      // Audit log
      await _auditService.logMove(
        projectId: project.id,
        entityId: story.id,
        entityName: story.title,
        performedBy: _currentUserEmail,
        performedByName: _currentUserName,
        fromStatus: story.status.name,
        toStatus: status.name,
        fromSprintId: story.sprintId,
        toSprintId: newSprintId,
      );
    } catch (e) {
      _showError('Errore aggiornamento status: $e');
    }
  }

  Future<void> _updateStoryPriority(AgileProjectModel project, String storyId, StoryPriority priority) async {
    try {
      final story = _stories.firstWhere((s) => s.id == storyId);
      final updated = story.copyWith(priority: priority);
      await _firestoreService.updateStory(project.id, updated);
      
      await _auditService.logUpdate(
        projectId: project.id,
        entityType: AuditEntityType.story,
        entityId: storyId,
        entityName: story.title,
        performedBy: _currentUserEmail,
        performedByName: _currentUserName,
        previousValue: {'priority': story.priority.name},
        newValue: {'priority': priority.name},
        description: 'Priority changed to ${priority.name}',
        changedFields: ['priority'],
      );
    } catch (e) {
      _showError('Errore aggiornamento priorità: $e');
    }
  }

  Future<void> _updateStoryTitle(AgileProjectModel project, String storyId, String title) async {
    try {
      final story = _stories.firstWhere((s) => s.id == storyId);
      final updated = story.copyWith(title: title);
      await _firestoreService.updateStory(project.id, updated);
      
      await _auditService.logUpdate(
        projectId: project.id,
        entityType: AuditEntityType.story,
        entityId: storyId,
        entityName: story.title, // Use old title for reference
        performedBy: _currentUserEmail,
        performedByName: _currentUserName,
        previousValue: {'title': story.title},
        newValue: {'title': title},
        description: 'Title changed',
        changedFields: ['title'],
      );
      
      // Audit log (opzionale ma utile per modifiche importanti come il titolo)
      // _auditService.logUpdate(...)
    } catch (e) {
      _showError('Errore aggiornamento titolo: $e');
    }
  }

  Future<void> _updateStoryPoints(AgileProjectModel project, UserStoryModel story, int? points) async {
    try {
      final updated = story.copyWith(storyPoints: points, isEstimated: points != null);
      if (points == null) {
        await _firestoreService.updateStoryFields(project.id, story.id, {
          'storyPoints': null,
          'isEstimated': false,
        });
      } else {
        await _firestoreService.updateStory(project.id, updated);
      }
      
      await _auditService.logUpdate(
        projectId: project.id,
        entityType: AuditEntityType.story,
        entityId: story.id,
        entityName: story.title,
        performedBy: _currentUserEmail,
        performedByName: _currentUserName,
        previousValue: {'storyPoints': story.storyPoints},
        newValue: {'storyPoints': points},
        description: 'Story points updated to $points',
        changedFields: ['storyPoints'],
      );
    } catch (e) {
      _showError('Errore aggiornamento punti: $e');
    }
  }

  Future<void> _toggleAcceptanceCriterion(AgileProjectModel project, UserStoryModel story, int index, bool completed) async {
    try {
      final criteria = List<String>.from(story.acceptanceCriteria);
      if (index < 0 || index >= criteria.length) return;

      final criterion = criteria[index];
      final cleanText = criterion.replaceAll(RegExp(r'^\[[xX]\]\s*|^✓\s*'), '');

      criteria[index] = completed ? '[x] $cleanText' : cleanText;

      final updatedStory = story.copyWith(acceptanceCriteria: criteria);
      await _firestoreService.updateStory(project.id, updatedStory);
      
      await _auditService.logUpdate(
        projectId: project.id,
        entityType: AuditEntityType.story,
        entityId: story.id,
        entityName: story.title,
        performedBy: _currentUserEmail,
        performedByName: _currentUserName,
        description: 'Acceptance criterion ${completed ? 'completed' : 'uncompleted'}: $cleanText',
        changedFields: ['acceptanceCriteria'],
      );
    } catch (e) {
      _showError('Errore aggiornamento criterio: $e');
    }
  }

  Future<void> _addStoryAcceptanceCriterion(AgileProjectModel project, UserStoryModel story, String text) async {
    try {
      final updatedStory = story.withAcceptanceCriterion(text);
      await _firestoreService.updateStory(project.id, updatedStory);
      
      await _auditService.logUpdate(
        projectId: project.id,
        entityType: AuditEntityType.story,
        entityId: story.id,
        entityName: story.title,
        performedBy: _currentUserEmail,
        performedByName: _currentUserName,
        // previousValue: {'acceptanceCriteria': story.acceptanceCriteria}, // Optional, maybe too verbose
        // newValue: {'acceptanceCriteria': updatedStory.acceptanceCriteria},
        description: 'Added acceptance criterion: $text',
        changedFields: ['acceptanceCriteria'],
      );
    } catch (e) {
      _showError('Errore aggiunta criterio: $e');
    }
  }

  Future<void> _deleteStoryAcceptanceCriterion(AgileProjectModel project, UserStoryModel story, int index) async {
    try {
      final updatedStory = story.withoutAcceptanceCriterion(index);
      await _firestoreService.updateStory(project.id, updatedStory);
      
      await _auditService.logUpdate(
        projectId: project.id,
        entityType: AuditEntityType.story,
        entityId: story.id,
        entityName: story.title,
        performedBy: _currentUserEmail,
        performedByName: _currentUserName,
        description: 'Deleted acceptance criterion at index $index',
        changedFields: ['acceptanceCriteria'],
      );
    } catch (e) {
      _showError('Errore eliminazione criterio: $e');
    }
  }

  Future<void> _updateStoryProgress(AgileProjectModel project, UserStoryModel story, int? progress) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      // Note: customProgress is nullable. passing null removes the override.
      // passing a value overrides the calculated progress.
      
      // We need to handle null explicitly if copyWith doesn't support setting to null via argument
      // But looking at UserStoryModel.copyWith:
      // customProgress: customProgress ?? this.customProgress,
      // This means passing null will KEEP the old value. We need a way to unset it.
      // Usually copyWith needs a specific sentinel or we reconstruct the object.
      // Let's check UserStoryModel.copyWith implementation again.
      // If it is `customProgress: customProgress ?? this.customProgress`, then we cannot unset it easily.
      // I should update UserStoryModel.copyWith to allow nulling if that was the case, OR use a different approach.
      // WAIT, I implemented copyWith as:
      // customProgress: customProgress ?? this.customProgress
      // This IS a problem for unsetting. 
      // I will assume for now I can reconstruct or change UserStoryModel later. 
      // For this method, I will construct a new object manually to be safe if I need to unset.
      
      UserStoryModel newStory;
      if (progress == null) {
        // We want to remove the custom progress.
        // Since copyWith might not support unsetting, we can recreate it or strictly use a "sentinel" if we had one.
        // A quick fix is to copy all fields.
        newStory = UserStoryModel(
          id: story.id,
          projectId: project.id, // Add projectId
          title: story.title,
          description: story.description,
          status: story.status,
          priority: story.priority,
          storyPoints: story.storyPoints,
          assigneeEmail: story.assigneeEmail,
          tags: story.tags,
          acceptanceCriteria: story.acceptanceCriteria,
          createdAt: story.createdAt,
          startedAt: story.startedAt,
          completedAt: story.completedAt,
          estimates: story.estimates,
          finalEstimate: story.finalEstimate,
          estimationType: story.estimationType,
          sprintId: story.sprintId,
          actualHours: story.actualHours,
          customProgress: null, // Force null
          externalIntegration: story.externalIntegration,
          createdBy: story.createdBy, // Also missing createdBy
        );
      } else {
        newStory = story.copyWith(customProgress: progress);
      }

      await _firestoreService.updateStory(project.id, newStory);
      
      // Log audit?
      // Maybe overkill for slider drag, but good for tracking.
      // Given the slider might fire frequently, we might want debouncing, but here it's onDialogClose or explicit.
      // The callback onProgressChange in the dialog is called "onChangeEnd" (slider) or "onChanged" (switch).
      // So it's safe to log.
    } catch (e) {
      _showError(l10n.errorGeneric(e.toString()));
    }
  }

  Future<void> _updateStoryAssignee(AgileProjectModel project, UserStoryModel story, String? email) async {
    try {
      // Always update the field, whether it's null (unassigned) or a value
      await _firestoreService.updateStoryFields(project.id, story.id, {
        'assigneeEmail': email,
      });
      
      await _auditService.logAssign(
        projectId: project.id,
        entityId: story.id,
        entityName: story.title,
        performedBy: _currentUserEmail,
        performedByName: _currentUserName,
        previousAssignee: story.assigneeEmail,
        newAssignee: email ?? 'Unassigned',
      );
    } catch (e) {
      _showError('Errore aggiornamento assegnatario: $e');
    }
  }

  Future<void> _syncJiraTransition(UserStoryModel story, StoryStatus newStatus) async {
    try {
      final jiraService = JiraService();
      final issueKey = story.externalIntegration!.externalId;

      // 1. Get transitions
      final transitions = await jiraService.getTransitions(issueKey);
      
      // 2. Find matching transition
      final targetKeyword = _mapStatusToJiraKeyword(newStatus);
      
      final matchingTransition = transitions.firstWhere(
        (t) {
          final toName = t['to']['name'].toString().toLowerCase();
          return toName.contains(targetKeyword);
        },
        orElse: () => {},
      );

      if (matchingTransition.isEmpty) {
        print('Jira sync skipped: No transition found for $targetKeyword on $issueKey');
        return;
      }

      final transitionId = matchingTransition['id'];
      final fieldsInfo = matchingTransition['fields'] as Map<String, dynamic>?;

      // 3. Check for mandatory fields
      final requiredFields = <dynamic>[];
      if (fieldsInfo != null) {
        fieldsInfo.forEach((key, value) {
          if (value['required'] == true) {
             requiredFields.add({...value, 'key': key});
          }
        });
      }

      // 4. Execute
      if (requiredFields.isNotEmpty) {
        if (!mounted) return;
        final values = await showDialog<Map<String, dynamic>>(
          context: context,
          builder: (context) => TransitionFallbackDialog(
             transitionName: matchingTransition['name'], 
             requiredFields: requiredFields
          ),
        );

        if (values != null) {
          await jiraService.postTransition(issueKey, transitionId, fields: values);
          if (mounted) _showSuccess(AppLocalizations.of(context)!.jiraSyncSuccess(matchingTransition['name']));
        }
      } else {
        await jiraService.postTransition(issueKey, transitionId);
        if (mounted) _showSuccess(AppLocalizations.of(context)!.jiraSyncedTo(matchingTransition['to']['name']));
      }

    } catch (e) {
      if (mounted) {
         // Warning non bloccante
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.jiraSyncWarning(e.toString().split('\n').first)), backgroundColor: Colors.orange),
          );
      }
    }
  }

  Future<void> _syncStoryFromJira(AgileProjectModel project, UserStoryModel story) async {
    try {
      final jiraService = JiraService();
      final issueData = await jiraService.getIssue(story.externalIntegration!.externalId);
      final fields = issueData['fields'];
      
      final summary = fields['summary'].toString();
      final jiraStatus = fields['status']['name'].toString();
      final newStatus = _mapJiraStatusToInternal(jiraStatus);
      
      final updated = story.copyWith(
        title: summary,
        status: newStatus,
        completedAt: newStatus == StoryStatus.done ? DateTime.now() : story.completedAt,
      );
      
      await _firestoreService.updateStory(widget.project.id, updated);
      
      await _auditService.logUpdate(
        projectId: widget.project.id,
        entityType: AuditEntityType.story,
        entityId: story.id,
        entityName: story.title,
        performedBy: _currentUserEmail,
        performedByName: _currentUserName,
        description: 'Synced from Jira (Title: $summary, Status: $newStatus)',
        changedFields: ['title', 'status', 'externalIntegration'],
      );
      
      if (mounted) _showSuccess(AppLocalizations.of(context)!.jiraSyncFromSuccess(story.externalIntegration!.externalId));
    } catch (e) {
      if (mounted) _showError(AppLocalizations.of(context)!.jiraSyncFailed(e.toString()));
    }
  }

  /// Checks and repairs sprint metrics if they don't match actual stories.
  /// This fixes "Ghost Points" from previous bugs.
  Future<void> _reconcileActiveSprintMetrics(AgileProjectModel project, SprintModel sprint) async {
     try {
       // 1. Get actual stories in sprint
       final actualStories = _stories.where((s) => s.sprintId == sprint.id).toList();
       
       // 2. Calculate totals
       final plannedPoints = actualStories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0) as int);
       final completedPoints = actualStories
          .where((s) => s.status == StoryStatus.done)
          .fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0) as int);
          
       final actualIds = actualStories.map((s) => s.id).toList();
       
       // 3. Compare with stored values
       bool needsUpdate = false;
       
       // IMPORTANT: We only reconcile plannedPoints if it's 0 (broken) or if we are in Planning.
       // If the sprint is ACTIVE, plannedPoints is the FROZEN baseline.
       final targetPlannedPoints = (sprint.plannedPoints == 0 || sprint.isPlanning) 
           ? plannedPoints 
           : sprint.plannedPoints;

       if (sprint.plannedPoints != targetPlannedPoints) needsUpdate = true;
       if (sprint.completedPoints != completedPoints) needsUpdate = true;
       
       // Check if IDs list matches (ignoring order)
       if (sprint.storyIds.length != actualIds.length) {
          needsUpdate = true;
       } else {
          final setA = sprint.storyIds.toSet();
          final setB = actualIds.toSet();
          if (!setA.containsAll(setB)) needsUpdate = true;
       }
       
       // 4. Update if needed
       if (needsUpdate) {
          final correctedSprint = sprint.copyWith(
             plannedPoints: targetPlannedPoints,
             completedPoints: completedPoints,
             storyIds: actualIds,
          );
          await _firestoreService.updateSprint(project.id, correctedSprint);
          print('🔧 Sprint corrected: ${sprint.name} (Pts: ${sprint.plannedPoints} -> $targetPlannedPoints)');
       }
     } catch (e) {
       print('Error reconciling sprint: $e');
     }
  }

  StoryStatus _mapJiraStatusToInternal(String jiraStatus) {
    final lower = jiraStatus.toLowerCase();
    if (lower.contains('done') || lower.contains('closed') || lower.contains('resolved')) return StoryStatus.done;
    if (lower.contains('progress') || lower.contains('doing')) return StoryStatus.inProgress;
    if (lower.contains('review') || lower.contains('qa') || lower.contains('test')) return StoryStatus.inReview;
    if (lower.contains('refinement')) return StoryStatus.refinement;
    if (lower.contains('selected') || lower.contains('ready')) return StoryStatus.ready;
    return StoryStatus.backlog; 
  }

  String _mapStatusToJiraKeyword(StoryStatus status) {
    switch (status) {
      case StoryStatus.backlog: return 'to do'; 
      case StoryStatus.refinement: return 'refinement'; 
      case StoryStatus.ready: return 'selected'; 
      case StoryStatus.inSprint: return 'to do'; 
      case StoryStatus.inProgress: return 'progress'; 
      case StoryStatus.inReview: return 'review'; 
      case StoryStatus.done: return 'done'; 
    }
  }

  // ignore: unused_element
  Future<void> _reorderStories(AgileProjectModel project, List<String> newOrder) async {
    // Aggiorna l'ordine delle stories su Firestore
    try {
      await _firestoreService.updateStoriesOrder(project.id, newOrder);
    } catch (e) {
      _showError('Errore riordino backlog: $e');
    }
  }

  Future<void> _showInviteDialog(AgileProjectModel project) async {
    await AgileParticipantInviteDialog.show(
      context: context,
      projectId: project.id,
      projectName: project.name,
    );
  }

  Future<void> _showProjectSettingsDialog(AgileProjectModel project) async {
    final l10n = AppLocalizations.of(context)!;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.settings, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(child: Text('${l10n.actionSettings}: ${project.name}')),
          ],
        ),
        insetPadding: const EdgeInsets.all(16),
        content: SizedBox(
          width: MediaQuery.of(context).size.width < 400
              ? MediaQuery.of(context).size.width * 0.85
              : 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(project.framework.icon),
                title: Text(l10n.agileFramework),
                subtitle: Text(project.framework.displayName),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(l10n.agileSprintDuration),
                subtitle: Text('${project.sprintDurationDays} giorni'),
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
                subtitle: SelectableText(project.id, style: const TextStyle(fontSize: 11)),
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

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 2: SPRINT
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _startSprint(AgileProjectModel project, String sprintId) async {
    final sprint = _sprints.firstWhere((s) => s.id == sprintId);
    // Include ready/backlog stories + stories in "To Do" (inSprint) for this sprint or unassigned
    final stories = _stories.where((s) =>
        s.status == StoryStatus.ready ||
        s.status == StoryStatus.backlog ||
        (s.status == StoryStatus.inSprint && (s.sprintId == sprintId || s.sprintId == null))
    ).toList();
    
    // Recalculate capacity for current team (fixes issue with old sprints having stale capacity)
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, now.day);
    final endDate = startDate.add(Duration(days: project.sprintDurationDays - 1));
    
    final currentTotalCapacity = _teamMembers
        .where((m) => m.role.isDevelopmentTeam)
        .fold<int>(0, (sum, m) => sum + m.getAvailableHours(startDate, endDate));

    // Mostra il wizard di pianificazione
    final selectedStoryIds = await SprintPlanningWizard.show(
      context: context,
      sprint: sprint,
      backlogStories: stories,
      storiesStream: _storiesStream,
      averageVelocity: _calculateAverageVelocity(),
      totalCapacityHours: currentTotalCapacity > 0 ? currentTotalCapacity : sprint.totalCapacityHours,
    );

    if (selectedStoryIds != null && mounted) {
      try {
        final now = DateTime.now();
        
        // Crea una copia aggiornata dello sprint
        final updatedSprint = sprint.copyWith(
          status: SprintStatus.active,
          storyIds: selectedStoryIds,
          startDate: now,
          endDate: now.add(Duration(days: sprint.durationDays - 1)),
        );
        
        // Aggiorna lo sprint
        await _firestoreService.updateSprint(project.id, updatedSprint);

        // Aggiorna le stories selezionate (spostale in sprint)
        for (final storyId in selectedStoryIds) {
           await _firestoreService.updateStoryStatus(
             project.id, 
             storyId, 
             StoryStatus.inSprint, // Reset status to In Sprint (Todo) for new sprint
             sprintId: sprint.id
           );
        }
        
        // Log audit
        await _auditService.logSprintStart(
          projectId: project.id,
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

  Future<void> _completeSprint(AgileProjectModel project, String sprintId) async {
    final sprint = _sprints.firstWhere((s) => s.id == sprintId);
    if (sprint.status == SprintStatus.active) {
      await _startSprintClosing(project, sprint);
    } else if (sprint.status == SprintStatus.review) {
      await _finalizeSprintConfirm(project, sprint);
    } else {
      // Fallback for backward compatibility
      await _completeSprintConfirm(project, sprint);
    }
  }


  Widget _buildSprintTab(AgileProjectModel project) {
    final activeSprint = _sprints.where((s) => s.status.isActiveOrReview).firstOrNull;

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
            // Burndown chart live
            SprintBurndownLiveWidget(
              currentSprint: activeSprint,
              stories: _stories,
            ),
            const SizedBox(height: 24),
          ],

          // Lista sprint
          // SCRUM PERMISSIONS: Solo SM può gestire gli sprint
          SprintListWidget(
            sprints: _sprints,
            stories: _stories,
            onSprintTap: (sprint) => _showSprintDetail(project, sprint),
            onAddSprint: project.canManageSprints(_currentUserEmail)
                ? () => _showCreateSprintDialog(project)
                : null,
            onSprintStart: project.canManageSprints(_currentUserEmail)
                ? (id) => _startSprint(project, id)
                : null,
            onSprintComplete: project.canManageSprints(_currentUserEmail)
                ? (id) => _completeSprint(project, id)
                : null,
            onSprintDelete: project.canManageSprints(_currentUserEmail)
                ? (id) => _deletePlanningSprint(project, id)
                : null,
            canEdit: project.canManageSprints(_currentUserEmail),
          ),

          const SizedBox(height: 24),



          // Sprint Review History (mostra tutte le review passate)
          if (_sprints.any((s) => s.hasSprintReview)) ...[
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SprintReviewHistoryWidget(
                  sprints: _sprints,
                  onEdit: project.canStartSprintReview(_currentUserEmail)
                      ? (sprint) => _showSprintReviewDialog(project, sprint)
                      : null,
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
    // FIX: Escludi storie in Backlog/Refinement/Ready anche se hanno sprintId (incongruenza storica)
    final sprintStories = _stories.where((s) => 
        s.sprintId == sprint.id && 
        s.status != StoryStatus.backlog &&
        s.status != StoryStatus.refinement &&
        s.status != StoryStatus.ready
    ).toList();
    
    final completedPoints = sprintStories
        .where((s) => s.status == StoryStatus.done)
        .fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0) as int);
    final plannedPoints = sprintStories
        .fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0) as int);
    
    final daysRemaining = sprint.daysRemaining;
    final inProgressCount = sprintStories
        .where((s) => s.status == StoryStatus.inProgress || s.status == StoryStatus.inReview)
        .length;
        
    final progress = plannedPoints > 0
        ? completedPoints / plannedPoints
        : 0.0;

    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant,
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
                    color: sprint.isReview ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    sprint.isReview
                        ? l10n.agileSprintClosingPhase.toUpperCase()
                        : l10n.agileSprintStatusActive.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            // Banner: Sprint in closing phase
            if (sprint.isReview)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.orange, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.agileSprintClosingBanner,
                        style: const TextStyle(fontSize: 13, color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              ),
            if (sprint.goal.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '${l10n.agileSprintGoal}: ${sprint.goal}',
                style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSprintStat(l10n.agileDaysLabel, '$daysRemaining', l10n.agileStatRemaining),
                _buildSprintStat(l10n.agileStatsCompletedLabel, '$completedPoints', l10n.agileStatsPoints),
                _buildSprintStat(l10n.agileStatsPlannedLabel, '$plannedPoints', l10n.agileStatsPoints),
                _buildSprintStat(l10n.agileSprintHealthStoriesInProgress, '$inProgressCount', ''), // Reuse localized string
                _buildSprintStat(l10n.agileProgressLabel, '${(progress * 100).round()}', '%'),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                minHeight: 8,
              ),
            ),
            


            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                if (project.canStartSprintReview(_currentUserEmail))
                  if (!sprint.hasSprintReview)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showSprintReviewDialog(project, sprint),
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
                        onPressed: () => _showSprintReviewDialog(project, sprint),
                        icon: const Icon(Icons.check_circle, size: 18, color: Colors.green),
                        label: Text(l10n.agileSprintReviewCompleted),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green,
                          side: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                if (project.canManageSprints(_currentUserEmail) && sprint.status == SprintStatus.active) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: sprint.hasSprintReview
                        ? ElevatedButton.icon(
                            onPressed: () => _finalizeSprintConfirm(project, sprint),
                            icon: const Icon(Icons.check),
                            label: Text(l10n.agileFinalizeSprint),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          )
                        : ElevatedButton.icon(
                            onPressed: () => _startSprintClosing(project, sprint),
                            icon: const Icon(Icons.rate_review),
                            label: Text(l10n.agileStartClosing),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                  ),
                ],
                if (project.canManageSprints(_currentUserEmail) && sprint.status == SprintStatus.review) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _finalizeSprintConfirm(project, sprint),
                      icon: const Icon(Icons.check),
                      label: Text(l10n.agileFinalizeSprint),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
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
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          if (unit.isNotEmpty)
            Text(
              unit,
              style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodySmall?.color),
              overflow: TextOverflow.ellipsis,
            ),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Theme.of(context).textTheme.bodySmall?.color),
            overflow: TextOverflow.ellipsis,
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

  Future<void> _showCreateSprintDialog(AgileProjectModel project) async {
    // Block creation if a planning sprint already exists
    final hasPlanningSprintAlready = _sprints.any((s) => s.status == SprintStatus.planning);
    if (hasPlanningSprintAlready) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.sprintPlanningAlreadyExists),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final avgVelocity = _calculateAverageVelocity();
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, now.day);
    final endDate = startDate.add(Duration(days: project.sprintDurationDays - 1));

    final teamCapacity = <String, int>{
      for (final member in _teamMembers.where((m) => m.role.isDevelopmentTeam))
        member.email: member.getAvailableHours(startDate, endDate)
    };

    final result = await SprintFormDialog.show(
      context: context,
      projectId: project.id,
      suggestedDuration: project.sprintDurationDays,
      averageVelocity: avgVelocity > 0 ? avgVelocity : null,
      teamCapacity: teamCapacity,
    );

    if (result != null && mounted) {
      try {
        final sprint = await _firestoreService.createSprint(
          projectId: project.id,
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

  Future<void> _deletePlanningSprint(AgileProjectModel project, String sprintId) async {
    final l10n = AppLocalizations.of(context)!;
    final sprint = _sprints.firstWhere((s) => s.id == sprintId);

    // Confirm deletion
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.sprintDeletePlanningTitle),
        content: Text(l10n.sprintDeletePlanningConfirm(sprint.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      // Move all associated stories back to backlog
      // Include: stories linked by sprintId, stories in sprint's storyIds list,
      // and stories manually set to inSprint without a specific sprintId
      final associatedStories = _stories.where((s) =>
        s.sprintId == sprintId ||
        sprint.storyIds.contains(s.id) ||
        (s.status == StoryStatus.inSprint && (s.sprintId == null || s.sprintId!.isEmpty))
      ).toList();

      for (final story in associatedStories) {
        await _firestoreService.updateStoryFields(
          project.id,
          story.id,
          {
            'status': StoryStatus.backlog.name,
            'sprintId': null,
          },
        );
      }

      // Delete the sprint
      await _firestoreService.deleteSprint(project.id, sprintId);

      if (mounted) {
        _showSuccess(l10n.sprintDeletedSuccess(sprint.name));
      }
    } catch (e) {
      _showError('Error deleting sprint: $e');
    }
  }

  void _showSprintDetail(AgileProjectModel project, SprintModel sprint) {
    final l10n = AppLocalizations.of(context)!;
    final sprintStories = _stories.where((s) => sprint.storyIds.contains(s.id)).toList();
    final completedStories = sprintStories.where((s) => s.status == StoryStatus.done).toList();
    
    final currentPlannedPoints = sprint.plannedPoints;
    final currentCompletedPoints = sprint.completedPoints;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.directions_run, color: AppColors.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sprint.name),
                  _buildSprintStatusBadge(sprint.status),
                ],
              ),
            ),
          ],
        ),
        insetPadding: const EdgeInsets.all(16),
        content: SizedBox(
          width: MediaQuery.of(context).size.width < 500
              ? MediaQuery.of(context).size.width * 0.85
              : 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (sprint.goal != null) ...[
                  Text(
                    l10n.agileSprintGoal,
                    style: TextStyle(fontWeight: FontWeight.bold, color: context.textSecondaryColor),
                  ),
                  Text(sprint.goal!),
                  const SizedBox(height: 16),
                ],

                // Dates
                Row(
                  children: [
                    Expanded(
                      child: _buildSprintInfoTile(
                        l10n.agileStartDate,
                        _formatDate(sprint.startDate),
                        Icons.calendar_today,
                      ),
                    ),
                    Expanded(
                      child: _buildSprintInfoTile(
                        l10n.agileEndDate,
                        _formatDate(sprint.endDate),
                        Icons.event,
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
                              l10n.agilePointsValue(story.storyPoints ?? 0),
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
          // SCRUM PERMISSIONS: Solo SM può chiudere/finalizzare sprint
          if (sprint.status == SprintStatus.active && project.canManageSprints(_currentUserEmail))
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _startSprintClosing(project, sprint);
              },
              icon: const Icon(Icons.rate_review),
              label: Text(l10n.agileStartClosing),
            ),
          if (sprint.status == SprintStatus.review && project.canManageSprints(_currentUserEmail))
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _finalizeSprintConfirm(project, sprint);
              },
              icon: const Icon(Icons.check),
              label: Text(l10n.agileFinalizeSprint),
            ),
        ],
      ),
    );
  }

  Widget _buildSprintStatusBadge(SprintStatus status) {
    final l10n = AppLocalizations.of(context)!;
    Color color;
    String label;
    switch (status) {
      case SprintStatus.planning:
        color = Colors.orange;
        label = l10n.agileSprintStatusPlanning;
        break;
      case SprintStatus.active:
        color = Colors.green;
        label = l10n.agileSprintStatusActive;
        break;
      case SprintStatus.review:
        color = Colors.blue;
        label = l10n.agileSprintStatusReview;
        break;
      case SprintStatus.completed:
        color = Colors.grey;
        label = l10n.agileSprintStatusCompleted;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
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

  Future<void> _completeSprintConfirm(AgileProjectModel project, SprintModel sprint) async {
    final l10n = AppLocalizations.of(context)!;
    // Calcola completedPoints REALI dalle stories Done in questo sprint
    final sprintStories = _stories.where((s) => s.sprintId == sprint.id).toList();
    final completedStories = sprintStories.where((s) => s.status == StoryStatus.done).toList();
    final actualCompletedPoints = completedStories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0) as int);
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
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
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
                            _showSprintReviewDialog(project, sprint);
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
                  color: Colors.green.withOpacity(0.1),
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
                color: Colors.blue.withOpacity(0.1),
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
        // Calcola velocity STANDARD (punti completati totali nello sprint)
        // La velocity settimanale viene calcolata dinamicamente nella dashboard.
        final velocity = actualCompletedPoints.toDouble();

        // Backfill plannedPoints se mancanti (per fix storico metrica commitment)
        int? backfillPlannedPoints;
        if (sprint.plannedPoints == 0) {
          backfillPlannedPoints = sprintStories.fold<int>(
              0, (sum, s) => sum + (s.storyPoints ?? 0) as int);
        }

        await _firestoreService.completeSprint(
          project.id,
          sprint.id,
          completedPoints: actualCompletedPoints,
          velocity: velocity,
          plannedPoints: backfillPlannedPoints,
        );

        // Riporta stories incomplete nel backlog
        for (final story in sprintStories.where((s) => s.status != StoryStatus.done)) {
          final updated = story.copyWith(
            clearSprintId: true,
            status: StoryStatus.backlog,
          );
          await _firestoreService.updateStory(project.id, updated);
        }

        _showSuccess(l10n.agileSprintCompleteSuccess(velocity.toStringAsFixed(1)));
        
        // Audit log
        await _auditService.logSprintClose(
          projectId: project.id,
          sprintId: sprint.id,
          sprintName: sprint.name,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
          completedStories: completedCount,
          totalStories: totalStories,
          completedPoints: actualCompletedPoints,
          plannedPoints: sprint.plannedPoints,
          velocity: velocity,
        );

      } catch (e) {
        _showError(l10n.errorGeneric(e.toString()));
      }
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SPRINT CLOSING FLOW - 2-Phase Scrum-Compliant
  // ══════════════════════════════════════════════════════════════════════════

  /// Phase 1: Transition sprint from active → review
  Future<void> _startSprintClosing(AgileProjectModel project, SprintModel sprint) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.rate_review, color: Colors.orange),
            const SizedBox(width: 8),
            Expanded(child: Text(l10n.agileStartClosing)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.agileSprintClosingDesc),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.orange, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.agileSprintClosingPhase,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('• ${l10n.agileSprintClosingBoardVisible}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                  Text('• ${l10n.agileSprintClosingNoNewStories}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                  Text('• ${l10n.agileSprintClosingReviewFirst}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700])),
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
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.rate_review),
            label: Text(l10n.agileStartClosing),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await _firestoreService.startSprintClosing(project.id, sprint.id);

        // Audit log
        final sprintStories = _stories.where((s) => s.sprintId == sprint.id).toList();
        final completedCount = sprintStories.where((s) => s.status == StoryStatus.done).length;
        await _auditService.logSprintClosingStarted(
          projectId: project.id,
          sprintId: sprint.id,
          sprintName: sprint.name,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
          totalStories: sprintStories.length,
          completedStories: completedCount,
        );

        _showSuccess(l10n.agileSprintClosingStarted);
      } catch (e) {
        _showError(l10n.errorGeneric(e.toString()));
      }
    }
  }

  /// Phase 2: Finalize sprint (review → completed) with story disposition
  Future<void> _finalizeSprintConfirm(AgileProjectModel project, SprintModel sprint) async {
    final l10n = AppLocalizations.of(context)!;
    final sprintStories = _stories.where((s) => s.sprintId == sprint.id).toList();
    final completedStories = sprintStories.where((s) => s.status == StoryStatus.done).toList();
    
    // Determine stories that actually need disposition (Physical Incomplete - Approved Review)
    final reviewApprovedIds = sprint.sprintReview?.storyOutcomes
        .where((o) => o.outcome == ReviewOutcomeType.approved)
        .map((o) => o.storyId)
        .toSet() ?? {};
        
    final storiesToDispose = sprintStories.where((s) => 
        s.status != StoryStatus.done && !reviewApprovedIds.contains(s.id)
    ).toList();
    
    // For metrics calculation we still use the physical state
    final actualCompletedPoints = completedStories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0) as int);
    final totalStories = sprintStories.length;
    final completedCount = completedStories.length;
    final hasSprintReview = sprint.hasSprintReview;

    // Story disposition map: storyId → disposition ('backlog', 'ready', 'to_refinement')
    final dispositions = <String, String>{};
    for (final story in storiesToDispose) {
      dispositions[story.id] = 'backlog'; // Default
    }

    // Calculate display metrics (Virtual State if Review exists)
    int displayCompletedCount = completedCount;
    int displayCompletedPoints = actualCompletedPoints;
    
    if (hasSprintReview && sprint.sprintReview != null) {
       displayCompletedCount = sprint.sprintReview!.storiesCompleted;
       displayCompletedPoints = sprint.sprintReview!.pointsCompleted;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.blue),
              const SizedBox(width: 8),
              Expanded(child: Text(l10n.agileFinalizeSprint)),
            ],
          ),
          insetPadding: const EdgeInsets.all(16),
          content: SizedBox(
            width: MediaQuery.of(context).size.width < 480
                ? MediaQuery.of(context).size.width * 0.85
                : 480,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: Sprint Review Status
                  Text(l10n.agileSprintReviewSection,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  if (hasSprintReview)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${l10n.agileSprintReviewCompleted} - ${_formatDate(sprint.sprintReview!.date)}',
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.warning_amber, color: Colors.orange, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  l10n.agileMissingReview,
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context, false);
                              _showSprintReviewDialog(project, sprint);
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

                  // Section 1.5: Sprint Review Recap
                  if (hasSprintReview && sprint.sprintReview?.storyOutcomes.isNotEmpty == true) ...[
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 12),
                    _buildReviewRecapSection(context, sprint.sprintReview!),
                  ],

                  // Section 2: Story Disposition
                  if (storiesToDispose.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 12),
                    Text(l10n.agileStoryDisposition,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(l10n.agileStoryDispositionDesc,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                    const SizedBox(height: 12),
                    ...storiesToDispose.map((story) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  story.title,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (story.storyPoints != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(l10n.agilePointsValue(story.storyPoints ?? 0),
                                      style: const TextStyle(fontSize: 11, color: Colors.blue)),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              _buildDispositionChip(
                                label: l10n.agileDispositionBacklog,
                                selected: dispositions[story.id] == 'backlog',
                                color: Colors.grey,
                                onTap: () => setDialogState(() => dispositions[story.id] = 'backlog'),
                              ),
                              const SizedBox(width: 6),
                              _buildDispositionChip(
                                label: l10n.agileDispositionReady,
                                selected: dispositions[story.id] == 'ready',
                                color: Colors.blue,
                                onTap: () => setDialogState(() => dispositions[story.id] = 'ready'),
                              ),
                              const SizedBox(width: 6),
                              _buildDispositionChip(
                                label: l10n.agileDispositionRefinement, // Was agileDispositionCarryForward
                                selected: dispositions[story.id] == 'refinement',
                                color: Colors.purple,
                                onTap: () => setDialogState(() => dispositions[story.id] = 'refinement'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ],

                  // Section 3: Summary
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(l10n.agileSprintSummarySection,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ${l10n.agileStoriesCompleted}: $displayCompletedCount / $totalStories'),
                        Text('• ${l10n.agilePointsCompletedLabel}: $displayCompletedPoints ${l10n.agileStatsPoints}',
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        Text('• Velocity: ${displayCompletedPoints.toStringAsFixed(0)} ${l10n.agileStatsPoints}'),
                        if (storiesToDispose.isNotEmpty)
                          Text('• ${l10n.agileStoriesIncomplete}: ${storiesToDispose.length}',
                              style: const TextStyle(color: Colors.orange)),
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
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.check),
              label: Text(l10n.agileFinalizeSprint),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && mounted) {
      try {
        // 1. Calculate metrics based on Review Outcomes (if available) or current status
        //    This ensures we use the qualitative assessment from the review.
        int finalCompletedPoints = 0;
        
        if (hasSprintReview && sprint.sprintReview != null) {
           // Trust the review data
           finalCompletedPoints = sprint.sprintReview!.pointsCompleted;
        } else {
           // Fallback to current status (auto-calculation)
           finalCompletedPoints = actualCompletedPoints;
        }

        final velocity = finalCompletedPoints.toDouble();

        // 2. Backfill plannedPoints if missing (for legacy data fix)
        //    Use the current sprintStories list which should still contain all stories
        //    since we didn't move them in _saveSprintReview anymore.
        int? backfillPlannedPoints;
        if (sprint.plannedPoints == 0) {
          backfillPlannedPoints = sprintStories.fold<int>(
              0, (sum, s) => sum + (s.storyPoints ?? 0) as int);
        }

        // 3. Complete sprint (INVARIANT - metrics calculated here)
        await _firestoreService.completeSprint(
          project.id,
          sprint.id,
          completedPoints: finalCompletedPoints,
          velocity: velocity,
          plannedPoints: backfillPlannedPoints,
        );

        // 4. Apply story dispositions (Move stories)
        //    Now it is safe to move stories out of the sprint because metrics are frozen.
        
        // A. Handle "Needs Refinement" / "Rejected" from Sprint Review
        if (hasSprintReview && sprint.sprintReview != null) {
           for (final outcome in sprint.sprintReview!.storyOutcomes) {
              if (outcome.outcome == ReviewOutcomeType.needsRefinement || 
                  outcome.outcome == ReviewOutcomeType.rejected) {
                  
                  final story = sprintStories.firstWhere(
                    (s) => s.id == outcome.storyId, 
                    orElse: () => UserStoryModel.empty()
                  );
                  
                  if (story.id.isNotEmpty && (story.sprintId != null || story.status != StoryStatus.backlog)) {
                     final updated = story.copyWith(
                        clearSprintId: true,
                        status: StoryStatus.backlog,
                        // Maintain existing tags
                     );
                     await _firestoreService.updateStory(project.id, updated);
                  }
              } else if (outcome.outcome == ReviewOutcomeType.approved) {
                  final story = sprintStories.firstWhere(
                    (s) => s.id == outcome.storyId, 
                    orElse: () => UserStoryModel.empty()
                  );
                  // Ensure approved stories are Done
                   if (story.id.isNotEmpty && story.status != StoryStatus.done) {
                     final updated = story.copyWith(status: StoryStatus.done);
                     await _firestoreService.updateStory(project.id, updated);
                  }
              }
           }
        }

        // B. Handle remaining incomplete stories (Administrative closing)
        //    This covers stories that were NOT in the review or were left pending.
        //    We MUST refresh the list because some stories might have moved in step 4A.
        //    However, for simplicity and robustness, we can just iterate the incomplete list
        //    and check their current (potentially updated) state or just apply the disposition
        //    if they haven't been moved yet.
        
        for (final story in storiesToDispose) {
           // Skip if already handled by Review (e.g. moved to backlog above)
           // But since 'storiesToDispose' is filtered to exclude approved ones, we are safer.
           // A safe approach is to check if we have a specific disposition set in the dialog.
           
           if (dispositions.containsKey(story.id)) {
              final disposition = dispositions[story.id]!;
              StoryStatus newStatus = StoryStatus.backlog;
              
              switch (disposition) {
                case 'ready': newStatus = StoryStatus.ready; break;
                case 'refinement': newStatus = StoryStatus.refinement; break;
                case 'backlog': default: newStatus = StoryStatus.backlog; break;
              }

              // Apply update
              // Note: We always clear sprintId for incomplete items at sprint close
              final updated = story.copyWith(
                clearSprintId: true,
                status: newStatus,
              );
              await _firestoreService.updateStory(project.id, updated);
           }
        }

        // Audit log
        await _auditService.logSprintClose(
          projectId: project.id,
          sprintId: sprint.id,
          sprintName: sprint.name,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
          completedStories: completedCount,
          totalStories: totalStories,
          completedPoints: actualCompletedPoints,
          plannedPoints: sprint.plannedPoints,
          velocity: velocity,
        );

        // Success dialog + Retro suggestion
        if (mounted) {
          final goToRetro = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
              title: Text(l10n.agileSprintCompleteSuccess(velocity.toStringAsFixed(1))),
              content: Text(l10n.agileRetroSuggestion),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: Text(l10n.agileNotNow),
                ),
                FilledButton.icon(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  icon: const Icon(Icons.rate_review),
                  label: Text(l10n.agileCreateRetro),
                ),
              ],
            ),
          );
          if (goToRetro == true && mounted) {
            final retroTabIndex = _features.visibleTabs.indexOf(AgileTab.retro);
            if (retroTabIndex >= 0) {
              _tabController.animateTo(retroTabIndex);
            }
          }
        }
      } catch (e) {
        _showError(l10n.errorGeneric(e.toString()));
      }
    }
  }

  Widget _buildDispositionChip({
    required String label,
    required bool selected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? color : Colors.grey.withOpacity(0.3),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? color : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Dialog per condurre la Sprint Review (Scrum Guide 2020) - ENHANCED
  Future<void> _showSprintReviewDialog(AgileProjectModel project, SprintModel sprint) async {
    final l10n = AppLocalizations.of(context)!;
    
    // Stories currently in the sprint
    final sprintStories = _stories.where((s) => s.sprintId == sprint.id).toList();
    
    // Load existing data if available
    final existingReview = sprint.sprintReview;

    // GHOST STORIES: Stories that were in the review but are no longer in the sprint (e.g. moved to backlog)
    final ghostStories = <UserStoryModel>[];
    if (existingReview != null) {
      for (final outcome in existingReview.storyOutcomes) {
        // If not found in current sprint stories
        if (!sprintStories.any((s) => s.id == outcome.storyId)) {
          // Find in global stories list
          final ghost = _stories.firstWhere(
            (s) => s.id == outcome.storyId,
            orElse: () => UserStoryModel.empty(),
          );
          
          if (ghost.id.isNotEmpty) {
            ghostStories.add(ghost);
          } else {
             debugPrint('Story ${outcome.storyId} not found in project stories');
          }
        }
      }
    }

    // Combine for the review list (Ghosts + Current)
    final allStoriesToReview = [...sprintStories, ...ghostStories];

    final completedStories = allStoriesToReview.where((s) => s.status == StoryStatus.done).toList();
    final incompleteStories = allStoriesToReview.where((s) => s.status != StoryStatus.done).toList();
    
    // Calculate points based on outcomes (more accurate for edits)
    // If editing, use outcomes. If new, use current status.
    final actualCompletedPoints = completedStories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0) as int);
    
    final demoNotesController = TextEditingController(text: existingReview?.demoNotes ?? '');
    final feedbackController = TextEditingController(text: existingReview?.feedback ?? '');
    final nextSprintFocusController = TextEditingController(text: existingReview?.nextSprintFocus ?? '');
    final backlogUpdateController = TextEditingController();
    final backlogUpdates = List<String>.from(existingReview?.backlogUpdates ?? []);

    // NEW: Story outcomes (valutazione per-story)
    final storyOutcomes = <String, ReviewOutcomeType>{};
    
    // Initialize outcomes: 
    // 1. From existing review if present
    // 2. Or default based on status (Done -> Approved, else -> Refinement)
    if (existingReview != null && existingReview.storyOutcomes.isNotEmpty) {
      for (final outcome in existingReview.storyOutcomes) {
        storyOutcomes[outcome.storyId] = outcome.outcome;
      }
      // Ensure any newly added stories also have a default
      for (final story in sprintStories) {
        if (!storyOutcomes.containsKey(story.id)) {
           storyOutcomes[story.id] = story.status == StoryStatus.done 
              ? ReviewOutcomeType.approved 
              : ReviewOutcomeType.needsRefinement;
        }
      }
    } else {
      for (final story in completedStories) {
        storyOutcomes[story.id] = ReviewOutcomeType.approved; 
      }
      for (final story in incompleteStories) {
        storyOutcomes[story.id] = ReviewOutcomeType.needsRefinement; 
      }
    }

    // NEW: Attendees con ruoli
    // Load from existing or default to current team
    final attendees = <ReviewAttendee>[];
    if (existingReview != null && existingReview.attendeesWithRoles.isNotEmpty) {
      attendees.addAll(existingReview.attendeesWithRoles);
      // Add any new team members that might be missing? Or just trust the snapshot?
      // For editing, it's better to show who was recorded.
      // But if we want to "update" the meeting, we might want to see current team.
      // Let's merge: keep existing statuses, add new members as not present.
      for (final member in _teamMembers) {
        if (!attendees.any((a) => a.email == member.email)) {
           attendees.add(ReviewAttendee(
            email: member.email, 
            name: member.name, 
            role: member.teamRole.name, 
            isPresent: false
          ));
        }
      }
    } else {
      for (final member in _teamMembers) {
        attendees.add(ReviewAttendee(
          email: member.email,
          name: member.name,
          role: member.teamRole.name,
          isPresent: true,
        ));
      }
    }

    // NEW: Decisioni formali
    final decisions = List<ReviewDecision>.from(existingReview?.decisions ?? []);
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
          insetPadding: const EdgeInsets.all(16),
          content: SizedBox(
            width: MediaQuery.of(context).size.width < 600
                ? MediaQuery.of(context).size.width * 0.85
                : 600,
            height: MediaQuery.of(context).size.height * 0.7,
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
                              Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.05), // Modern lighter look
                                  borderRadius: BorderRadius.circular(12),
                                  // No border, just subtle background
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.info_rounded, size: 20, color: Colors.blue[700]),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            l10n.agileReviewGuidance,
                                            style: TextStyle(fontSize: 13, color: Colors.blue[900]),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Tip: Use "Move In Progress to Review" below to update board status before evaluating.',
                                            style: TextStyle(fontSize: 11, color: Colors.blue[800], fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                    color: Colors.green.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('✅ ${l10n.agileStatsCompleted}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      ...completedStories.map((story) {
                                        final isGhost = ghostStories.contains(story);
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (isGhost)
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8, bottom: 4),
                                                child: Text(
                                                  '⚠️ Currently in ${story.status.name} (Restored if approved)',
                                                  style: const TextStyle(fontSize: 10, color: Colors.orange, fontStyle: FontStyle.italic),
                                                ),
                                              ),
                                            _buildStoryEvaluationRow(
                                              story,
                                              storyOutcomes[story.id]!,
                                              (outcome) => setDialogState(() => storyOutcomes[story.id] = outcome),
                                            ),
                                          ],
                                        );
                                      }),
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
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('⏳ ${l10n.agileStatsNotCompleted}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                          // BULK ACTION: Move In Progress -> Review
                                          if (incompleteStories.any((s) => s.status == StoryStatus.inProgress))
                                            TextButton.icon(
                                              onPressed: () async {
                                                int movedCount = 0;
                                                for (final story in incompleteStories) {
                                                  if (story.status == StoryStatus.inProgress) {
                                                    await _firestoreService.updateStory(
                                                      project.id, 
                                                      story.copyWith(status: StoryStatus.inReview)
                                                    );
                                                    movedCount++;
                                                  }
                                                }
                                                if (movedCount > 0 && mounted) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Moved $movedCount stories to Review')),
                                                  );
                                                  // Note: Dialog UI state won't refresh automatically because sprintStories is local.
                                                  // But the board behind will. This is a quick helper.
                                                }
                                              },
                                              icon: const Icon(Icons.low_priority, size: 16),
                                              label: const Text('Move In Progress to Review', style: TextStyle(fontSize: 12)),
                                              style: TextButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                minimumSize: Size.zero,
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      ...incompleteStories.map((story) {
                                        final isGhost = ghostStories.contains(story);
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (isGhost)
                                               Padding(
                                                padding: const EdgeInsets.only(left: 8, bottom: 4),
                                                child: Text(
                                                  '⚠️ Currently in ${story.status.name} (Restored if approved)',
                                                  style: const TextStyle(fontSize: 10, color: Colors.orange, fontStyle: FontStyle.italic),
                                                ),
                                              ),
                                            _buildStoryEvaluationRow(
                                              story,
                                              storyOutcomes[story.id]!,
                                              (outcome) => setDialogState(() => storyOutcomes[story.id] = outcome),
                                            ),
                                          ],
                                        );
                                      }),
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
                              TextField(
                                controller: backlogUpdateController,
                                decoration: InputDecoration(
                                  hintText: l10n.agileReviewBacklogHint,
                                  isDense: true,
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.add_circle),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      if (backlogUpdateController.text.trim().isNotEmpty) {
                                        setDialogState(() {
                                          backlogUpdates.add(backlogUpdateController.text.trim());
                                          backlogUpdateController.clear();
                                        });
                                      }
                                    },
                                  ),
                                ),
                                onSubmitted: (value) {
                                  if (value.trim().isNotEmpty) {
                                    setDialogState(() {
                                      backlogUpdates.add(value.trim());
                                      backlogUpdateController.clear();
                                    });
                                  }
                                },
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
                              TextField(
                                controller: decisionController,
                                decoration: InputDecoration(
                                  hintText: l10n.agileAddDecision,
                                  isDense: true,
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.add_circle),
                                    color: Theme.of(context).primaryColor,
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
                                  ),
                                ),
                                onSubmitted: (value) {
                                  if (value.trim().isNotEmpty) {
                                    setDialogState(() {
                                      decisions.add(ReviewDecision(
                                        description: value.trim(),
                                        type: ReviewDecisionType.actionItem,
                                      ));
                                      decisionController.clear();
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 12),
                              ...decisions.asMap().entries.map((e) => Card(
                                child: ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Color(e.value.type.colorValue).withOpacity(0.1),
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
                                    l10n.agileNoDecisions,
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
                              title: UserDisplayName(email: attendee.email, fallback: attendee.name),
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
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            OutlinedButton.icon(
              onPressed: () {
                final buffer = StringBuffer();
                buffer.writeln('📋 SPRINT REVIEW: ${sprint.name}');
                buffer.writeln('📅 Date: ${_formatDate(DateTime.now())}');
                buffer.writeln('👤 Conducted by: ${_currentUserEmail}');
                
                // Attendees
                final presentAttendees = attendees.where((a) => a.isPresent).toList();
                if (presentAttendees.isNotEmpty) {
                  buffer.writeln('\n👥 ATTENDEES:');
                  for (final a in presentAttendees) {
                    buffer.writeln('- ${a.name} (${a.roleDisplayName})');
                  }
                }

                buffer.writeln('\n--- STORY EVALUATIONS ---');
                
                if (completedStories.isNotEmpty) {
                  buffer.writeln('\n✅ Completed Stories:');
                  for (final story in completedStories) {
                     final outcome = storyOutcomes[story.id];
                     String outcomeIcon = '❓';
                     if (outcome == ReviewOutcomeType.approved) outcomeIcon = '✅';
                     if (outcome == ReviewOutcomeType.needsRefinement || outcome == ReviewOutcomeType.rejected) outcomeIcon = '🔄';
                     buffer.writeln('- $outcomeIcon ${story.title} (${story.storyPoints} SP)');
                  }
                }
                
                if (incompleteStories.isNotEmpty) {
                  buffer.writeln('\n⏳ Not Completed Stories:');
                   for (final story in incompleteStories) {
                     final outcome = storyOutcomes[story.id];
                     String outcomeIcon = '❓';
                     if (outcome == ReviewOutcomeType.approved) outcomeIcon = '✅';
                     if (outcome == ReviewOutcomeType.needsRefinement || outcome == ReviewOutcomeType.rejected) outcomeIcon = '🔄';
                     buffer.writeln('- $outcomeIcon ${story.title} (${story.storyPoints} SP)');
                  }
                }

                if (demoNotesController.text.isNotEmpty) {
                  buffer.writeln('\n--- NOTES & FEEDBACK ---');
                  buffer.writeln('Demo Notes: ${demoNotesController.text}');
                }
                if (feedbackController.text.isNotEmpty) {
                  buffer.writeln('Feedback: ${feedbackController.text}');
                }
                
                if (decisions.isNotEmpty) {
                  buffer.writeln('\n--- DECISIONS ---');
                  for (final d in decisions) {
                    buffer.writeln('- [${d.type.displayName}] ${d.description}');
                  }
                }

                if (backlogUpdates.isNotEmpty) {
                   buffer.writeln('\n--- BACKLOG UPDATES ---');
                   for (final u in backlogUpdates) {
                     buffer.writeln('- $u');
                   }
                }
                
                Clipboard.setData(ClipboardData(text: buffer.toString()));
                ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(l10n.agileRecapCopied)),
                );
              },
              icon: const Icon(Icons.share, size: 16),
              label: Text(l10n.agileGenerateRecap),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(l10n.actionCancel),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () => Navigator.pop(context, true),
                  icon: const Icon(Icons.check),
                  label: Text(l10n.agileSaveReview),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final currentUser = project.participants[_currentUserEmail];

        // Convert story outcomes to StoryReviewOutcome list
        final storyOutcomesList = storyOutcomes.entries.map((entry) {
          final story = sprintStories.firstWhere(
            (s) => s.id == entry.key,
            orElse: () => _stories.firstWhere(
              (s) => s.id == entry.key,
              orElse: () => UserStoryModel.empty(),
            ),
          );
          return StoryReviewOutcome(
            storyId: entry.key,
            storyTitle: story.title,
            outcome: entry.value,
            storyPoints: story.storyPoints,
          );
        }).toList();

        // Recalculate metrics based on current outcomes
        final finalStoriesCompleted = storyOutcomesList.where((o) => o.outcome == ReviewOutcomeType.approved).length;
        final finalStoriesNotCompleted = storyOutcomesList.where((o) => o.outcome != ReviewOutcomeType.approved).length;
        final finalPointsCompleted = storyOutcomesList
            .where((o) => o.outcome == ReviewOutcomeType.approved)
            .fold<int>(0, (sum, o) => sum + (o.storyPoints ?? 0) as int);

        final sprintReview = SprintReview(
          date: DateTime.now(),
          conductedBy: _currentUserEmail,
          conductedByName: currentUser?.name ?? await UserProfileService().getNameByEmail(_currentUserEmail),
          attendees: attendees.where((a) => a.isPresent).map((a) => a.email).toList(),
          attendeesWithRoles: attendees.where((a) => a.isPresent).toList(),
          demoNotes: demoNotesController.text,
          feedback: feedbackController.text,
          backlogUpdates: backlogUpdates,
          nextSprintFocus: nextSprintFocusController.text,
          storiesCompleted: finalStoriesCompleted,
          storiesNotCompleted: finalStoriesNotCompleted,
          pointsCompleted: finalPointsCompleted,
          decisions: decisions,
          storyOutcomes: storyOutcomesList,
        );

        final updatedSprint = sprint.copyWith(
          sprintReview: sprintReview,
          // DO NOT update completedPoints here. It must be updated only at sprint completion
          // to preserve the original plannedPoints context.
        );
        await _firestoreService.updateSprint(project.id, updatedSprint);

        // NOTE: We do NOT move stories here anymore. 
        // Stories are moved only when the sprint is finalized (_finalizeSprintConfirm).
        // This ensures that "Needs Refinement" stories stay in the sprint until it is closed,
        // allowing metrics (like commitment reliability) to be calculated correctly.

        _showSuccess(l10n.agileSprintReviewSaveSuccess);
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
    final l10n = AppLocalizations.of(context)!;
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
          Container(
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ToggleButtons(
              isSelected: [
                currentOutcome == ReviewOutcomeType.approved,
                currentOutcome == ReviewOutcomeType.needsRefinement,
              ],
              onPressed: (index) {
                final newOutcome = index == 0
                    ? ReviewOutcomeType.approved
                    : ReviewOutcomeType.needsRefinement;
                onChanged(newOutcome);
              },
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: currentOutcome == ReviewOutcomeType.approved
                  ? Colors.green
                  : Colors.blue,
              color: Colors.grey[400],
              constraints: const BoxConstraints(minWidth: 40, minHeight: 32),
              children: [
                Tooltip(message: l10n.agileReviewApproved, child: const Icon(Icons.check, size: 18)),
                Tooltip(message: l10n.agileReviewRefinement, child: const Icon(Icons.refresh, size: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // ══════════════════════════════════════════════════════════════════════════
  // TAB 3: KANBAN
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildKanbanTab(AgileProjectModel project) {
    return AgileBoardWidget(
      project: project,
      sprints: _sprints,
      stories: _stories,
      teamMembers: _teamMembers.map((m) => m.email).toList(),
      canEdit: project.canEdit(_currentUserEmail),
      onStatusChange: (storyId, newStatus) {
        final story = _stories.firstWhere((s) => s.id == storyId);
        _updateStoryStatus(project, story, newStatus);
      },
      onStoryTap: (story) => _showStoryDetail(project, story, isBoardContext: true),
      onWipLimitChange: project.canConfigureBoard(_currentUserEmail)
          ? (colId, limit) => _updateColumnConfig(project, colId, wipLimit: limit, clearWip: limit == null)
          : null,
      onPoliciesChange: project.canConfigureBoard(_currentUserEmail)
          ? (colId, policies) => _updateColumnConfig(project, colId, policies: policies)
          : null,
      onAssigneeChange: (story, email) => _updateStoryAssignee(project, story, email),
      onStoryPointsChange: (story, points) => _updateStoryPoints(project, story, points),
      onTitleChange: (storyId, newTitle) => _updateStoryTitle(project, storyId, newTitle),
      onPriorityChange: (storyId, newPriority) => _updateStoryPriority(project, storyId, newPriority),
      onActivePoliciesChange: project.canConfigureBoard(_currentUserEmail)
          ? (colId, activePolicies, policySettings) => _updateColumnConfig(project, colId, activePolicies: activePolicies, policySettings: policySettings)
          : null,
      onStoryDelete: project.canDeleteStory(_currentUserEmail)
          ? (storyId) => _deleteStory(project, storyId)
          : null,
      canMoveToBacklog: project.canMoveToBacklog(_currentUserEmail),
      canMarkAsReady: project.canMarkAsReady(_currentUserEmail),
    );
  }

  Future<void> _updateColumnConfig(
    AgileProjectModel project,
    String columnId, {
    int? wipLimit,
    bool clearWip = false,
    List<String>? policies,
    Map<String, bool>? activePolicies,
    Map<String, dynamic>? policySettings,
  }) async {
    try {
      final currentCols = List<KanbanColumnConfig>.from(project.effectiveKanbanColumns);
      final index = currentCols.indexWhere((c) => c.id == columnId);

      if (index != -1) {
        currentCols[index] = currentCols[index].copyWith(
          wipLimit: wipLimit,
          clearWipLimit: clearWip,
          policies: policies,
          activePolicies: activePolicies,
          policySettings: policySettings,
        );

        await _firestoreService.updateProjectKanbanColumns(project.id, currentCols);
        _showSuccess('Configurazione board aggiornata');
      }
    } catch (e) {
      _showError('Errore aggiornamento colonne: $e');
    }
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
            framework: project.framework,
            onEdit: project.canChangeRoles(_currentUserEmail)
                ? (member) => _showMemberDetail(member)
                : null,
            onInvite: project.canInviteMembers(_currentUserEmail)
                ? () => _showInviteDialog(project)
                : null,
          ),
          const SizedBox(height: 24),
          // Team Capacity - Doppia vista: Story Points (Scrum) / Ore
          TeamCapacityWidget(
            teamMembers: _teamMembers,
            sprints: _sprints,
            stories: _stories,
            currentSprint: _sprints.where((s) => s.status.isActiveOrReview).firstOrNull,
            assignedHours: assignedHours,
            framework: widget.project.framework,
          ),
          const SizedBox(height: 24),

          // Team Workload - Distribuzione carico per persona
          TeamWorkloadWidget(
            teamMembers: _teamMembers,
            stories: _stories,
            currentSprint: _sprints.where((s) => s.status.isActiveOrReview).firstOrNull,
            framework: widget.project.framework,
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

    // Trova lo sprint attivo (include review)
    final activeSprint = _sprints.where((s) => s.status.isActiveOrReview).firstOrNull;

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
      framework: widget.project.framework,
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


  // ══════════════════════════════════════════════════════════════════════════
  // TAB 5: METRICS
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildMetricsTab(AgileProjectModel project) {
    final assignedHours = _calculateAssignedHours();
    final sortedSprints = List<SprintModel>.from(_sprints)
      ..sort((a, b) => a.endDate.compareTo(b.endDate));
    final activeSprint = sortedSprints.where((s) => s.status.isActiveOrReview).firstOrNull ??
                        (sortedSprints.isNotEmpty ? sortedSprints.last : null);
    final isKanban = project.framework == AgileFramework.kanban;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isKanban) ...[
             // Sprint Health Card (Status + ProgressPie + Goals)
             SprintHealthCardWidget(
              currentSprint: activeSprint,
              stories: _stories,
              sprints: _sprints,
            ),
            const SizedBox(height: 16),

            // Commitment Reliability Trend (Scrum specific)
            if (activeSprint != null) 
              CommitmentTrendWidget(
                sprints: _sprints,
              ),
            if (activeSprint != null) 
              const SizedBox(height: 16),
          ],

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flow Efficiency & WIP Analysis
              Expanded(
                child: FlowEfficiencyWidget(
                  stories: _stories,
                ),
              ),
              const SizedBox(width: 16),
              // Blocked Items
              Expanded(
                child: BlockedItemsWidget(
                  stories: _stories,
                  currentSprint: isKanban ? null : activeSprint,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Existing Metrics Dashboard (Generic/Adaptive)
          MetricsDashboardWidget(
            sprints: _sprints,
            stories: _stories,
            teamAssignedHours: assignedHours,
            framework: project.framework,
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 6: RETROSPECTIVE
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildRetroTab(AgileProjectModel project) {
    final lastCompletedSprint = _sprints
        .where((s) => s.status == SprintStatus.completed)
        .toList()
      ..sort((a, b) => b.endDate.compareTo(a.endDate));

    final latestSprint = lastCompletedSprint.isNotEmpty ? lastCompletedSprint.first : null;

    // Per Kanban: le retro si chiamano "Operations Review" e non richiedono sprint
    final isKanban = project.framework == AgileFramework.kanban;

    // Stream delle retrospettive con nuovo layout a 4 sub-tab
    return StreamBuilder<List<RetrospectiveModel>>(
      stream: _retrosStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final retrospectives = snapshot.data ?? [];

        return RetroTabSectionsWidget(
          projectId: project.id,
          retrospectives: retrospectives,
          currentUserEmail: _currentUserEmail,
          currentUserName: _currentUserName,
          onCreateNew: project.canManageRetrospectives(_currentUserEmail) 
              ? (isKanban
                  ? () => _createInteractiveRetro(project, null, sequenceNumber: retrospectives.length + 1)
                  : (latestSprint != null
                      ? () => _createInteractiveRetro(project, latestSprint!)
                      : () => _showNoSprintForRetroWarning()))
              : null,
          onTapRetro: (retro) {
            if (retro.isCompleted) {
              _showRetroDetail(retro);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RetroBoardScreen(
                    retroId: retro.id,
                    currentUserEmail: _currentUserEmail,
                    currentUserName: _currentUserName,
                  ),
                ),
              );
            }
          },
          onDeleteRetro: project.canManageRetrospectives(_currentUserEmail) 
              ? _confirmDeleteRetro 
              : null,
          sprints: _sprints,
        );
      },
    );
  }

  void _showRetroSummary(RetrospectiveModel retro) {
    showDialog(
      context: context,
      builder: (context) => RetroSummaryDialog(retro: retro),
    );
  }

  void _confirmDeleteRetro(RetrospectiveModel retro) {
    final l10n = AppLocalizations.of(context)!;
    final actionCount = retro.actionItems.length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red[400]),
            const SizedBox(width: 8),
            Text(l10n.retroDeleteTitle),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.retroDeleteConfirm(retro.title.isNotEmpty ? retro.title : retro.sprintName)),
            if (actionCount > 0) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.assignment_late, color: Colors.orange, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.retroDeleteActionItemsWarning(actionCount),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              l10n.actionIrreversible,
              style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.pop(context);
              try {
                await _retroService.deleteRetrospective(
                  retro.id,
                  userId: _currentUserEmail,
                  userName: _currentUserName,
                );
                messenger.showSnackBar(SnackBar(content: Text(l10n.retroDeletedSuccess)));
              } catch (e) {
                messenger.showSnackBar(SnackBar(content: Text('${l10n.stateError}: $e')));
              }
            },
            child: Text(l10n.actionDelete, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }


  Future<void> _showRetroCreationChoice(AgileProjectModel project, SprintModel sprint) async {
    final l10n = AppLocalizations.of(context)!;
    
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.retroChooseMode),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.flash_on, color: Colors.white),
              ),
              title: Text(l10n.retroQuickForm),
              subtitle: Text(l10n.retroQuickModeDesc),
              onTap: () => Navigator.pop(context, 'quick'),
            ),
            const Divider(),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.purple,
                child: Icon(Icons.groups, color: Colors.white),
              ),
              title: Text(l10n.retroInteractiveBoard),
              subtitle: Text(l10n.retroInteractiveModeDesc),
              onTap: () => Navigator.pop(context, 'interactive'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
        ],
      ),
    );

    if (choice == 'quick') {
      _showQuickRetroDialog(sprint);
    } else if (choice == 'interactive') {
      _createInteractiveRetro(project, sprint);
    }
  }

  Future<String?> _showRetroNameDialog(String defaultName) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: defaultName);

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nome Retrospettiva'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Titolo',
            hintText: 'Es. Retrospective Sprint 5',
          ),
          autofocus: MediaQuery.of(context).size.width > 600,
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Crea'),
          ),
        ],
      ),
    );
  }

  Future<void> _createInteractiveRetro(AgileProjectModel project, SprintModel? sprint, {int? sequenceNumber}) async {
    final l10n = AppLocalizations.of(context)!;

    // 1. Determine Default Name
    String defaultName;
    if (sprint != null) {
      defaultName = 'Retrospective - ${sprint.name}';
    } else {
      defaultName = 'Operations Review #${sequenceNumber ?? 1}'; // Kanban
    }

    // 2. Ask User for Name
    final customTitle = await _showRetroNameDialog(defaultName);
    if (customTitle == null || customTitle.isEmpty) return; // Cancelled

    try {
      setState(() => _isCreatingRetro = true);
      final now = DateTime.now();
      final retro = RetrospectiveModel(
        id: '',
        projectId: project.id,
        sprintId: sprint?.id,
        title: customTitle,
        sprintName: sprint != null ? sprint.name : customTitle, // Fallback/Legacy
        sprintNumber: sprint != null ? _sprints.indexOf(sprint) + 1 : (sequenceNumber ?? 0),
        createdAt: now,
        createdBy: _currentUserEmail,
        status: RetroStatus.active,
        currentPhase: RetroPhase.icebreaker,
        columns: RetroTemplateExt(RetroTemplate.startStopContinue).defaultColumns,
        items: [],
        actionItems: [],
        timer: RetroTimer(durationMinutes: 60),
      );

      final createdId = await _retroService.createRetrospective(retro);
      
      if (mounted) {
        _showSuccess(l10n.stateSuccess);
        // Navigate
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RetroBoardScreen(
              retroId: createdId,
              currentUserEmail: _currentUserEmail,
              currentUserName: _currentUserName,
            ),
          ),
        );
      }
    } catch (e) {
      _showError(l10n.errorSaving);
    } finally {
      if (mounted) {
        setState(() => _isCreatingRetro = false);
      }
    }
  }

  Future<void> _showRetroDetail(RetrospectiveModel retro) async {
    final l10n = AppLocalizations.of(context)!;
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
                  Text(l10n.scrumEventsRetro),
                  Text(
                    '${retro.title.isNotEmpty ? retro.title : l10n.retroSprintLabel(retro.sprintNumber, retro.sprintName)} - ${_formatDate(retro.createdAt)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            if (!retro.isCompleted)
              IconButton(
                icon: const Icon(Icons.launch, color: Colors.blue),
                tooltip: l10n.retroOpenInteractiveBoard,
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RetroBoardScreen(
                        retroId: retro.id,
                        currentUserEmail: _currentUserEmail,
                        currentUserName: _currentUserName,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
        insetPadding: const EdgeInsets.all(16),
        content: SizedBox(
          width: MediaQuery.of(context).size.width < 600
              ? MediaQuery.of(context).size.width * 0.85
              : 600,
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
                              Text(l10n.retroSentimentTeam, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                l10n.retroResultLabel(retro.averageSentiment!.toStringAsFixed(1), _getSentimentLabel(retro.averageSentiment!)),
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
                  l10n.retroWentWell,
                  retro.wentWell,
                  Icons.thumb_up,
                  Colors.green,
                ),
                const SizedBox(height: 16),

                // What to improve
                _buildRetroSection(
                  l10n.retroToImprove,
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
            child: Text(l10n.actionClose),
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.assignment_turned_in, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            Text(l10n.retroActionItemsLabel, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 8),
        if (items.isEmpty)
          Text(l10n.retroNoActionItemsFound, style: TextStyle(color: Colors.grey[500], fontStyle: FontStyle.italic))
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
                  ? Text(l10n.retroAssignedTo(item.assigneeEmail!))
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
    final l10n = AppLocalizations.of(context)!;
    if (sentiment >= 4.5) return l10n.retroExcellent;
    if (sentiment >= 4) return l10n.retroGood;
    if (sentiment >= 3) return l10n.retroNormal;
    if (sentiment >= 2) return l10n.retroNeedsImprovement;
    return l10n.retroCritical;
  }

  Future<void> _showQuickRetroDialog(SprintModel sprint) async {
    final l10n = AppLocalizations.of(context)!;
    // Dialog per creare una nuova retrospettiva rapida
    final wentWell = <String>[];
    final toImprove = <String>[];
    final actionItems = <String>[];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.flash_on, color: Colors.blue),
              const SizedBox(width: 8),
              Expanded(child: Text('${l10n.retroQuickForm} - ${sprint.name}')),
            ],
          ),
          insetPadding: const EdgeInsets.all(16),
          content: SizedBox(
            width: MediaQuery.of(context).size.width < 600
                ? MediaQuery.of(context).size.width * 0.85
                : 600,
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // What went well
                  _buildRetroInput(
                    l10n.retroWentWell,
                    l10n.retroWentWellHint,
                    Icons.thumb_up,
                    Colors.green,
                    wentWell,
                    (value) => setState(() => wentWell.add(value)),
                    (index) => setState(() => wentWell.removeAt(index)),
                  ),
                  const SizedBox(height: 24),

                  // What to improve
                  _buildRetroInput(
                    l10n.retroToImprove,
                    l10n.retroToImproveHint,
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
                    l10n.retroActionItemHint,
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
              child: Text(l10n.actionCancel),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.save),
              label: Text(l10n.retroSave),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final now = DateTime.now();
        
        // Costruisci le colonne usando il template Quick Form
        const template = RetroTemplate.quickForm;
        final columns = template.defaultColumns;
        
        // In Quick Form:
        // columns[0].id is 'went_well'
        // columns[1].id is 'improve'
        final col1Id = columns[0].id;
        final col2Id = columns[1].id;

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

        // Crea il modello completo
        final retro = RetrospectiveModel(
          id: '', // Verrà generato dal servizio
          projectId: widget.project.id,
          sprintId: sprint.id,
          sprintName: sprint.name,
          sprintNumber: _sprints.indexOf(sprint) + 1,
          createdAt: now,
          createdBy: _currentUserEmail,
          status: RetroStatus.completed,
          currentPhase: RetroPhase.completed,
          isCompleted: true,
          template: template,
          columns: columns,
          items: [...wentWellItems, ...toImproveItems],
          actionItems: updatedActionItemsList,
          timer: const RetroTimer(durationMinutes: 0, isRunning: false),
        );

        // Salva usando il service corretto (Root Collection)
        await _retroService.createRetrospective(retro);

        _showSuccess(l10n.stateSuccess);
      } catch (e) {
        _showError('${l10n.stateError}: $e');
      }
    }
  }





  // ══════════════════════════════════════════════════════════════════════════
  // FAB
  // ══════════════════════════════════════════════════════════════════════════
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


  Widget? _buildFab(AgileProjectModel project) {
    final l10n = AppLocalizations.of(context)!;
    // FAB diverso in base alla tab
    switch (_tabController.index) {
      case 0: // Backlog
        // SCRUM: Backlog has its own "New Story" button, so FAB is redundant
        if (project.framework == AgileFramework.scrum) {
          return null;
        }
        // KANBAN/HYBRID: Keep FAB for quick access
        if (project.canCreateStory(_currentUserEmail)) {
          return FloatingActionButton.extended(
            onPressed: () => _showCreateStoryDialog(project),
            icon: const Icon(Icons.add),
            label: const Text('Nuova Story'),
          );
        }
        return null;
      case 1: // Sprint
        // SCRUM: User requested to remove "New Sprint" FAB, use header/menu actions instead
        if (project.framework == AgileFramework.scrum) {
          return null;
        }
        return null;
      case 3: // Team
        return FloatingActionButton.extended(
          onPressed: () => _showInviteDialog(project),
          icon: const Icon(Icons.person_add),
          label: Text(l10n.actionInviteMember),
        );
      default:
        return null;
    }
  }

  Widget _buildAppBarTitle(AgileProjectModel project, AppLocalizations l10n) {
    if (project.framework != AgileFramework.scrum) {
      return Text(project.name, overflow: TextOverflow.ellipsis);
    }

    // Find active or planning sprint for status indicator
    final activeSprint = _sprints.where((s) => s.status.isActiveOrReview).firstOrNull;
    final planningSprint = activeSprint == null ? _sprints.where((s) => s.status == SprintStatus.planning).firstOrNull : null;

    if (activeSprint == null && planningSprint == null) {
      return Text(project.name, overflow: TextOverflow.ellipsis);
    }

    // Status Indicator Logic
    Color statusColor;
    String statusText;

    if (activeSprint == null && planningSprint != null) {
      // Planning phase
      statusColor = Colors.blue;
      statusText = 'Planning';
      return _buildHeaderWithStatus(project.name, planningSprint.name, statusText, statusColor);
    }

    if (activeSprint == null) return Text(project.name, overflow: TextOverflow.ellipsis);
    
    final now = DateTime.now();
    final endDate = activeSprint.endDate;
    // Normalized to midnight for consistent comparison
    final today = DateTime(now.year, now.month, now.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);
    final daysRemaining = end.difference(today).inDays;

    if (activeSprint.status == SprintStatus.review) {
      // Review
      statusColor = Colors.orange;
      statusText = 'Review';
      if (today.isAfter(end)) {
         statusColor = Colors.red; // Overdue review
      }
    } else if (today.isAfter(end)) {
      // Active but Overdue
      statusColor = Colors.red;
      statusText = 'Overdue';
    } else if (daysRemaining <= 3) {
      // Active ending soon
      statusColor = Colors.orange;
      statusText = '${daysRemaining}d left';
    } else {
      // Active healthy
      statusColor = Colors.green;
      statusText = 'Active';
    }

    return _buildHeaderWithStatus(project.name, activeSprint.name, statusText, statusColor);
  }

  Widget _buildHeaderWithStatus(String projectName, String sprintName, String statusText, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(projectName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                '$sprintName • $statusText',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // EXPORT
  // ══════════════════════════════════════════════════════════════════════════


  Future<void> _showExportDialog() async {
    final l10n = AppLocalizations.of(context)!;
    await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.actionExportCsv),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _exportAllData();
            },
            child: const ListTile(
              leading: Icon(Icons.download_for_offline, color: Colors.indigo),
              title: Text('Export All Data'),
              subtitle: Text('Backlog, Sprints, Team, Kanban, Metrics'),
            ),
          ),
          const Divider(),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _exportBacklog();
            },
            child: const ListTile(
              leading: Icon(Icons.list_alt, color: Colors.blue),
              title: Text('Export Backlog'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _exportSprints();
            },
            child: const ListTile(
              leading: Icon(Icons.directions_run, color: Colors.green),
              title: Text('Export Sprints'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _exportTeam();
            },
            child: const ListTile(
              leading: Icon(Icons.people, color: Colors.purple),
              title: Text('Export Team'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _exportKanban();
            },
            child: const ListTile(
              leading: Icon(Icons.view_column, color: Colors.orange),
              title: Text('Export Kanban'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _exportMetrics();
            },
            child: const ListTile(
              leading: Icon(Icons.insights, color: Colors.teal),
              title: Text('Export Metrics'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportBacklog() async {
    try {
      await _csvService.exportBacklogToCsv(widget.project.name, _stories);
      _showSuccess('Backlog esportato!');
    } catch (e) {
      _showError('Errore export: $e');
    }
  }

  Future<void> _exportSprints() async {
    try {
      await _csvService.exportSprintsToCsv(widget.project.name, _sprints, _stories);
      _showSuccess('Sprints esportati!');
    } catch (e) {
      _showError('Errore export: $e');
    }
  }

  Future<void> _exportTeam() async {
    try {
      await _csvService.exportTeamToCsv(widget.project.name, _teamMembers);
      _showSuccess('Team esportato!');
    } catch (e) {
      _showError('Errore export: $e');
    }
  }

  Future<void> _exportKanban() async {
    try {
      await _csvService.exportKanbanToCsv(widget.project.name, _stories);
      _showSuccess('Kanban esportato!');
    } catch (e) {
      _showError('Errore export: $e');
    }
  }

  Future<void> _exportMetrics() async {
    try {
      await _csvService.exportMetricsToCsv(widget.project.name, _sprints, _stories);
      _showSuccess('Metrics esportato!');
    } catch (e) {
      _showError('Errore export: $e');
    }
  }

  Future<void> _exportAllData() async {
    try {
      await _csvService.exportAllDataToCsv(
        widget.project.name,
        _stories,
        _sprints,
        _teamMembers,
      );
      _showSuccess('Export completo riuscito!');
    } catch (e) {
      _showError('Errore export: $e');
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

  Widget _buildReviewRecapSection(BuildContext context, SprintReview review) {
    final l10n = AppLocalizations.of(context)!;
    final outcomes = review.storyOutcomes;
    final approved = outcomes.where((o) => o.outcome == ReviewOutcomeType.approved).toList();
    final refinement = outcomes.where((o) => o.outcome == ReviewOutcomeType.needsRefinement || o.outcome == ReviewOutcomeType.rejected).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.agileReviewRecapTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 8),
        if (approved.isNotEmpty)
          _buildOutcomeGroup(
              context, l10n.agileReviewApproved, approved, Colors.green, Icons.check_circle_outline),
        if (refinement.isNotEmpty)
          _buildOutcomeGroup(
              context, l10n.agileReviewRefinement, refinement, Colors.orange, Icons.refresh),
      ],
    );
  }

  Widget _buildOutcomeGroup(BuildContext context, String title, List<StoryReviewOutcome> stories,
      Color color, IconData icon) {
    final l10n = AppLocalizations.of(context)!;
    final totalPoints =
        stories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        visualDensity: VisualDensity.compact,
        shape: const Border(),
        leading: Icon(icon, color: color, size: 20),
        title: Row(
          children: [
            Text(title,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('${stories.length}',
                  style: TextStyle(
                      color: color, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
            const Spacer(),
            if (totalPoints > 0)
              Text(l10n.agilePointsValue(totalPoints),
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        children: [
          ...stories.map((s) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(s.storyTitle,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis)),
                    if (s.storyPoints != null) ...[
                      const SizedBox(width: 8),
                      Text(l10n.agilePointsValue(s.storyPoints!),
                          style: TextStyle(
                              fontSize: 11,
                              color: color.withValues(alpha: 0.8))),
                    ]
                  ],
                ),
              )),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  /// Mostra il dialog delle impostazioni del progetto
}

