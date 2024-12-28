import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Usage: the device regains network connectivity
Future<void> theDeviceRegainsNetworkConnectivity(
    PatrolIntegrationTester $) async {
  await $.native.enableWifi();
  await $.native.enableCellular();
}
