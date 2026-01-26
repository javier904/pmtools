import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/cfd_metrics_model.dart';
import '../../services/cfd_data_service.dart';

/// Full-page CFD Analytics screen with comprehensive metrics
class SmartTodoCfdScreen extends StatefulWidget {
  final TodoListModel list;

  const SmartTodoCfdScreen({
    super.key,
    required this.list,
  });

  @override
  State<SmartTodoCfdScreen> createState() => _SmartTodoCfdScreenState();
}

class _SmartTodoCfdScreenState extends State<SmartTodoCfdScreen> {
  final CfdDataService _cfdService = CfdDataService();
  CfdAnalyticsData? _analyticsData;
  bool _isLoading = true;
  String? _error;

  late DateTime _startDate;
  late DateTime _endDate;
  int _selectedDays = 30;
  int? _customWipLimit;  // null = use default (teamSize * 2)

  @override
  void initState() {
    super.initState();
    _initializeDateRange();
    _loadAnalytics();
  }

  void _initializeDateRange() {
    _endDate = DateTime.now();
    _startDate = _endDate.subtract(Duration(days: _selectedDays - 1));
  }

  Future<void> _loadAnalytics() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _cfdService.calculateAnalytics(
        listId: widget.list.id,
        columns: widget.list.columns,
        startDate: _startDate,
        endDate: _endDate,
        teamSize: widget.list.participants.length,
        customWipLimit: _customWipLimit,
      );

      setState(() {
        _analyticsData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _showWipLimitDialog() {
    final l10n = AppLocalizations.of(context);
    final defaultLimit = widget.list.participants.length * 2;
    final currentLimit = _customWipLimit ?? defaultLimit;
    final controller = TextEditingController(text: currentLimit.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.smartTodoCfdWip ?? 'WIP Limit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Default: $defaultLimit (Team × 2)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n?.smartTodoCfdLimit ?? 'Limit',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.restart_alt),
                  tooltip: 'Reset to default',
                  onPressed: () {
                    controller.text = defaultLimit.toString();
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final newLimit = int.tryParse(controller.text);
              if (newLimit != null && newLimit > 0) {
                setState(() {
                  _customWipLimit = newLimit == defaultLimit ? null : newLimit;
                });
                Navigator.of(context).pop();
                _loadAnalytics();  // Reload with new limit
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onDateRangeChanged(int days) {
    setState(() {
      _selectedDays = days;
    });
    _initializeDateRange();
    _loadAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.smartTodoCfdTitle ?? 'CFD Analytics',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              widget.list.title,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
        actions: [
          // Date range selector
          ...[7, 14, 30, 90].map((days) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ChoiceChip(
              label: Text('${days}d'),
              selected: _selectedDays == days,
              onSelected: (_) => _onDateRangeChanged(days),
              selectedColor: Colors.blue,
              labelStyle: TextStyle(
                color: _selectedDays == days ? Colors.white : null,
                fontSize: 12,
              ),
              visualDensity: VisualDensity.compact,
            ),
          )),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAnalytics,
            tooltip: l10n?.smartTodoCfdRetry ?? 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorView(l10n)
              : _analyticsData == null
                  ? _buildEmptyView(l10n)
                  : _buildAnalyticsContent(isDark, l10n),
    );
  }

  Widget _buildErrorView(AppLocalizations? l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(l10n?.smartTodoCfdError ?? 'Error loading analytics'),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _loadAnalytics,
            icon: const Icon(Icons.refresh),
            label: Text(l10n?.smartTodoCfdRetry ?? 'Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView(AppLocalizations? l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics_outlined, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(l10n?.smartTodoCfdNoData ?? 'No data available'),
        ],
      ),
    );
  }

  Widget _buildAnalyticsContent(bool isDark, AppLocalizations? l10n) {
    final metrics = _analyticsData!.metrics;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CFD Chart
          _buildChartSection(isDark, l10n),
          const SizedBox(height: 24),

          // Key Metrics Cards
          _buildKeyMetricsSection(metrics, isDark, l10n),
          const SizedBox(height: 24),

          // Flow Analysis & Bottlenecks Row
          _buildFlowAndBottlenecksSection(metrics, isDark, l10n),
          const SizedBox(height: 24),

          // Aging WIP Table
          if (metrics.wip.agingTasks.isNotEmpty)
            _buildAgingWipSection(metrics.wip, isDark, l10n),
          const SizedBox(height: 24),

          // Team Balance Section
          if (metrics.teamBalance.hasData)
            _buildTeamBalanceSection(metrics.teamBalance, isDark, l10n),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CFD CHART SECTION
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildChartSection(bool isDark, AppLocalizations? l10n) {
    final chartData = _analyticsData!.chartData;
    final columns = chartData.columns;
    final dataPoints = chartData.dataPoints;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.stacked_line_chart, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  l10n?.smartTodoCfdTitle ?? 'Cumulative Flow Diagram',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: dataPoints.isEmpty
                  ? Center(child: Text(l10n?.smartTodoCfdNoData ?? 'No data'))
                  : _buildStackedAreaChart(isDark, columns, dataPoints),
            ),
            const SizedBox(height: 12),
            _buildChartLegend(columns),
          ],
        ),
      ),
    );
  }

  Widget _buildStackedAreaChart(bool isDark, List<TodoColumn> columns, List<CfdDataPoint> dataPoints) {
    final lineBarsData = <LineChartBarData>[];

    for (int colIndex = 0; colIndex < columns.length; colIndex++) {
      final column = columns[colIndex];
      final spots = <FlSpot>[];

      for (int i = 0; i < dataPoints.length; i++) {
        double cumulativeValue = 0;
        for (int j = colIndex; j < columns.length; j++) {
          cumulativeValue += (dataPoints[i].columnCounts[columns[j].id] ?? 0).toDouble();
        }
        spots.add(FlSpot(i.toDouble(), cumulativeValue));
      }

      final columnColor = Color(column.colorValue);

      lineBarsData.add(
        LineChartBarData(
          spots: spots,
          isCurved: true,
          curveSmoothness: 0.2,
          color: columnColor,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),  // Clean look - dots only on hover
          belowBarData: BarAreaData(
            show: true,
            color: columnColor.withOpacity(0.6),
          ),
        ),
      );
    }

    return LineChart(
      LineChartData(
        lineBarsData: lineBarsData,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            strokeWidth: 1,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: TextStyle(fontSize: 10, color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: _getXAxisInterval(dataPoints.length),
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= dataPoints.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat('dd/MM').format(dataPoints[index].date),
                    style: TextStyle(fontSize: 9, color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
        ),
        minY: 0,
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchSpotThreshold: 20,
          getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((index) {
              final color = barData.color ?? Colors.grey;
              return TouchedSpotIndicatorData(
                FlLine(
                  color: color.withOpacity(0.3),
                  strokeWidth: 1,
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, idx) => FlDotCirclePainter(
                    radius: 5,
                    color: color,
                    strokeWidth: 0,  // No border - clean look
                    strokeColor: Colors.transparent,
                  ),
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 8,
            tooltipPadding: const EdgeInsets.all(12),
            tooltipMargin: 16,
            maxContentWidth: 200,
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipColor: (touchedSpot) => isDark ? Colors.grey.shade800.withOpacity(0.95) : Colors.white.withOpacity(0.95),
            tooltipBorder: BorderSide(
              color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
              width: 1,
            ),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              if (touchedSpots.isEmpty) return [];

              // Get the data point index from the first spot
              final dataIndex = touchedSpots.first.x.toInt();
              if (dataIndex < 0 || dataIndex >= dataPoints.length) {
                return touchedSpots.map((spot) => null).toList();
              }

              final dataPoint = dataPoints[dataIndex];
              final date = DateFormat('dd/MM/yyyy').format(dataPoint.date);
              final total = dataPoint.totalTasks;

              // Build tooltip items - first one shows date and total
              final items = <LineTooltipItem?>[];

              for (int i = 0; i < touchedSpots.length; i++) {
                final spot = touchedSpots[i];
                final columnIndex = spot.barIndex;

                if (columnIndex < 0 || columnIndex >= columns.length) {
                  items.add(null);
                  continue;
                }

                final column = columns[columnIndex];
                final count = dataPoint.columnCounts[column.id] ?? 0;
                final columnColor = Color(column.colorValue);

                // First item shows date header
                if (i == 0) {
                  items.add(LineTooltipItem(
                    '$date\n\n${column.title}: $count',
                    TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: '',
                        style: TextStyle(color: columnColor),
                      ),
                    ],
                  ));
                } else {
                  items.add(LineTooltipItem(
                    '${column.title}: $count',
                    TextStyle(
                      color: columnColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ));
                }
              }

              // Add total at the end (on the last item)
              if (items.isNotEmpty && items.last != null) {
                final lastIndex = items.length - 1;
                final lastItem = items[lastIndex]!;
                items[lastIndex] = LineTooltipItem(
                  '${lastItem.text}\n\nTotal: $total',
                  lastItem.textStyle ?? const TextStyle(fontSize: 11),
                );
              }

              return items;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChartLegend(List<TodoColumn> columns) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: columns.map((column) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Color(column.colorValue).withOpacity(0.6),
                border: Border.all(color: Color(column.colorValue), width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 6),
            Text(column.title, style: const TextStyle(fontSize: 12)),
          ],
        );
      }).toList(),
    );
  }

  double _getXAxisInterval(int count) {
    if (count <= 7) return 1;
    if (count <= 14) return 2;
    if (count <= 30) return 5;
    return 10;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // KEY METRICS SECTION
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildKeyMetricsSection(CfdMetrics metrics, bool isDark, AppLocalizations? l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n?.smartTodoCfdKeyMetrics ?? 'Key Metrics',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildMetricCard(
              title: l10n?.smartTodoCfdLeadTime ?? 'Lead Time',
              value: metrics.leadTime.hasData
                  ? '${metrics.leadTime.averageDays.toStringAsFixed(1)}d'
                  : '-',
              subtitle: metrics.leadTime.hasData
                  ? 'P85: ${metrics.leadTime.percentile85Days.toStringAsFixed(1)}d'
                  : l10n?.smartTodoCfdNoData ?? 'No data',
              trend: metrics.leadTime.trendDirection,
              trendValue: metrics.leadTime.trendPercentage,
              icon: Icons.timer_outlined,
              color: Colors.blue,
              isDark: isDark,
              tooltip: l10n?.smartTodoCfdLeadTimeTooltip ?? 'Time from creation to completion',
              explanation: l10n?.smartTodoCfdLeadTimeExplanation,
            ),
            _buildMetricCard(
              title: l10n?.smartTodoCfdCycleTime ?? 'Cycle Time',
              value: metrics.cycleTime.hasData
                  ? '${metrics.cycleTime.averageDays.toStringAsFixed(1)}d'
                  : '-',
              subtitle: metrics.cycleTime.hasData
                  ? 'P85: ${metrics.cycleTime.percentile85Days.toStringAsFixed(1)}d'
                  : l10n?.smartTodoCfdNoData ?? 'No data',
              trend: metrics.cycleTime.trendDirection,
              trendValue: metrics.cycleTime.trendPercentage,
              icon: Icons.speed,
              color: Colors.orange,
              isDark: isDark,
              tooltip: l10n?.smartTodoCfdCycleTimeTooltip ?? 'Time from work start to completion',
              explanation: l10n?.smartTodoCfdCycleTimeExplanation,
            ),
            _buildMetricCard(
              title: l10n?.smartTodoCfdThroughput ?? 'Throughput',
              value: metrics.throughput.hasData
                  ? '${metrics.throughput.weeklyAverage.toStringAsFixed(1)}/w'
                  : '-',
              subtitle: '${metrics.throughput.totalCompleted} ${l10n?.smartTodoCfdCompleted ?? 'completed'}',
              trend: metrics.throughput.trendDirection,
              trendValue: metrics.throughput.trendPercentage,
              icon: Icons.trending_up,
              color: Colors.green,
              isDark: isDark,
              invertTrend: true,
              tooltip: l10n?.smartTodoCfdThroughputTooltip ?? 'Tasks completed per week',
              explanation: l10n?.smartTodoCfdThroughputExplanation,
            ),
            _buildMetricCard(
              title: l10n?.smartTodoCfdWip ?? 'WIP',
              value: '${metrics.wip.totalWip}',
              subtitle: '${l10n?.smartTodoCfdLimit ?? 'Limit'}: ${metrics.wip.wipLimit}${_customWipLimit != null ? ' ✏️' : ''}',
              icon: Icons.work_outline,
              color: _getWipColor(metrics.wip.status),
              isDark: isDark,
              statusIcon: _getWipStatusIcon(metrics.wip.status),
              tooltip: '${l10n?.smartTodoCfdWipTooltip ?? 'Work in progress'} - Click to edit limit',
              explanation: l10n?.smartTodoCfdWipExplanation,
              onTap: _showWipLimitDialog,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isDark,
    int? trend,
    double? trendValue,
    bool invertTrend = false,
    IconData? statusIcon,
    String? tooltip,
    String? explanation,
    VoidCallback? onTap,
  }) {
    Widget content = Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ),
              if (explanation != null)
                GestureDetector(
                  onTap: () => _showExplanationDialog(title, explanation, color),
                  child: Icon(
                    Icons.info_outline,
                    size: 16,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  ),
                ),
              if (statusIcon != null) ...[
                const SizedBox(width: 4),
                Icon(statusIcon, size: 18, color: color),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (trend != null && trend != 0) ...[
                const SizedBox(width: 8),
                _buildTrendIndicator(trend, trendValue, invertTrend),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );

    // Wrap with onTap if provided
    if (onTap != null) {
      content = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: content,
        ),
      );
    }

    if (tooltip != null) {
      return Tooltip(message: tooltip, child: content);
    }
    return content;
  }

  void _showExplanationDialog(String title, String explanation, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: SingleChildScrollView(
            child: _buildMarkdownText(explanation, isDark),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: color)),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkdownText(String text, bool isDark) {
    // Simple markdown-like rendering for **bold** text and newlines
    final List<InlineSpan> spans = [];
    final lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // Check for headers
      if (line.startsWith('**') && line.endsWith('**') && line.length > 4) {
        spans.add(TextSpan(
          text: line.substring(2, line.length - 2),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
        ));
      } else {
        // Process inline bold markers
        int lastEnd = 0;
        final boldRegex = RegExp(r'\*\*(.+?)\*\*');
        for (final match in boldRegex.allMatches(line)) {
          // Add text before bold
          if (match.start > lastEnd) {
            spans.add(TextSpan(
              text: line.substring(lastEnd, match.start),
              style: TextStyle(
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                fontSize: 13,
                height: 1.5,
              ),
            ));
          }
          // Add bold text
          spans.add(TextSpan(
            text: match.group(1),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 13,
              height: 1.5,
            ),
          ));
          lastEnd = match.end;
        }
        // Add remaining text
        if (lastEnd < line.length) {
          spans.add(TextSpan(
            text: line.substring(lastEnd),
            style: TextStyle(
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
              fontSize: 13,
              height: 1.5,
            ),
          ));
        }
      }

      // Add newline (except for last line)
      if (i < lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildTrendIndicator(int trend, double? trendValue, bool invert) {
    final isPositive = invert ? trend > 0 : trend < 0;
    final color = isPositive ? Colors.green : Colors.red;
    final icon = trend > 0 ? Icons.arrow_upward : Icons.arrow_downward;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        if (trendValue != null)
          Text(
            '${trendValue.abs().toStringAsFixed(0)}%',
            style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  Color _getWipColor(WipStatus status) {
    switch (status) {
      case WipStatus.ok:
        return Colors.green;
      case WipStatus.warning:
        return Colors.orange;
      case WipStatus.critical:
        return Colors.red;
    }
  }

  IconData _getWipStatusIcon(WipStatus status) {
    switch (status) {
      case WipStatus.ok:
        return Icons.check_circle_outline;
      case WipStatus.warning:
        return Icons.warning_amber_outlined;
      case WipStatus.critical:
        return Icons.error_outline;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FLOW & BOTTLENECKS SECTION
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildFlowAndBottlenecksSection(CfdMetrics metrics, bool isDark, AppLocalizations? l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildFlowAnalysis(metrics.flow, isDark, l10n)),
        const SizedBox(width: 16),
        Expanded(child: _buildBottleneckDetection(metrics.bottlenecks, isDark, l10n)),
      ],
    );
  }

  Widget _buildFlowAnalysis(FlowMetrics flow, bool isDark, AppLocalizations? l10n) {
    final maxCount = [flow.arrivedCount, flow.completedCount].reduce((a, b) => a > b ? a : b);
    final arrivedPercent = maxCount > 0 ? flow.arrivedCount / maxCount : 0.0;
    final completedPercent = maxCount > 0 ? flow.completedCount / maxCount : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.swap_horiz, color: Colors.purple.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n?.smartTodoCfdFlowAnalysis ?? 'Flow Analysis',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showExplanationDialog(
                    l10n?.smartTodoCfdFlowAnalysis ?? 'Flow Analysis',
                    l10n?.smartTodoCfdFlowExplanation ?? '',
                    Colors.purple.shade700,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 18,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFlowBar(
              label: l10n?.smartTodoCfdArrived ?? 'Arrived',
              count: flow.arrivedCount,
              percent: arrivedPercent,
              color: Colors.blue,
              isDark: isDark,
            ),
            const SizedBox(height: 8),
            _buildFlowBar(
              label: l10n?.smartTodoCfdCompleted ?? 'Completed',
              count: flow.completedCount,
              percent: completedPercent,
              color: Colors.green,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  flow.netFlow <= 0 ? Icons.trending_down : Icons.trending_up,
                  size: 18,
                  color: flow.netFlow <= 0 ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    flow.netFlow <= 0
                        ? l10n?.smartTodoCfdBacklogShrinking ?? 'Backlog shrinking'
                        : '${l10n?.smartTodoCfdBacklogGrowing ?? 'Backlog growing'} (+${flow.netFlow})',
                    style: TextStyle(
                      fontSize: 12,
                      color: flow.netFlow <= 0 ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlowBar({
    required String label,
    required int count,
    required double percent,
    required Color color,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            Text('$count', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percent,
          backgroundColor: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildBottleneckDetection(List<BottleneckInfo> bottlenecks, bool isDark, AppLocalizations? l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n?.smartTodoCfdBottlenecks ?? 'Bottleneck Detection',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showExplanationDialog(
                    l10n?.smartTodoCfdBottlenecks ?? 'Bottleneck Detection',
                    l10n?.smartTodoCfdBottleneckExplanation ?? '',
                    Colors.orange.shade700,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 18,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (bottlenecks.isEmpty)
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.smartTodoCfdNoBottlenecks ?? 'No bottlenecks detected',
                    style: const TextStyle(color: Colors.green, fontSize: 13),
                  ),
                ],
              )
            else
              ...bottlenecks.take(3).map((b) => _buildBottleneckItem(b, isDark, l10n)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottleneckItem(BottleneckInfo bottleneck, bool isDark, AppLocalizations? l10n) {
    final severityColor = _getSeverityColor(bottleneck.severityLevel);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: severityColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bottleneck.columnTitle,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
                Text(
                  '${bottleneck.taskCount} ${l10n?.smartTodoCfdTasks ?? 'tasks'} - ${l10n?.smartTodoCfdAvgAge ?? 'Avg'}: ${bottleneck.averageAgeDays.toStringAsFixed(1)}d',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Icon(
            _getSeverityIcon(bottleneck.severityLevel),
            color: severityColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(BottleneckSeverity severity) {
    switch (severity) {
      case BottleneckSeverity.low:
        return Colors.yellow.shade700;
      case BottleneckSeverity.medium:
        return Colors.orange;
      case BottleneckSeverity.high:
        return Colors.red;
    }
  }

  IconData _getSeverityIcon(BottleneckSeverity severity) {
    switch (severity) {
      case BottleneckSeverity.low:
        return Icons.info_outline;
      case BottleneckSeverity.medium:
        return Icons.warning_amber_outlined;
      case BottleneckSeverity.high:
        return Icons.error_outline;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // AGING WIP SECTION
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildAgingWipSection(WipMetrics wip, bool isDark, AppLocalizations? l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.hourglass_empty, color: Colors.purple.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n?.smartTodoCfdAgingWip ?? 'Aging Work in Progress',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showExplanationDialog(
                    l10n?.smartTodoCfdAgingWip ?? 'Aging Work in Progress',
                    l10n?.smartTodoCfdAgingExplanation ?? '',
                    Colors.purple.shade700,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 18,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${l10n?.smartTodoCfdAvgAge ?? 'Avg'}: ${wip.averageAge.toStringAsFixed(1)}d',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Table header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(l10n?.smartTodoCfdTask ?? 'Task', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text(l10n?.smartTodoCfdColumn ?? 'Column', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text(l10n?.smartTodoCfdAge ?? 'Age', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 30),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Table rows (show max 10)
            ...wip.agingTasks.take(10).map((task) => _buildAgingTaskRow(task, isDark)),
          ],
        ),
      ),
    );
  }

  Widget _buildAgingTaskRow(AgingTask task, bool isDark) {
    final statusColor = _getAgingStatusColor(task.status);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              task.taskTitle,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              task.columnTitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${task.ageDays.toStringAsFixed(1)}d',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
          Icon(
            _getAgingStatusIcon(task.status),
            color: statusColor,
            size: 18,
          ),
        ],
      ),
    );
  }

  Color _getAgingStatusColor(AgingStatus status) {
    switch (status) {
      case AgingStatus.ok:
        return Colors.green;
      case AgingStatus.watch:
        return Colors.orange;
      case AgingStatus.aging:
        return Colors.red;
    }
  }

  IconData _getAgingStatusIcon(AgingStatus status) {
    switch (status) {
      case AgingStatus.ok:
        return Icons.check_circle_outline;
      case AgingStatus.watch:
        return Icons.remove_circle_outline;
      case AgingStatus.aging:
        return Icons.error_outline;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TEAM BALANCE SECTION
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildTeamBalanceSection(TeamBalanceMetrics teamBalance, bool isDark, AppLocalizations? l10n) {
    final statusColor = _getBalanceStatusColor(teamBalance.status);
    final statusText = _getBalanceStatusText(teamBalance.status, l10n);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.group, color: Colors.indigo.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n?.smartTodoCfdTeamBalance ?? 'Team Balance',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showExplanationDialog(
                    l10n?.smartTodoCfdTeamBalance ?? 'Team Balance',
                    l10n?.smartTodoCfdTeamBalanceExplanation ?? '',
                    Colors.indigo.shade700,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 18,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_getBalanceStatusIcon(teamBalance.status), size: 14, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        statusText,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: statusColor),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${(teamBalance.balanceScore * 100).toStringAsFixed(0)}%',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Table header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      l10n?.smartTodoCfdMember ?? 'Member',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      l10n?.smartTodoCfdTotal ?? 'Total',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      l10n?.smartTodoCfdToDo ?? 'To Do',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      l10n?.smartTodoCfdInProgress ?? 'In Progress',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      l10n?.smartTodoCfdDone ?? 'Done',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Table rows
            ...teamBalance.members.map((member) => _buildMemberWorkloadRow(member, teamBalance, isDark)),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberWorkloadRow(MemberWorkload member, TeamBalanceMetrics teamBalance, bool isDark) {
    final averageTasks = teamBalance.totalTasks / teamBalance.members.length;
    final workloadLevel = member.levelRelativeTo(averageTasks);
    final levelColor = _getWorkloadLevelColor(workloadLevel);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: levelColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    member.displayName,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${member.totalTasks}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: levelColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${member.todoCount}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${member.wipCount}',
              style: TextStyle(fontSize: 12, color: Colors.orange.shade700),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${member.doneCount}',
              style: TextStyle(fontSize: 12, color: Colors.green.shade700),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBalanceStatusColor(BalanceStatus status) {
    switch (status) {
      case BalanceStatus.balanced:
        return Colors.green;
      case BalanceStatus.uneven:
        return Colors.orange;
      case BalanceStatus.imbalanced:
        return Colors.red;
    }
  }

  String _getBalanceStatusText(BalanceStatus status, AppLocalizations? l10n) {
    switch (status) {
      case BalanceStatus.balanced:
        return l10n?.smartTodoCfdBalanced ?? 'Balanced';
      case BalanceStatus.uneven:
        return l10n?.smartTodoCfdUneven ?? 'Uneven';
      case BalanceStatus.imbalanced:
        return l10n?.smartTodoCfdImbalanced ?? 'Imbalanced';
    }
  }

  IconData _getBalanceStatusIcon(BalanceStatus status) {
    switch (status) {
      case BalanceStatus.balanced:
        return Icons.check_circle_outline;
      case BalanceStatus.uneven:
        return Icons.warning_amber_outlined;
      case BalanceStatus.imbalanced:
        return Icons.error_outline;
    }
  }

  Color _getWorkloadLevelColor(WorkloadLevel level) {
    switch (level) {
      case WorkloadLevel.low:
        return Colors.blue;
      case WorkloadLevel.normal:
        return Colors.grey.shade600;
      case WorkloadLevel.high:
        return Colors.red;
    }
  }
}
