import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/hass_area_manager.dart';

Future<void> homeAssistantShouldHaveArea(
  PatrolIntegrationTester $,
  String areaName,
) async {
  final manager = HassAreaManager();
  HassTestArea? area;
  for (var attempt = 0; attempt < 10; attempt += 1) {
    area = await manager
        .findRemoteByName(areaName)
        .timeout(const Duration(seconds: 3), onTimeout: () => null);
    if (area != null) {
      break;
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  expect(area, isNotNull, reason: 'Expected Home Assistant area "$areaName"');
}
