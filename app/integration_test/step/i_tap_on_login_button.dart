import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future<void> iTapOnLoginButton(PatrolIntegrationTester $) async {
  await $.platform.tap(Selector(text: 'LOG IN'));
}
