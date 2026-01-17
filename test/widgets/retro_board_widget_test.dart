import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/widgets/retrospective/retro_board_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Mock data
  final now = DateTime.now();
  final itemMine = RetroItem(
    id: '1',
    content: 'My secret idea',
    authorEmail: 'me@test.com',
    authorName: 'Me',
    createdAt: now,
    category: RetroCategory.wentWell,
  );
  
  final itemOther = RetroItem(
    id: '2',
    content: 'Other secret idea',
    authorEmail: 'other@test.com',
    authorName: 'Other',
    createdAt: now,
    category: RetroCategory.wentWell,
  );

  final retro = RetrospectiveModel(
    id: 'r1',
    sprintId: 's1',
    projectId: 'p1',
    createdAt: now,
    createdBy: 'me@test.com',
    isCompleted: false,
    wentWell: [itemMine, itemOther],
  );

  testWidgets('Incognito Mode hides others content', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RetroBoardWidget(
          retro: retro,
          currentUserEmail: 'me@test.com',
          currentUserName: 'Me',
          isIncognito: true,
        ),
      ),
    ));

    // My content should be visible
    expect(find.text('My secret idea'), findsOneWidget);
    
    // Other content should NOT be visible (text not found)
    expect(find.text('Other secret idea'), findsNothing);
    
    // "HIDDEN" or "Someone is typing..." should be visible for other item
    expect(find.text('HIDDEN'), findsOneWidget);
    expect(find.text('Someone is typing...'), findsOneWidget);
  });

  testWidgets('Reveal Mode shows all content', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RetroBoardWidget(
          retro: retro,
          currentUserEmail: 'me@test.com',
          currentUserName: 'Me',
          isIncognito: false, // REVEALED
        ),
      ),
    ));

    // Both contents should be visible
    expect(find.text('My secret idea'), findsOneWidget);
    expect(find.text('Other secret idea'), findsOneWidget);
    
    // No HIDDEN placeholders
    expect(find.text('HIDDEN'), findsNothing);
  });
}
