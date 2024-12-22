import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future<void> iSeePage(PatrolIntegrationTester $, Key pageName) async {
  await $(pageName).waitUntilVisible();
  // expect($(pageName), findsOneWidget);
  // await $(Scaffold).$(AppBar).$(pageName).waitUntilVisible();
}
