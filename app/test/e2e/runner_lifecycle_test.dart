import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/lifecycle.dart';
import '../../../scripts/e2e/watch.dart';

void main() {
  test('dead owner is flagged for fixture reconciliation', () async {
    final dir = Directory.systemTemp.createTempSync('stale-lock');
    addTearDown(() => dir.deleteSync(recursive: true));
    final file = File('${dir.path}/run.lock')
      ..writeAsStringSync('{"pid":999999999,"status":"active"}');
    final lock = await RunLock.acquire(file);
    expect(lock.stale, isTrue);
    await lock.release();
  });
  test('repeat is exact and fails fast', () async {
    var runs = 0;
    expect(
      await repeatRuns(3, () async {
        runs++;
        return 0;
      }),
      0,
    );
    expect(runs, 3);
    runs = 0;
    expect(
      await repeatRuns(3, () async {
        runs++;
        return 7;
      }),
      7,
    );
    expect(runs, 1);
  });
  test(
    'live ownership excludes a second runner, released locks can be reused',
    () async {
      final dir = Directory.systemTemp.createTempSync('run-lock');
      addTearDown(() => dir.deleteSync(recursive: true));
      final lock = await RunLock.acquire(File('${dir.path}/run.lock'));
      await expectLater(
        RunLock.acquire(File('${dir.path}/run.lock')),
        throwsStateError,
      );
      await lock.release();
      final next = await RunLock.acquire(File('${dir.path}/run.lock'));
      await next.release();
    },
  );
  test(
    'watch filters generated files and coalesces events without overlap',
    () async {
      expect(watchRelevant('app/lib/widget.dart'), isTrue);
      expect(watchRelevant('app/lib/widget.g.dart'), isFalse);
      expect(
        watchRelevant('app/integration_test/offline_banner_test.dart'),
        isFalse,
      );
      expect(watchRelevant('app/build/output'), isFalse);
      final events = <String>[];
      final queue = SerializedRunQueue(() async {
        events.add('start');
        await Future<void>.delayed(const Duration(milliseconds: 30));
        events.add('end');
      });
      final first = queue.request();
      await Future<void>.delayed(const Duration(milliseconds: 5));
      queue.request();
      queue.request();
      await first;
      expect(events, ['start', 'end', 'start', 'end']);
    },
  );
}
