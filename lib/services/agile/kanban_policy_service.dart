import 'package:agile_tools/models/user_story_model.dart';
import 'package:agile_tools/models/framework_features.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Rappresenta una violazione di una policy Kanban
class KanbanPolicyViolation {
  final String policyId;
  final String message;
  final bool isBlocking; // true = deve risolvere; false = warning

  const KanbanPolicyViolation({
    required this.policyId,
    required this.message,
    this.isBlocking = false,
  });
}

/// Servizio per la validazione attiva delle policy Kanban
class KanbanPolicyService {
  final AppLocalizations l10n;

  KanbanPolicyService(this.l10n);

  /// Valida lo spostamento di una story verso una nuova colonna
  List<KanbanPolicyViolation> validateMove(
    UserStoryModel story,
    KanbanColumnConfig targetColumn,
    List<UserStoryModel> columnStories, // Storie già presenti nella colonna target
  ) {
    final violations = <KanbanPolicyViolation>[];

    // Itera sulle policy attive della colonna
    if (targetColumn.activePolicies != null) {
      targetColumn.activePolicies!.forEach((policyId, isActive) {
        if (isActive) {
          final violation = _checkPolicy(policyId, story, targetColumn, columnStories);
          if (violation != null) {
            violations.add(violation);
          }
        }
      });
    }

    return violations;
  }

  /// Verifica una singola policy
  KanbanPolicyViolation? _checkPolicy(
    String policyId,
    UserStoryModel story,
    KanbanColumnConfig targetColumn,
    List<UserStoryModel> columnStories,
  ) {
    switch (policyId) {
      case 'kanbanPolicyReqAcceptance':
        if (story.acceptanceCriteria.isEmpty) {
          return KanbanPolicyViolation(
            policyId: policyId,
            message: l10n.kanbanPolicyReqAcceptance, // Usare una chiave specifica per errore se necessario
            isBlocking: false, // Soft enforcement
          );
        }
        break;

      case 'kanbanPolicyEstimationsDone':
        // Consideriamo stimata se ha storyPoints o se isEstimated è true
        if (story.storyPoints == null && !story.isEstimated) {
           return KanbanPolicyViolation(
            policyId: policyId,
            message: l10n.kanbanPolicyEstimationsDone,
            isBlocking: false,
          );
        }
        break;

      case 'kanbanPolicyMax1PerPerson':
        if (story.assigneeEmail != null) {
          // Get custom limit from settings (default to 1)
          final limit = targetColumn.getPolicySetting('maxItemsPerPerson', 1);
          
          // Conta quanti item ha già l'assignee in questa colonna
          final assigneeStories = columnStories.where((s) => s.assigneeEmail == story.assigneeEmail && s.id != story.id).length;
          if (assigneeStories >= limit) {
             return KanbanPolicyViolation(
              policyId: policyId,
              message: l10n.kanbanPolicyMax1PerPersonParam(limit),
              isBlocking: false, // Può essere soft
            );
          }
        }
        break;
        
      case 'kanbanPolicyAllAcceptanceMet':
        // Policy: "All acceptance criteria met"
        // If there are no criteria, it's a violation because you can't meet "all" of nothing in a completion context
        if (story.acceptanceCriteria.isEmpty) {
          return KanbanPolicyViolation(
            policyId: policyId,
            message: l10n.kanbanPolicyAllAcceptanceMet,
            isBlocking: false,
          );
        }
        
        final completed = story.completedAcceptanceCriteria;
        final total = story.acceptanceCriteria.length;
        if (completed < total) {
          return KanbanPolicyViolation(
            policyId: policyId,
            message: l10n.kanbanPolicyAllAcceptanceMet,
            isBlocking: false, 
          );
        }
        break;
        
      // Policy che non possono essere controllate allo spostamento (es. Time limits si controllano su card esistenti)
      // o che richiedono logica manuale (Item Ready) sono ignorate qui.
    }
    return null;
  }
  
  /// Controlla violazioni "passive" per card che sono ferme in colonna (Time policies)
  KanbanPolicyViolation? checkTimePolicy(
    UserStoryModel story,
    KanbanColumnConfig column,
  ) {
    if (story.statusChangedAt == null) return null;
    
    final hoursInStatus = DateTime.now().difference(story.statusChangedAt!).inHours.toDouble();
    
    // Helper to generic temporal check
    KanbanPolicyViolation? check(String policyId, int defaultHours) {
      if (column.isPolicyActive(policyId)) {
        final maxHours = column.getPolicySetting('maxHours', defaultHours);
        final unit = column.getPolicySetting('maxHoursUnit', 'hours');
        
        if (hoursInStatus > maxHours) {
          final String message;
          if (unit == 'days') {
            final days = (maxHours / 24).round();
            message = l10n.kanbanPolicyMaxDaysParam(days);
          } else {
            message = l10n.kanbanPolicyMaxHoursParam(maxHours);
          }
          
          return KanbanPolicyViolation(
            policyId: policyId,
            message: message,
            isBlocking: false,
          );
        }
      }
      return null;
    }

    final v2Days = check('kanbanPolicyMax2Days', 48);
    if (v2Days != null) return v2Days;

    final v24h = check('kanbanPolicyMax24h', 24);
    if (v24h != null) return v24h;
    
    return null;
  }
}
