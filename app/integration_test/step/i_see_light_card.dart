import 'package:flutter/foundation.dart';
import 'package:patrol/patrol.dart';

Future<void> iSeeLightCard(PatrolIntegrationTester $, String entityId) async {
  await $(Key('light_card.$entityId')).waitUntilVisible();
}
