import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/team_member_model.dart';
import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Enum per le due modalità di visualizzazione
enum CapacityViewMode {
  scrumStandard,  // Story Points, Velocity, Throughput
  hours,          // Ore (vista tradizionale)
}

/// Widget per visualizzare la capacità del team con doppia vista
///
/// Vista Scrum Standard (default):
/// - Velocity media (Story Points/Sprint)
/// - Throughput (Stories completate/Sprint)
/// - Capacità suggerita per planning
///
/// Vista Ore (toggle):
/// - Ore disponibili per membro
/// - Ore assegnate vs disponibili
/// - Utilizzo percentuale
class TeamCapacityWidget extends StatefulWidget {
  final List<TeamMemberModel> teamMembers;
  final List<SprintModel> sprints;
  final List<UserStoryModel> stories;
  final SprintModel? currentSprint;
  final Map<String, int> assignedHours;

  const TeamCapacityWidget({
    super.key,
    required this.teamMembers,
    required this.sprints,
    required this.stories,
    this.currentSprint,
    this.assignedHours = const {},
  });

  @override
  State<TeamCapacityWidget> createState() => _TeamCapacityWidgetState();
}

class _TeamCapacityWidgetState extends State<TeamCapacityWidget> {
  CapacityViewMode _viewMode = CapacityViewMode.scrumStandard;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con toggle
            _buildHeader(),
            const SizedBox(height: 16),

            // Contenuto basato sulla vista selezionata
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _viewMode == CapacityViewMode.scrumStandard
                  ? _buildScrumView()
                  : _buildHoursView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(
          _viewMode == CapacityViewMode.scrumStandard
              ? Icons.speed
              : Icons.schedule,
          color: _viewMode == CapacityViewMode.scrumStandard
              ? Colors.indigo
              : Colors.teal,
        ),
        const SizedBox(width: 8),
        Text(
          _viewMode == CapacityViewMode.scrumStandard
              ? l10n.agileTeamCapacityScrum
              : l10n.agileTeamCapacityHours,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        // Toggle button
        Container(
          decoration: BoxDecoration(
            color: context.surfaceVariantColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToggleButton(
                icon: Icons.speed,
                label: 'SP',
                tooltip: l10n.agileTeamCapacityScrum,
                isSelected: _viewMode == CapacityViewMode.scrumStandard,
                onTap: () => setState(() => _viewMode = CapacityViewMode.scrumStandard),
              ),
              _buildToggleButton(
                icon: Icons.schedule,
                label: l10n.agileHours,
                tooltip: l10n.agileTeamCapacityHours,
                isSelected: _viewMode == CapacityViewMode.hours,
                onTap: () => setState(() => _viewMode = CapacityViewMode.hours),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButton({
    required IconData icon,
    required String label,
    required String tooltip,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? Colors.indigo : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SCRUM STANDARD VIEW
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildScrumView() {
    final l10n = AppLocalizations.of(context)!;
    final completedSprints = widget.sprints
        .where((s) => s.status == SprintStatus.completed)
        .toList();

    // Calcola metriche
    final velocityData = _calculateVelocityData(completedSprints);
    final throughputData = _calculateThroughputData(completedSprints);
    final avgVelocity = velocityData.isNotEmpty
        ? velocityData.reduce((a, b) => a + b) / velocityData.length
        : 0.0;
    final avgThroughput = throughputData.isNotEmpty
        ? throughputData.reduce((a, b) => a + b) / throughputData.length
        : 0.0;

    // Deviazione standard per range suggerito
    final velocityStdDev = _calculateStdDev(velocityData, avgVelocity);

    return Column(
      key: const ValueKey('scrum_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Metriche principali
        Row(
          children: [
            Expanded(child: _buildMetricCard(
              icon: Icons.speed,
              label: l10n.agileAverageVelocity,
              value: '${avgVelocity.toStringAsFixed(1)} SP',
              subtitle: l10n.agileVelocityUnits, // Wait, I should add this too
              color: Colors.indigo,
            )),
            const SizedBox(width: 12),
            Expanded(child: _buildMetricCard(
              icon: Icons.check_circle_outline,
              label: l10n.agileThroughput,
              value: avgThroughput.toStringAsFixed(1),
              subtitle: l10n.agileStoriesPerSprint,
              color: Colors.green,
            )),
            const SizedBox(width: 12),
            Expanded(child: _buildMetricCard(
              icon: Icons.history,
              label: l10n.agileStatsCompleted,
              value: '${completedSprints.length}',
              subtitle: l10n.agileSprints,
              color: Colors.blue,
            )),
          ],
        ),
        const SizedBox(height: 16),

        // Capacità suggerita per Sprint Planning
        _buildSuggestedCapacity(avgVelocity, velocityStdDev),
        const SizedBox(height: 16),

        // Grafico velocity trend (se ci sono abbastanza dati)
        if (completedSprints.length >= 2) ...[
          Text(
            l10n.agileVelocityTrend,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: _buildVelocityChart(completedSprints),
          ),
        ],

        // Team breakdown per ruolo
        const SizedBox(height: 16),
        _buildTeamBreakdown(),

        // Nota informativa
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: context.isDarkMode ? 0.15 : 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withValues(alpha: context.isDarkMode ? 0.3 : 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: context.isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.agileScrumGuideNote,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String label,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedCapacity(double avgVelocity, double stdDev) {
    final l10n = AppLocalizations.of(context)!;
    final minSuggested = (avgVelocity - stdDev).clamp(0, double.infinity);
    final maxSuggested = avgVelocity + stdDev;

    final isDark = context.isDarkMode;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: isDark ? 0.15 : 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.withValues(alpha: isDark ? 0.3 : 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade700),
              const SizedBox(width: 8),
              Text(
                l10n.agileSuggestedCapacity,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (avgVelocity > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${minSuggested.toStringAsFixed(0)} - ${maxSuggested.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade700,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Story Points',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.indigo.shade400 : Colors.indigo.shade500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.agileSuggestedCapacityHint,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.indigo.shade400 : Colors.indigo.shade400,
              ),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            Text(
              l10n.agileSuggestedCapacityNoData,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.indigo.shade400 : Colors.indigo.shade500,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVelocityChart(List<SprintModel> completedSprints) {
    // Ordina per data
    final sortedSprints = List<SprintModel>.from(completedSprints)
      ..sort((a, b) => a.endDate.compareTo(b.endDate));

    // Prendi ultimi 6 sprint
    final recentSprints = sortedSprints.length > 6
        ? sortedSprints.sublist(sortedSprints.length - 6)
        : sortedSprints;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 10,
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < recentSprints.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'S${recentSprints[index].number}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: recentSprints.asMap().entries.map((e) {
              return FlSpot(e.key.toDouble(), e.value.completedPoints.toDouble());
            }).toList(),
            isCurved: true,
            color: Colors.indigo,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.indigo,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.indigo.withValues(alpha: 0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final sprint = recentSprints[spot.x.toInt()];
                return LineTooltipItem(
                  'Sprint ${sprint.number}\n${sprint.completedPoints} SP',
                  const TextStyle(color: Colors.white, fontSize: 12),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTeamBreakdown() {
    // Raggruppa membri per ruolo Scrum
    final roleGroups = <TeamRole, List<TeamMemberModel>>{};
    for (final member in widget.teamMembers) {
      roleGroups.putIfAbsent(member.teamRole, () => []).add(member);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.agileTeamComposition,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: roleGroups.entries.map((e) => _buildRoleChip(e.key, e.value.length)).toList(),
        ),
      ],
    );
  }

  Widget _buildRoleChip(TeamRole role, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: role.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: role.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(role.icon, size: 14, color: role.color),
          const SizedBox(width: 6),
          Text(
            '$count ${role.shortName}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: role.color,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HOURS VIEW (Vista tradizionale)
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildHoursView() {
    final l10n = AppLocalizations.of(context)!;
    if (widget.teamMembers.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      key: const ValueKey('hours_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildLegendItem(l10n.agileHoursAvailable, Colors.green),
            const SizedBox(width: 12),
            _buildLegendItem(l10n.agileHoursAssigned, Colors.blue),
            const SizedBox(width: 12),
            _buildLegendItem(l10n.agileHoursOverloaded, Colors.red),
          ],
        ),
        const SizedBox(height: 16),

        // Chart
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _calculateMaxY(),
              barGroups: _buildBarGroups(),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < widget.teamMembers.length) {
                        final member = widget.teamMembers[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _getShortName(member.name),
                            style: const TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    reservedSize: 40,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${value.toInt()}h',
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 20,
              ),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final member = widget.teamMembers[group.x];
                    final capacity = _getMemberCapacity(member);
                    final assigned = widget.assignedHours[member.email] ?? 0;
                    final available = capacity - assigned;

                    return BarTooltipItem(
                      '${member.name}\n'
                      '${l10n.agileHoursTotal}: ${capacity}h\n'
                      '${l10n.agileHoursAssigned}: ${assigned}h\n'
                      '${l10n.agileHoursAvailable}: ${available}h',
                      const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Summary
        _buildHoursSummary(),

        // Nota informativa
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: context.isDarkMode ? 0.15 : 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.withValues(alpha: context.isDarkMode ? 0.3 : 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: context.isDarkMode ? Colors.orange.shade300 : Colors.orange.shade700, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.agileHoursNote,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.isDarkMode ? Colors.orange.shade300 : Colors.orange.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.group, size: 48, color: Colors.grey.shade400),
        const SizedBox(height: 16),
        Text(
          l10n.agileNoTeamMembers,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return widget.teamMembers.asMap().entries.map((entry) {
      final index = entry.key;
      final member = entry.value;
      final capacity = _getMemberCapacity(member);
      final assigned = widget.assignedHours[member.email] ?? 0;
      final isOverloaded = assigned > capacity;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: capacity.toDouble(),
            color: Colors.green.withValues(alpha: 0.3),
            width: 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          BarChartRodData(
            toY: assigned.toDouble(),
            color: isOverloaded ? Colors.red : Colors.blue,
            width: 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ],
      );
    }).toList();
  }

  double _calculateMaxY() {
    double maxCapacity = 0;
    double maxAssigned = 0;

    for (final member in widget.teamMembers) {
      final capacity = _getMemberCapacity(member);
      final assigned = widget.assignedHours[member.email] ?? 0;
      if (capacity > maxCapacity) maxCapacity = capacity.toDouble();
      if (assigned > maxAssigned) maxAssigned = assigned.toDouble();
    }

    return (maxCapacity > maxAssigned ? maxCapacity : maxAssigned) * 1.2;
  }

  int _getMemberCapacity(TeamMemberModel member) {
    if (widget.currentSprint == null) return member.capacityHoursPerDay * 10;
    return widget.currentSprint!.teamCapacity[member.email] ??
           (member.capacityHoursPerDay * widget.currentSprint!.durationDays);
  }

  String _getShortName(String fullName) {
    final parts = fullName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}.${parts.last}';
    }
    return fullName.length > 8 ? '${fullName.substring(0, 8)}...' : fullName;
  }

  Widget _buildHoursSummary() {
    final l10n = AppLocalizations.of(context)!;
    int totalCapacity = 0;
    int totalAssigned = 0;
    int overloadedCount = 0;

    for (final member in widget.teamMembers) {
      final capacity = _getMemberCapacity(member);
      final assigned = widget.assignedHours[member.email] ?? 0;
      totalCapacity += capacity;
      totalAssigned += assigned;
      if (assigned > capacity) overloadedCount++;
    }

    final utilizationPercent = totalCapacity > 0
        ? (totalAssigned / totalCapacity * 100).round()
        : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSummaryItem(l10n.agileHoursTotal, '${totalCapacity}h', Colors.green),
        _buildSummaryItem(l10n.agileHoursAssigned, '${totalAssigned}h', Colors.blue),
        _buildSummaryItem(
          l10n.agileHoursUtilization,
          '$utilizationPercent%',
          utilizationPercent > 100 ? Colors.red : Colors.teal,
        ),
        if (overloadedCount > 0)
          _buildSummaryItem(l10n.agileHoursOverloaded, '$overloadedCount', Colors.red),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  List<double> _calculateVelocityData(List<SprintModel> completedSprints) {
    return completedSprints.map((s) => s.completedPoints.toDouble()).toList();
  }

  List<double> _calculateThroughputData(List<SprintModel> completedSprints) {
    return completedSprints.map((s) {
      // Conta le stories completate in questo sprint
      final completedStories = widget.stories.where((story) =>
          story.sprintId == s.id && story.status == StoryStatus.done
      ).length;
      return completedStories.toDouble();
    }).toList();
  }

  double _calculateStdDev(List<double> values, double mean) {
    if (values.isEmpty) return 0;
    final squaredDiffs = values.map((v) => (v - mean) * (v - mean));
    final variance = squaredDiffs.reduce((a, b) => a + b) / values.length;
    return variance > 0 ? (variance * 0.5).clamp(mean * 0.1, mean * 0.3) : mean * 0.1;
  }
}
