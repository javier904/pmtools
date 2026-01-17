import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_export_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RetrospectiveExportService', () {
    final now = DateTime.now();
    final item = RetroItem(
      id: '1',
      content: 'Great Sprint',
      authorEmail: 'test@test.com',
      authorName: 'Tester',
      createdAt: now,
      votes: 5,
      category: RetroCategory.wentWell,
    );
    
    final retro = RetrospectiveModel(
      id: 'r1',
      sprintId: 's1',
      sprintName: 'Sprint 1',
      projectId: 'p1',
      createdAt: now,
      createdBy: 'admin',
      wentWell: [item],
      activeParticipants: ['test@test.com'],
    );

    final service = RetrospectiveExportService();

    test('generateCsv includes header and items', () {
      final csv = service.generateCsv(retro);
      expect(csv, contains('ID,Date,Category'));
      expect(csv, contains('Great Sprint'));
      expect(csv, contains('Went Well'));
      expect(csv, contains('5')); // votes
    });

    test('generateClipboardText includes structured sections', () {
      final text = service.generateClipboardText(retro);
      expect(text, contains('# Retrospective Report: Sprint 1'));
      expect(text, contains('## 🟢 Went Well'));
      expect(text, contains('* Great Sprint (5 votes)'));
      expect(text, contains('Participants: 1'));
    });
  });
}
