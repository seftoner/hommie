import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:patrol/patrol.dart';

Future<void> iDeleteArea(PatrolIntegrationTester $, String areaName) async {
  await _scrollUntilAreaVisible($, areaName);
  await _tapAreaOverflowMenu($, areaName);
  await $(find.text('Delete')).tap();
  await $(K.areas.deleteDialog).waitUntilVisible();
  await $(K.areas.deleteConfirmButton).tap();
  await _waitUntilDeleteDialogDismissed($);
  await _waitUntilAreaAbsent($, areaName);
}

Future<void> _waitUntilDeleteDialogDismissed(PatrolIntegrationTester $) async {
  for (var attempt = 0; attempt < 10; attempt += 1) {
    final dialog = $(K.areas.deleteDialog);
    if (!dialog.exists) {
      break;
    }
    await $.pump(const Duration(milliseconds: 500));
  }

  expect(
    $(K.areas.deleteDialog).exists,
    isFalse,
    reason: 'Expected area delete dialog to be dismissed',
  );
}

Future<void> _waitUntilAreaAbsent(
  PatrolIntegrationTester $,
  String areaName,
) async {
  for (var attempt = 0; attempt < 10; attempt += 1) {
    final area = $(find.text(areaName));
    if (!area.exists) {
      break;
    }
    await $.pump(const Duration(milliseconds: 500));
  }

  expect(
    $(find.text(areaName)).exists,
    isFalse,
    reason: 'Expected deleted area "$areaName" to be absent from the page',
  );
}

Future<void> _tapAreaOverflowMenu(
  PatrolIntegrationTester $,
  String areaName,
) async {
  final rowFinder = find.ancestor(
    of: find.text(areaName),
    matching: find.byType(ListTile),
  );
  final overflowFinder = find.descendant(
    of: rowFinder,
    matching: find.byIcon(Symbols.more_vert_rounded),
  );

  await $(overflowFinder).tap();
}

Future<void> _scrollUntilAreaVisible(
  PatrolIntegrationTester $,
  String areaName,
) async {
  final areaFinder = find.text(areaName);
  await $(areaFinder).scrollTo(maxScrolls: 20);
  await $(areaFinder).waitUntilVisible();
}
