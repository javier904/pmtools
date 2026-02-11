import 'package:flutter/material.dart';
import '../../models/agile_project_model.dart';
import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../models/framework_features.dart'; // Import FrameworkFeatures
import 'kanban_board_widget.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Widget wrapper per la board Agile che gestisce la logica specifica del framework.
/// 
/// - Scrum: Mostra solo le stories dello Sprint Attivo.
/// - Kanban: Mostra tutte le stories attive (flusso continuo).
/// - Hybrid: Configurale.
class AgileBoardWidget extends StatelessWidget {
  final AgileProjectModel project;
  final List<SprintModel> sprints;
  final List<UserStoryModel> stories;
  final List<String> teamMembers; // Email list
  final bool canEdit;
  
  // Callbacks
  final void Function(String storyId, StoryStatus newStatus)? onStatusChange;
  final void Function(UserStoryModel story)? onStoryTap;
  final void Function(String columnId, int? newLimit)? onWipLimitChange;
  final void Function(String columnId, List<String> policies)? onPoliciesChange;
  final void Function(String columnId, Map<String, bool> activePolicies)? onActivePoliciesChange;
  final void Function(UserStoryModel story, String? email)? onAssigneeChange;
  final void Function(UserStoryModel story, int? points)? onStoryPointsChange;
  final void Function(String storyId, String newTitle)? onTitleChange;
  final void Function(String storyId, StoryPriority newPriority)? onPriorityChange;

  const AgileBoardWidget({
    super.key,
    required this.project,
    required this.sprints,
    required this.stories,
    this.teamMembers = const [],
    this.canEdit = true,
    this.onStatusChange,
    this.onStoryTap,
    this.onWipLimitChange,
    this.onPoliciesChange,
    this.onActivePoliciesChange,
    this.onAssigneeChange,
    this.onStoryPointsChange,
    this.onTitleChange,
    this.onPriorityChange,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // 1. Determina le stories da mostrare
    final visibleStories = _getVisibleStories();
    
    // 2. Determina le colonne da mostrare
    // Usa le colonne configurate nel progetto o i default del framework
    final columns = project.effectiveKanbanColumns;

    // Se Scrum e non c'è sprint attivo, mostra placeholder
    if (project.framework == AgileFramework.scrum && _activeSprint == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              l10n.agileNoActiveSprint,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(l10n.agileStartSprintHint),
          ],
        ),
      );
    }

    return KanbanBoardWidget(
      stories: visibleStories,
      columns: columns,
      framework: project.framework,
      onStatusChange: onStatusChange,
      onStoryTap: onStoryTap,
      onWipLimitChange: onWipLimitChange,
      onPoliciesChange: onPoliciesChange,
      onActivePoliciesChange: onActivePoliciesChange,
      onAssigneeChange: onAssigneeChange,
      onStoryPointsChange: onStoryPointsChange,
      onTitleChange: onTitleChange,
      onPriorityChange: onPriorityChange,
      // Swimlane configurable logic could be added here
      swimlaneType: SwimlaneType.none, // Default for now
      canEdit: canEdit,
      showWipConfig: project.framework != AgileFramework.scrum, // Scrum di solito non ha WIP strict
      showPolicies: true,
      teamMembers: teamMembers,
      sprints: sprints,
    );
  }

  /// Recupera lo sprint attivo (se esiste)
  SprintModel? get _activeSprint {
    return sprints.where((s) => s.status == SprintStatus.active).firstOrNull;
  }

  List<UserStoryModel> _getVisibleStories() {
    switch (project.framework) {
      case AgileFramework.scrum:
        // SCRUM: Solo stories dello sprint attivo
        final active = _activeSprint;
        if (active == null) return [];
        return stories.where((s) => s.sprintId == active.id).toList();

      case AgileFramework.kanban:
        // KANBAN: Tutte le stories attive (non archiviate/completate da tempo)
        // KanbanBoardWidget si occupa di mappare alle colonne.
        // Qui filtriamo solo quelle che hanno senso visualizzare (es. non il backlog profondo se c'è una colonna backlog)
        // Ma se la board ha una colonna Backlog, le mostriamo tutte.
        // Generalmente Kanban board mostra tutto ciò che è nel flusso.
        return stories;

      case AgileFramework.hybrid:
        // HYBRID: Dipende dalla config. Spesso come Kanban ma con swimlanes per sprint.
        // Per ora mostriamo tutte, eventualmente filtrando per sprint se l'utente usa sprint.
        return stories;
    }
  }
}
