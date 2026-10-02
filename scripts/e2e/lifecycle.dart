import 'dart:convert';
import 'dart:io';
import 'dart:async';

/// Keep signal handling alive through recovery and evidence capture, not just
/// the primary child. A second interruption must not orphan a recovery child.
Future<T> withRunSignals<T>(
  Future<T> Function() body,
  Future<void> Function(int) interrupt, {
  Stream<int>? events,
}) async {
  final streams = events == null
      ? [
          ProcessSignal.sigint.watch().map((_) => 130),
          ProcessSignal.sigterm.watch().map((_) => 143),
        ]
      : [events];
  final subscriptions = streams
      .map(
        (stream) => stream.listen((code) {
          interrupt(code).ignore();
        }),
      )
      .toList();
  try {
    return await body();
  } finally {
    for (final subscription in subscriptions) {
      await subscription.cancel();
    }
  }
}

Future<int> repeatRuns(int count, Future<int> Function() run) async {
  for (var i = 0; i < count; i++) {
    final code = await run();
    if (code != 0) return code;
  }
  return 0;
}

/// Keep the inode stable: unlinking a locked file permits competing locks.
class RunLock {
  static final _held = <String>{};
  final RandomAccessFile handle;
  final String path;
  final bool stale;
  RunLock._(this.handle, this.path, this.stale);
  static Future<RunLock> acquire(File file) async {
    final path = file.absolute.path;
    if (_held.contains(path))
      throw StateError('Another E2E runner owns the fixture');
    await file.parent.create(recursive: true);
    final handle = await file.open(mode: FileMode.append);
    try {
      await handle.lock(FileLock.exclusive);
      await handle.setPosition(0);
      final text = utf8.decode(await handle.read(await handle.length()));
      var stale = false;
      if (text.trim().isNotEmpty) {
        final previous = jsonDecode(text) as Map;
        if (previous['status'] == 'active') {
          final owner = previous['pid'];
          if (owner is! int)
            throw StateError('Invalid lock owner; repair required');
          final alive = await Process.run('/bin/kill', ['-0', '$owner']);
          if (alive.exitCode == 0)
            throw StateError(
              'Another E2E runner owns the fixture (PID $owner)',
            );
          stale = true;
        }
      }
      await handle.truncate(0);
      await handle.setPosition(0);
      await handle.writeString(
        jsonEncode({
          'pid': pid,
          'runId': 'owner_${DateTime.now().microsecondsSinceEpoch}',
          'startedAt': DateTime.now().toUtc().toIso8601String(),
          'status': 'active',
        }),
      );
      await handle.flush();
      _held.add(path);
      return RunLock._(handle, path, stale);
    } catch (_) {
      await handle.close();
      throw StateError(
        'Another E2E runner owns the fixture, or its lock requires repair',
      );
    }
  }

  Future<void> release() async {
    await handle.truncate(0);
    await handle.setPosition(0);
    await handle.writeString(jsonEncode({'pid': pid, 'status': 'released'}));
    await handle.flush();
    await handle.unlock();
    await handle.close();
    _held.remove(path);
  }

  Future<void> recordRun(String runId) async {
    await handle.truncate(0);
    await handle.setPosition(0);
    await handle.writeString(
      jsonEncode({
        'pid': pid,
        'runId': runId,
        'startedAt': DateTime.now().toUtc().toIso8601String(),
        'status': 'active',
      }),
    );
    await handle.flush();
  }
}

/// Smoke keeps ownership through cancellation and independent route recovery.
Future<int> runSmokeLifecycle(
  Future<void> Function() body,
  Future<void> Function() cancel,
  Future<void> Function() restore, {
  Stream<int>? events,
  Duration timeout = const Duration(minutes: 4),
}) async {
  int? interrupted;
  Future<void>? cancellation;
  Future<void> interrupt(int code) {
    interrupted ??= code;
    return cancellation ??= cancel();
  }

  final deadline = Timer(timeout, () => interrupt(124).ignore());
  return withRunSignals(
    () async {
      try {
        await body();
      } catch (_) {
        if (interrupted == null) rethrow;
      } finally {
        deadline.cancel();
        try {
          await cancellation;
        } finally {
          await restore().timeout(const Duration(seconds: 30));
        }
      }
      return interrupted ?? 0;
    },
    interrupt,
    events: events,
  );
}
