import 'package:agile_tools/models/retrospective_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RetrospectiveModel', () {
    final now = DateTime.now();
    final retro = RetrospectiveModel(
      id: 'retro1',
      sprintId: 'sprint1',
      projectId: 'proj1',
      createdAt: now,
      createdBy: 'user@example.com',
      timer: const RetroTimer(),
    );

    test('Initial state is draft and setup phase', () {
      expect(retro.status, RetroStatus.draft);
      expect(retro.currentPhase, RetroPhase.setup);
      expect(retro.template, RetroTemplate.startStopContinue);
    });
    
    test('Standalone retro creation (null ids)', () {
      final standalone = RetrospectiveModel(
        id: 'standalone1',
        // sprintId and projectId are null by default
        createdAt: now,
        createdBy: 'user@example.com',
        sprintName: 'Weekly Sync',
        timer: const RetroTimer(),
      );
      
      expect(standalone.projectId, isNull);
      expect(standalone.sprintId, isNull);
      expect(standalone.sprintName, 'Weekly Sync');
      
      final json = standalone.toFirestore();
      expect(json['projectId'], isNull);
    });

    test('Serialization with new fields', () {
      final json = retro.toFirestore();
      expect(json['status'], 'draft');
      expect(json['currentPhase'], 'setup');
      expect(json['template'], 'startStopContinue');

      final fromJson = RetrospectiveModel.fromMap('retro1', json);
      expect(fromJson.status, RetroStatus.draft);
    });

    test('Template Columns', () {
      expect(RetroTemplate.startStopContinue.defaultColumns.length, 2);
      
      // Future expansion verification
      expect(RetroTemplate.fourLs.defaultColumns.isNotEmpty, true);
    });

    test('Item Management', () {
      final item = RetroItem(
        id: 'i1',
        columnId: 'col_1',
        content: 'Good job',
        authorEmail: 'a@b.com',
        authorName: 'A',
        createdAt: now,
      );

      final withItem = retro.copyWith(items: [item]);
      expect(withItem.items.length, 1);
      
      final withoutItem = withItem.copyWith(items: []);
      expect(withoutItem.items.isEmpty, true);
    });
  });
}
