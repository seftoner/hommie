import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

Future<void> theClientLosesConnectionToHomeAssistant(
  PatrolIntegrationTester $,
) async {
  await TestContext.instance().proxy.disconnectFromHa();
}
