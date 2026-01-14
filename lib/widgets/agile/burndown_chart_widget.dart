import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/sprint_model.dart';

/// Widget per visualizzare il Burndown Chart dello sprint
class BurndownChartWidget extends StatelessWidget {
  final SprintModel sprint;
  final List<BurndownPoint> burndownData;

  const BurndownChartWidget({
    super.key,
    required this.sprint,
    required this.burndownData,
  });

  @override
  Widget build(BuildContext context) {
    if (burndownData.isEmpty) {
      return _buildEmptyState();
    }

    final idealLine = _calculateIdealLine();
    final actualLine = _calculateActualLine();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.show_chart, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Burndown Chart',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                // Legend
                _buildLegendItem('Ideale', Colors.blue),
                const SizedBox(width: 16),
                _buildLegendItem('Reale', Colors.green),
              ],
            ),
            const SizedBox(height: 24),

            // Chart
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey[300]!,
                      strokeWidth: 1,
                    ),
                    getDrawingVerticalLine: (value) => FlLine(
                      color: Colors.grey[300]!,
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          final day = value.toInt();
                          if (day % 2 == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'G$day',
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
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
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
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  lineBarsData: [
                    // Ideal line
                    LineChartBarData(
                      spots: idealLine,
                      isCurved: false,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      dashArray: [5, 5],
                    ),
                    // Actual line
                    LineChartBarData(
                      spots: actualLine,
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                          radius: 4,
                          color: Colors.green,
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.green.withOpacity(0.1),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final isIdeal = spot.barIndex == 0;
                          return LineTooltipItem(
                            '${isIdeal ? "Ideale" : "Reale"}: ${spot.y.toInt()} pts',
                            TextStyle(
                              color: isIdeal ? Colors.blue : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatBox(
                  'Pianificati',
                  '${sprint.plannedPoints}',
                  'pts',
                  Colors.blue,
                ),
                _buildStatBox(
                  'Completati',
                  '${sprint.completedPoints}',
                  'pts',
                  Colors.green,
                ),
                _buildStatBox(
                  'Rimanenti',
                  '${sprint.plannedPoints - sprint.completedPoints}',
                  'pts',
                  Colors.orange,
                ),
                _buildStatBox(
                  'Giorni',
                  '${sprint.daysRemaining}',
                  'rimasti',
                  Colors.purple,
                ),
              ],
            ),
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
            Icon(Icons.show_chart, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessun dato burndown',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'I dati appariranno quando lo sprint sarà attivo',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
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
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                unit,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<FlSpot> _calculateIdealLine() {
    final totalDays = sprint.durationDays;
    final totalPoints = sprint.plannedPoints.toDouble();
    final pointsPerDay = totalPoints / totalDays;

    return List.generate(totalDays + 1, (day) {
      final remaining = totalPoints - (pointsPerDay * day);
      return FlSpot(day.toDouble(), remaining.clamp(0, totalPoints));
    });
  }

  List<FlSpot> _calculateActualLine() {
    if (burndownData.isEmpty) return [];

    final spots = <FlSpot>[];
    final startDate = sprint.startDate;

    for (final point in burndownData) {
      final day = point.date.difference(startDate).inDays;
      spots.add(FlSpot(day.toDouble(), point.remainingPoints.toDouble()));
    }

    return spots;
  }
}

/// Widget per visualizzare il Velocity Chart
class VelocityChartWidget extends StatelessWidget {
  final List<SprintVelocityData> velocityData;

  const VelocityChartWidget({
    super.key,
    required this.velocityData,
  });

  @override
  Widget build(BuildContext context) {
    if (velocityData.isEmpty) {
      return _buildEmptyState();
    }

    final avgVelocity = velocityData.fold<double>(0, (sum, d) => sum + d.velocity) /
        velocityData.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.speed, color: Colors.purple),
                const SizedBox(width: 8),
                const Text(
                  'Velocity Trend',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Media: ${avgVelocity.toStringAsFixed(1)} pts',
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: velocityData.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.velocity,
                          color: Colors.purple,
                          width: 24,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < velocityData.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'S${velocityData[index].sprintNumber}',
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
                        reservedSize: 30,
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
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                  ),
                  borderData: FlBorderData(show: false),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: avgVelocity,
                        color: Colors.orange,
                        strokeWidth: 2,
                        dashArray: [5, 5],
                        label: HorizontalLineLabel(
                          show: true,
                          labelResolver: (line) => 'Media',
                          style: const TextStyle(fontSize: 10, color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
            Icon(Icons.speed, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessun dato velocity',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Completa almeno uno sprint per vedere il trend',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dati velocity per il grafico
class SprintVelocityData {
  final int sprintNumber;
  final String sprintName;
  final double velocity;
  final int plannedPoints;
  final int completedPoints;

  SprintVelocityData({
    required this.sprintNumber,
    required this.sprintName,
    required this.velocity,
    required this.plannedPoints,
    required this.completedPoints,
  });

  factory SprintVelocityData.fromSprint(SprintModel sprint) {
    return SprintVelocityData(
      sprintNumber: sprint.number,
      sprintName: sprint.name,
      velocity: sprint.velocity ?? 0,
      plannedPoints: sprint.plannedPoints,
      completedPoints: sprint.completedPoints,
    );
  }
}
