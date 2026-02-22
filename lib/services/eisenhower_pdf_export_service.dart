import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/eisenhower_matrix_model.dart';
import '../models/eisenhower_activity_model.dart';
import '../l10n/app_localizations.dart';

class EisenhowerPdfExportService {
  static final EisenhowerPdfExportService _instance = EisenhowerPdfExportService._internal();
  factory EisenhowerPdfExportService() => _instance;
  EisenhowerPdfExportService._internal();

  Future<void> exportToPdf(
    AppLocalizations l10n,
    EisenhowerMatrixModel matrix,
    List<EisenhowerActivityModel> activities,
  ) async {
    final pdf = pw.Document();

    // Use a font that supports emojis or special characters if needed, but standard should be fine for now
    final font = await PdfGoogleFonts.interRegular();
    final fontBold = await PdfGoogleFonts.interBold();

    // Page 1: 4-Quadrant Grid
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => _buildGridPage(l10n, matrix, activities, font, fontBold),
      ),
    );

    // Page 2: Scatter Plot & Legend (MultiPage to handle overflow)
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _buildHeader(l10n, matrix, fontBold),
        build: (context) => _buildScatterPage(l10n, matrix, activities, font, fontBold),
      ),
    );

    // Page 3: RACI Matrix (Conditional)
    if (matrix.raciColumns.isNotEmpty) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: const pw.EdgeInsets.all(32),
          header: (context) => _buildHeader(l10n, matrix, fontBold),
          build: (context) => [_buildRaciPage(l10n, matrix, activities, font, fontBold)],
        ),
      );
    }

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: '${matrix.title.replaceAll(' ', '_')}_Report.pdf',
    );
  }

  pw.Widget _buildHeader(AppLocalizations l10n, EisenhowerMatrixModel matrix, pw.Font fontBold) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(matrix.title, style: pw.TextStyle(font: fontBold, fontSize: 24)),
        pw.Text(matrix.projectCode ?? '', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
        pw.SizedBox(height: 10),
        pw.Divider(),
        pw.SizedBox(height: 10),
      ],
    );
  }

  pw.Widget _buildGridPage(
    AppLocalizations l10n,
    EisenhowerMatrixModel matrix,
    List<EisenhowerActivityModel> activities,
    pw.Font font,
    pw.Font fontBold,
  ) {
    // Find the max lines across all quadrants to ensure equal height
    int maxLines = 0;
    for (var q in EisenhowerQuadrant.values) {
      final qActivities = activities.where((a) => a.quadrant == q).toList();
      int qLines = 0;
      for (var a in qActivities) {
        // Estimate line count based on title length + scores (assuming ~45 chars per line)
        qLines += ((a.title.length + 15) / 45).ceil();
      }
      if (qLines > maxLines) maxLines = qLines;
    }
    if (maxLines < 8) maxLines = 8; // Guarantee a minimum elegant size
    final globalMinHeight = maxLines * 14.0 + 40.0;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildHeader(l10n, matrix, fontBold),
        pw.SizedBox(height: 10),
        pw.Table(
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(1),
          },
          children: [
            pw.TableRow(
              children: [
                // Order matched to web app: Green (Q2) | Red (Q1)
                _buildQuadrantBox(l10n, EisenhowerQuadrant.q2, activities, font, fontBold, globalMinHeight),
                _buildQuadrantBox(l10n, EisenhowerQuadrant.q1, activities, font, fontBold, globalMinHeight),
              ],
            ),
            pw.TableRow(
              children: [
                // Order matched to web app: Grey (Q4) | Yellow (Q3)
                _buildQuadrantBox(l10n, EisenhowerQuadrant.q4, activities, font, fontBold, globalMinHeight),
                _buildQuadrantBox(l10n, EisenhowerQuadrant.q3, activities, font, fontBold, globalMinHeight),
              ],
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildQuadrantBox(
    AppLocalizations l10n,
    EisenhowerQuadrant quadrant,
    List<EisenhowerActivityModel> activities,
    pw.Font font,
    pw.Font fontBold,
    double minHeight,
  ) {
    final quadrantActivities = activities.where((a) => a.quadrant == quadrant).toList();
    final color = PdfColor.fromInt(quadrant.colorValue);

    return pw.Container(
      margin: const pw.EdgeInsets.all(4),
      constraints: pw.BoxConstraints(minHeight: minHeight),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            width: double.infinity,
            decoration: pw.BoxDecoration(
              color: color,
              borderRadius: const pw.BorderRadius.only(
                topLeft: pw.Radius.circular(3),
                topRight: pw.Radius.circular(3),
              ),
            ),
            child: pw.Text(
              quadrant.localizedTitle(l10n),
              style: pw.TextStyle(font: fontBold, color: PdfColors.white, fontSize: 13),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: quadrantActivities.map((a) {
                final scores = a.hasVotes ? ' (U:${a.aggregatedUrgency.toStringAsFixed(1)}, I:${a.aggregatedImportance.toStringAsFixed(1)})' : '';
                return pw.Bullet(
                  text: '${a.title}$scores',
                  style: const pw.TextStyle(fontSize: 8.5),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<pw.Widget> _buildScatterPage(
    AppLocalizations l10n,
    EisenhowerMatrixModel matrix,
    List<EisenhowerActivityModel> activities,
    pw.Font font,
    pw.Font fontBold,
  ) {
    const double chartSize = 320;
    const double sidePadding = 60;

    // Header with inline legend (match web app)
    final headerLegend = pw.Row(
      children: [
        pw.Text(l10n.eisenhowerChartCardTitle, style: pw.TextStyle(font: fontBold, fontSize: 18, color: PdfColors.grey900)),
        pw.SizedBox(width: 15),
        ...EisenhowerQuadrant.values.map((q) => pw.Padding(
              padding: const pw.EdgeInsets.only(right: 10),
              child: pw.Row(
                children: [
                  pw.Container(
                    width: 7,
                    height: 7,
                    decoration: pw.BoxDecoration(
                      color: _getPdfColor(q.colorValue, 1.0), // Pure color for legend markers
                      shape: pw.BoxShape.circle,
                    ),
                  ),
                  pw.SizedBox(width: 4),
                  pw.Text(q.name.toUpperCase(), style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                ],
              ),
            )),
      ],
    );

    return [
      headerLegend,
      pw.SizedBox(height: 15),
      pw.Center(
        child: pw.Container(
          height: chartSize + 60, // extra space for titles/numbers
          width: chartSize + sidePadding + 20,
          child: pw.Stack(
            children: [
              // 1. Plot Area (The square chart)
              pw.Positioned(
                left: sidePadding,
                top: 10,
                child: pw.Container(
                  height: chartSize,
                  width: chartSize,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
                  ),
                  child: pw.Stack(
                    children: [
                      // Light Background Quadrants (extremely light)
                      pw.Positioned.fill(
                        child: pw.Column(
                          children: [
                            pw.Expanded(
                              child: pw.Row(
                                children: [
                                  _buildQuadrantBg(EisenhowerQuadrant.q2, 0.13), // PLAN
                                  _buildQuadrantBg(EisenhowerQuadrant.q1, 0.13), // DO
                                ],
                              ),
                            ),
                            pw.Expanded(
                              child: pw.Row(
                                children: [
                                  _buildQuadrantBg(EisenhowerQuadrant.q4, 0.13), // ELIMINATE
                                  _buildQuadrantBg(EisenhowerQuadrant.q3, 0.13), // DELEGATE
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Precise Grid Lines (Absolute at 1-10)
                      ...List.generate(10, (i) {
                        final v = i + 1;
                        final pos = (v - 1) / 9.0 * chartSize;
                        return pw.Positioned(
                          left: 0,
                          right: 0,
                          bottom: pos,
                          child: pw.Divider(color: PdfColors.white, thickness: 0.2),
                        );
                      }),
                      ...List.generate(10, (i) {
                        final v = i + 1;
                        final pos = (v - 1) / 9.0 * chartSize;
                        return pw.Positioned(
                          top: 0,
                          bottom: 0,
                          left: pos,
                          child: pw.VerticalDivider(color: PdfColors.white, thickness: 0.2),
                        );
                      }),
                      
                      // Central Axes (Subtle grey shift at 5.5 = center of 1-10 area)
                      pw.Positioned(
                        left: chartSize / 2,
                        top: 0,
                        bottom: 0,
                        child: pw.VerticalDivider(color: PdfColors.grey200, thickness: 0.5),
                      ),
                      pw.Positioned(
                        top: chartSize / 2,
                        left: 0,
                        right: 0,
                        child: pw.Divider(color: PdfColors.grey200, thickness: 0.5),
                      ),

                      // Labels (Centered in Quadrants)
                      _buildCenteredLabel(l10n.quadrantLabelPlan.toUpperCase(), pw.Alignment(-0.5, 0.5), EisenhowerQuadrant.q2),
                      _buildCenteredLabel(l10n.quadrantLabelDo.toUpperCase(), pw.Alignment(0.5, 0.5), EisenhowerQuadrant.q1),
                      _buildCenteredLabel(l10n.quadrantLabelEliminate.toUpperCase(), pw.Alignment(-0.5, -0.5), EisenhowerQuadrant.q4),
                      _buildCenteredLabel(l10n.quadrantLabelDelegate.toUpperCase(), pw.Alignment(0.5, -0.5), EisenhowerQuadrant.q3),

                      // Activity dots
                      ...() {
                        final grouped = <String, List<MapEntry<int, EisenhowerActivityModel>>>{};
                        for (final entry in activities.asMap().entries) {
                          final a = entry.value;
                          if (!a.hasVotes) continue;
                          final key = "${a.aggregatedUrgency.toStringAsFixed(2)}_${a.aggregatedImportance.toStringAsFixed(2)}";
                          grouped.putIfAbsent(key, () => []).add(entry);
                        }

                        return grouped.values.map((group) {
                          final firstActivity = group.first.value;
                          final ids = group.map((e) => (e.key + 1).toString()).join(group.length > 3 ? ' ' : '/');

                          final x = ((firstActivity.aggregatedUrgency - 1) / 9.0) * chartSize;
                          final y = ((firstActivity.aggregatedImportance - 1) / 9.0) * chartSize;

                          const d = 18.0;

                          return pw.Positioned(
                            left: x - (d / 2),
                            bottom: y - (d / 2),
                            child: pw.Container(
                              width: d,
                              height: d,
                              decoration: pw.BoxDecoration(
                                color: _getPdfColor(firstActivity.quadrant?.colorValue ?? 0xFF000000, 1.0), // Pure color for dots
                                shape: pw.BoxShape.circle,
                                border: pw.Border.all(color: PdfColors.white, width: 1.2),
                              ),
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                ids,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  fontSize: ids.length > 4 ? 4 : 6,
                                  color: PdfColors.white,
                                  font: fontBold,
                                  lineSpacing: 1,
                                ),
                              ),
                            ),
                          );
                        });
                      }(),
                    ],
                  ),
                ),
              ),

              // Y Axis Numbers (Positioned between title and chart)
              ...[2, 4, 6, 8, 10].map((v) {
                final pos = (v - 1) / 9.0 * chartSize;
                // Chart top is at 10. pos is upward from chart bottom.
                // top: 10 (chart top) + (chartSize - pos) - 3.5 (center text)
                return pw.Positioned(
                  left: sidePadding - 25,
                  top: 10 + (chartSize - pos) - 3.5,
                  child: pw.Text(v.toString(), style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey600)),
                );
              }),

              // X Axis Numbers
              ...[2, 4, 6, 8, 10].map((v) {
                final pos = (v - 1) / 9.0 * chartSize;
                return pw.Positioned(
                  left: sidePadding + pos - 3,
                  top: 10 + chartSize + 8,
                  child: pw.Text(v.toString(), style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey600)),
                );
              }),

              // Rotated Axis Titles (Outermost)
              pw.Positioned(
                left: 0,
                top: 10 + (chartSize / 2) - 30,
                child: pw.Transform.rotate(
                  angle: 3.14159 / 2, // point DOWN as requested
                  child: pw.Text(l10n.eisenhowerImportance.toUpperCase(), style: pw.TextStyle(fontSize: 8, font: fontBold, color: PdfColors.grey600)),
                ),
              ),
              pw.Positioned(
                left: sidePadding + (chartSize / 2) - 20,
                top: 10 + chartSize + 30,
                child: pw.Text(l10n.eisenhowerUrgency.toUpperCase(), style: pw.TextStyle(fontSize: 8, font: fontBold, color: PdfColors.grey600)),
              ),
            ],
          ),
        ),
      ),
      pw.SizedBox(height: 20),
      pw.Text(l10n.eisenhowerPdfLegend, style: pw.TextStyle(font: fontBold, fontSize: 16)),
      pw.SizedBox(height: 10),
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey200, width: 0.5),
        columnWidths: {
          0: const pw.FixedColumnWidth(30),
          1: const pw.FlexColumnWidth(3),
          2: const pw.FixedColumnWidth(40),
          3: const pw.FixedColumnWidth(40),
          4: const pw.FixedColumnWidth(70),
        },
        children: [
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.grey600),
            children: [
              _tableCell('#', fontBold, textColor: PdfColors.white),
              _tableCell(l10n.eisenhowerActivityTitle, fontBold, textColor: PdfColors.white),
              _tableCell(l10n.eisenhowerUrgencyShort, fontBold, textColor: PdfColors.white),
              _tableCell(l10n.eisenhowerImportanceShort, fontBold, textColor: PdfColors.white),
              _tableCell(l10n.eisenhowerQuadrant, fontBold, textColor: PdfColors.white),
            ],
          ),
          ...(() {
            // Sort activities by Urgency (desc), then Importance (desc)
            final sortedList = List<EisenhowerActivityModel>.from(activities)
              ..sort((a, b) {
                final uComp = b.aggregatedUrgency.compareTo(a.aggregatedUrgency);
                if (uComp != 0) return uComp;
                return b.aggregatedImportance.compareTo(a.aggregatedImportance);
              });

            return sortedList.map((a) {
              // Find original index for the ID/Legend consistency
              final idx = activities.indexOf(a) + 1;
              return pw.TableRow(
                children: [
                  _tableCell(idx.toString(), font),
                  _tableCell(a.title, font),
                  _tableCell(a.hasVotes ? a.aggregatedUrgency.toStringAsFixed(1) : '-', font),
                  _tableCell(a.hasVotes ? a.aggregatedImportance.toStringAsFixed(1) : '-', font),
                  _tableCell(a.quadrant?.name ?? '-', font),
                ],
              );
            });
          })(),
        ],
      ),
    ];
  }

  pw.Widget _buildQuadrantBg(EisenhowerQuadrant q, double opacity) {
    return pw.Expanded(
      child: pw.Container(
        color: _getPdfColor(q.colorValue, opacity),
      ),
    );
  }

  pw.Widget _buildCenteredLabel(String label, pw.Alignment alignment, EisenhowerQuadrant q) {
    return pw.Align(
      alignment: alignment,
      child: pw.Text(
        label,
        style: pw.TextStyle(
          fontSize: 8,
          color: _getPdfColor(q.colorValue, 0.45),
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _tableCell(String text, pw.Font font, {PdfColor textColor = PdfColors.black}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(text, style: pw.TextStyle(font: font, fontSize: 10, color: textColor)),
    );
  }

  pw.Widget _buildRaciPage(
    AppLocalizations l10n,
    EisenhowerMatrixModel matrix,
    List<EisenhowerActivityModel> activities,
    pw.Font font,
    pw.Font fontBold,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(l10n.eisenhowerPdfRaciTitle, style: pw.TextStyle(font: fontBold, fontSize: 18)),
        pw.SizedBox(height: 20),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: const pw.FlexColumnWidth(2),
            ...Map.fromIterable(
              List.generate(matrix.raciColumns.length, (i) => i + 1),
              value: (_) => const pw.FlexColumnWidth(1),
            ),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              children: [
                _tableCell(l10n.eisenhowerActivityTitle, fontBold),
                ...matrix.raciColumns.map((c) => _tableCell(c.name, fontBold)),
              ],
            ),
            ...activities.map((a) {
              return pw.TableRow(
                children: [
                  _tableCell(a.title, font),
                  ...matrix.raciColumns.map((c) {
                    final assignment = a.raciAssignments[c.id];
                    return _tableCell(assignment?.label ?? '', font);
                  }),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }


  PdfColor _getPdfColor(int colorValue, double opacity) {
    final base = PdfColor.fromInt(colorValue);
    // Robust softening: Mathematically blend with white to create a professional pastel shade.
    // result = base * opacity + 1.0 * (1 - opacity)
    return PdfColor(
      base.red * opacity + (1.0 - opacity),
      base.green * opacity + (1.0 - opacity),
      base.blue * opacity + (1.0 - opacity),
      1.0, // Solid color for maximum viewer compatibility
    );
  }
}
