import 'dart:convert';
import 'dart:html' as html; // Web-only import for download
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/smart_todo/todo_list_model.dart';
import '../models/smart_todo/todo_task_model.dart';
import '../services/user_profile_service.dart';
import 'package:intl/intl.dart';

class SmartTodoCsvExportService {
  static final SmartTodoCsvExportService _instance = SmartTodoCsvExportService._internal();
  factory SmartTodoCsvExportService() => _instance;
  SmartTodoCsvExportService._internal();

  final UserProfileService _userProfileService = UserProfileService();

  /// Generates a CSV string and triggers download (Web)
  Future<void> exportToCsv(TodoListModel list, List<TodoTaskModel> tasks) async {
    final headers = [
      'Titolo',
      'Descrizione',
      'Stato',
      'Priorità',
      'Scadenza',
      'Assegnatario',
      'Tags',
      'Creato Il'
    ];

    final statusMap = {for (var c in list.columns) c.id: c.title};

    final Set<String> emails = {};
    for (var task in tasks) {
      emails.addAll(task.assignedTo);
    }
    final namesMap = await _resolveEmails(emails);

    List<List<dynamic>> rows = [];
    rows.add(headers);

    for (var task in tasks) {
      rows.add([
        task.title,
        task.description,
        task.statusId != null ? (statusMap[task.statusId] ?? 'N/A') : 'N/A',
        task.priority.name.toUpperCase(),
        task.dueDate?.toIso8601String().split('T')[0] ?? '',
        task.assignedTo.map((e) => namesMap[e] ?? e).join('; '),
        task.tags.map((t) => t.title).join('; '),
        task.createdAt.toIso8601String()
      ]);
    }

    String csvContent = const ListToCsvConverter().convert(rows);

    if (kIsWeb) {
      // Trigger browser download
      final bytes = utf8.encode(csvContent);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "Keisen_List_${list.title.replaceAll(' ', '_')}.csv")
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      // For mobile, you would typically use path_provider and share_plus
      // But since user is Web-focused for now, we leave this placeholder
      print('CSV Export not fully implemented for Mobile yet');
    }
  }

  Future<Map<String, String>> _resolveEmails(Set<String> emails) async {
    final Map<String, String> results = {};
    for (final email in emails) {
      results[email] = await _userProfileService.getNameByEmail(email);
    }
    return results;
  }
}

// Simple CSV Converter helper to avoid adding 'csv' package dependency if not present
// If 'csv' package is present, prefer using it.
class ListToCsvConverter {
  const ListToCsvConverter();

  String convert(List<List<dynamic>> rows) {
    return rows.map((row) {
      return row.map((field) {
        String value = field.toString();
        // Escape double quotes
        if (value.contains('"')) {
          value = value.replaceAll('"', '""');
        }
        // Wrap in quotes if contains comma, newline or quotes
        if (value.contains(',') || value.contains('\n') || value.contains('"')) {
          value = '"$value"';
        }
        return value;
      }).join(',');
    }).join('\n');
  }
}
