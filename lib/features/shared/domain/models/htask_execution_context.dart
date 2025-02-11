class TaskExecutionContext {
  final Map<String, dynamic> _data;

  TaskExecutionContext([Map<String, dynamic>? initialData])
      : _data = {...initialData ?? {}};

  T? get<T>(String key) => _data[key] as T?;
  void set<T>(String key, T value) => _data[key] = value;
  bool has(String key) => _data.containsKey(key);
}
