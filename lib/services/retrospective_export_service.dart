import 'package:agile_tools/models/retrospective_model.dart';
import 'package:flutter/services.dart';

class RetrospectiveExportService {
  
  /// Genera contenuto CSV per l'export
  String generateCsv(RetrospectiveModel retro) {
    final buffer = StringBuffer();
    // Header
    buffer.writeln('ID,Date,Category,Author,Content,Votes,Action Item');
    
    // Went Well
    for (final item in retro.wentWell) {
      buffer.writeln(_csvRow(retro, item, 'Went Well'));
    }
    
    // To Improve
    for (final item in retro.toImprove) {
      buffer.writeln(_csvRow(retro, item, 'To Improve'));
    }
    
    // Action Items
    for (final action in retro.actionItems) {
      buffer.writeln('${action.id},${retro.createdAt.toIso8601String()},Action Item,${action.assigneeEmail ?? ""},"${_escape(action.description)}",-,Linked');
    }

    return buffer.toString();
  }

  /// Genera testo formattato per Clipboard (Markdown/Confluence style)
  String generateClipboardText(RetrospectiveModel retro) {
    final buffer = StringBuffer();
    buffer.writeln('# Retrospective Report: ${retro.sprintName}');
    buffer.writeln('Date: ${retro.createdAt.day}/${retro.createdAt.month}/${retro.createdAt.year}');
    buffer.writeln('Participants: ${retro.activeParticipants.length}');
    buffer.writeln('');
    
    buffer.writeln('## 🟢 Went Well');
    if (retro.wentWell.isEmpty) buffer.writeln('* No items');
    for (final item in retro.wentWell) {
      buffer.writeln('* ${item.content} (${item.votes} votes) - *${item.authorName}*');
    }
    buffer.writeln('');
    
    buffer.writeln('## 🔴 To Improve');
    if (retro.toImprove.isEmpty) buffer.writeln('* No items');
    for (final item in retro.toImprove) {
      buffer.writeln('* ${item.content} (${item.votes} votes) - *${item.authorName}*');
    }
    buffer.writeln('');
    
    buffer.writeln('## 🚀 Action Items');
    if (retro.actionItems.isEmpty) buffer.writeln('* No actions defined');
    for (final action in retro.actionItems) {
      buffer.writeln('* [ ] **${action.priority.name.toUpperCase()}** ${action.description} (@${action.assigneeName ?? "Unassigned"})');
    }
    
    return buffer.toString();
  }

  /// Helper per CSV
  String _csvRow(RetrospectiveModel retro, RetroItem item, String category) {
    return '${item.id},${retro.createdAt.toIso8601String()},$category,${item.authorEmail},"${_escape(item.content)}",${item.votes},-';
  }

  String _escape(String input) {
    return input.replaceAll('"', '""');
  }

  /// Copia negli appunti
  Future<void> copyToClipboard(RetrospectiveModel retro) async {
    final text = generateClipboardText(retro);
    await Clipboard.setData(ClipboardData(text: text));
  }
}
