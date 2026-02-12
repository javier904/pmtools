import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/widgets/retrospective/retro_board_widget.dart';

/// Widget that shows the "Active" section in the retrospective tab.
///
/// Displays either:
/// - The currently active/draft retrospective with a card to access it
/// - A button to create a new retrospective if none is active
class RetroActiveSectionWidget extends StatelessWidget {
  final List<RetrospectiveModel> retrospectives;
  final String currentUserEmail;
  final VoidCallback? onCreateNew;
  final Function(RetrospectiveModel) onTapRetro;
  final Function(RetrospectiveModel)? onDeleteRetro;

  const RetroActiveSectionWidget({
    super.key,
    required this.retrospectives,
    required this.currentUserEmail,
    this.onCreateNew,
    required this.onTapRetro,
    this.onDeleteRetro,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Filter retrospectives to find active or draft ones
    final activeRetros = retrospectives.where(
      (retro) => retro.status == RetroStatus.active || retro.status == RetroStatus.draft,
    ).toList();

    final activeRetro = activeRetros.isNotEmpty ? activeRetros.first : null;

    if (activeRetro != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (activeRetros.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.amber.shade700),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.warning_amber_rounded, size: 16, color: Colors.amber.shade700),
                          const SizedBox(width: 8),
                          Text(
                            'Found ${activeRetros.length} active retrospectives. Showing the most recent.',
                            style: TextStyle(color: Colors.amber.shade900, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                _buildActiveRetroCard(context, activeRetro, l10n),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: RetroBoardWidget(
              retro: activeRetro,
              currentUserEmail: currentUserEmail,
              currentUserName: currentUserEmail.split('@').first,
              isIncognito: false,
            ),
          ),
        ],
      );
    } else {
      return _buildEmptyState(context, l10n);
    }
  }

  Widget _buildActiveRetroCard(
    BuildContext context,
    RetrospectiveModel retro,
    AppLocalizations l10n,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(retro.template.icon, size: 32, color: colorScheme.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        retro.template.displayName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (retro.sprintName.isNotEmpty)
                        Text(
                          'Sprint: ${retro.sprintName}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
                if (onDeleteRetro != null)
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red[400]),
                    tooltip: l10n.actionDelete,
                    onPressed: () => onDeleteRetro!(retro),
                  ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => onTapRetro(retro),
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(l10n.retroContinueAction),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${l10n.retroCurrentPhase}: ${retro.currentPhase.name}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.people, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${retro.participantEmails.length} ${l10n.retroParticipantsLabel}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 48),
          Icon(Icons.add_circle_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            l10n.retroNoRetrosFound,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          const SizedBox(height: 24),
          if (onCreateNew != null)
            ElevatedButton.icon(
              onPressed: onCreateNew,
              icon: const Icon(Icons.add),
              label: Text(l10n.retroCreateNew),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
        ],
      ),
    );
  }
}
