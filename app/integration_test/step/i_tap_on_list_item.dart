import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Usage: I tap on {K.hubListItem} list item
Future<void> iTapOnListItem(PatrolIntegrationTester $, Key listItem) async {
  await $(listItem).tap();
}
