import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

Future<void> performCleanup(PatrolIntegrationTester $) async {
  final failures = await TestContext.instance().cleanup.run();
  if (failures.isNotEmpty)
    throw StateError(
      'Cleanup failed: ${failures.map((f) => f.label).join(', ')}',
    );
}
