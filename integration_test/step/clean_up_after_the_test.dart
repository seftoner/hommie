import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';
import '../utils/test_provider_overrides.dart';
import '../utils/hass_token_manager.dart';

/// Usage: clean up after the test
Future<void> cleanUpAfterTheTest(PatrolIntegrationTester $) async {
  TestProviderOverrides.instance().clear();
  TestContext.instance().clear();

  final tokenManager = HassTokenManager();
  await tokenManager.cleanupToken();
}
