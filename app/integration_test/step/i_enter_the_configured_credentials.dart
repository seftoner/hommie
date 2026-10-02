import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';
import 'i_enter_credentials.dart';

Future<void> iEnterTheConfiguredCredentials(PatrolIntegrationTester $) async {
  final config = TestContext.instance().config;
  await iEnterCredentials($, config.username, config.password);
}
