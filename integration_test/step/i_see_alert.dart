import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Usage: I see {K.signOutAlert} alert
Future<void> iSeeAlert(PatrolIntegrationTester $, Key alerName) async {
  await $(alerName).waitUntilVisible();
}
