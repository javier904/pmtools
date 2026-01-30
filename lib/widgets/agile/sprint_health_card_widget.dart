import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../../models/agile_enums.dart';
import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../themes/app_colors.dart';

/// Sprint Health Summary Card
///
/// Displays the current sprint's health at a glance, including:
/// - Status badge (on-track / at-risk / off-track)
/// - Sprint goal
/// - Time and work progress circular indicators
/// - Key metrics (stories done, commitment reliability, daily velocity, prediction)
/// - Stories status breakdown bar
class SprintHealthCardWidget extends StatelessWidget {
  final SprintModel? currentSprint;
  final List<UserStoryModel> stories;
  final List<SprintModel> sprints;

  const SprintHealthCardWidget({
    super.key,
    required this.currentSprint,
    required this.stories,
    required this.sprints,
  });

  // ---------------------------------------------------------------------------
  // Health status helpers
  // ---------------------------------------------------------------------------

  _SprintHealthStatus _computeHealthStatus(SprintModel sprint) {
    final completionRate = sprint.completionRate;
    final timeProgress = sprint.timeProgress;

    if (completionRate >= timeProgress * 0.8) {
      return _SprintHealthStatus.onTrack;
    } else if (completionRate >= timeProgress * 0.5) {
      return _SprintHealthStatus.atRisk;
    } else {
      return _SprintHealthStatus.offTrack;
    }
  }

  Color _healthColor(_SprintHealthStatus status) {
    switch (status) {
      case _SprintHealthStatus.onTrack:
        return AppColors.success;
      case _SprintHealthStatus.atRisk:
        return AppColors.warning;
      case _SprintHealthStatus.offTrack:
        return AppColors.error;
    }
  }

  String _healthLabel(_SprintHealthStatus status, AppLocalizations l10n) {
    switch (status) {
      case _SprintHealthStatus.onTrack:
        return l10n.agileSprintHealthOnTrack;
      case _SprintHealthStatus.atRisk:
        return l10n.agileSprintHealthAtRisk;
      case _SprintHealthStatus.offTrack:
        return l10n.agileSprintHealthOffTrack;
    }
  }

  // ---------------------------------------------------------------------------
  // Metrics helpers
  // ---------------------------------------------------------------------------

  /// Stories in the current sprint.
  List<UserStoryModel> _sprintStories(SprintModel sprint) {
    return stories
        .where((s) => sprint.storyIds.contains(s.id))
        .toList();
  }

  int _storiesDoneCount(SprintModel sprint) {
    return _sprintStories(sprint)
        .where((s) => s.status == StoryStatus.done)
        .length;
  }

  /// Commitment reliability: average(completedPoints / plannedPoints)
  /// across completed sprints that had planned points > 0.
  double _commitmentReliability() {
    final completed = sprints.where(
      (s) => s.status == SprintStatus.completed && s.plannedPoints > 0,
    );
    if (completed.isEmpty) return 0.0;

    final sum = completed.fold<double>(
      0.0,
      (acc, s) => acc + (s.completedPoints / s.plannedPoints),
    );
    return (sum / completed.length).clamp(0.0, 1.0);
  }

  /// Stories grouped by status for the breakdown bar.
  Map<StoryStatus, int> _storiesPerStatus(SprintModel sprint) {
    final ss = _sprintStories(sprint);
    final map = <StoryStatus, int>{};
    for (final s in ss) {
      map[s.status] = (map[s.status] ?? 0) + 1;
    }
    return map;
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (currentSprint == null) {
      return _buildEmptyState(context, l10n, theme);
    }

    return _buildHealthCard(context, currentSprint!, l10n, theme);
  }

  // ---------------------------------------------------------------------------
  // Empty state
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
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
              Icons.timer_off_outlined,
              size: 48,
              color: theme.colorScheme.onSurface.withOpacity(0.38),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.agileSprintHealthNoSprint,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.agileSprintHealthNoSprintDesc,
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

  // ---------------------------------------------------------------------------
  // Main health card
  // ---------------------------------------------------------------------------

  Widget _buildHealthCard(
    BuildContext context,
    SprintModel sprint,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final healthStatus = _computeHealthStatus(sprint);
    final statusColor = _healthColor(healthStatus);

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
            _buildHeader(sprint, healthStatus, statusColor, l10n, theme),

            // Sprint goal
            if (sprint.goal.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildGoal(sprint.goal, l10n, theme),
            ],

            const SizedBox(height: 16),

            // Progress indicators
            _buildProgressSection(sprint, l10n, theme),

            const SizedBox(height: 16),

            // Key metrics
            _buildMetricsRow(sprint, l10n, theme),

            const SizedBox(height: 16),

            // Stories breakdown bar
            _buildStoriesBreakdown(sprint, l10n, theme),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

  Widget _buildHeader(
    SprintModel sprint,
    _SprintHealthStatus healthStatus,
    Color statusColor,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      children: [
        Icon(
          Icons.favorite_outline,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          l10n.agileSprintHealthTitle,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        // Sprint name
        Flexible(
          child: Text(
            sprint.name,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _healthLabel(healthStatus, l10n),
            style: theme.textTheme.labelSmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Sprint goal
  // ---------------------------------------------------------------------------

  Widget _buildGoal(String goal, AppLocalizations l10n, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.agileSprintHealthGoal}: ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            goal,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Progress section (time + work side-by-side)
  // ---------------------------------------------------------------------------

  Widget _buildProgressSection(
    SprintModel sprint,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      children: [
        // Time progress
        Expanded(
          child: _buildCircularProgress(
            label: l10n.agileSprintHealthTime,
            progress: sprint.timeProgress,
            centerText: '${sprint.daysElapsed}/${sprint.durationDays}',
            subtitle: '${sprint.daysRemaining} ${l10n.agileSprintHealthDaysLeft}',
            color: theme.colorScheme.primary,
            theme: theme,
          ),
        ),
        const SizedBox(width: 16),
        // Work progress
        Expanded(
          child: _buildCircularProgress(
            label: l10n.agileSprintHealthWork,
            progress: sprint.completionRate,
            centerText: '${sprint.completedPoints}/${sprint.plannedPoints}',
            subtitle:
                '${sprint.remainingPoints} ${l10n.agileSprintHealthSpRemaining}',
            color: AppColors.success,
            theme: theme,
          ),
        ),
      ],
    );
  }

  Widget _buildCircularProgress({
    required String label,
    required double progress,
    required String centerText,
    required String subtitle,
    required Color color,
    required ThemeData theme,
  }) {
    const double size = 72;
    const double strokeWidth = 6;

    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background track
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: strokeWidth,
                  color: theme.colorScheme.onSurface.withOpacity(0.08),
                ),
              ),
              // Foreground progress
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  strokeWidth: strokeWidth,
                  color: color,
                  strokeCap: StrokeCap.round,
                ),
              ),
              // Center text
              Text(
                centerText,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Key metrics row
  // ---------------------------------------------------------------------------

  Widget _buildMetricsRow(
    SprintModel sprint,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final sprintStories = _sprintStories(sprint);
    final doneCount = _storiesDoneCount(sprint);
    final commitment = _commitmentReliability();
    final velocity = sprint.dailyVelocity;
    final prediction = sprint.predictedCompletionDate;

    // Format prediction
    String predictionText;
    if (sprint.remainingPoints == 0) {
      predictionText = l10n.agileSprintHealthOnTime;
    } else if (prediction == null) {
      predictionText = '-';
    } else if (!prediction.isAfter(sprint.endDate)) {
      predictionText = l10n.agileSprintHealthOnTime;
    } else {
      predictionText = DateFormat('dd/MM').format(prediction);
    }

    return Row(
      children: [
        _buildMetricItem(
          label: l10n.agileSprintHealthStoriesDone,
          value: '$doneCount/${sprintStories.length}',
          theme: theme,
        ),
        _buildMetricItem(
          label: l10n.agileSprintHealthCommitment,
          value: '${(commitment * 100).toStringAsFixed(0)}%',
          theme: theme,
        ),
        _buildMetricItem(
          label: l10n.agileSprintHealthDailyVelocity,
          value: velocity.toStringAsFixed(1),
          theme: theme,
        ),
        _buildMetricItem(
          label: l10n.agileSprintHealthPrediction,
          value: predictionText,
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Stories breakdown bar
  // ---------------------------------------------------------------------------

  Widget _buildStoriesBreakdown(
    SprintModel sprint,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final perStatus = _storiesPerStatus(sprint);
    final totalStories = _sprintStories(sprint).length;

    if (totalStories == 0) {
      return const SizedBox.shrink();
    }

    // Order of statuses to display in the bar.
    const statusOrder = [
      StoryStatus.backlog,
      StoryStatus.refinement,
      StoryStatus.ready,
      StoryStatus.inSprint,
      StoryStatus.inProgress,
      StoryStatus.inReview,
      StoryStatus.done,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.agileSprintHealthStoriesBreakdown,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        // Stacked horizontal bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 14,
            child: Row(
              children: statusOrder.map((status) {
                final count = perStatus[status] ?? 0;
                if (count == 0) return const SizedBox.shrink();
                return Expanded(
                  flex: count,
                  child: Container(color: status.color),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 6),
        // Legend
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: statusOrder
              .where((s) => (perStatus[s] ?? 0) > 0)
              .map((status) {
            final count = perStatus[status]!;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: status.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '${status.displayName} ($count)',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

// =============================================================================
// Private enum for health status
// =============================================================================

enum _SprintHealthStatus {
  onTrack,
  atRisk,
  offTrack,
}
