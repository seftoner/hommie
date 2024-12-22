import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Usage: I enter {'admin'} {'yourpassword'} credentials
Future<void> iEnterCredentials(
    PatrolIntegrationTester $, String usernmae, String password) async {
  // await $.native.enterText(Selector(text: 'Username'), text: usernmae);
  // await $.native.enterText(Selector(text: 'Password'), text: password);
  await $.native.enterTextByIndex(usernmae, index: 0); // enter username
  await $.native.enterTextByIndex(password, index: 1); // enter password
}
