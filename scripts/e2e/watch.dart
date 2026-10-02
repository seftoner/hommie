import 'dart:async';
import 'dart:io';

bool watchRelevant(String path) {
  path = path.replaceAll('\\', '/');
  if (path.startsWith('docker/hass_init_conf/')) return false;
  if (path == 'app/integration_test/test_bundle.dart') return false;
  if (path
      .split('/')
      .any(
        (p) => [
          'build',
          '.dart_tool',
          '.git',
          '.superpowers',
          'artifacts',
        ].contains(p),
      ))
    return false;
  if (path.endsWith('.g.dart') ||
      path.endsWith('.freezed.dart') ||
      RegExp(r'^app/integration_test/[^/]+_test\.dart$').hasMatch(path))
    return false;
  return path.startsWith('app/lib/') ||
      path.startsWith('app/integration_test/') ||
      path.startsWith('docker/') ||
      path.startsWith('scripts/e2e') ||
      path.endsWith('pubspec.yaml') ||
      path.endsWith('pubspec.lock') ||
      path.endsWith('build.yaml');
}

class SerializedRunQueue {
  final Future<void> Function() run;
  bool _queued = false;
  Future<void>? _active;
  bool _stopped = false;
  SerializedRunQueue(this.run);
  Future<void> request() {
    if (_stopped) return _active ?? Future.value();
    _queued = true;
    return _active ??= _drain();
  }

  Future<void> waitForIdle() => _active ?? Future.value();

  void stop() {
    _stopped = true;
    _queued = false;
  }

  Future<void> _drain() async {
    try {
      while (_queued) {
        _queued = false;
        await run();
      }
    } finally {
      _active = null;
    }
  }
}

Future<int> watchRuns(
  Directory root,
  Future<int> Function() run, {
  Stream<int>? stopEvents,
}) async {
  var code = 0;
  final queue = SerializedRunQueue(() async {
    code = await run();
  });
  Timer? debounce;
  final subscription = root.watch(recursive: true).listen((event) {
    if (!event.path.startsWith('${root.path}/')) return;
    final path = event.path.substring(root.path.length + 1);
    if (!watchRelevant(path)) return;
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () {
      unawaited(queue.request());
    });
  });
  final stopped = Completer<void>();
  final signals =
      (stopEvents == null
              ? [
                  ProcessSignal.sigint.watch().map((_) => 130),
                  ProcessSignal.sigterm.watch().map((_) => 143),
                ]
              : [stopEvents])
          .map(
            (stream) => stream.listen((_) {
              queue.stop();
              if (!stopped.isCompleted) stopped.complete();
            }),
          )
          .toList();
  try {
    await queue.request();
    await stopped.future;
  } finally {
    debounce?.cancel();
    queue.stop();
    await subscription.cancel();
    await queue.waitForIdle();
    for (final s in signals) {
      await s.cancel();
    }
  }
  return code;
}
