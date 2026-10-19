import 'package:patrol/patrol.dart';
import '../utils/offline_assertions.dart';

/// Usage: I should not see the offline banner
Future<void> iShouldNotSeeTheOfflineBanner(PatrolIntegrationTester $) async {
  await waitForOfflineBanner($.tester, visible: false);
}
