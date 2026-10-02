import 'dart:io';
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/lifecycle.dart';
import '../../../scripts/e2e/watch.dart';

void main() {
  test(
    'interruption remains handled until asynchronous cleanup finishes',
    () async {
      final signals = StreamController<int>();
      addTearDown(signals.close);
      final cleanupStarted = Completer<void>(), cleanupDone = Completer<void>();
      final received = <int>[];
      final result = withRunSignals(
        () async {
          try {
            return 7;
          } finally {
            cleanupStarted.complete();
            await cleanupDone.future;
          }
        },
        (code) async {
          received.add(code);
        },
        events: signals.stream,
      );
      await cleanupStarted.future;
      signals.add(143);
      await Future<void>.delayed(Duration.zero);
      expect(received, [143]);
      cleanupDone.complete();
      expect(await result, 7);
    },
  );
  test('watch stop waits for a later file-triggered recovery', () async {
    final dir = Directory.systemTemp.createTempSync('watch-recovery');
    final source = File('${dir.path}/app/lib/widget.dart');
    source.parent.createSync(recursive: true);
    source.writeAsStringSync('initial');
    final signals = StreamController<int>();
    final initial = Completer<void>(), later = Completer<void>();
    final recovered = Completer<void>();
    var calls = 0, finished = false;
    final watching =
        watchRuns(dir, () async {
          if (++calls == 1) {
            initial.complete();
            return 0;
          }
          later.complete();
          await recovered.future;
          return 7;
        }, stopEvents: signals.stream).then((code) {
          finished = true;
          return code;
        });
    await initial.future;
    await Future<void>.delayed(const Duration(milliseconds: 100));
    source.writeAsStringSync('edited');
    await later.future.timeout(const Duration(seconds: 5));
    signals.add(143);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(finished, isFalse);
    recovered.complete();
    expect(await watching, 7);
    await signals.close();
    dir.deleteSync(recursive: true);
  });
  test(
    'smoke interruption restores route before releasing ownership',
    () async {
      final signals = StreamController<int>();
      final disabled = Completer<void>(), cancelled = Completer<void>();
      final restoring = Completer<void>(), restored = Completer<void>();
      var finished = false;
      final result =
          runSmokeLifecycle(
            () async {
              disabled.complete();
              await cancelled.future;
              throw StateError('cancelled request');
            },
            () async {
              cancelled.complete();
            },
            () async {
              restoring.complete();
              await restored.future;
            },
            events: signals.stream,
          ).then((code) {
            finished = true;
            return code;
          });
      await disabled.future;
      signals.add(143);
      await restoring.future;
      expect(finished, isFalse);
      restored.complete();
      expect(await result, 143);
      await signals.close();
    },
  );
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
      expect(watchRelevant('docker/hass_init_conf/.env'), isFalse);
      expect(watchRelevant('docker/hass_init_conf/.env.tmp'), isFalse);
      expect(watchRelevant('app/lib/widget.dart'), isTrue);
      expect(watchRelevant('app/lib/widget.g.dart'), isFalse);
      expect(watchRelevant('app/integration_test/test_bundle.dart'), isFalse);
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
