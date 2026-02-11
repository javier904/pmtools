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
          // Conta quanti item ha già l'assignee in questa colonna
          final assigneeStories = columnStories.where((s) => s.assigneeEmail == story.assigneeEmail && s.id != story.id).length;
          if (assigneeStories >= 1) {
             return KanbanPolicyViolation(
              policyId: policyId,
              message: l10n.kanbanPolicyMax1PerPerson,
              isBlocking: false, // Può essere soft
            );
          }
        }
        break;
        
      case 'kanbanPolicyAllAcceptanceMet':
        if (story.acceptanceCriteria.isNotEmpty) {
          final completed = story.completedAcceptanceCriteria;
          final total = story.acceptanceCriteria.length;
          if (completed < total) {
            return KanbanPolicyViolation(
              policyId: policyId,
              message: l10n.kanbanPolicyAllAcceptanceMet,
              isBlocking: false, 
            );
          }
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
    
    final daysInStatus = DateTime.now().difference(story.statusChangedAt!).inHours / 24.0;
    
    if (column.isPolicyActive('kanbanPolicyMax2Days')) {
      if (daysInStatus > 2.0) {
        return KanbanPolicyViolation(
          policyId: 'kanbanPolicyMax2Days',
          message: l10n.kanbanPolicyMax2Days,
          isBlocking: false,
        );
      }
    }
    
    if (column.isPolicyActive('kanbanPolicyMax24h')) {
      if (daysInStatus > 1.0) {
        return KanbanPolicyViolation(
          policyId: 'kanbanPolicyMax24h',
          message: l10n.kanbanPolicyMax24h,
          isBlocking: false,
        );
      }
    }
    
    return null;
  }
}
