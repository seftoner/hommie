import 'package:flutter/foundation.dart';
import 'package:patrol/patrol.dart';

Future<void> iScrollToButton(PatrolIntegrationTester $, Key key) async {
  await $(key).scrollTo(maxScrolls: 20);
  await $(key).waitUntilVisible();
}
