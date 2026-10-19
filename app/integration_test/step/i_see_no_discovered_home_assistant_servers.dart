import 'package:patrol/patrol.dart';

import '../utils/discovery_assertions.dart';

/// Usage: I see no discovered home assistant servers
Future<void> iSeeNoDiscoveredHomeAssistantServers(
  PatrolIntegrationTester $,
) async {
  await waitForNoDiscoveredServers($.tester);
}
