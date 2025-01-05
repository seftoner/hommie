import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Usage: the device loses network connectivity
Future<void> theDeviceLosesNetworkConnectivity(
    PatrolIntegrationTester $) async {
  await $.native.disableWifi();
  await $.native.disableCellular();
}
