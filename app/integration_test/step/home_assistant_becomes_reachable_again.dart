import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

Future<void> homeAssistantBecomesReachableAgain(
  PatrolIntegrationTester $,
) async {
  await TestContext.instance().proxy.restoreHaRoute();
}
