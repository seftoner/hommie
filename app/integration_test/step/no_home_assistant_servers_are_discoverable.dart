import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

/// Usage: no home assistant servers are discoverable
Future<void> noHomeAssistantServersAreDiscoverable(
  PatrolIntegrationTester $,
) async {
  TestContext.instance().discoveryFixture.clear();
}
