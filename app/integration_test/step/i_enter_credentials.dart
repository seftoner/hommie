import 'dart:io';

import 'package:patrol/patrol.dart';

Future<void> iEnterCredentials(
  PatrolIntegrationTester $,
  String usernmae,
  String password,
) async {
  final keyboardBehavior = Platform.isIOS ? KeyboardBehavior.alternative : null;
  await $.platform.mobile.enterTextByIndex(
    usernmae,
    index: 0,
    keyboardBehavior: keyboardBehavior,
  );
  await $.platform.mobile.enterTextByIndex(
    password,
    index: 1,
    keyboardBehavior: keyboardBehavior,
  );
}
