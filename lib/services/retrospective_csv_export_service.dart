import 'dart:convert';
import 'dart:html' as html;
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/retrospective_model.dart';
import 'user_profile_service.dart';

class RetrospectiveCsvExportService {
  static final RetrospectiveCsvExportService _instance = RetrospectiveCsvExportService._internal();
  factory RetrospectiveCsvExportService() => _instance;
  RetrospectiveCsvExportService._internal();

  final UserProfileService _userProfileService = UserProfileService();

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

    final Set<String> emails = {};
    for (var item in retro.actionItems) {
      emails.add(item.ownerEmail);
      if (item.assigneeEmail != null) emails.add(item.assigneeEmail!);
    }
    final namesMap = await _resolveEmails(emails);

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
        namesMap[item.ownerEmail] ?? item.ownerEmail,
        item.assigneeEmail != null ? (namesMap[item.assigneeEmail] ?? item.assigneeEmail!) : '-',
        item.priority.name,
        item.dueDate?.toString().split(' ')[0] ?? '-',
        item.resources ?? '-',
        item.monitoring ?? '-',
        item.isCompleted ? 'Completed' : 'Pending',
      ]);
    }

    final name = retro.title.isNotEmpty ? retro.title : retro.sprintName;
    await _downloadCsv(rows, 'Retro_ActionItems_${name.replaceAll(' ', '_')}');
  }

  /// Exports Board Items to CSV
  Future<void> exportBoardItemsToCsv(RetrospectiveModel retro) async {
    final Set<String> emails = {};
    for (var column in retro.columns) {
      final items = retro.getItemsForColumn(column.id);
      for (var item in items) {
        emails.add(item.authorEmail);
      }
    }
    final namesMap = await _resolveEmails(emails);
    final headers = ['Column', 'Content', 'Votes', 'Author'];
    List<List<dynamic>> rows = [headers];

    for (var column in retro.columns) {
      final items = retro.getItemsForColumn(column.id);
      if (items.isEmpty) {
        rows.add([
          column.title,
          '(No items)',
          '-',
          '-',
        ]);
      } else {
        for (var item in items) {
          rows.add([
            column.title,
            item.content,
            item.votes,
            namesMap[item.authorEmail] ?? item.authorEmail,
          ]);
        }
      }
    }

    final name = retro.title.isNotEmpty ? retro.title : retro.sprintName;
    await _downloadCsv(rows, 'Retro_Board_${name.replaceAll(' ', '_')}');
  }

  /// Exports ALL Data to a single CSV
  Future<void> exportAllDataToCsv(RetrospectiveModel retro) async {
    List<List<dynamic>> allRows = [];

    // 1. SUMMARY SECTION
    allRows.add(['=== RETROSPECTIVE SUMMARY ===']);
    allRows.add(['Name', retro.title.isNotEmpty ? retro.title : retro.sprintName]);
    allRows.add(['Date', DateTime.now().toString().split(' ')[0]]);
    allRows.add(['Participants', retro.participantEmails.length]);
    allRows.add(['Average Sentiment', retro.averageSentiment?.toStringAsFixed(1) ?? 'N/A']);
    allRows.add([]);

    final Set<String> emails = {};
    for (var column in retro.columns) {
      final items = retro.getItemsForColumn(column.id);
      for (var item in items) {
        emails.add(item.authorEmail);
      }
    }
    for (var item in retro.actionItems) {
      emails.add(item.ownerEmail);
      if (item.assigneeEmail != null) emails.add(item.assigneeEmail!);
    }
    final namesMap = await _resolveEmails(emails);

    // 2. BOARD ITEMS SECTION
    allRows.add(['=== BOARD ITEMS ===']);
    allRows.add(['Column', 'Content', 'Votes', 'Author']);
    
    for (var column in retro.columns) {
      final items = retro.getItemsForColumn(column.id);
      if (items.isEmpty) {
        allRows.add([
          column.title,
          '(No items)',
          '-',
          '-',
        ]);
      } else {
        for (var item in items) {
          allRows.add([
            column.title,
            item.content,
            item.votes,
            namesMap[item.authorEmail] ?? item.authorEmail,
          ]);
        }
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
        namesMap[item.ownerEmail] ?? item.ownerEmail,
        item.assigneeEmail != null ? (namesMap[item.assigneeEmail] ?? item.assigneeEmail!) : '-',
        item.priority.name,
        item.dueDate?.toString().split(' ')[0] ?? '-',
        item.resources ?? '-',
        item.monitoring ?? '-',
        item.isCompleted ? 'Completed' : 'Pending',
      ]);
    }

    final name = retro.title.isNotEmpty ? retro.title : retro.sprintName;
    await _downloadCsv(allRows, 'Retro_Full_${name.replaceAll(' ', '_')}');
  }

  Future<Map<String, String>> _resolveEmails(Set<String> emails) async {
    final Map<String, String> results = {};
    for (final email in emails) {
      results[email] = await _userProfileService.getNameByEmail(email);
    }
    return results;
  }

  Future<void> _downloadCsv(List<List<dynamic>> rows, String filename) async {
    String csvContent = const ListToCsvConverter().convert(rows);

    if (kIsWeb) {
      final bytes = utf8.encode('\uFEFF$csvContent');
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", "$filename.csv")
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      print('CSV Export not implemented for Mobile');
    }
  }
}
