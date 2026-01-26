import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../services/cfd_data_service.dart';

/// Dialog that displays a Cumulative Flow Diagram for a Smart Todo list
class CfdChartDialog extends StatefulWidget {
  final TodoListModel list;

  const CfdChartDialog({
    super.key,
    required this.list,
  });

  @override
  State<CfdChartDialog> createState() => _CfdChartDialogState();
}

class _CfdChartDialogState extends State<CfdChartDialog> {
  final CfdDataService _cfdService = CfdDataService();
  CfdChartData? _chartData;
  bool _isLoading = true;
  String? _error;

  // Date range selection
  late DateTime _startDate;
  late DateTime _endDate;
  int _selectedDays = 30; // Default to last 30 days

  @override
  void initState() {
    super.initState();
    _initializeDateRange();
    _loadChartData();
  }

  void _initializeDateRange() {
    _endDate = DateTime.now();
    _startDate = _endDate.subtract(Duration(days: _selectedDays - 1));
  }

  Future<void> _loadChartData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _cfdService.calculateCfdData(
        listId: widget.list.id,
        columns: widget.list.columns,
        startDate: _startDate,
        endDate: _endDate,
      );

      setState(() {
        _chartData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onDateRangeChanged(int days) {
    setState(() {
      _selectedDays = days;
    });
    _initializeDateRange();
    _loadChartData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 900, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(context, l10n, isDark),

            // Date range selector
            _buildDateRangeSelector(l10n, isDark),

            // Chart area
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? _buildErrorView(l10n)
                      : _chartData == null || _chartData!.isEmpty
                          ? _buildEmptyView(l10n)
                          : _buildChart(isDark),
            ),

            // Legend
            if (_chartData != null && !_chartData!.isEmpty)
              _buildLegend(isDark),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations? l10n, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.blue.shade50,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.stacked_line_chart,
            color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n?.smartTodoCfdTitle ?? 'Cumulative Flow Diagram',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.blue.shade900,
                  ),
                ),
                Text(
                  widget.list.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey.shade400 : Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeSelector(AppLocalizations? l10n, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            l10n?.smartTodoCfdDateRange ?? 'Date Range:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 12),
          _buildDateRangeChip(7, l10n?.smartTodoCfd7Days ?? '7 days', isDark),
          const SizedBox(width: 8),
          _buildDateRangeChip(14, l10n?.smartTodoCfd14Days ?? '14 days', isDark),
          const SizedBox(width: 8),
          _buildDateRangeChip(30, l10n?.smartTodoCfd30Days ?? '30 days', isDark),
          const SizedBox(width: 8),
          _buildDateRangeChip(90, l10n?.smartTodoCfd90Days ?? '90 days', isDark),
        ],
      ),
    );
  }

  Widget _buildDateRangeChip(int days, String label, bool isDark) {
    final isSelected = _selectedDays == days;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => _onDateRangeChanged(days),
      selectedColor: Colors.blue,
      labelStyle: TextStyle(
        color: isSelected
            ? Colors.white
            : isDark
                ? Colors.grey.shade300
                : Colors.grey.shade700,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildErrorView(AppLocalizations? l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            l10n?.smartTodoCfdError ?? 'Error loading chart data',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _loadChartData,
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
          Text(
            l10n?.smartTodoCfdNoData ?? 'No data available for this period',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            l10n?.smartTodoCfdNoDataHint ?? 'Tasks movements will be tracked here',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(bool isDark) {
    final dataPoints = _chartData!.dataPoints;
    final columns = _chartData!.columns;

    if (dataPoints.isEmpty || columns.isEmpty) {
      return const Center(child: Text('No data'));
    }

    // Build line bar data for stacked area chart
    final lineBarsData = <LineChartBarData>[];

    // Create cumulative stacked data
    // For stacked area, each column's values are cumulative sum of all columns below it
    for (int colIndex = 0; colIndex < columns.length; colIndex++) {
      final column = columns[colIndex];
      final spots = <FlSpot>[];

      for (int i = 0; i < dataPoints.length; i++) {
        // Calculate cumulative value (sum of this column and all columns above)
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
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: columnColor.withOpacity(0.6),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
      child: LineChart(
        LineChartData(
          lineBarsData: lineBarsData,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: _getVerticalInterval(),
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
                interval: _getYAxisInterval(),
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: _getXAxisInterval(),
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= dataPoints.length) {
                    return const SizedBox.shrink();
                  }
                  final date = dataPoints[index].date;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      DateFormat('dd/MM').format(date),
                      style: TextStyle(
                        fontSize: 10,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
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
            border: Border.all(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
          ),
          minY: 0,
          maxY: _getMaxY(),
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => isDark ? Colors.grey.shade800 : Colors.white,
              tooltipBorder: BorderSide(
                color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
              ),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final index = spot.x.toInt();
                  if (index < 0 || index >= dataPoints.length) {
                    return null;
                  }

                  // Find which column this spot belongs to
                  final lineIndex = touchedSpots.indexOf(spot);
                  if (lineIndex < 0 || lineIndex >= columns.length) {
                    return null;
                  }

                  final column = columns[lineIndex];
                  final count = dataPoints[index].columnCounts[column.id] ?? 0;

                  return LineTooltipItem(
                    '${column.title}: $count',
                    TextStyle(
                      color: Color(column.colorValue),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(bool isDark) {
    final columns = _chartData!.columns;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        alignment: WrapAlignment.center,
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
              Text(
                column.title,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  double _getVerticalInterval() {
    final count = _chartData?.dataPoints.length ?? 1;
    if (count <= 7) return 1;
    if (count <= 14) return 2;
    if (count <= 30) return 5;
    return 10;
  }

  double _getXAxisInterval() {
    final count = _chartData?.dataPoints.length ?? 1;
    if (count <= 7) return 1;
    if (count <= 14) return 2;
    if (count <= 30) return 5;
    return 10;
  }

  double _getYAxisInterval() {
    final maxY = _getMaxY();
    if (maxY <= 5) return 1;
    if (maxY <= 10) return 2;
    if (maxY <= 25) return 5;
    return 10;
  }

  double _getMaxY() {
    final max = _chartData?.maxTaskCount ?? 0;
    // Add some padding above the max
    if (max <= 5) return max + 1;
    if (max <= 10) return max + 2;
    return max * 1.1;
  }
}
