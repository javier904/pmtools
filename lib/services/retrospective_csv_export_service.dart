import 'dart:convert';
import 'dart:html' as html;
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/retrospective_model.dart';


class RetrospectiveCsvExportService {
  static final RetrospectiveCsvExportService _instance = RetrospectiveCsvExportService._internal();
  factory RetrospectiveCsvExportService() => _instance;
  RetrospectiveCsvExportService._internal();

  /// Exports Action Items to CSV
  Future<void> exportActionItemsToCsv(RetrospectiveModel retro) async {
    final headers = [
      'Source Column',
      'Action Type',
      'Description',
      'Linked Card',
      'Owner',
      'Assignee',
      'Priority',
      'Due Date',
      'Resources',
      'Monitoring',
      'Status',
    ];

    List<List<dynamic>> rows = [headers];

    for (var item in retro.actionItems) {
       // Get column title from sourceColumnId
        String sourceColumnTitle = '-';
        if (item.sourceColumnId != null && item.sourceColumnId!.isNotEmpty) {
          final column = retro.columns.where((c) => c.id == item.sourceColumnId).firstOrNull;
          sourceColumnTitle = column?.title ?? item.sourceColumnId!;
        }

      rows.add([
        sourceColumnTitle,
        item.actionType?.displayName ?? '-',
        item.description,
        item.sourceRefContent ?? '-',
        item.ownerEmail,
        item.assigneeEmail ?? '-',
        item.priority.name,
        item.dueDate?.toString().split(' ')[0] ?? '-',
        item.resources ?? '-',
        item.monitoring ?? '-',
        item.isCompleted ? 'Completed' : 'Pending',
      ]);
    }

    await _downloadCsv(rows, 'Retro_ActionItems_${retro.sprintName.replaceAll(' ', '_')}');
  }

  /// Exports Board Items to CSV
  Future<void> exportBoardItemsToCsv(RetrospectiveModel retro) async {
    final headers = ['Column', 'Content', 'Votes', 'Author'];
    List<List<dynamic>> rows = [headers];

    for (var column in retro.columns) {
      final items = retro.getItemsForColumn(column.id);
      for (var item in items) {
        rows.add([
          column.title,
          item.content,
          item.votes,
          item.authorEmail ?? 'Anonymous',
        ]);
      }
    }

    await _downloadCsv(rows, 'Retro_Board_${retro.sprintName.replaceAll(' ', '_')}');
  }

  /// Exports ALL Data to a single CSV
  Future<void> exportAllDataToCsv(RetrospectiveModel retro) async {
    List<List<dynamic>> allRows = [];

    // 1. SUMMARY SECTION
    allRows.add(['=== RETROSPECTIVE SUMMARY ===']);
    allRows.add(['Sprint', retro.sprintName]);
    allRows.add(['Date', DateTime.now().toString().split(' ')[0]]);
    allRows.add(['Participants', retro.participantEmails.length]);
    allRows.add(['Average Sentiment', retro.averageSentiment?.toStringAsFixed(1) ?? 'N/A']);
    allRows.add([]);

    // 2. BOARD ITEMS SECTION
    allRows.add(['=== BOARD ITEMS ===']);
    allRows.add(['Column', 'Content', 'Votes', 'Author']);
    
    for (var column in retro.columns) {
      final items = retro.getItemsForColumn(column.id);
      for (var item in items) {
        allRows.add([
          column.title,
          item.content,
          item.votes,
          item.authorEmail ?? 'Anonymous',
        ]);
      }
    }
    allRows.add([]);

    // 3. ACTION ITEMS SECTION
    allRows.add(['=== ACTION ITEMS ===']);
    allRows.add([
      'Source Column',
      'Action Type',
      'Description',
      'Linked Card',
      'Owner',
      'Assignee',
      'Priority',
      'Due Date',
      'Resources',
      'Monitoring',
      'Status',
    ]);

    for (var item in retro.actionItems) {
      String sourceColumnTitle = '-';
      if (item.sourceColumnId != null && item.sourceColumnId!.isNotEmpty) {
        final column = retro.columns.where((c) => c.id == item.sourceColumnId).firstOrNull;
        sourceColumnTitle = column?.title ?? item.sourceColumnId!;
      }

      allRows.add([
        sourceColumnTitle,
        item.actionType?.displayName ?? '-',
        item.description,
        item.sourceRefContent ?? '-',
        item.ownerEmail,
        item.assigneeEmail ?? '-',
        item.priority.name,
        item.dueDate?.toString().split(' ')[0] ?? '-',
        item.resources ?? '-',
        item.monitoring ?? '-',
        item.isCompleted ? 'Completed' : 'Pending',
      ]);
    }

    await _downloadCsv(allRows, 'Retro_Full_${retro.sprintName.replaceAll(' ', '_')}');
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
