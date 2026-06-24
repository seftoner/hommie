import 'dart:async';

import 'package:patrol/patrol.dart';

import '../utils/hass_area_manager.dart';

Future<void> homeAssistantTestAreasAreClean(PatrolIntegrationTester $) async {
  const timeout = Duration(seconds: 10);
  await HassAreaManager().cleanupDeterministicAreas().timeout(
    timeout,
    onTimeout: () => throw TimeoutException(
      'Timed out cleaning deterministic Home Assistant areas',
      timeout,
    ),
  );
}
