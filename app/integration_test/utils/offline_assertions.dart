import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';

Future<void> waitForOfflineBanner(
  WidgetTester tester, {
  required bool visible,
  Duration timeout = const Duration(seconds: 20),
}) async {
  final deadline = tester.binding.clock.now().add(timeout);
  final banner = find.byKey(K.common.offlineBanner);
  final alignment = find.ancestor(
    of: banner,
    matching: find.byType(AnimatedAlign),
  );
  while (true) {
    final mounted =
        banner.evaluate().isNotEmpty && alignment.evaluate().isNotEmpty;
    final clippedHeight = mounted ? tester.getSize(alignment).height : 0.0;
    final fullHeight = mounted ? tester.getSize(banner).height : 0.0;
    final appeared =
        mounted &&
        fullHeight > 0 &&
        clippedHeight >= fullHeight - 0.5 &&
        banner.hitTestable().evaluate().isNotEmpty;
    final disappeared = !mounted || clippedHeight <= 0.5;
    if (visible ? appeared : disappeared) return;
    if (tester.binding.clock.now().isAfter(deadline))
      throw TimeoutException(
        'Offline banner did not ${visible ? 'become visible' : 'disappear'}',
        timeout,
      );
    await tester.pump(const Duration(milliseconds: 100));
  }
}
