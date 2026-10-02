import 'dart:convert';
import 'dart:io';

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
