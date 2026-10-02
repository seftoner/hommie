import 'package:hommie/ui/keys.dart';
import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

Future<void> iEnterTheHomeAssistantAddress(PatrolIntegrationTester $) async {
  await $(K.manualAddress.addressField)
      .enterText(TestContext.instance().config.appServerUrl.toString());
}
