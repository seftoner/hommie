import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/hass_token_manager.dart';
import '../utils/test_context.dart';

/// Usage: home assistant access is configured
Future<void> homeAssistantAccessIsConfigured(PatrolIntegrationTester $) async {
  final tokenManager = HassTokenManager();

  final token = await tokenManager.createToken();
  TestContext.instance().setAuthToken(token);
}
