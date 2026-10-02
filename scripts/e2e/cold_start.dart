import 'dart:convert';
import 'dart:io';

/// One logical test, two real app processes, one owned session.
class ColdStartRunner {
  final Future<int> Function(String, File) phase;
  final Future<void> Function() checkpoint, terminate, cleanup;
  final Future<void> Function(bool) route;
  ColdStartRunner({
    required this.phase,
    required this.checkpoint,
    required this.terminate,
    required this.route,
    required this.cleanup,
  });
  Future<int> run({required File defines}) async {
    var code = 1;
    try {
      await _setPhase(defines, 'seed');
      code = await phase('seed', defines);
      if (code != 0) return code;
      await checkpoint();
      await terminate();
      await route(false);
      await _setPhase(defines, 'verify');
      code = await phase('verify', defines);
    } finally {
      Object? failure;
      StackTrace? trace;
      try {
        await route(true);
      } catch (e, s) {
        failure = e;
        trace = s;
      }
      try {
        await cleanup();
      } catch (e, s) {
        failure ??= e;
        trace ??= s;
      }
      if (failure != null && code == 0)
        Error.throwWithStackTrace(failure, trace!);
    }
    return code;
  }

  Future<void> _setPhase(File file, String phase) async {
    final values = jsonDecode(await file.readAsString()) as Map;
    values['E2E_COLD_PHASE'] = phase;
    final temp = File('${file.path}.tmp');
    await temp.writeAsString(jsonEncode(values), flush: true);
    await Process.run('chmod', ['600', temp.path]);
    await temp.rename(file.path);
  }
}
