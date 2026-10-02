import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

Future<void> theExistingPersistedSessionIsUsed(
  PatrolIntegrationTester $,
) async {
  final c = TestContext.instance();
  await c.appState.verifyCheckpoint(c.config.runId);
}
