import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';

Finder discoveredServerRow({required String name, required Uri url}) {
  final namedRows = find.ancestor(
    of: find.text(name),
    matching: find.byType(ListTile),
  );
  return find.ancestor(
    of: find.descendant(of: namedRows, matching: find.text(url.toString())),
    matching: namedRows,
  );
}

Future<void> waitForNoDiscoveredServers(
  WidgetTester tester, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final page = find.byKey(K.serversDiscovery.page);
  final emptyState = find
      .descendant(of: page, matching: find.text('No servers found.'))
      .hitTestable();
  final rows = find.descendant(of: page, matching: find.byType(ListTile));
  final deadline = tester.binding.clock.now().add(timeout);
  while (true) {
    if (emptyState.evaluate().length == 1 && rows.evaluate().isEmpty) {
      return;
    }
    if (tester.binding.clock.now().isAfter(deadline)) {
      throw TimeoutException(
        'Discovery did not complete with no servers found',
        timeout,
      );
    }
    await tester.pump(const Duration(milliseconds: 100));
  }
}
