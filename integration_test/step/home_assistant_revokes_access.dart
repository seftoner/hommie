import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/hass_token_manager.dart';

/// Usage: home assistant revokes access
Future<void> homeAssistantRevokesAccess(PatrolIntegrationTester $) async {
  final tokenManager = HassTokenManager();
  await tokenManager.cleanupToken();
}
