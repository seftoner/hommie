import 'package:hommie/features/sync/domain/models/sync_task.dart';

class SyncChainExecutor {
  final List<SyncTask> _tasks;

  SyncChainExecutor(this._tasks);

  Future<List<SyncResult>> execute() async {
    final context = SyncContext();
    final results = <SyncResult>[];
    final completed = <String>{};

    while (completed.length < _tasks.length) {
      final availableTasks = _tasks.where((task) =>
          !completed.contains(task.name) &&
          task.dependencies.every((dep) => completed.contains(dep)));

      if (availableTasks.isEmpty) {
        throw Exception('Circular dependency detected or missing dependencies');
      }

      for (final task in availableTasks) {
        final result = await task.execute(context);
        results.add(result);
        completed.add(task.name);
      }
    }

    return results;
  }
}
