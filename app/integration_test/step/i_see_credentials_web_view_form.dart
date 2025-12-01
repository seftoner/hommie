import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Usage: I see credentials web view form
Future<void> iSeeCredentialsWebViewForm(PatrolIntegrationTester $) async {
  await $.native.waitUntilVisible(Selector(text: 'Home Assistant'));
}
