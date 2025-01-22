import 'package:hommie/features/sync/domain/models/sync_task.dart';
import 'package:hommie/features/sync/domain/services/i_sync_task_factory.dart';
import 'package:hommie/features/sync/infrastructure/runner/sync_chain_executor.dart';

class SyncOrchestrator {
  // final IHAConnection _connection;
  final ISyncTaskFactory _taskFactory;

  SyncOrchestrator(this._taskFactory);

  Future<List<SyncResult>> execute() async {
    /*  final preflight = await _runPreflightChecks();
    if (!preflight.canProceed) {
      return [SyncResult(
        status: SyncStatus.skipped,
        message: preflight.message
      )];
    } */

    final tasks = await _taskFactory.createAllTasks();
    final executor = SyncChainExecutor(tasks);
    return executor.execute();
  }
}
