import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future<void> iTapOnButton(PatrolIntegrationTester $, Key button) async {
  await $(button).tap();
}
