import 'dart:io';
import 'dart:async';

import 'package:patrol/patrol.dart';

/// Usage: I see credentials web view form
Future<void> iSeeCredentialsWebViewForm(PatrolIntegrationTester $) async {
  if (Platform.isIOS) {
    final deadline = DateTime.now().add(const Duration(seconds: 20));
    while (true) {
      final consent = await $.platform.ios.getNativeViews(
        const IOSSelector(text: 'Continue'),
        appId: 'com.apple.springboard',
      );
      if (consent.roots.isNotEmpty) {
        await $.platform.ios.tap(
          const IOSSelector(text: 'Continue'),
          appId: 'com.apple.springboard',
        );
        break;
      }
      final form = await $.platform.ios.getNativeViews(
        const IOSSelector(text: 'Home Assistant'),
      );
      if (form.roots.isNotEmpty) break;
      if (DateTime.now().isAfter(deadline))
        throw TimeoutException('iOS sign-in consent or HA form did not appear');
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }
  await $.platform.mobile.waitUntilVisible(Selector(text: 'Home Assistant'));
}
