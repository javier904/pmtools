import 'dart:convert';
import 'dart:html' as html;
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/eisenhower_matrix_model.dart';
import '../models/eisenhower_activity_model.dart';

class EisenhowerCsvExportService {
  static final EisenhowerCsvExportService _instance = EisenhowerCsvExportService._internal();
  factory EisenhowerCsvExportService() => _instance;
  EisenhowerCsvExportService._internal();

  /// Exports All Data (Summary + Votes + RACI) to a single CSV
  Future<void> exportAllToCsv(EisenhowerMatrixModel matrix, List<EisenhowerActivityModel> activities) async {
    final rows = <List<dynamic>>[];

    // Summary
    rows.add(['=== MATRIX SUMMARY ===']);
    rows.addAll(_buildSummaryRows(matrix, activities));
    rows.add([]); // Spacing

    // Votes
    rows.add(['=== VOTES ===']);
    rows.addAll(_buildVotesRows(matrix, activities));
    rows.add([]); // Spacing

    // RACI
    rows.add(['=== RACI MATRIX ===']);
    rows.addAll(_buildRaciRows(matrix, activities));

    await _downloadCsv(rows, 'Eisenhower_Full_Export_${matrix.title.replaceAll(' ', '_')}');
  }

  /// Exports System Summary to CSV
  Future<void> exportMatrixSummaryToCsv(EisenhowerMatrixModel matrix, List<EisenhowerActivityModel> activities) async {
    final rows = _buildSummaryRows(matrix, activities);
    await _downloadCsv(rows, 'Eisenhower_Summary_${matrix.title.replaceAll(' ', '_')}');
  }

  /// Exports Votes to CSV
  Future<void> exportVotesToCsv(EisenhowerMatrixModel matrix, List<EisenhowerActivityModel> activities) async {
    final rows = _buildVotesRows(matrix, activities);
    await _downloadCsv(rows, 'Eisenhower_Votes_${matrix.title.replaceAll(' ', '_')}');
  }

  /// Exports RACI to CSV
  Future<void> exportRaciToCsv(EisenhowerMatrixModel matrix, List<EisenhowerActivityModel> activities) async {
    final rows = _buildRaciRows(matrix, activities);
    await _downloadCsv(rows, 'Eisenhower_RACI_${matrix.title.replaceAll(' ', '_')}');
  }

  // --- Helper Builders ---

  List<List<dynamic>> _buildSummaryRows(EisenhowerMatrixModel matrix, List<EisenhowerActivityModel> activities) {
    final headers = [
      '#',
      'Attività',
      'Descrizione',
      'Quadrante',
      'Azione',
      'Urgenza (media)',
      'Importanza (media)',
      'N. Voti',
    ];

    List<List<dynamic>> rows = [headers];

    final sortedActivities = List<EisenhowerActivityModel>.from(activities);
    sortedActivities.sort((a, b) {
      final aQ = a.quadrant?.name ?? 'Z';
      final bQ = b.quadrant?.name ?? 'Z';
      return aQ.compareTo(bQ);
    });

    for (var i = 0; i < sortedActivities.length; i++) {
      final activity = sortedActivities[i];
      rows.add([
        i + 1,
        activity.title,
        activity.description,
        activity.quadrant?.name ?? '-',
        activity.quadrant?.action ?? '-',
        activity.hasVotes ? activity.aggregatedUrgency.toStringAsFixed(1) : '-',
        activity.hasVotes ? activity.aggregatedImportance.toStringAsFixed(1) : '-',
        activity.voteCount,
      ]);
    }
    return rows;
  }

  List<List<dynamic>> _buildVotesRows(EisenhowerMatrixModel matrix, List<EisenhowerActivityModel> activities) {
    final headers = [
      'Attività',
      'Partecipante',
      'Urgenza',
      'Importanza',
    ];

    List<List<dynamic>> rows = [headers];

    for (final activity in activities) {
      for (final entry in activity.votes.entries) {
        rows.add([
          activity.title,
          entry.key, // email or id
          entry.value.urgency,
          entry.value.importance,
        ]);
      }
    }
    return rows;
  }

  List<List<dynamic>> _buildRaciRows(EisenhowerMatrixModel matrix, List<EisenhowerActivityModel> activities) {
    // Header: Activity + Columns
    final headers = ['Attività', ...matrix.raciColumns.map((c) => c.name)];
    List<List<dynamic>> rows = [headers];

     // Sort aligned with UI (by quadrant, then score)
    final sortedActivities = List<EisenhowerActivityModel>.from(activities);
    sortedActivities.sort((a, b) {
      final qA = a.quadrant?.index ?? 99;
      final qB = b.quadrant?.index ?? 99;
      if (qA != qB) return qA.compareTo(qB);
      final scoreA = (a.aggregatedUrgency) + (a.aggregatedImportance);
      final scoreB = (b.aggregatedUrgency) + (b.aggregatedImportance);
      return scoreB.compareTo(scoreA); // Descending
    });

    for (final activity in sortedActivities) {
      final row = <dynamic>[activity.title];
      for (final col in matrix.raciColumns) {
        final role = activity.raciAssignments[col.id];
        row.add(role?.label ?? '');
      }
      rows.add(row);
    }
    return rows;
  }

  Future<void> _downloadCsv(List<List<dynamic>> rows, String filename) async {
    String csvContent = const ListToCsvConverter().convert(rows);

    if (kIsWeb) {
      final bytes = utf8.encode('\uFEFF$csvContent');
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "$filename.csv")
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      print('CSV Export not implemented for Mobile');
    }
  }
}
