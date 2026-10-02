import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/hass_area_manager.dart';

Future<void> homeAssistantRemainsManageable(PatrolIntegrationTester $) async {
  expect(
    (await HassAreaManager().list()).map((area) => area.areaId),
    contains('kitchen'),
  );
}
