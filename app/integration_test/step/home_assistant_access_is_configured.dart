import 'package:patrol/patrol.dart';

import '../utils/hass_token_manager.dart';
import '../utils/test_context.dart';

/// Usage: home assistant access is configured
Future<void> homeAssistantAccessIsConfigured(PatrolIntegrationTester $) async {
  final tokenManager = HassTokenManager();

  final context = TestContext.instance();
  final token = await tokenManager.createLongLivedToken(
    clientName: context.namespace,
  );
  context.token = token;
  context.cleanup.register('owned access token', () async {
    if (!context.preserveSeed) await tokenManager.deleteById(token.id);
  });
  context.setAuthToken(token.accessToken);
}
