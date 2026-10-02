import 'package:patrol/patrol.dart';

import '../utils/hass_token_manager.dart';
import '../utils/test_context.dart';

/// Usage: home assistant revokes access
Future<void> homeAssistantRevokesAccess(PatrolIntegrationTester $) async {
  final tokenManager = HassTokenManager();
  final token = TestContext.instance().token;
  if (token == null) throw StateError('No owned app token to revoke');
  await tokenManager.deleteById(token.id);
}
