import 'package:patrol/patrol.dart';

import '../utils/fault_proxy_client.dart';
import '../utils/test_context.dart';

Future<void> theClientLosesConnectionToHomeAssistant(
  PatrolIntegrationTester $,
) async {
  final context = TestContext.instance();
  final proxy = FaultProxyClient(
    faultControlUrl: context.config.faultControlUrl,
  );
  context.cleanup.register('scenario proxy HTTP client', () async {
    proxy.close();
  });
  context.cleanup.register(
    'scenario HA route restoration',
    proxy.restoreHaRoute,
  );
  await proxy.disconnectFromHa();
}
