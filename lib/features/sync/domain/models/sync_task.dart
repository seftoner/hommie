enum SyncStatus { success, failed, partia, skipped }

class SyncResult {
  final SyncStatus status;
  final String? message;
  final Exception? error;

  const SyncResult({
    required this.status,
    this.message,
    this.error,
  });
}

class SyncContext {
  final Map<String, dynamic> _data = {};

  T? get<T>(String key) => _data[key] as T?;
  void set<T>(String key, T value) => _data[key] = value;
  bool has(String key) => _data.containsKey(key);
}

abstract class SyncTask {
  String get name;
  Set<String> get dependencies => {};
  Future<SyncResult> execute(SyncContext context);
}
