import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future<void> iEnterCredentials(
  PatrolIntegrationTester $,
  String usernmae,
  String password,
) async {
  await $.platform.mobile.enterTextByIndex(usernmae, index: 0);
  await $.platform.mobile.enterTextByIndex(password, index: 1);
}
