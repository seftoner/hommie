import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/task_chain.dart';

class UnknownError implements Exception {
  @override
  String toString() => 'Unknown error occurred';
}

class TaskExecutor {
  final TaskChain _chain;

  TaskExecutor(this._chain);

  void _handleError(HTask task, Object error) {
    final specificHandler = _chain.errorHandlers[task.runtimeType];
    if (specificHandler != null) {
      specificHandler(error);
    } else if (_chain.defaultErrorHandler != null) {
      _chain.defaultErrorHandler!(error);
    }
  }

  Future<void> execute() async {
    final completedTasks = <HTask>[];

    try {
      for (final task in _chain.tasks) {
        final result = await task.execute(_chain.context);

        if (result.status == Status.failed) {
          await _rollback(completedTasks);
          _handleError(task, result.error ?? UnknownError());
          return;
        }

        completedTasks.add(task);
      }

      _chain.onSuccess?.call();
    } catch (e) {
      final currentTask = _chain.tasks[completedTasks.length];
      await _rollback(completedTasks);
      _handleError(currentTask, e);
    }
  }

  Future<Map<String, HTaskResult>> _rollback(List<HTask> tasks) async {
    final rollbackResults = <String, HTaskResult>{};

    for (final task in tasks.reversed) {
      if (task.supportsRollback) {
        try {
          await task.rollback(_chain.context);
          rollbackResults[task.name] =
              const HTaskResult(status: Status.success);
        } catch (e) {
          rollbackResults[task.name] = HTaskResult(
            status: Status.failed,
            error: e as Exception?,
            message: 'Rollback failed: $e',
          );
        }
      }
    }

    return rollbackResults;
  }
}

class TaskExecutionResult {
  final bool isSuccess;
  final HTask? failedTask;
  final Object? error;
  final String? message;

  const TaskExecutionResult.success()
      : isSuccess = true,
        failedTask = null,
        error = null,
        message = null;

  const TaskExecutionResult.failure({
    this.failedTask,
    this.error,
    this.message,
  }) : isSuccess = false;
}
