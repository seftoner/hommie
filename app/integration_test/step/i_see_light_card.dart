import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../utils/test_context.dart';

Future<void> iSeeLightCard(PatrolIntegrationTester $, String entityId) async {
  await TestContext.instance().appState.waitForCachedEntity(entityId);
  final summary = find.byKey(const PageStorageKey('home.summary'));
  final scrollable = summary.evaluate().isNotEmpty
      ? find.descendant(of: summary, matching: find.byType(Scrollable)).first
      : find.byType(Scrollable).first;
  await $(Key('light_card.$entityId')).scrollTo(view: scrollable, maxScrolls: 40);
  await $(Key('light_card.$entityId')).waitUntilVisible();
}
