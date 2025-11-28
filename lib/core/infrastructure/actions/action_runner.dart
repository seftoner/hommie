import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/action_chain.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';

class UnknownError implements Exception {
  @override
  String toString() => 'Unknown error occurred';
}

class ActionRunner {
  final ActionChain _chain;

  ActionRunner(this._chain);

  void _handleError(HAction action, Object error) {
    final specificHandler = _chain.errorHandlers[action.runtimeType];
    if (specificHandler != null) {
      specificHandler(error);
    } else if (_chain.defaultErrorHandler != null) {
      _chain.defaultErrorHandler!(error);
    }
  }

  Future<void> run() async {
    final completedActions = <HAction>[];
    logger.d('Starting action chain execution');

    try {
      for (final action in _chain.actions) {
        logger.d('Executing action: ${action.name}');
        final result = await action.execute(_chain.context);

        if (result.status == Status.failed) {
          logger.e('Action ${action.name} failed', error: result.error);
          logger.d(
            'Starting rollback for ${completedActions.length} completed actions',
          );
          await _rollback(completedActions);

          _handleError(action, result.error ?? UnknownError());
          return;
        }

        logger.d('Action ${action.name} completed successfully');
        completedActions.add(action);
      }

      logger.d('Action chain completed successfully');
      _chain.onSuccess?.call(_chain.context);
    } catch (e, stack) {
      final currentAction = _chain.actions[completedActions.length];
      logger.e(
        'Unexpected error in action ${currentAction.name}',
        error: e,
        stackTrace: stack,
      );

      logger.d('Starting rollback due to unexpected error');
      await _rollback(completedActions);
      _handleError(currentAction, e);
    }
  }

  Future<Map<String, HActionResult>> _rollback(List<HAction> actions) async {
    final rollbackResults = <String, HActionResult>{};

    for (final action in actions.reversed) {
      if (action.supportsRollback) {
        try {
          await action.rollback(_chain.context);
          rollbackResults[action.name] = const HActionResult(
            status: Status.success,
          );
        } catch (e) {
          rollbackResults[action.name] = HActionResult(
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

class ActionExecutionResult {
  final bool isSuccess;
  final HAction? failedAction;
  final Object? error;
  final String? message;

  const ActionExecutionResult.success()
    : isSuccess = true,
      failedAction = null,
      error = null,
      message = null;

  const ActionExecutionResult.failure({
    this.failedAction,
    this.error,
    this.message,
  }) : isSuccess = false;
}
