import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';

import '../../integration_test/utils/offline_assertions.dart';

Widget banner(ValueNotifier<bool> show) => MaterialApp(
  home: Scaffold(
    body: ValueListenableBuilder<bool>(
      valueListenable: show,
      builder: (_, visible, _) => Column(
        children: [
          ClipRect(
            child: AnimatedAlign(
              alignment: Alignment.topCenter,
              heightFactor: visible ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: SizedBox(
                height: 80,
                child: Text('Offline', key: K.common.offlineBanner),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
void main() {
  testWidgets('mounted banner clipped to zero is hidden', (tester) async {
    final show = ValueNotifier(false);
    addTearDown(show.dispose);
    await tester.pumpWidget(banner(show));
    expect(find.byKey(K.common.offlineBanner), findsOneWidget);
    await waitForOfflineBanner(tester, visible: false);
  });
  testWidgets('waits for delayed hide and completed clipping animation', (
    tester,
  ) async {
    final show = ValueNotifier(true);
    addTearDown(show.dispose);
    await tester.pumpWidget(banner(show));
    await waitForOfflineBanner(tester, visible: true);
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      show.value = false;
    });
    await waitForOfflineBanner(tester, visible: false);
    expect(find.byKey(K.common.offlineBanner), findsOneWidget);
    expect(tester.getSize(find.byType(AnimatedAlign)).height, 0);
  });
}
