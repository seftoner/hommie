import 'dart:io';

import 'package:patrol/patrol.dart';

Future<void> iEnterCredentials(
  PatrolIntegrationTester $,
  String username,
  String password,
) async {
  final keyboardBehavior = Platform.isIOS ? KeyboardBehavior.alternative : null;
  await $.platform.mobile.enterTextByIndex(
    username,
    index: 0,
    keyboardBehavior: keyboardBehavior,
  );
  if (Platform.isIOS) {
    // Avoid XCTest's intermittent secure-field focus failure in the HA web form.
    await $.platform.ios.tap(
      const IOSSelector(
        elementType: IOSElementType.button,
        label: 'Show password',
      ),
    );
  }
  await $.platform.mobile.enterTextByIndex(
    password,
    index: 1,
    keyboardBehavior: keyboardBehavior,
  );
}
