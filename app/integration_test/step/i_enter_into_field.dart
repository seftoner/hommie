import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future<void> iEnterIntoField(
    PatrolIntegrationTester $, String text, Key field) async {
  await $(field).enterText(text);
}
