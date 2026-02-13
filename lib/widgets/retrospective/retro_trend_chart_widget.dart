import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Widget that displays sentiment trend and action completion rate charts
/// for completed retrospectives, helping teams visualize improvement over time.
class RetroTrendChartWidget extends StatelessWidget {
  final List<RetrospectiveModel> retrospectives;

  const RetroTrendChartWidget({
    super.key,
    required this.retrospectives,
  });

  /// Filters and sorts completed retrospectives by creation date ascending.
  List<RetrospectiveModel> get _completedRetros {
    final completed = retrospectives.where((r) {
      return r.status == RetroStatus.completed || r.isCompleted;
    }).toList();
    completed.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return completed;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final completed = _completedRetros;

    if (completed.length < 2) {
      return _buildInsufficientDataMessage(context, theme);
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              l10n.retroTrendTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Charts - side by side on wide screens, stacked on narrow
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 600;
                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSentimentChart(context, completed),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionCompletionChart(context, completed),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildSentimentChart(context, completed),
                      const SizedBox(height: 16),
                      _buildActionCompletionChart(context, completed),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 12),
            // Trend indicator
            _buildTrendIndicator(context, completed),
          ],
        ),
      ),
    );
  }

  Widget _buildInsufficientDataMessage(BuildContext context, ThemeData theme) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.show_chart,
                size: 48,
                color: theme.colorScheme.primary.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 12),
              Text(
                'Need at least 2 completed retrospectives for trends',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Sentiment Trend Chart
  // ---------------------------------------------------------------------------

  Widget _buildSentimentChart(
    BuildContext context,
    List<RetrospectiveModel> completed,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    // Build data points, skipping retros with null/zero sentiment
    final spots = <FlSpot>[];
    final labels = <int, String>{};

    for (var i = 0; i < completed.length; i++) {
      final retro = completed[i];
      final sentiment = retro.averageSentiment;
      if (sentiment != null && sentiment > 0) {
        spots.add(FlSpot(i.toDouble(), sentiment));
      }
      labels[i] = retro.title.isNotEmpty
          ? retro.title
          : 'Retro ${i + 1}';
    }

    if (spots.isEmpty) {
      return SizedBox(
        height: 140,
        child: Center(
          child: Text(
            l10n.retroTrendSentiment,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.retroTrendSentiment,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: 5,
              gridData: FlGridData(
                show: true,
                horizontalInterval: 1,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      if (value % 1 != 0 || value < 0 || value > 5) {
                        return const SizedBox.shrink();
                      }
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final idx = value.toInt();
                      final label = labels[idx];
                      if (label == null) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          _truncateLabel(label),
                          style: TextStyle(
                            fontSize: 9,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.5),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final idx = spot.x.toInt();
                      final label = labels[idx] ?? '';
                      return LineTooltipItem(
                        '$label\n${spot.y.toStringAsFixed(1)} / 5',
                        TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  preventCurveOverShooting: true,
                  color: primaryColor,
                  barWidth: 3,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: primaryColor,
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        primaryColor.withValues(alpha: 0.3),
                        primaryColor.withValues(alpha: 0.0),
                      ],
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

  // ---------------------------------------------------------------------------
  // Action Completion Rate Chart
  // ---------------------------------------------------------------------------

  Widget _buildActionCompletionChart(
    BuildContext context,
    List<RetrospectiveModel> completed,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    const lineColor = Color(0xFF4CAF50); // Green

    final spots = <FlSpot>[];
    final labels = <int, String>{};

    for (var i = 0; i < completed.length; i++) {
      final retro = completed[i];
      final total = retro.actionItems.length;
      final completedCount =
          retro.actionItems.where((a) => a.isCompleted).length;
      final rate = total > 0 ? (completedCount / total) * 100.0 : 0.0;
      spots.add(FlSpot(i.toDouble(), rate));
      labels[i] = retro.title.isNotEmpty
          ? retro.title
          : 'Retro ${i + 1}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.retroTrendActionCompletion,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: 100,
              gridData: FlGridData(
                show: true,
                horizontalInterval: 25,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 36,
                    interval: 25,
                    getTitlesWidget: (value, meta) {
                      if (value < 0 || value > 100) {
                        return const SizedBox.shrink();
                      }
                      return Text(
                        '${value.toInt()}%',
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final idx = value.toInt();
                      final label = labels[idx];
                      if (label == null) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          _truncateLabel(label),
                          style: TextStyle(
                            fontSize: 9,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.5),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final idx = spot.x.toInt();
                      final label = labels[idx] ?? '';
                      return LineTooltipItem(
                        '$label\n${spot.y.toStringAsFixed(0)}%',
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  preventCurveOverShooting: true,
                  color: lineColor,
                  barWidth: 3,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: lineColor,
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        lineColor.withValues(alpha: 0.3),
                        lineColor.withValues(alpha: 0.0),
                      ],
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

  // ---------------------------------------------------------------------------
  // Trend Indicator
  // ---------------------------------------------------------------------------

  Widget _buildTrendIndicator(
    BuildContext context,
    List<RetrospectiveModel> completed,
  ) {
    final l10n = AppLocalizations.of(context)!;

    // Compute sentiment trend
    final sentimentValues = <double>[];
    for (final retro in completed) {
      final s = retro.averageSentiment;
      if (s != null && s > 0) sentimentValues.add(s);
    }

    // Compute action completion trend
    final completionRates = <double>[];
    for (final retro in completed) {
      final total = retro.actionItems.length;
      final done = retro.actionItems.where((a) => a.isCompleted).length;
      if (total > 0) completionRates.add(done / total * 100);
    }

    // Calculate combined trend direction
    final sentimentDelta = _calculateTrendDelta(sentimentValues);
    final completionDelta = _calculateTrendDelta(completionRates);

    // Average both deltas to determine overall trend
    // Normalize sentiment delta to percentage scale (0-5 -> 0-100)
    final normalizedSentimentDelta =
        sentimentValues.isNotEmpty ? sentimentDelta / 5.0 * 100.0 : 0.0;
    final overallDelta = completionRates.isNotEmpty
        ? (normalizedSentimentDelta + completionDelta) / 2.0
        : normalizedSentimentDelta;

    _TrendDirection trend;
    if (overallDelta > 5) {
      trend = _TrendDirection.improving;
    } else if (overallDelta < -5) {
      trend = _TrendDirection.declining;
    } else {
      trend = _TrendDirection.stable;
    }

    final String label;
    final Color chipColor;
    final IconData icon;

    switch (trend) {
      case _TrendDirection.improving:
        label = l10n.retroTrendImproving;
        chipColor = const Color(0xFF4CAF50);
        icon = Icons.trending_up;
      case _TrendDirection.stable:
        label = l10n.retroTrendStable;
        chipColor = const Color(0xFFFFC107);
        icon = Icons.trending_flat;
      case _TrendDirection.declining:
        label = l10n.retroTrendDeclining;
        chipColor = const Color(0xFFF44336);
        icon = Icons.trending_down;
    }

    return Center(
      child: Chip(
        avatar: Icon(icon, color: Colors.white, size: 18),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        backgroundColor: chipColor,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Calculates the difference between the last and first value in the series.
  double _calculateTrendDelta(List<double> values) {
    if (values.length < 2) return 0.0;
    return values.last - values.first;
  }

  /// Truncates a label for bottom axis display.
  String _truncateLabel(String label) {
    if (label.length <= 8) return label;
    return '${label.substring(0, 7)}...';
  }
}

enum _TrendDirection { improving, stable, declining }
