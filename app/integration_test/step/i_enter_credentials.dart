import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future<void> iEnterCredentials(
    PatrolIntegrationTester $, String usernmae, String password) async {
  await $.native.enterTextByIndex(usernmae, index: 0); // enter username
  await $.native.enterTextByIndex(password, index: 1); // enter password
}
