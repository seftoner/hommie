import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Usage: the device loses network connectivity
Future<void> theDeviceLosesNetworkConnectivity(
  PatrolIntegrationTester $,
) async {
  await $.platform.mobile.disableWifi();
  await $.platform.mobile.disableCellular();
}
