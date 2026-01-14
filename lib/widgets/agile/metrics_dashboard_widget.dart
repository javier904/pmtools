import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/sprint_model.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../models/framework_features.dart';

/// Dashboard principale per metriche Agile
///
/// Mostra metriche diverse in base al framework:
/// - **Scrum**: Velocity, Burndown, Sprint Completion, Estimation Accuracy
/// - **Kanban**: Lead Time, Cycle Time, CFD, Throughput
/// - **Hybrid**: Tutte le metriche
class MetricsDashboardWidget extends StatelessWidget {
  final List<SprintModel> sprints;
  final List<UserStoryModel> stories;
  final Map<String, int> teamAssignedHours;
  final AgileFramework framework;

  const MetricsDashboardWidget({
    super.key,
    required this.sprints,
    required this.stories,
    this.teamAssignedHours = const {},
    this.framework = AgileFramework.scrum,
  });

  FrameworkFeatures get _features => FrameworkFeatures(framework);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con info framework
          _buildFrameworkHeader(context),
          const SizedBox(height: 16),

          // Summary cards row (differenti per framework)
          _buildSummaryRow(),
          const SizedBox(height: 24),

          // Metriche specifiche per framework
          ..._buildFrameworkSpecificMetrics(),
        ],
      ),
    );
  }

  Widget _buildFrameworkHeader(BuildContext context) {
    return Card(
      color: _features.primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              framework == AgileFramework.scrum
                  ? Icons.flag
                  : framework == AgileFramework.kanban
                      ? Icons.view_kanban
                      : Icons.all_inclusive,
              color: _features.primaryColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Metriche ${framework.displayName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _features.primaryColor,
                    ),
                  ),
                  Text(
                    _features.focusDescription,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.info_outline, size: 20),
              onPressed: () => _showMetricsInfo(context),
              tooltip: 'Info metriche',
            ),
          ],
        ),
      ),
    );
  }

  void _showMetricsInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(_features.primaryColor == Colors.purple
                ? Icons.flag
                : _features.primaryColor == Colors.green
                    ? Icons.view_kanban
                    : Icons.all_inclusive),
            const SizedBox(width: 8),
            Text('Metriche ${framework.displayName}'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_features.hasVelocityTracking) ...[
                _buildInfoSection(
                  'Velocity',
                  'Misura la quantità di story points completati per sprint. '
                  'Aiuta a prevedere la capacità del team nei prossimi sprint.',
                  Icons.speed,
                  Colors.purple,
                ),
                const SizedBox(height: 16),
              ],
              if (_features.hasFlowMetrics) ...[
                _buildInfoSection(
                  'Lead Time',
                  'Tempo totale dalla creazione della story al completamento. '
                  'Include il tempo di attesa nel backlog.',
                  Icons.hourglass_full,
                  Colors.indigo,
                ),
                const SizedBox(height: 16),
                _buildInfoSection(
                  'Cycle Time',
                  'Tempo dall\'inizio del lavoro al completamento. '
                  'Misura l\'efficienza del processo di sviluppo.',
                  Icons.timer,
                  Colors.blue,
                ),
                const SizedBox(height: 16),
                _buildInfoSection(
                  'Throughput',
                  'Numero di item completati per unità di tempo. '
                  'Indica la produttività del team.',
                  Icons.trending_up,
                  Colors.teal,
                ),
                const SizedBox(height: 16),
              ],
              _buildInfoSection(
                'Distribuzione Stories',
                'Visualizza la distribuzione delle stories per stato. '
                'Aiuta a identificare colli di bottiglia.',
                Icons.layers,
                Colors.teal,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String description, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow() {
    // Metriche diverse per framework
    if (framework == AgileFramework.kanban) {
      return _buildKanbanSummary();
    } else if (framework == AgileFramework.scrum) {
      return _buildScrumSummary();
    } else {
      // Hybrid: mostra mix
      return _buildHybridSummary();
    }
  }

  Widget _buildScrumSummary() {
    final completedSprints = sprints.where((s) => s.status == SprintStatus.completed).length;
    final avgVelocity = _calculateAverageVelocity();
    final totalStories = stories.length;
    final completedStories = stories.where((s) => s.status == StoryStatus.done).length;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Sprint Completati',
            '$completedSprints',
            '${sprints.length} totali',
            Icons.flag,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Velocity Media',
            avgVelocity.toStringAsFixed(1),
            'pts/sprint',
            Icons.speed,
            Colors.purple,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Stories Completate',
            '$completedStories',
            '$totalStories totali',
            Icons.check_circle,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Story Points',
            '${_getTotalCompletedPoints()}',
            '${_getTotalPlannedPoints()} pianificati',
            Icons.stars,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildKanbanSummary() {
    final totalItems = stories.length;
    final completedItems = stories.where((s) => s.status == StoryStatus.done).length;
    final inProgressItems = stories.where((s) => s.status == StoryStatus.inProgress).length;
    final avgCycleTime = _calculateAverageCycleTime();
    final avgLeadTime = _calculateAverageLeadTime();
    final throughput = _calculateWeeklyThroughput();

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Items Completati',
            '$completedItems',
            '$totalItems totali',
            Icons.done_all,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'In Lavorazione',
            '$inProgressItems',
            'work in progress',
            Icons.engineering,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Cycle Time Medio',
            avgCycleTime > 0 ? avgCycleTime.toStringAsFixed(1) : '-',
            'giorni',
            Icons.timer,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Throughput',
            throughput > 0 ? throughput.toStringAsFixed(1) : '-',
            'items/settimana',
            Icons.trending_up,
            Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _buildHybridSummary() {
    final completedSprints = sprints.where((s) => s.status == SprintStatus.completed).length;
    final avgVelocity = _calculateAverageVelocity();
    final avgCycleTime = _calculateAverageCycleTime();
    final completedStories = stories.where((s) => s.status == StoryStatus.done).length;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Sprint',
            '$completedSprints',
            '${sprints.length} totali',
            Icons.flag,
            Colors.purple,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Velocity',
            avgVelocity.toStringAsFixed(1),
            'pts/sprint',
            Icons.speed,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Cycle Time',
            avgCycleTime > 0 ? avgCycleTime.toStringAsFixed(1) : '-',
            'giorni',
            Icons.timer,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Completate',
            '$completedStories',
            '${stories.length} totali',
            Icons.check_circle,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFrameworkSpecificMetrics() {
    final widgets = <Widget>[];

    // Scrum-specific: Velocity Trend
    if (_features.hasVelocityTracking) {
      widgets.add(VelocityTrendWidget(sprints: sprints));
      widgets.add(const SizedBox(height: 24));
    }

    // Kanban-specific: Lead Time & Throughput
    if (_features.hasFlowMetrics) {
      widgets.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LeadTimeWidget(stories: stories),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ThroughputWidget(stories: stories),
            ),
          ],
        ),
      );
      widgets.add(const SizedBox(height: 24));
    }

    // Common: Distribution & Cycle Time
    widgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CumulativeFlowWidget(stories: stories),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _features.hasFlowMetrics
                ? CycleTimeWidget(stories: stories)
                : StoryCompletionWidget(stories: stories),
          ),
        ],
      ),
    );
    widgets.add(const SizedBox(height: 24));

    // Scrum-specific: Estimation Accuracy
    if (_features.hasVelocityTracking) {
      widgets.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CycleTimeWidget(stories: stories),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: EstimationAccuracyWidget(sprints: sprints),
            ),
          ],
        ),
      );
    }

    return widgets;
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateAverageVelocity() {
    final completed = sprints.where((s) => s.velocity != null).toList();
    if (completed.isEmpty) return 0;
    return completed.fold<double>(0, (sum, s) => sum + s.velocity!) / completed.length;
  }

  double _calculateAverageCycleTime() {
    final completedStories = stories.where(
      (s) => s.status == StoryStatus.done && s.startedAt != null && s.completedAt != null
    ).toList();
    if (completedStories.isEmpty) return 0;

    final cycleTimes = completedStories.map((s) =>
      s.completedAt!.difference(s.startedAt!).inDays.toDouble()
    ).toList();

    return cycleTimes.reduce((a, b) => a + b) / cycleTimes.length;
  }

  double _calculateAverageLeadTime() {
    final completedStories = stories.where(
      (s) => s.status == StoryStatus.done && s.completedAt != null
    ).toList();
    if (completedStories.isEmpty) return 0;

    final leadTimes = completedStories.map((s) =>
      s.completedAt!.difference(s.createdAt).inDays.toDouble()
    ).toList();

    return leadTimes.reduce((a, b) => a + b) / leadTimes.length;
  }

  double _calculateWeeklyThroughput() {
    final completedStories = stories.where(
      (s) => s.status == StoryStatus.done && s.completedAt != null
    ).toList();
    if (completedStories.isEmpty) return 0;

    // Calcola throughput delle ultime 4 settimane
    final fourWeeksAgo = DateTime.now().subtract(const Duration(days: 28));
    final recentCompleted = completedStories.where(
      (s) => s.completedAt!.isAfter(fourWeeksAgo)
    ).length;

    return recentCompleted / 4.0; // items per settimana
  }

  int _getTotalCompletedPoints() {
    return stories
        .where((s) => s.status == StoryStatus.done)
        .fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
  }

  int _getTotalPlannedPoints() {
    return stories.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
  }
}

/// Widget per visualizzare trend velocity
class VelocityTrendWidget extends StatelessWidget {
  final List<SprintModel> sprints;

  const VelocityTrendWidget({
    super.key,
    required this.sprints,
  });

  @override
  Widget build(BuildContext context) {
    final completedSprints = sprints
        .where((s) => s.status == SprintStatus.completed && s.velocity != null)
        .toList()
      ..sort((a, b) => a.number.compareTo(b.number));

    if (completedSprints.isEmpty) {
      return _buildEmptyState();
    }

    final avgVelocity = completedSprints.fold<double>(0, (sum, s) => sum + s.velocity!) /
        completedSprints.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.trending_up, color: Colors.purple),
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
              child: LineChart(
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
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < completedSprints.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'S${completedSprints[index].number}',
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
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    // Velocity line
                    LineChartBarData(
                      spots: completedSprints.asMap().entries.map((e) =>
                        FlSpot(e.key.toDouble(), e.value.velocity!)
                      ).toList(),
                      isCurved: true,
                      color: Colors.purple,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                            radius: 5,
                            color: Colors.purple,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.purple.withOpacity(0.1),
                      ),
                    ),
                    // Average line
                    LineChartBarData(
                      spots: List.generate(completedSprints.length, (i) =>
                        FlSpot(i.toDouble(), avgVelocity)
                      ),
                      isCurved: false,
                      color: Colors.orange,
                      barWidth: 2,
                      dashArray: [5, 5],
                      dotData: const FlDotData(show: false),
                    ),
                  ],
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
            Icon(Icons.trending_up, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessun dato velocity',
              style: TextStyle(color: Colors.grey[600]),
            ),
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

/// Widget Lead Time (Kanban-specific)
class LeadTimeWidget extends StatelessWidget {
  final List<UserStoryModel> stories;

  const LeadTimeWidget({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    final completedStories = stories.where(
      (s) => s.status == StoryStatus.done && s.completedAt != null
    ).toList();

    if (completedStories.isEmpty) {
      return _buildEmptyState();
    }

    // Calculate lead times
    final leadTimes = completedStories.map((s) =>
      s.completedAt!.difference(s.createdAt).inDays
    ).toList();

    final avgLeadTime = leadTimes.reduce((a, b) => a + b) / leadTimes.length;
    final minLeadTime = leadTimes.reduce((a, b) => a < b ? a : b);
    final maxLeadTime = leadTimes.reduce((a, b) => a > b ? a : b);

    // Calculate percentiles for predictability
    leadTimes.sort();
    final p50Index = (leadTimes.length * 0.5).floor();
    final p85Index = (leadTimes.length * 0.85).floor().clamp(0, leadTimes.length - 1);
    final p50 = leadTimes[p50Index];
    final p85 = leadTimes[p85Index];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.hourglass_full, color: Colors.indigo),
                const SizedBox(width: 8),
                const Text(
                  'Lead Time',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Tooltip(
                  message: 'Tempo dalla creazione al completamento',
                  child: Icon(Icons.info_outline, size: 18, color: Colors.grey[400]),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeMetric('Media', avgLeadTime.toStringAsFixed(1), Colors.indigo),
                _buildTimeMetric('Min', '$minLeadTime', Colors.green),
                _buildTimeMetric('Max', '$maxLeadTime', Colors.red),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Prevedibilità',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildPercentileBar('50%', p50, maxLeadTime, Colors.green),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPercentileBar('85%', p85, maxLeadTime, Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Il 85% degli item viene completato in ≤$p85 giorni',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                'gg',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPercentileBar(String label, int value, int max, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            Text('$value gg', style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: max > 0 ? value / max : 0,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_full, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessun dato lead time',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              'Completa almeno un item per calcolare',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget Throughput (Kanban-specific)
class ThroughputWidget extends StatelessWidget {
  final List<UserStoryModel> stories;

  const ThroughputWidget({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    final completedStories = stories.where(
      (s) => s.status == StoryStatus.done && s.completedAt != null
    ).toList();

    if (completedStories.isEmpty) {
      return _buildEmptyState();
    }

    // Calculate weekly throughput for last 8 weeks
    final weeklyData = <int, int>{};
    final now = DateTime.now();

    for (int i = 0; i < 8; i++) {
      final weekStart = now.subtract(Duration(days: (i + 1) * 7));
      final weekEnd = now.subtract(Duration(days: i * 7));

      final count = completedStories.where((s) =>
        s.completedAt!.isAfter(weekStart) && s.completedAt!.isBefore(weekEnd)
      ).length;

      weeklyData[7 - i] = count;
    }

    final avgThroughput = weeklyData.values.reduce((a, b) => a + b) / weeklyData.length;
    final maxThroughput = weeklyData.values.reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.trending_up, color: Colors.teal),
                const SizedBox(width: 8),
                const Text(
                  'Throughput',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${avgThroughput.toStringAsFixed(1)}/sett',
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: weeklyData.entries.map((entry) {
                  final height = maxThroughput > 0
                      ? (entry.value / maxThroughput * 100)
                      : 0.0;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${entry.value}',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: height.clamp(4, 100),
                            decoration: BoxDecoration(
                              color: entry.value >= avgThroughput
                                  ? Colors.teal
                                  : Colors.teal.withOpacity(0.5),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'W${entry.key}',
                            style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Items completati per settimana (ultime 8 settimane)',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
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
            Icon(Icons.trending_up, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessun dato throughput',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              'Completa almeno un item per calcolare',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget Cumulative Flow Diagram
class CumulativeFlowWidget extends StatelessWidget {
  final List<UserStoryModel> stories;

  const CumulativeFlowWidget({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    final statusCounts = <StoryStatus, int>{};
    for (final status in StoryStatus.values) {
      statusCounts[status] = stories.where((s) => s.status == status).length;
    }

    final total = stories.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.layers, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Distribuzione Items',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (total == 0)
              const Center(
                child: Text('Nessun item', style: TextStyle(color: Colors.grey)),
              )
            else ...[
              // Stacked bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 40,
                  child: Row(
                    children: StoryStatus.values.map((status) {
                      final count = statusCounts[status] ?? 0;
                      final percent = count / total;
                      if (percent == 0) return const SizedBox.shrink();
                      return Expanded(
                        flex: (percent * 100).round(),
                        child: Container(
                          color: status.color,
                          child: Center(
                            child: count > 0
                                ? Text(
                                    '$count',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Legend
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: StoryStatus.values.map((status) {
                  final count = statusCounts[status] ?? 0;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: status.color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${status.displayName}: $count',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Widget per story completion rate
class StoryCompletionWidget extends StatelessWidget {
  final List<UserStoryModel> stories;

  const StoryCompletionWidget({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    final totalStories = stories.length;
    final completedStories = stories.where((s) => s.status == StoryStatus.done).length;
    final completionRate = totalStories > 0 ? completedStories / totalStories : 0.0;

    // By priority
    final byPriority = <StoryPriority, Map<String, int>>{};
    for (final priority in StoryPriority.values) {
      final total = stories.where((s) => s.priority == priority).length;
      final completed = stories.where((s) => s.priority == priority && s.status == StoryStatus.done).length;
      byPriority[priority] = {'total': total, 'completed': completed};
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.pie_chart, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Completion Rate',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Overall completion
            Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    children: [
                      CircularProgressIndicator(
                        value: completionRate,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation(Colors.green),
                      ),
                      Center(
                        child: Text(
                          '${(completionRate * 100).round()}%',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$completedStories su $totalStories',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'items completati',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            // By priority
            ...StoryPriority.values.map((priority) {
              final data = byPriority[priority]!;
              final total = data['total']!;
              final completed = data['completed']!;
              if (total == 0) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: priority.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        priority.displayName,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: priority.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: completed / total,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation(priority.color),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$completed/$total',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// Widget per cycle time analysis
class CycleTimeWidget extends StatelessWidget {
  final List<UserStoryModel> stories;

  const CycleTimeWidget({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    final completedStories = stories.where(
      (s) => s.status == StoryStatus.done && s.startedAt != null && s.completedAt != null
    ).toList();

    if (completedStories.isEmpty) {
      return _buildEmptyState();
    }

    // Calculate cycle times
    final cycleTimes = completedStories.map((s) =>
      s.completedAt!.difference(s.startedAt!).inDays
    ).toList();

    final avgCycleTime = cycleTimes.reduce((a, b) => a + b) / cycleTimes.length;
    final minCycleTime = cycleTimes.reduce((a, b) => a < b ? a : b);
    final maxCycleTime = cycleTimes.reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Cycle Time',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Tooltip(
                  message: 'Tempo dall\'inizio lavoro al completamento',
                  child: Icon(Icons.info_outline, size: 18, color: Colors.grey[400]),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeMetric('Media', avgCycleTime.toStringAsFixed(1), Colors.blue),
                _buildTimeMetric('Min', '$minCycleTime', Colors.green),
                _buildTimeMetric('Max', '$maxCycleTime', Colors.red),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Basato su ${completedStories.length} items completati',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                'gg',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessun dato cycle time',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              'Completa almeno un item per calcolare',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget per estimation accuracy
class EstimationAccuracyWidget extends StatelessWidget {
  final List<SprintModel> sprints;

  const EstimationAccuracyWidget({
    super.key,
    required this.sprints,
  });

  @override
  Widget build(BuildContext context) {
    final completedSprints = sprints.where(
      (s) => s.status == SprintStatus.completed && s.plannedPoints > 0
    ).toList();

    if (completedSprints.isEmpty) {
      return _buildEmptyState();
    }

    // Calculate accuracy for each sprint
    final accuracies = completedSprints.map((s) =>
      (s.completedPoints / s.plannedPoints * 100).clamp(0.0, 150.0)
    ).toList();

    final avgAccuracy = accuracies.reduce((a, b) => a + b) / accuracies.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.analytics, color: Colors.orange),
                const SizedBox(width: 8),
                const Text(
                  'Estimation Accuracy',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getAccuracyColor(avgAccuracy).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${avgAccuracy.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getAccuracyColor(avgAccuracy),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Sprint by sprint
            ...completedSprints.take(5).map((sprint) {
              final accuracy = sprint.completedPoints / sprint.plannedPoints * 100;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sprint ${sprint.number}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          '${sprint.completedPoints}/${sprint.plannedPoints} pts (${accuracy.toStringAsFixed(0)}%)',
                          style: TextStyle(
                            fontSize: 11,
                            color: _getAccuracyColor(accuracy),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (accuracy / 100).clamp(0.0, 1.5),
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(_getAccuracyColor(accuracy)),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              );
            }),
            if (completedSprints.length > 5)
              Text(
                '+${completedSprints.length - 5} altri sprint',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
          ],
        ),
      ),
    );
  }

  Color _getAccuracyColor(double accuracy) {
    if (accuracy >= 90 && accuracy <= 110) return Colors.green;
    if (accuracy >= 70 && accuracy <= 130) return Colors.orange;
    return Colors.red;
  }

  Widget _buildEmptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessun dato accuracy',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              'Completa almeno uno sprint',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget compatto per mostrare metriche key
class MetricsQuickViewWidget extends StatelessWidget {
  final List<SprintModel> sprints;
  final List<UserStoryModel> stories;
  final AgileFramework framework;
  final VoidCallback? onTap;

  const MetricsQuickViewWidget({
    super.key,
    required this.sprints,
    required this.stories,
    this.framework = AgileFramework.scrum,
    this.onTap,
  });

  FrameworkFeatures get _features => FrameworkFeatures(framework);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.analytics, color: _features.primaryColor),
                  const SizedBox(width: 8),
                  const Text(
                    'Metriche',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildQuickMetrics(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildQuickMetrics() {
    if (framework == AgileFramework.kanban) {
      // Kanban: Cycle Time, Throughput, WIP
      final avgCycleTime = _calculateAverageCycleTime();
      final inProgress = stories.where((s) => s.status == StoryStatus.inProgress).length;
      final throughput = _calculateWeeklyThroughput();

      return [
        _buildMetricColumn('Cycle Time', avgCycleTime > 0 ? avgCycleTime.toStringAsFixed(1) : '-', 'gg', Colors.blue),
        _buildMetricColumn('In Progress', '$inProgress', 'items', Colors.orange),
        _buildMetricColumn('Throughput', throughput > 0 ? throughput.toStringAsFixed(1) : '-', '/sett', Colors.teal),
      ];
    } else if (framework == AgileFramework.scrum) {
      // Scrum: Velocity, Completion, Sprint days remaining
      final avgVelocity = _calculateAverageVelocity();
      final completionRate = _calculateCompletionRate();
      final activeSprint = sprints.where((s) => s.status == SprintStatus.active).firstOrNull;

      return [
        _buildMetricColumn('Velocity', avgVelocity.toStringAsFixed(1), 'pts', Colors.purple),
        _buildMetricColumn('Completamento', '${(completionRate * 100).round()}', '%', Colors.green),
        if (activeSprint != null)
          _buildMetricColumn('Sprint', '${activeSprint.daysRemaining}', 'gg', Colors.blue),
      ];
    } else {
      // Hybrid: mix of both
      final avgVelocity = _calculateAverageVelocity();
      final avgCycleTime = _calculateAverageCycleTime();
      final completionRate = _calculateCompletionRate();

      return [
        _buildMetricColumn('Velocity', avgVelocity.toStringAsFixed(1), 'pts', Colors.purple),
        _buildMetricColumn('Cycle', avgCycleTime > 0 ? avgCycleTime.toStringAsFixed(1) : '-', 'gg', Colors.blue),
        _buildMetricColumn('Done', '${(completionRate * 100).round()}', '%', Colors.green),
      ];
    }
  }

  Widget _buildMetricColumn(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 2, left: 2),
              child: Text(
                unit,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  double _calculateAverageVelocity() {
    final completed = sprints.where((s) => s.velocity != null).toList();
    if (completed.isEmpty) return 0;
    return completed.fold<double>(0, (sum, s) => sum + s.velocity!) / completed.length;
  }

  double _calculateAverageCycleTime() {
    final completedStories = stories.where(
      (s) => s.status == StoryStatus.done && s.startedAt != null && s.completedAt != null
    ).toList();
    if (completedStories.isEmpty) return 0;

    final cycleTimes = completedStories.map((s) =>
      s.completedAt!.difference(s.startedAt!).inDays.toDouble()
    ).toList();

    return cycleTimes.reduce((a, b) => a + b) / cycleTimes.length;
  }

  double _calculateWeeklyThroughput() {
    final completedStories = stories.where(
      (s) => s.status == StoryStatus.done && s.completedAt != null
    ).toList();
    if (completedStories.isEmpty) return 0;

    final fourWeeksAgo = DateTime.now().subtract(const Duration(days: 28));
    final recentCompleted = completedStories.where(
      (s) => s.completedAt!.isAfter(fourWeeksAgo)
    ).length;

    return recentCompleted / 4.0;
  }

  double _calculateCompletionRate() {
    if (stories.isEmpty) return 0;
    final completed = stories.where((s) => s.status == StoryStatus.done).length;
    return completed / stories.length;
  }
}
