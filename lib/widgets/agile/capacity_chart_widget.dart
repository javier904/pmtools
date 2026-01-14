import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/team_member_model.dart';
import '../../models/sprint_model.dart';

/// Widget per visualizzare il carico di lavoro del team
class CapacityChartWidget extends StatelessWidget {
  final List<TeamMemberModel> teamMembers;
  final SprintModel? currentSprint;
  final Map<String, int> assignedHours; // email -> ore assegnate

  const CapacityChartWidget({
    super.key,
    required this.teamMembers,
    this.currentSprint,
    this.assignedHours = const {},
  });

  @override
  Widget build(BuildContext context) {
    if (teamMembers.isEmpty) {
      return _buildEmptyState();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.bar_chart, color: Colors.teal),
                const SizedBox(width: 8),
                const Text(
                  'Capacità Team',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                // Legend
                _buildLegendItem('Disponibile', Colors.green),
                const SizedBox(width: 12),
                _buildLegendItem('Assegnato', Colors.blue),
                const SizedBox(width: 12),
                _buildLegendItem('Sovraccarico', Colors.red),
              ],
            ),
            const SizedBox(height: 24),

            // Chart
            SizedBox(
              height: 250,
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
                          if (index < teamMembers.length) {
                            final member = teamMembers[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                _getShortName(member.name ?? member.email),
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
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
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
                        final member = teamMembers[group.x];
                        final capacity = _getMemberCapacity(member);
                        final assigned = assignedHours[member.email] ?? 0;
                        final available = capacity - assigned;

                        return BarTooltipItem(
                          '${member.name ?? member.email}\n'
                          'Capacità: ${capacity}h\n'
                          'Assegnato: ${assigned}h\n'
                          'Disponibile: ${available}h',
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
            _buildSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.group, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessun membro nel team',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
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
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return teamMembers.asMap().entries.map((entry) {
      final index = entry.key;
      final member = entry.value;
      final capacity = _getMemberCapacity(member);
      final assigned = assignedHours[member.email] ?? 0;
      final isOverloaded = assigned > capacity;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: capacity.toDouble(),
            color: Colors.green.withOpacity(0.3),
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

    for (final member in teamMembers) {
      final capacity = _getMemberCapacity(member);
      final assigned = assignedHours[member.email] ?? 0;
      if (capacity > maxCapacity) maxCapacity = capacity.toDouble();
      if (assigned > maxAssigned) maxAssigned = assigned.toDouble();
    }

    return (maxCapacity > maxAssigned ? maxCapacity : maxAssigned) * 1.2;
  }

  int _getMemberCapacity(TeamMemberModel member) {
    if (currentSprint == null) return member.capacityHoursPerDay * 10; // default 10 giorni
    return currentSprint!.teamCapacity[member.email] ??
           (member.capacityHoursPerDay * currentSprint!.durationDays);
  }

  String _getShortName(String fullName) {
    final parts = fullName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}.${parts.last}';
    }
    return fullName.length > 8 ? '${fullName.substring(0, 8)}...' : fullName;
  }

  Widget _buildSummary() {
    int totalCapacity = 0;
    int totalAssigned = 0;
    int overloadedCount = 0;

    for (final member in teamMembers) {
      final capacity = _getMemberCapacity(member);
      final assigned = assignedHours[member.email] ?? 0;
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
        _buildSummaryItem(
          'Capacità Totale',
          '${totalCapacity}h',
          Colors.green,
        ),
        _buildSummaryItem(
          'Ore Assegnate',
          '${totalAssigned}h',
          Colors.blue,
        ),
        _buildSummaryItem(
          'Utilizzazione',
          '$utilizationPercent%',
          utilizationPercent > 100 ? Colors.red : Colors.teal,
        ),
        if (overloadedCount > 0)
          _buildSummaryItem(
            'Sovraccaricati',
            '$overloadedCount',
            Colors.red,
          ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
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
}

/// Widget compatto per mostrare workload singolo membro
class MemberWorkloadWidget extends StatelessWidget {
  final TeamMemberModel member;
  final int assignedHours;
  final int totalCapacity;
  final VoidCallback? onTap;

  const MemberWorkloadWidget({
    super.key,
    required this.member,
    required this.assignedHours,
    required this.totalCapacity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final utilizationPercent = totalCapacity > 0
        ? (assignedHours / totalCapacity * 100).round()
        : 0;
    final isOverloaded = utilizationPercent > 100;
    final available = totalCapacity - assignedHours;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isOverloaded ? Colors.red.withOpacity(0.3) : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: member.role.color.withOpacity(0.2),
                  child: Text(
                    (member.name ?? member.email)[0].toUpperCase(),
                    style: TextStyle(
                      color: member.role.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.name ?? member.email,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        member.role.displayName,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isOverloaded
                        ? Colors.red.withOpacity(0.1)
                        : Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$utilizationPercent%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isOverloaded ? Colors.red : Colors.teal,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (utilizationPercent / 100).clamp(0.0, 1.5),
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(
                  isOverloaded ? Colors.red : Colors.teal,
                ),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assegnato: ${assignedHours}h',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
                Text(
                  available >= 0
                      ? 'Disponibile: ${available}h'
                      : 'Sovraccarico: ${-available}h',
                  style: TextStyle(
                    fontSize: 11,
                    color: available >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget per alert sovraccarico
class OverloadAlertWidget extends StatelessWidget {
  final List<TeamMemberModel> overloadedMembers;
  final Map<String, int> assignedHours;
  final Map<String, int> capacities;
  final void Function(TeamMemberModel)? onMemberTap;

  const OverloadAlertWidget({
    super.key,
    required this.overloadedMembers,
    required this.assignedHours,
    required this.capacities,
    this.onMemberTap,
  });

  @override
  Widget build(BuildContext context) {
    if (overloadedMembers.isEmpty) return const SizedBox.shrink();

    return Card(
      color: Colors.red.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'Alert Sovraccarico (${overloadedMembers.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...overloadedMembers.map((member) {
              final assigned = assignedHours[member.email] ?? 0;
              final capacity = capacities[member.email] ?? 0;
              final overload = assigned - capacity;

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.red.withOpacity(0.2),
                  child: Text(
                    (member.name ?? member.email)[0].toUpperCase(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                title: Text(member.name ?? member.email),
                subtitle: Text(
                  '${assigned}h assegnate su ${capacity}h disponibili (+${overload}h)',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.red),
                onTap: onMemberTap != null ? () => onMemberTap!(member) : null,
              );
            }),
          ],
        ),
      ),
    );
  }
}
