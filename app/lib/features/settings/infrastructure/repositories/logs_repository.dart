import 'dart:io';

import 'package:hommie/core/infrastructure/parallelism/i_parallel_executor.dart';
import 'package:hommie/features/settings/domain/entities/logs.dart';
import 'package:hommie/features/settings/domain/repository/i_logs_repository.dart';
import 'package:hommie/features/settings/infrastructure/tasks/fetch_logs_task.dart';

class LogsRepository implements ILogsRepository {
  IParallelExecutor executor;
  final String _logsPath;

  LogsRepository(this._logsPath, this.executor);

  @override
  Future<List<Log>> fetchLogs(int offset, int limit) {
    final fetchTask = FetchLogsTask(FetchLogsParams(offset, limit, _logsPath));

    return executor.execute<void, List<Log>>(fetchTask.run);
  }

  @override
  Future<void> deleteLogs() async {
    final logFile = File(_logsPath);
    if (await logFile.exists()) {
      await logFile.delete();
      // Recreate empty file
      await logFile.create(recursive: true);
    }
  }
}
