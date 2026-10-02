import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

Future<void> theApplicationIsRunningInTheForeground(
  PatrolIntegrationTester $,
) async {
  await $.pumpWidget(
    UncontrolledProviderScope(
      container: TestContext.instance().appState.container,
      child: const HommieApp(),
    ),
  );
}
