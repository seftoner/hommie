import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:patrol/patrol.dart';

Future<void> iRenameArea(
  PatrolIntegrationTester $,
  String currentName,
  String newName,
) async {
  await _scrollUntilAreaVisible($, currentName);
  await _tapAreaOverflowMenu($, currentName);
  await $(find.text('Rename')).tap();
  await $(K.areas.nameField).enterText(newName);
  await $(K.areas.saveButton).tap();
  await _scrollUntilAreaVisible($, newName);
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
