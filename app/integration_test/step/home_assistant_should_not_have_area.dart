import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/hass_area_manager.dart';

Future<void> homeAssistantShouldNotHaveArea(
  PatrolIntegrationTester $,
  String areaName,
) async {
  final manager = HassAreaManager();
  HassTestArea? area;
  var lookupCompleted = false;
  for (var attempt = 0; attempt < 10; attempt += 1) {
    try {
      area = await manager
          .findRemoteByName(areaName)
          .timeout(const Duration(seconds: 3));
      lookupCompleted = true;
    } on TimeoutException {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      continue;
    }
    if (area == null) {
      break;
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  expect(
    lookupCompleted,
    isTrue,
    reason: 'Expected Home Assistant area lookup for "$areaName" to complete',
  );
  expect(area, isNull, reason: 'Expected no Home Assistant area "$areaName"');
}
