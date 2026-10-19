import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:patrol/patrol.dart';

Future<void> iCreateArea(PatrolIntegrationTester $, String areaName) async {
  await $(K.areas.createButton).tap();
  await $(K.areas.nameField).enterText(areaName);
  await $(K.areas.saveButton).tap();
  await _scrollUntilAreaVisible($, areaName);
}

Future<void> _scrollUntilAreaVisible(
  PatrolIntegrationTester $,
  String areaName,
) async {
  final areaFinder = find.text(areaName);
  await $(areaFinder).scrollTo(maxScrolls: 20);
  await $(areaFinder).waitUntilVisible();
}
