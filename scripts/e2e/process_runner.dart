import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ProcessTimeout implements Exception {
  final String executable;
  ProcessTimeout(this.executable);
  @override
  String toString() => 'Timed out running $executable';
}

class ProcessRunner {
  final Set<Process> _active = {};
  final void Function(String)? onOutput;
  bool _cancelled = false;
  ProcessRunner({this.onOutput});
  int get activeCount => _active.length;
  Future<ProcessResult> run(
    String executable,
    List<String> args, {
    required Directory cwd,
    required Duration timeout,
    Map<String, String>? environment,
    Stream<List<int>>? input,
  }) async {
    if (_cancelled) throw StateError('Run was interrupted');
    final p = await Process.start(
      executable,
      args,
      workingDirectory: cwd.path,
      environment: environment,
    );
    _active.add(p);
    StreamSubscription<List<int>>? inputSubscription;
    if (input != null) {
      inputSubscription = input.listen(
        p.stdin.add,
        onDone: () {
          unawaited(p.stdin.close().catchError((_) {}));
        },
      );
      unawaited(p.stdin.done.catchError((_) {}));
    }
    final outputSubscriptions = <StreamSubscription<String>>[];
    Future<String> collect(Stream<List<int>> stream) {
      final buffer = StringBuffer();
      var pending = '';
      final done = Completer<String>();
      outputSubscriptions.add(
        stream
            .transform(utf8.decoder)
            .listen(
              (text) {
                buffer.write(text);
                pending += text;
                final last = pending.lastIndexOf('\n');
                if (last >= 0) {
                  onOutput?.call(pending.substring(0, last + 1));
                  pending = pending.substring(last + 1);
                }
              },
              onDone: () {
                if (pending.isNotEmpty) onOutput?.call(pending);
                done.complete(buffer.toString());
              },
              onError: done.completeError,
            ),
      );
      return done.future;
    }

    final stdout = collect(p.stdout), stderr = collect(p.stderr);
    try {
      return await (() async {
        final code = await p.exitCode;
        return ProcessResult(p.pid, code, await stdout, await stderr);
      })().timeout(timeout);
    } on TimeoutException {
      await _killTree(p);
      await p.exitCode;
      // A reparented descendant may still own a pipe after its parent exits.
      // Close our pipe subscriptions; output draining is part of the deadline.
      for (final subscription in outputSubscriptions) {
        await subscription.cancel();
      }
      throw ProcessTimeout(executable);
    } finally {
      await inputSubscription?.cancel();
      _active.remove(p);
    }
  }

  Future<void> cancel() async {
    _cancelled = true;
    for (final p in _active.toList()) {
      await _killTree(p);
    }
    await Future.wait(_active.toList().map((p) => p.exitCode));
  }

  Future<void> _killTree(Process process) async {
    final snapshot = await Process.run('/bin/ps', ['-axo', 'pid=,ppid=']);
    if (snapshot.exitCode != 0) {
      process.kill(ProcessSignal.sigkill);
      throw StateError(
        'Cannot inspect owned child processes for interruption cleanup',
      );
    }
    final children = <int, List<int>>{};
    for (final line in (snapshot.stdout as String).split('\n')) {
      final parts = line.trim().split(RegExp(r'\s+'));
      if (parts.length != 2) continue;
      final child = int.tryParse(parts[0]), parent = int.tryParse(parts[1]);
      if (child != null && parent != null) (children[parent] ??= []).add(child);
    }
    void kill(int parent) {
      for (final child in children[parent] ?? <int>[]) {
        kill(child);
      }
      Process.killPid(parent, ProcessSignal.sigkill);
    }

    kill(process.pid);
  }
}
