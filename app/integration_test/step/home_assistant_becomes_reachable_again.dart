import 'package:patrol/patrol.dart';

import '../utils/fault_proxy_client.dart';
import '../utils/test_context.dart';

Future<void> homeAssistantBecomesReachableAgain(
  PatrolIntegrationTester $,
) async {
  final proxy = FaultProxyClient(
    faultControlUrl: TestContext.instance().config.faultControlUrl,
  );
  try {
    await proxy.restoreHaRoute();
  } finally {
    proxy.close();
  }
}
