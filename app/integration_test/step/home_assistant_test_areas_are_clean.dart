import 'dart:async';

import 'package:patrol/patrol.dart';

import '../utils/hass_area_manager.dart';
import '../utils/test_context.dart';

Future<void> homeAssistantTestAreasAreClean(PatrolIntegrationTester $) async {
  const timeout = Duration(seconds: 10);
  final context = TestContext.instance();
  await HassAreaManager()
      .cleanupOwnedAreas(
        ids: context.ownedAreaIds,
        reservedNames: {context.initialAreaName, context.renamedAreaName},
      )
      .timeout(
        timeout,
        onTimeout: () => throw TimeoutException(
          'Timed out cleaning deterministic Home Assistant areas',
          timeout,
        ),
      );
}
