import 'package:hommie/core/infrastructure/repositories/base_repository.dart';
import 'package:hommie/core/infrastructure/parallelism/i_parallel_executor.dart';
import 'package:hommie/features/settings/domain/entities/logs.dart';
import 'package:hommie/features/settings/domain/repository/i_logs_repository.dart';
import 'package:hommie/features/settings/infrastructure/tasks/fetch_logs_task.dart';

class LogsRepository extends BaseRepository implements ILogsRepository {
  final String _logsPath;

  LogsRepository(this._logsPath, IParallelExecutor executor) : super(executor);

  @override
  Future<List<Log>> fetchLogs(int offset, int limit) {
    final fetchTask = FetchLogsTask(
      FetchLogsParams(
        offset,
        limit,
        _logsPath,
      ),
    );

    return executor.execute<void, List<Log>>(fetchTask.run);
  }
}
