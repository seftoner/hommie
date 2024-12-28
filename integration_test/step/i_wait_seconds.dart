import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Usage: I wait {5} seconds
Future<void> iWaitSeconds(PatrolIntegrationTester $, int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  await $.pump();
}
