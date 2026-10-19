import 'package:patrol/patrol.dart';
import '../utils/offline_assertions.dart';

Future<void> iShouldSeeTheOfflineBanner(PatrolIntegrationTester $) async {
  await waitForOfflineBanner($.tester, visible: true);
}
