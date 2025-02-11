import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

abstract class HTask<TSuccess, TError> {
  void Function(TSuccess data)? onSuccess;
  void Function(TError error)? onError;

  String get name;
  Future<HTaskResult<TSuccess, TError>> execute(TaskExecutionContext context);

  // void Function(TSuccess data)? get onSuccess => _onSuccess;
  // set onSuccess(void Function(TSuccess data)? callback) =>
  //     _onSuccess = callback;

  // void Function(TError error)? get onError => _onError;
  // set onError(void Function(TError error)? callback) => _onError = callback;

  bool get supportsRollback => true;
  Future<void> rollback(TaskExecutionContext context) async {}
}

enum Status { success, failed }

class HTaskResult<TSuccess, TError> {
  final Status status;
  final String? message;
  final TError? error;
  final TSuccess? data;

  const HTaskResult({
    required this.status,
    this.message,
    this.error,
    this.data,
  });

  HTaskResult.success(TSuccess this.data, {this.message})
      : status = Status.success,
        error = null;

  HTaskResult.failure(TError this.error, {this.message})
      : status = Status.failed,
        data = null;
}
