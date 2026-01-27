import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/models/retro_methodology_guide.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Widget che guida il facilitatore nella raccolta delle azioni
/// Mostra:
/// - Coverage status per ogni colonna (quali hanno azioni, quali no)
/// - Ordine suggerito di raccolta per la metodologia
/// - Alert se mancano azioni per colonne richieste
/// - Suggerimenti contestuali per la prossima azione
class ActionCollectionGuideWidget extends StatelessWidget {
  final RetrospectiveModel retro;
  final VoidCallback? onColumnTap;

  const ActionCollectionGuideWidget({
    Key? key,
    required this.retro,
    this.onColumnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final collectionOrder = RetroMethodologyGuide.getActionCollectionOrder(retro.template);
    final requiredColumns = RetroMethodologyGuide.getRequiredActionColumns(retro.template);

    // Calculate coverage
    final columnsWithActions = _getColumnsWithActions();
    final missingRequired = requiredColumns.where((id) => !columnsWithActions.contains(id)).toList();
    final isComplete = missingRequired.isEmpty;

    // Find next suggested column
    String? nextSuggestedColumn;
    for (final columnId in collectionOrder) {
      if (!columnsWithActions.contains(columnId)) {
        nextSuggestedColumn = columnId;
        break;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      // Styling: Minimalist, no strong borders or backgrounds
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
         _buildHeader(context, l10n, isComplete, missingRequired),

          // Divider
          Divider(height: 1, color: Colors.grey.withValues(alpha: 0.2)),

          // Collection Order
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rationale
                Text(
                  RetroMethodologyGuide.getCollectionOrderRationale(l10n, retro.template),
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).textTheme.bodySmall?.color, // Use theme color for visibility in Light/Dark
                  ),
                ),
                const SizedBox(height: 12),

                // Column chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: collectionOrder.map((columnId) {
                    final column = retro.columns.where((c) => c.id == columnId).firstOrNull;
                    if (column == null) return const SizedBox.shrink();

                    final hasAction = columnsWithActions.contains(columnId);
                    final isRequired = requiredColumns.contains(columnId);
                    final isNext = columnId == nextSuggestedColumn;

                    return _buildColumnChip(
                      context,
                      l10n,
                      column,
                      hasAction,
                      isRequired,
                      isNext,
                    );
                  }).toList(),
                ),

                // Next suggestion or completion message
                const SizedBox(height: 12),
                if (!isComplete && nextSuggestedColumn != null)
                  _buildNextSuggestion(context, l10n, nextSuggestedColumn)
                else if (isComplete)
                  _buildCompletionMessage(context, l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n, bool isComplete, List<String> missingRequired) {
    final missingCount = missingRequired.length;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            isComplete ? Icons.check_circle : Icons.lightbulb_outline,
            color: isComplete ? Colors.green : Colors.amber, // Keep lightbulb amber as requested, only changed badge
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.facilitatorGuideTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // Use default text color for better harmony
                color: Theme.of(context).textTheme.titleSmall?.color, 
              ),
            ),
          ),
            // Coverage badge
          Tooltip(
            message: missingCount > 0 
                ? '${l10n.facilitatorGuideMissing}: ${missingRequired.map((id) => RetroMethodologyGuide.getColumnTitle(l10n, retro.template, id, id)).join(", ")}'
                : l10n.facilitatorGuideAllCovered,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isComplete
                  ? Colors.green.withValues(alpha: 0.2)
                  : Colors.deepOrange.withValues(alpha: 0.15), // DeepOrange: visible but less aggressive than Red
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isComplete ? Icons.check : Icons.warning_amber_rounded,
                    size: 14,
                    color: isComplete ? Colors.green : Colors.deepOrange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isComplete
                      ? l10n.facilitatorGuideComplete
                      : '${l10n.facilitatorGuideIncomplete} ($missingCount)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isComplete ? Colors.green : Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnChip(
    BuildContext context,
    AppLocalizations l10n,
    RetroColumn column,
    bool hasAction,
    bool isRequired,
    bool isNext,
  ) {
    // If it's the next suggested column, use its own color for emphasis, but keep it harmonious.
    // Avoid yellow/amber outlines which might be hard to read or look like warnings.
    final baseColor = column.color;

    return Tooltip(
      message: hasAction
        ? l10n.facilitatorGuideColumnHasAction
        : '${l10n.facilitatorGuideColumnNoAction} - ${isRequired ? l10n.facilitatorGuideRequired : l10n.facilitatorGuideOptional}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: hasAction
            ? baseColor.withValues(alpha: 0.2)
            : isNext
              ? baseColor.withValues(alpha: 0.1) // Use column color instead of Amber
              : Colors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasAction
              ? baseColor.withValues(alpha: 0.5)
              : isNext
                ? baseColor.withValues(alpha: 0.5) // Use column color for border too
                : Colors.grey.withValues(alpha: 0.2),
            width: isNext ? 1.5 : 1, // Slight emphasis for next
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status icon
            Icon(
              hasAction ? Icons.check_circle : (isNext ? Icons.arrow_forward_ios_rounded : Icons.radio_button_unchecked),
              size: 14,
              color: hasAction || isNext ? baseColor : Colors.grey, // Icon follows column color
            ),
            const SizedBox(width: 6),
            // Column name
            Text(
              // Use localized title helper
              RetroMethodologyGuide.getColumnTitle(l10n, retro.template, column.id, column.title),
              style: TextStyle(
                fontSize: 12,
                fontWeight: hasAction || isNext ? FontWeight.w600 : FontWeight.normal,
                color: hasAction || isNext ? baseColor : context.textMutedColor,
              ),
            ),
            // Required badge
            if (isRequired && !hasAction) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8), 
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '!',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.white, 
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNextSuggestion(BuildContext context, AppLocalizations l10n, String columnId) {
    final column = retro.columns.where((c) => c.id == columnId).firstOrNull;
    if (column == null) return const SizedBox.shrink();

    final suggestion = RetroMethodologyGuide.getMissingColumnSuggestion(l10n, retro.template, columnId);

    // Styling: Minimalist, removed yellow box. Just icon + text.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
         // No border, no background color (or very subtle if needed)
         borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Keep the lightbulb yellow as requested ("solo la lampadina a sinistra gialla")
          Icon(Icons.lightbulb_outline, color: Colors.amber.shade700, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${l10n.facilitatorGuideNextColumn} ',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyMedium?.color, // Neutral text color
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: column.color.withValues(alpha: 0.2), // Column-colored badge
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        RetroMethodologyGuide.getColumnTitle(l10n, retro.template, column.id, column.title),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: column.color, // Column text color
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  suggestion,
                  style: TextStyle(
                    fontSize: 12,
                    // Slightly muted text for the explanation
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionMessage(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.celebration, color: Colors.green.shade700, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.facilitatorGuideAllCovered,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.green.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the set of column IDs that have at least one action item
  Set<String> _getColumnsWithActions() {
    final columnsWithActions = <String>{};
    for (final action in retro.actionItems) {
      if (action.sourceColumnId != null && action.sourceColumnId!.isNotEmpty) {
        columnsWithActions.add(action.sourceColumnId!);
      }
    }
    return columnsWithActions;
  }
}
