import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

/// Widget che visualizza un grafico scatter plot della matrice di Eisenhower
///
/// Mostra le attività come punti posizionati in base ai loro valori
/// di urgenza (asse X) e importanza (asse Y)
class EisenhowerScatterChartWidget extends StatefulWidget {
  final List<EisenhowerActivityModel> activities;
  final Function(EisenhowerActivityModel)? onActivityTap;
  final double threshold;

  const EisenhowerScatterChartWidget({
    super.key,
    required this.activities,
    this.onActivityTap,
    this.threshold = 5.5,
  });

  @override
  State<EisenhowerScatterChartWidget> createState() => _EisenhowerScatterChartWidgetState();
}

class _EisenhowerScatterChartWidgetState extends State<EisenhowerScatterChartWidget> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.scatter_plot, color: AppColors.secondary),
              const SizedBox(width: 8),
              const Text(
                'Distribuzione Attività',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // Legenda
              _buildLegend(),
            ],
          ),
          const SizedBox(height: 16),
          // Grafico
          Expanded(
            child: _buildChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLegendItem('Q1', Color(EisenhowerQuadrant.q1.colorValue)),
        const SizedBox(width: 8),
        _buildLegendItem('Q2', Color(EisenhowerQuadrant.q2.colorValue)),
        const SizedBox(width: 8),
        _buildLegendItem('Q3', Color(EisenhowerQuadrant.q3.colorValue)),
        const SizedBox(width: 8),
        _buildLegendItem('Q4', Color(EisenhowerQuadrant.q4.colorValue)),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildChart() {
    final votedActivities = widget.activities.where((a) => a.hasVotes).toList();

    if (votedActivities.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.scatter_plot, size: 48, color: context.borderColor),
            const SizedBox(height: 8),
            Text(
              'Nessuna attività votata',
              style: TextStyle(color: context.textTertiaryColor),
            ),
            const SizedBox(height: 4),
            Text(
              'Vota le attività per visualizzarle nel grafico',
              style: TextStyle(fontSize: 12, color: context.textMutedColor),
            ),
          ],
        ),
      );
    }

    // Calcola le proporzioni per il background colorato
    // Il grafico va da 0 a 11, threshold a 5.5
    // Margini: left=50 (per asse Y), bottom=50 (per asse X), top/right=10
    const double leftMargin = 50;
    const double bottomMargin = 50;
    const double topMargin = 10;
    const double rightMargin = 10;

    return LayoutBuilder(
      builder: (context, constraints) {
        final chartWidth = constraints.maxWidth - leftMargin - rightMargin;
        final chartHeight = constraints.maxHeight - topMargin - bottomMargin;

        // Posizione della soglia (5.5 su scala 0-11)
        final thresholdRatioX = widget.threshold / 11;
        final thresholdRatioY = widget.threshold / 11;

        final thresholdX = leftMargin + (chartWidth * thresholdRatioX);
        final thresholdY = topMargin + (chartHeight * (1 - thresholdRatioY)); // Invertito per Y

        return Stack(
          children: [
            // Background colorato per i 4 quadranti
            Positioned.fill(
              child: CustomPaint(
                painter: _QuadrantBackgroundPainter(
                  threshold: widget.threshold,
                  leftMargin: leftMargin,
                  bottomMargin: bottomMargin,
                  topMargin: topMargin,
                  rightMargin: rightMargin,
                ),
              ),
            ),
            // Grafico scatter
            ScatterChart(
              ScatterChartData(
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 11,
                scatterSpots: _buildSpots(votedActivities),
                scatterTouchData: ScatterTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: ScatterTouchTooltipData(
                    getTooltipColor: (spot) => Colors.blueGrey.withOpacity(0.9),
                    getTooltipItems: (spot) {
                      final activity = votedActivities.firstWhere(
                        (a) =>
                            (a.aggregatedUrgency - spot.x).abs() < 0.01 &&
                            (a.aggregatedImportance - spot.y).abs() < 0.01,
                        orElse: () => votedActivities.first,
                      );
                      return ScatterTooltipItem(
                        '${activity.title}\n'
                        'Urgenza: ${activity.aggregatedUrgency.toStringAsFixed(1)}\n'
                        'Importanza: ${activity.aggregatedImportance.toStringAsFixed(1)}\n'
                        '${activity.quadrant?.title ?? ""}',
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.left,
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    if (event is FlTapUpEvent && response?.touchedSpot != null) {
                      final spotIndex = response!.touchedSpot!.spotIndex;
                      if (spotIndex >= 0 && spotIndex < votedActivities.length) {
                        widget.onActivityTap?.call(votedActivities[spotIndex]);
                      }
                    }
                    setState(() {
                      _touchedIndex = response?.touchedSpot?.spotIndex;
                    });
                  },
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    if (value == widget.threshold) {
                      return FlLine(
                        color: context.textPrimaryColor.withOpacity(0.87),
                        strokeWidth: 2,
                      );
                    }
                    return FlLine(
                      color: context.borderColor,
                      strokeWidth: 0.5,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    if (value == widget.threshold) {
                      return FlLine(
                        color: context.textPrimaryColor.withOpacity(0.87),
                        strokeWidth: 2,
                      );
                    }
                    return FlLine(
                      color: context.borderColor,
                      strokeWidth: 0.5,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      'IMPORTANZA',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: context.textSecondaryColor,
                      ),
                    ),
                    axisNameSize: 20,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        if (value == 0 || value > 10) return const SizedBox.shrink();
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(fontSize: 10, color: context.textSecondaryColor),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameWidget: Text(
                      'URGENZA',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: context.textSecondaryColor,
                      ),
                    ),
                    axisNameSize: 20,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        if (value == 0 || value > 10) return const SizedBox.shrink();
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(fontSize: 10, color: context.textSecondaryColor),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: context.textMutedColor),
                ),
                scatterLabelSettings: ScatterLabelSettings(showLabel: false),
              ),
            ),
          ],
        );
      },
    );
  }

  List<ScatterSpot> _buildSpots(List<EisenhowerActivityModel> activities) {
    return activities.asMap().entries.map((entry) {
      final index = entry.key;
      final activity = entry.value;
      final quadrant = activity.quadrant ?? EisenhowerQuadrant.q4;
      final color = Color(quadrant.colorValue);
      final isSelected = _touchedIndex == index;

      return ScatterSpot(
        activity.aggregatedUrgency,
        activity.aggregatedImportance,
        dotPainter: FlDotCirclePainter(
          radius: isSelected ? 10 : 8,
          color: color,
          strokeWidth: isSelected ? 3 : 1,
          strokeColor: isSelected ? context.surfaceColor : color.withOpacity(0.5),
        ),
      );
    }).toList();
  }
}

/// Painter per disegnare lo sfondo colorato dei 4 quadranti
class _QuadrantBackgroundPainter extends CustomPainter {
  final double threshold;
  final double leftMargin;
  final double bottomMargin;
  final double topMargin;
  final double rightMargin;

  _QuadrantBackgroundPainter({
    required this.threshold,
    required this.leftMargin,
    required this.bottomMargin,
    required this.topMargin,
    required this.rightMargin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final chartWidth = size.width - leftMargin - rightMargin;
    final chartHeight = size.height - topMargin - bottomMargin;

    // Calcola la posizione della soglia (5.5 su scala 0-11)
    final thresholdRatioX = threshold / 11;
    final thresholdRatioY = threshold / 11;

    final thresholdX = leftMargin + (chartWidth * thresholdRatioX);
    final thresholdY = topMargin + (chartHeight * (1 - thresholdRatioY));

    // Colori dei quadranti (con opacità leggera)
    final q1Color = Color(EisenhowerQuadrant.q1.colorValue).withOpacity(0.15); // Rosso - Alto destra
    final q2Color = Color(EisenhowerQuadrant.q2.colorValue).withOpacity(0.15); // Verde - Alto sinistra
    final q3Color = Color(EisenhowerQuadrant.q3.colorValue).withOpacity(0.15); // Giallo - Basso destra
    final q4Color = Color(EisenhowerQuadrant.q4.colorValue).withOpacity(0.15); // Grigio - Basso sinistra

    // Q2 - Alto Sinistra (Non Urgente + Importante) - VERDE
    canvas.drawRect(
      Rect.fromLTRB(leftMargin, topMargin, thresholdX, thresholdY),
      Paint()..color = q2Color,
    );

    // Q1 - Alto Destra (Urgente + Importante) - ROSSO
    canvas.drawRect(
      Rect.fromLTRB(thresholdX, topMargin, size.width - rightMargin, thresholdY),
      Paint()..color = q1Color,
    );

    // Q4 - Basso Sinistra (Non Urgente + Non Importante) - GRIGIO
    canvas.drawRect(
      Rect.fromLTRB(leftMargin, thresholdY, thresholdX, size.height - bottomMargin),
      Paint()..color = q4Color,
    );

    // Q3 - Basso Destra (Urgente + Non Importante) - GIALLO
    canvas.drawRect(
      Rect.fromLTRB(thresholdX, thresholdY, size.width - rightMargin, size.height - bottomMargin),
      Paint()..color = q3Color,
    );

    // Aggiungi etichette ai quadranti
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Q1 label
    _drawQuadrantLabel(canvas, textPainter, 'Q1 - FAI',
      thresholdX + (size.width - rightMargin - thresholdX) / 2,
      topMargin + (thresholdY - topMargin) / 2,
      Color(EisenhowerQuadrant.q1.colorValue),
    );

    // Q2 label
    _drawQuadrantLabel(canvas, textPainter, 'Q2 - PIANIFICA',
      leftMargin + (thresholdX - leftMargin) / 2,
      topMargin + (thresholdY - topMargin) / 2,
      Color(EisenhowerQuadrant.q2.colorValue),
    );

    // Q3 label
    _drawQuadrantLabel(canvas, textPainter, 'Q3 - DELEGA',
      thresholdX + (size.width - rightMargin - thresholdX) / 2,
      thresholdY + (size.height - bottomMargin - thresholdY) / 2,
      Color(EisenhowerQuadrant.q3.colorValue).withOpacity(0.8),
    );

    // Q4 label
    _drawQuadrantLabel(canvas, textPainter, 'Q4 - ELIMINA',
      leftMargin + (thresholdX - leftMargin) / 2,
      thresholdY + (size.height - bottomMargin - thresholdY) / 2,
      Color(EisenhowerQuadrant.q4.colorValue),
    );
  }

  void _drawQuadrantLabel(Canvas canvas, TextPainter textPainter, String text, double x, double y, Color color) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(
        color: color.withOpacity(0.6),
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2, y - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Widget compatto per mostrare il grafico in una card
class EisenhowerScatterChartCard extends StatelessWidget {
  final List<EisenhowerActivityModel> activities;
  final VoidCallback? onExpandTap;

  const EisenhowerScatterChartCard({
    super.key,
    required this.activities,
    this.onExpandTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onExpandTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.scatter_plot, size: 18, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  const Text(
                    'Grafico Distribuzione',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  if (onExpandTap != null)
                    Icon(Icons.fullscreen, size: 18, color: context.textSecondaryColor),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: EisenhowerScatterChartWidget(
                  activities: activities,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
