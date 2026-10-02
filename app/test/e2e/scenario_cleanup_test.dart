import 'package:flutter_test/flutter_test.dart';

import '../../integration_test/utils/scenario_cleanup.dart';

void main() {
  test('cleanup diagnostics preserve an existing assertion but fail a successful scenario', () async {
    final cleanup = ScenarioCleanup();
    cleanup.register('owned token', () async {
      throw StateError('secondary');
    });
    final diagnostics = <String>[];
    await cleanup.finish(primaryFailed: true, diagnostic: diagnostics.add);
    expect(diagnostics.single, contains('owned token'));
    await expectLater(
      cleanup.finish(primaryFailed: false, diagnostic: diagnostics.add),
      throwsStateError,
    );
  });
  test('all cleanup runs once in reverse order despite failures', () async {
    final cleanup = ScenarioCleanup();
    final events = <String>[];
    cleanup.register('first', () async {
      events.add('first');
    });
    cleanup.register('broken', () async {
      events.add('broken');
      throw StateError('failure');
    });
    cleanup.register('last', () async {
      events.add('last');
    });
    final failures = await cleanup.run();
    expect(events, ['last', 'broken', 'first']);
    expect(failures.single.label, 'broken');
    expect(failures.single.stackTrace.toString(), isNotEmpty);
    expect(await cleanup.run(), failures);
    expect(events.length, 3);
  });
}
