import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

Future<void> theKitchenLightIsPersisted(PatrolIntegrationTester $) async {
  final c = TestContext.instance();
  await c.appState.writeCheckpoint(c.config.runId);
}
