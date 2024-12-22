import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future<void> iSeeButton(PatrolIntegrationTester $, Key button) async {
  await $(button).waitUntilVisible();
}
