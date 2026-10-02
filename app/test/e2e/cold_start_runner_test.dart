import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/cold_start.dart';

void main() {
  for (final failure in ['none', 'seed', 'verify', 'checkpoint']) {
    test('cold pair ordering and cleanup on $failure', () async {
      final events = <String>[];
      final dir = Directory.systemTemp.createTempSync('cold-test');
      addTearDown(() => dir.deleteSync(recursive: true));
      final defines = File('${dir.path}/defines.json')
        ..writeAsStringSync('{"E2E_RUN_ID":"same_run"}');
      final runner = ColdStartRunner(
        phase: (name, file) async {
          events.add(name);
          expect(file.readAsStringSync(), contains('same_run'));
          return name == failure ? 7 : 0;
        },
        checkpoint: () async {
          events.add('checkpoint');
          if (failure == 'checkpoint') throw StateError('missing');
        },
        terminate: () async => events.add('terminate'),
        route: (enabled) async =>
            events.add(enabled ? 'restore' : 'disconnect'),
        cleanup: () async => events.add('cleanup'),
      );
      if (failure == 'checkpoint') {
        await expectLater(runner.run(defines: defines), throwsStateError);
      } else {
        expect(await runner.run(defines: defines), failure == 'none' ? 0 : 7);
      }
      expect(
        events,
        failure == 'seed'
            ? ['seed', 'restore', 'cleanup']
            : failure == 'checkpoint'
            ? ['seed', 'checkpoint', 'restore', 'cleanup']
            : [
                'seed',
                'checkpoint',
                'terminate',
                'disconnect',
                'verify',
                'restore',
                'cleanup',
              ],
      );
    });
  }
}
