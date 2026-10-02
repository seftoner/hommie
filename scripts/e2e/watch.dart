import 'dart:async';
import 'dart:io';

bool watchRelevant(String path) {
  path = path.replaceAll('\\', '/');
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
      (path.contains('integration_test/') && path.endsWith('_test.dart')))
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

Future<int> watchRuns(Directory root, Future<int> Function() run) async {
  var code = 0;
  final queue = SerializedRunQueue(() async {
    code = await run();
  });
  Timer? debounce;
  final subscription = root.watch(recursive: true).listen((event) {
    final path = event.path.substring(root.path.length + 1);
    if (!watchRelevant(path)) return;
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () {
      unawaited(queue.request());
    });
  });
  final stopped = Completer<void>();
  final signals = [
    ProcessSignal.sigint.watch().listen((_) {
      queue.stop();
      if (!stopped.isCompleted) stopped.complete();
    }),
    ProcessSignal.sigterm.watch().listen((_) {
      queue.stop();
      if (!stopped.isCompleted) stopped.complete();
    }),
  ];
  try {
    await queue.request();
    await stopped.future;
  } finally {
    debounce?.cancel();
    await subscription.cancel();
    for (final s in signals) {
      await s.cancel();
    }
  }
  return code;
}
