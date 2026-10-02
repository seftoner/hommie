import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/cold_start.dart';

void main() {
  test(
    'verify exception survives restoration failure; cleanup still runs',
    () async {
      final events = <String>[];
      final dir = Directory.systemTemp.createTempSync('cold-errors');
      addTearDown(() => dir.deleteSync(recursive: true));
      final file = File('${dir.path}/defines.json')..writeAsStringSync('{}');
      final runner = ColdStartRunner(
        phase: (name, _) async {
          if (name == 'verify') throw const FormatException('primary');
          return 0;
        },
        checkpoint: () async {},
        terminate: () async {},
        route: (enabled) async {
          if (enabled) throw StateError('secondary');
        },
        cleanup: () async {
          events.add('cleanup');
        },
      );
      await expectLater(runner.run(defines: file), throwsFormatException);
      expect(events, ['cleanup']);
    },
  );
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
