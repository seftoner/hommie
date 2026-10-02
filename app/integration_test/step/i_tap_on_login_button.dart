import 'dart:io';

import 'package:patrol/patrol.dart';

Future<void> iTapOnLoginButton(PatrolIntegrationTester $) async {
  if (Platform.isIOS) {
    final response = await $.platform.ios.getNativeViews(
      const IOSSelector(elementType: IOSElementType.button),
    );
    Iterable<IOSNativeView> flatten(IOSNativeView view) sync* {
      yield view;
      for (final child in view.children) {
        yield* flatten(child);
      }
    }

    final buttons = response.roots
        .expand(flatten)
        .where(
          (view) =>
              view.elementType == IOSElementType.button &&
              view.label.trim().toLowerCase() == 'log in',
        )
        .toList();
    if (buttons.length != 1) {
      throw StateError(
        'Expected one native HA Log in button, found ${buttons.length}',
      );
    }
    await $.platform.ios.tap(
      IOSSelector(
        elementType: IOSElementType.button,
        label: buttons.single.label,
      ),
    );
    return;
  }
  await $.platform.tap(Selector(text: 'LOG IN'));
}
