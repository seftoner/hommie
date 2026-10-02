class CleanupFailure {
  final String label;
  final Object error;
  final StackTrace stackTrace;
  CleanupFailure(this.label, this.error, this.stackTrace);
}

class ScenarioCleanup {
  final _actions = <({String label, Future<void> Function() action})>[];
  Future<List<CleanupFailure>>? _result;
  void register(String label, Future<void> Function() action) {
    if (_result != null) throw StateError('Cleanup already started');
    _actions.add((label: label, action: action));
  }

  Future<List<CleanupFailure>> run() => _result ??= _run();
  Future<void> finish({
    required bool primaryFailed,
    required void Function(String) diagnostic,
  }) async {
    final failures = await run();
    if (failures.isEmpty) return;
    final message =
        'Cleanup failures: ${failures.map((f) => f.label).join(', ')}';
    if (primaryFailed) {
      diagnostic(message);
    } else {
      throw StateError(message);
    }
  }

  Future<List<CleanupFailure>> _run() async {
    final failures = <CleanupFailure>[];
    for (final entry in _actions.reversed) {
      try {
        await entry.action();
      } catch (error, stack) {
        failures.add(CleanupFailure(entry.label, error, stack));
      }
    }
    return List.unmodifiable(failures);
  }
}
