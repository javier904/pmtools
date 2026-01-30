import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/agile_enums.dart';
import '../../models/user_story_model.dart';
import '../../themes/app_colors.dart';

/// Flow Efficiency & WIP Analysis Widget
///
/// Displays:
/// - Flow efficiency percentage (cycle time / lead time)
/// - Average cycle time vs lead time comparison
/// - WIP count per status (excluding backlog and done)
class FlowEfficiencyWidget extends StatelessWidget {
  final List<UserStoryModel> stories;

  const FlowEfficiencyWidget({super.key, required this.stories});

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Stories with both cycle and lead time available.
  List<UserStoryModel> _storiesWithFlowData() {
    return stories
        .where((s) => s.cycleTimeDays != null && s.leadTimeDays != null)
        .toList();
  }

  double _avgCycleTime(List<UserStoryModel> data) {
    if (data.isEmpty) return 0;
    final sum = data.fold<int>(0, (acc, s) => acc + s.cycleTimeDays!);
    return sum / data.length;
  }

  double _avgLeadTime(List<UserStoryModel> data) {
    if (data.isEmpty) return 0;
    final sum = data.fold<int>(0, (acc, s) => acc + s.leadTimeDays!);
    return sum / data.length;
  }

  double _flowEfficiency(double avgCycle, double avgLead) {
    if (avgLead == 0) return 0;
    return (avgCycle / avgLead * 100).clamp(0, 100);
  }

  Color _efficiencyColor(double pct) {
    if (pct >= 40) return AppColors.success;
    if (pct >= 20) return AppColors.warning;
    return AppColors.error;
  }

  /// WIP: stories not in backlog and not done.
  Map<StoryStatus, int> _wipPerStatus() {
    final map = <StoryStatus, int>{};
    for (final s in stories) {
      if (s.status == StoryStatus.backlog || s.status == StoryStatus.done) {
        continue;
      }
      map[s.status] = (map[s.status] ?? 0) + 1;
    }
    return map;
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    if (stories.isEmpty) {
      return _buildEmptyState(l10n, theme);
    }

    return _buildCard(l10n, theme);
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
              Icons.speed,
              size: 48,
              color: theme.colorScheme.onSurface.withOpacity(0.38),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.agileFlowEfficiencyNoData,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.agileFlowEfficiencyNoDataDesc,
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

  Widget _buildCard(AppLocalizations l10n, ThemeData theme) {
    final flowData = _storiesWithFlowData();
    final avgCycle = _avgCycleTime(flowData);
    final avgLead = _avgLeadTime(flowData);
    final efficiency = _flowEfficiency(avgCycle, avgLead);
    final wipMap = _wipPerStatus();

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
            _buildHeader(l10n, theme),
            const SizedBox(height: 16),

            // Section 1 + 2: Flow efficiency + times
            _buildFlowSection(flowData, avgCycle, avgLead, efficiency, l10n, theme),

            // Section 3: WIP
            if (wipMap.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildWipSection(wipMap, l10n, theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, ThemeData theme) {
    return Row(
      children: [
        Icon(Icons.speed, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          l10n.agileFlowEfficiencyTitle,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Flow efficiency + cycle/lead time
  // ---------------------------------------------------------------------------

  Widget _buildFlowSection(
    List<UserStoryModel> flowData,
    double avgCycle,
    double avgLead,
    double efficiency,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final hasData = flowData.isNotEmpty;

    return Row(
      children: [
        // Circular indicator
        _buildCircularEfficiency(
          hasData ? efficiency : null,
          l10n,
          theme,
        ),
        const SizedBox(width: 16),
        // Cycle / Lead time boxes
        Expanded(
          child: Column(
            children: [
              _buildTimeMetric(
                label: l10n.agileFlowCycleTime,
                value: hasData
                    ? '${avgCycle.toStringAsFixed(1)} ${l10n.agileFlowDays}'
                    : '-',
                color: AppColors.success,
                theme: theme,
              ),
              const SizedBox(height: 8),
              _buildTimeMetric(
                label: l10n.agileFlowLeadTime,
                value: hasData
                    ? '${avgLead.toStringAsFixed(1)} ${l10n.agileFlowDays}'
                    : '-',
                color: AppColors.secondary,
                theme: theme,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircularEfficiency(
    double? efficiency,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    const double size = 80;
    const double strokeWidth = 6;
    final color =
        efficiency != null ? _efficiencyColor(efficiency) : AppColors.warning;
    final progress = efficiency != null ? (efficiency / 100).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        Text(
          l10n.agileFlowEfficiency,
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
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: strokeWidth,
                  color: theme.colorScheme.onSurface.withOpacity(0.08),
                ),
              ),
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: strokeWidth,
                  color: color,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                efficiency != null
                    ? '${efficiency.toStringAsFixed(0)}%'
                    : 'N/A',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeMetric({
    required String label,
    required String value,
    required Color color,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
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
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // WIP per status
  // ---------------------------------------------------------------------------

  Widget _buildWipSection(
    Map<StoryStatus, int> wipMap,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final totalWip = wipMap.values.fold<int>(0, (a, b) => a + b);

    const statusOrder = [
      StoryStatus.refinement,
      StoryStatus.ready,
      StoryStatus.inSprint,
      StoryStatus.inProgress,
      StoryStatus.inReview,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.agileFlowWipByStatus} ($totalWip)',
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        // Stacked bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 14,
            child: Row(
              children: statusOrder.map((status) {
                final count = wipMap[status] ?? 0;
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
              .where((s) => (wipMap[s] ?? 0) > 0)
              .map((status) {
            final count = wipMap[status]!;
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
