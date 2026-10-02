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
  ProcessRunner({this.onOutput});
  int get activeCount => _active.length;
  Future<ProcessResult> run(
    String executable,
    List<String> args, {
    required Directory cwd,
    required Duration timeout,
    Map<String, String>? environment,
  }) async {
    final p = await Process.start(
      executable,
      args,
      workingDirectory: cwd.path,
      environment: environment,
    );
    _active.add(p);
    Future<String> collect(Stream<List<int>> stream) async {
      final buffer = StringBuffer();
      await for (final text in stream.transform(utf8.decoder)) {
        buffer.write(text);
        onOutput?.call(text);
      }
      return buffer.toString();
    }

    final stdout = collect(p.stdout), stderr = collect(p.stderr);
    try {
      final code = await p.exitCode.timeout(timeout);
      return ProcessResult(p.pid, code, await stdout, await stderr);
    } on TimeoutException {
      p.kill(ProcessSignal.sigkill);
      await p.exitCode;
      await Future.wait([stdout, stderr]);
      throw ProcessTimeout(executable);
    } finally {
      _active.remove(p);
    }
  }

  Future<void> cancel() async {
    for (final p in _active.toList()) {
      p.kill(ProcessSignal.sigkill);
    }
    await Future.wait(_active.toList().map((p) => p.exitCode));
  }
}
