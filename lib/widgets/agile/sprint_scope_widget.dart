import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../themes/app_colors.dart';

/// Sprint Scope Changes Widget
///
/// Compares the sprint's original planned SP vs the current total SP
/// of stories in the sprint, showing scope creep or reduction.
class SprintScopeWidget extends StatelessWidget {
  final SprintModel? currentSprint;
  final List<UserStoryModel> stories;

  const SprintScopeWidget({
    super.key,
    required this.currentSprint,
    required this.stories,
  });

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  int _currentSP(SprintModel sprint) {
    return stories
        .where((s) => sprint.storyIds.contains(s.id))
        .fold<int>(0, (acc, s) => acc + (s.storyPoints ?? 0));
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    if (currentSprint == null) {
      return _buildEmptyState(l10n, theme);
    }

    return _buildCard(currentSprint!, l10n, theme);
  }

  Widget _buildEmptyState(AppLocalizations l10n, ThemeData theme) {
    return Card(
      color: theme.colorScheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.track_changes,
              size: 48,
              color: theme.colorScheme.onSurface.withOpacity(0.38),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.agileSprintScopeNoSprint,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.agileSprintScopeNoSprintDesc,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    SprintModel sprint,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final originalSP = sprint.plannedPoints;
    final currentSP = _currentSP(sprint);
    final delta = currentSP - originalSP;

    return Card(
      color: theme.colorScheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(delta, l10n, theme),
            const SizedBox(height: 16),
            // Bars
            _buildBars(originalSP, currentSP, l10n, theme),
            const SizedBox(height: 16),
            // Metrics row
            _buildMetricsRow(originalSP, currentSP, delta, l10n, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int delta, AppLocalizations l10n, ThemeData theme) {
    String badgeLabel;
    Color badgeColor;

    if (delta == 0) {
      badgeLabel = l10n.agileSprintScopeStable;
      badgeColor = AppColors.success;
    } else if (delta > 0) {
      badgeLabel = '${l10n.agileSprintScopeCreep} +$delta ${l10n.agileSprintScopeSp}';
      badgeColor = AppColors.warning;
    } else {
      badgeLabel =
          '${l10n.agileSprintScopeReduction} $delta ${l10n.agileSprintScopeSp}';
      badgeColor = AppColors.secondary;
    }

    return Row(
      children: [
        Icon(
          Icons.track_changes,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            l10n.agileSprintScopeTitle,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: badgeColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            badgeLabel,
            style: theme.textTheme.labelSmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBars(
    int originalSP,
    int currentSP,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final maxSP = originalSP > currentSP ? originalSP : currentSP;
    final originalFrac = maxSP > 0 ? originalSP / maxSP : 0.0;
    final currentFrac = maxSP > 0 ? currentSP / maxSP : 0.0;

    Color currentBarColor;
    if (currentSP <= originalSP) {
      currentBarColor = AppColors.success;
    } else if (currentSP <= originalSP * 1.2) {
      currentBarColor = AppColors.warning;
    } else {
      currentBarColor = AppColors.error;
    }

    return Column(
      children: [
        // Original bar
        _buildBar(
          label: l10n.agileSprintScopeOriginal,
          value: '$originalSP ${l10n.agileSprintScopeSp}',
          fraction: originalFrac,
          color: AppColors.secondary,
          theme: theme,
        ),
        const SizedBox(height: 10),
        // Current bar
        _buildBar(
          label: l10n.agileSprintScopeCurrent,
          value: '$currentSP ${l10n.agileSprintScopeSp}',
          fraction: currentFrac,
          color: currentBarColor,
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildBar({
    required String label,
    required String value,
    required double fraction,
    required Color color,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 12,
            child: Stack(
              children: [
                // Background
                Container(
                  color: theme.colorScheme.onSurface.withOpacity(0.06),
                ),
                // Filled
                FractionallySizedBox(
                  widthFactor: fraction.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsRow(
    int originalSP,
    int currentSP,
    int delta,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      children: [
        _buildMetricItem(
          label: l10n.agileSprintScopeOriginal,
          value: '$originalSP',
          theme: theme,
        ),
        _buildMetricItem(
          label: l10n.agileSprintScopeCurrent,
          value: '$currentSP',
          theme: theme,
        ),
        _buildMetricItem(
          label: l10n.agileSprintScopeDelta,
          value: delta >= 0 ? '+$delta' : '$delta',
          valueColor: delta == 0
              ? AppColors.success
              : (delta > 0 ? AppColors.warning : AppColors.secondary),
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    Color? valueColor,
    required ThemeData theme,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: valueColor ?? theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
