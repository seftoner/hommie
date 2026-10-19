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
    if (_result != null) {
      throw StateError('Cleanup already started');
    }
    _actions.add((label: label, action: action));
  }

  Future<List<CleanupFailure>> run() => _result ??= _run();
  Future<void> finish({
    required bool primaryFailed,
    required void Function(String) diagnostic,
    Iterable<String> secrets = const [],
  }) async {
    final failures = await run();
    if (failures.isEmpty) {
      return;
    }
    var message =
        'Cleanup failures: ${failures.map((f) => '${f.label}: ${f.error}').join('; ')}';
    for (final secret in secrets.where((value) => value.isNotEmpty)) {
      message = message.replaceAll(secret, '[REDACTED]');
    }
    if (primaryFailed) {
      diagnostic(message);
    } else {
      Error.throwWithStackTrace(StateError(message), failures.first.stackTrace);
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
