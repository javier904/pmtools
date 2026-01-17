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

    test('Template Categories', () {
      expect(RetroTemplate.startStopContinue.categories, 
        containsAll([RetroCategory.wentWell, RetroCategory.toImprove]));
      
      // Future expansion verification
      expect(RetroTemplate.fourLs.categories.isNotEmpty, true);
    });

    test('Item Management', () {
      final item = RetroItem(
        id: 'i1',
        content: 'Good job',
        authorEmail: 'a@b.com',
        authorName: 'A',
        createdAt: now,
      );

      final withItem = retro.withWentWellItem(item);
      expect(withItem.wentWell.length, 1);
      
      final withoutItem = withItem.withoutWentWellItem('i1');
      expect(withoutItem.wentWell.isEmpty, true);
    });
  });
}
