import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Sprint Burndown Chart computed LIVE from story completion data.
///
/// Instead of requiring pre-recorded [BurndownPoint] data, this widget
/// computes the burndown directly from [UserStoryModel.completedAt] dates,
/// providing an always-up-to-date view of sprint progress.
///
/// If the sprint already has pre-recorded [SprintModel.burndownData], the
/// widget uses that data as a hybrid fallback for historical accuracy.
class SprintBurndownLiveWidget extends StatelessWidget {
  /// The current sprint to display the burndown for.
  /// When null, an empty state is shown.
  final SprintModel? currentSprint;

  /// All project stories. The widget filters to only those
  /// belonging to [currentSprint].
  final List<UserStoryModel> stories;

  const SprintBurndownLiveWidget({
    super.key,
    required this.currentSprint,
    required this.stories,
  });

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (currentSprint == null) {
      return _buildEmptyState(context, l10n, theme);
    }

    final sprintStories = stories
        .where((s) => s.sprintId == currentSprint!.id)
        .toList();

    if (sprintStories.isEmpty) {
      return _buildEmptyState(context, l10n, theme);
    }

    final totalPoints = sprintStories.fold<int>(
      0,
      (sum, s) => sum + (s.storyPoints ?? 0),
    );

    if (totalPoints == 0) {
      return _buildEmptyState(context, l10n, theme);
    }

    final workingDays = _getWorkingDays();
    final idealSpots = _buildIdealLine(totalPoints, workingDays.length);
    final actualSpots = _buildActualLine(
      sprintStories,
      totalPoints,
      workingDays,
    );

    final completedPoints = _computeCompletedPoints(sprintStories);
    final remainingPoints = totalPoints - completedPoints;
    final daysLeft = currentSprint!.daysRemaining;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, l10n, theme),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: _buildChart(
                context,
                l10n,
                theme,
                idealSpots,
                actualSpots,
                totalPoints,
                workingDays,
              ),
            ),
            const SizedBox(height: 16),
            _buildFooterStats(
              context,
              l10n,
              theme,
              totalPoints,
              completedPoints,
              remainingPoints,
              daysLeft,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // HEADER
  // ===========================================================================

  Widget _buildHeader(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      children: [
        Icon(
          Icons.show_chart,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          l10n.agileSprintBurndownTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        _buildLegendItem(
          context,
          l10n.agileIdeal,
          AppColors.secondary,
          isDashed: true,
        ),
        const SizedBox(width: 16),
        _buildLegendItem(
          context,
          l10n.agileActual,
          AppColors.success,
          isDashed: false,
        ),
      ],
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    Color color, {
    required bool isDashed,
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 3,
          child: CustomPaint(
            painter: _LegendLinePainter(
              color: color,
              isDashed: isDashed,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  // ===========================================================================
  // CHART
  // ===========================================================================

  Widget _buildChart(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    List<FlSpot> idealSpots,
    List<FlSpot> actualSpots,
    int totalPoints,
    List<DateTime> workingDays,
  ) {
    final maxY = (totalPoints * 1.1).ceilToDouble();
    final maxX = idealSpots.isEmpty
        ? 1.0
        : idealSpots.last.x;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: maxX,
        minY: 0,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: max(1, (totalPoints / 5).ceilToDouble()),
          verticalInterval: max(1, (maxX / 5).ceilToDouble()),
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.dividerTheme.color ?? theme.dividerColor,
            strokeWidth: 0.5,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: theme.dividerTheme.color ?? theme.dividerColor,
            strokeWidth: 0.5,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: max(1, (maxX / 6).ceilToDouble()),
              getTitlesWidget: (value, meta) {
                final dayIndex = value.toInt();
                if (dayIndex < 0 || dayIndex >= workingDays.length) {
                  return const SizedBox.shrink();
                }
                final date = workingDays[dayIndex];
                final label = DateFormat('dd/MM').format(date);
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    label,
                    style: theme.textTheme.labelSmall,
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: max(1, (totalPoints / 5).ceilToDouble()),
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: theme.textTheme.labelSmall,
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(
              color: theme.dividerTheme.color ?? theme.dividerColor,
            ),
            bottom: BorderSide(
              color: theme.dividerTheme.color ?? theme.dividerColor,
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) =>
                theme.colorScheme.surfaceContainerHighest,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final isIdeal = spot.barIndex == 0;
                final label = isIdeal
                    ? '${l10n.agileIdeal}: ${spot.y.toStringAsFixed(1)} pts'
                    : '${l10n.agileActual}: ${spot.y.toStringAsFixed(1)} pts';
                return LineTooltipItem(
                  label,
                  TextStyle(
                    color: isIdeal ? AppColors.secondary : AppColors.success,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          // Ideal line (dashed blue)
          LineChartBarData(
            spots: idealSpots,
            isCurved: false,
            color: AppColors.secondary,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            dashArray: [8, 4],
            belowBarData: BarAreaData(show: false),
          ),
          // Actual line (solid green with dots and area fill)
          LineChartBarData(
            spots: actualSpots,
            isCurved: false,
            color: AppColors.success,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                radius: 3.5,
                color: AppColors.success,
                strokeWidth: 1.5,
                strokeColor: theme.colorScheme.surface,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.success.withAlpha(30),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FOOTER STATS
  // ===========================================================================

  Widget _buildFooterStats(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    int totalPoints,
    int completedPoints,
    int remainingPoints,
    int daysLeft,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(
          context,
          theme,
          l10n.agilePlanned,
          '$totalPoints pts',
          AppColors.secondary,
        ),
        _buildStatItem(
          context,
          theme,
          l10n.agileStatsCompleted,
          '$completedPoints pts',
          AppColors.success,
        ),
        _buildStatItem(
          context,
          theme,
          l10n.agileRemaining,
          '$remainingPoints pts',
          AppColors.warning,
        ),
        _buildStatItem(
          context,
          theme,
          l10n.agileDaysLeft,
          '$daysLeft ${l10n.agileDaysRemainingSuffix}',
          theme.colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    ThemeData theme,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  // ===========================================================================
  // EMPTY STATE
  // ===========================================================================

  Widget _buildEmptyState(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.show_chart,
                size: 48,
                color: theme.colorScheme.onSurface.withAlpha(80),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.agileSprintBurndownNoData,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(150),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.agileSprintBurndownNoDataDesc,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(100),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // COMPUTATION: WORKING DAYS
  // ===========================================================================

  /// Returns a list of working days (Mon-Fri) from sprint start to sprint end.
  List<DateTime> _getWorkingDays() {
    final sprint = currentSprint!;
    final List<DateTime> days = [];
    DateTime current = DateTime(
      sprint.startDate.year,
      sprint.startDate.month,
      sprint.startDate.day,
    );
    final end = DateTime(
      sprint.endDate.year,
      sprint.endDate.month,
      sprint.endDate.day,
    );

    while (!current.isAfter(end)) {
      if (current.weekday != DateTime.saturday &&
          current.weekday != DateTime.sunday) {
        days.add(current);
      }
      current = current.add(const Duration(days: 1));
    }
    return days;
  }

  // ===========================================================================
  // COMPUTATION: IDEAL LINE
  // ===========================================================================

  /// Builds the ideal burndown line from totalPoints at day 0 to 0 at the
  /// last working day, using [SprintModel.idealRemainingAtDay].
  List<FlSpot> _buildIdealLine(int totalPoints, int workingDayCount) {
    if (workingDayCount == 0) return [];
    final spots = <FlSpot>[];
    for (int day = 0; day <= workingDayCount; day++) {
      final remaining = currentSprint!.idealRemainingAtDay(day);
      spots.add(FlSpot(day.toDouble(), remaining));
    }
    return spots;
  }

  // ===========================================================================
  // COMPUTATION: ACTUAL LINE
  // ===========================================================================

  /// Builds the actual burndown line computed live from story completion dates.
  ///
  /// If the sprint has pre-recorded [BurndownPoint] data, uses that instead
  /// (hybrid approach for backward compatibility).
  List<FlSpot> _buildActualLine(
    List<UserStoryModel> sprintStories,
    int totalPoints,
    List<DateTime> workingDays,
  ) {
    // Hybrid: prefer pre-recorded burndown data if available
    if (currentSprint!.burndownData.isNotEmpty) {
      return _buildActualLineFromBurndownData(workingDays);
    }

    return _buildActualLineFromStories(
      sprintStories,
      totalPoints,
      workingDays,
    );
  }

  /// Builds the actual line from pre-recorded burndown data.
  List<FlSpot> _buildActualLineFromBurndownData(List<DateTime> workingDays) {
    final spots = <FlSpot>[];
    for (final point in currentSprint!.burndownData) {
      final normalizedDate = DateTime(
        point.date.year,
        point.date.month,
        point.date.day,
      );
      final dayIndex = workingDays.indexWhere(
        (d) => d.isAtSameMomentAs(normalizedDate),
      );
      if (dayIndex >= 0) {
        spots.add(FlSpot(
          dayIndex.toDouble(),
          point.remainingPoints.toDouble(),
        ));
      }
    }
    return spots;
  }

  /// Builds the actual line live from story completedAt dates.
  ///
  /// For each working day from sprint start to min(today, sprint end):
  /// - Count points of stories completed on or before that day
  /// - Remaining = totalPoints - completedPoints
  List<FlSpot> _buildActualLineFromStories(
    List<UserStoryModel> sprintStories,
    int totalPoints,
    List<DateTime> workingDays,
  ) {
    if (workingDays.isEmpty) return [];

    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final sprintEnd = workingDays.last;
    final cutoff = today.isBefore(sprintEnd) ? today : sprintEnd;

    final spots = <FlSpot>[];

    for (int i = 0; i < workingDays.length; i++) {
      final day = workingDays[i];
      if (day.isAfter(cutoff)) break;

      int completedPoints = 0;
      for (final story in sprintStories) {
        if (story.completedAt != null) {
          final completedDate = DateTime(
            story.completedAt!.year,
            story.completedAt!.month,
            story.completedAt!.day,
          );
          if (!completedDate.isAfter(day)) {
            completedPoints += story.storyPoints ?? 0;
          }
        }
      }

      final remaining = totalPoints - completedPoints;
      spots.add(FlSpot(i.toDouble(), remaining.toDouble()));
    }

    return spots;
  }

  // ===========================================================================
  // COMPUTATION: COMPLETED POINTS
  // ===========================================================================

  /// Computes the total completed points from sprint stories that have
  /// a [StoryStatus.done] status.
  int _computeCompletedPoints(List<UserStoryModel> sprintStories) {
    return sprintStories
        .where((s) => s.status == StoryStatus.done)
        .fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
  }
}

// =============================================================================
// LEGEND LINE PAINTER
// =============================================================================

/// Custom painter for rendering legend line indicators (solid or dashed).
class _LegendLinePainter extends CustomPainter {
  final Color color;
  final bool isDashed;

  _LegendLinePainter({
    required this.color,
    required this.isDashed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final y = size.height / 2;

    if (isDashed) {
      const dashWidth = 4.0;
      const dashSpace = 3.0;
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, y),
          Offset(min(startX + dashWidth, size.width), y),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    } else {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LegendLinePainter oldDelegate) =>
      color != oldDelegate.color || isDashed != oldDelegate.isDashed;
}
