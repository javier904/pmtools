import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/agile_enums.dart';
import '../../models/sprint_model.dart';
import '../../themes/app_colors.dart';

/// Commitment Reliability Trend Widget
///
/// Shows a bar chart of planned vs completed SP per completed sprint,
/// with commitment ratio percentage and color-coded indicator.
class CommitmentTrendWidget extends StatelessWidget {
  final List<SprintModel> sprints;

  const CommitmentTrendWidget({super.key, required this.sprints});

  List<SprintModel> _completedSprints() {
    final completed = sprints
        .where((s) =>
            s.status == SprintStatus.completed && s.plannedPoints > 0)
        .toList();
    completed.sort((a, b) => a.number.compareTo(b.number));
    return completed;
  }

  double _avgCommitment(List<SprintModel> completed) {
    if (completed.isEmpty) return 0;
    final sum = completed.fold<double>(
      0,
      (acc, s) => acc + (s.completedPoints / s.plannedPoints),
    );
    return (sum / completed.length).clamp(0.0, 1.0);
  }

  Color _ratioColor(double ratio) {
    if (ratio >= 0.8) return AppColors.success;
    if (ratio >= 0.6) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final completed = _completedSprints();

    if (completed.isEmpty) {
      return _buildEmptyState(l10n, theme);
    }

    return _buildCard(completed, l10n, theme);
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
              Icons.bar_chart,
              size: 48,
              color: theme.colorScheme.onSurface.withOpacity(0.38),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.agileCommitmentTrendNoData,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.agileCommitmentTrendNoDataDesc,
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
    List<SprintModel> completed,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final avg = _avgCommitment(completed);
    final maxSP = completed.fold<int>(
      0,
      (m, s) => s.plannedPoints > m
          ? s.plannedPoints
          : (s.completedPoints > m ? s.completedPoints : m),
    );

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
            _buildHeader(avg, l10n, theme),
            const SizedBox(height: 16),
            // Chart
            SizedBox(
              height: 170,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: completed.map((sprint) {
                    return _buildSprintColumn(sprint, maxSP, theme);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Legend
            _buildLegend(l10n, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    double avg,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      children: [
        Icon(
          Icons.bar_chart,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            l10n.agileCommitmentTrendTitle,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Average badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _ratioColor(avg).withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${l10n.agileCommitmentTrendAvg}: ${(avg * 100).toStringAsFixed(0)}%',
            style: theme.textTheme.labelSmall?.copyWith(
              color: _ratioColor(avg),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSprintColumn(
    SprintModel sprint,
    int maxSP,
    ThemeData theme,
  ) {
    const double maxBarHeight = 120;
    final ratio = sprint.plannedPoints > 0
        ? (sprint.completedPoints / sprint.plannedPoints).clamp(0.0, 2.0)
        : 0.0;
    final plannedH =
        maxSP > 0 ? (sprint.plannedPoints / maxSP) * maxBarHeight : 0.0;
    final completedH =
        maxSP > 0 ? (sprint.completedPoints / maxSP) * maxBarHeight : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Ratio label
            Text(
              '${(ratio * 100).toStringAsFixed(0)}%',
              style: theme.textTheme.labelSmall?.copyWith(
                color: _ratioColor(ratio),
                fontWeight: FontWeight.w700,
              ),
            ),
            // Dot indicator
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: _ratioColor(ratio),
                shape: BoxShape.circle,
              ),
            ),
            // Bars side by side
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Planned bar
                Container(
                  width: 18,
                  height: plannedH.clamp(2.0, maxBarHeight),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.7),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(3)),
                  ),
                ),
                const SizedBox(width: 4),
                // Completed bar
                Container(
                  width: 18,
                  height: completedH.clamp(2.0, maxBarHeight),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.85),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(3)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Sprint name
            Text(
              sprint.name.length > 8
                  ? sprint.name.substring(0, 8)
                  : sprint.name,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontSize: 10,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(AppLocalizations l10n, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(AppColors.secondary, l10n.agileCommitmentTrendPlanned, theme),
        const SizedBox(width: 20),
        _legendItem(AppColors.success, l10n.agileCommitmentTrendCompleted, theme),
      ],
    );
  }

  Widget _legendItem(Color color, String label, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
