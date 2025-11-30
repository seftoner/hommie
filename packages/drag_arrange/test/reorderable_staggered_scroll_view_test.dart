import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'main.dart';

void main() {
  group('ReorderableScrollView Tests', () {
    testWidgets('Test if toggling drag enables works',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      // Tap the "Grid" button to navigate to the next page.
      await tester.tap(find.text('Grid'));
      await tester.pumpAndSettle(); // Wait for the navigation to complete.

      // Find and tap the icon on the next page.
      await tester.tap(find.byIcon(Icons.pause));
      await tester.pumpAndSettle(); // Wait for the icon interaction.
      //print('pause::');

      // Verify that the drag was toggled off.
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      //print('play_arrow::');

      // Tap it again to toggle back on.
      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pump();
      //print('play_arrow::');

      // Verify that the drag was toggled back on.
      expect(find.byIcon(Icons.pause), findsOneWidget);
      //print('pause::');
    });
  });
}
