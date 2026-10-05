import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Usage: I tap on {'Hommie E2E'}
Future<void> iTapOn(PatrolIntegrationTester $, String label) async {
  final target = $(find.text(label).hitTestable());
  await target.waitUntilVisible(timeout: const Duration(seconds: 20));
  expect(target, findsOneWidget);
  await target.tap();
}
