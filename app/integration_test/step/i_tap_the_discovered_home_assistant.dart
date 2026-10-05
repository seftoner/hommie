import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/discovery_assertions.dart';
import '../utils/test_context.dart';

/// Usage: I tap the discovered home assistant {'Hommie E2E'}
Future<void> iTapTheDiscoveredHomeAssistant(
  PatrolIntegrationTester $,
  String name,
) async {
  final row = discoveredServerRow(
    name: name,
    url: TestContext.instance().config.appServerUrl,
  );
  await $(row).waitUntilVisible(timeout: const Duration(seconds: 20));
  expect(row, findsOneWidget);
  await $(row).tap();
}
