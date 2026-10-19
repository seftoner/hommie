import 'package:patrol/patrol.dart';

import '../utils/hass_token_manager.dart';
import '../utils/test_context.dart';

/// Usage: home assistant access is configured
Future<void> homeAssistantAccessIsConfigured(PatrolIntegrationTester $) async {
  final context = TestContext.instance();
  final tokenManager = HassTokenManager(cli: context.cli);
  final token = await tokenManager.createLongLivedToken(
    clientName: context.namespace,
  );
  context.token = token;
  context.setAuthToken(token.accessToken);
}
