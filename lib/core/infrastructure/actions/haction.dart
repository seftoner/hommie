import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';

abstract class HAction<TSuccess, TError> {
  void Function(TSuccess data)? onSuccess;
  void Function(TError error)? onError;

  String get name;
  Future<HActionResult<TSuccess, TError>> execute(
    ActionExecutionContext context,
  );

  // void Function(TSuccess data)? get onSuccess => _onSuccess;
  // set onSuccess(void Function(TSuccess data)? callback) =>
  //     _onSuccess = callback;

  // void Function(TError error)? get onError => _onError;
  // set onError(void Function(TError error)? callback) => _onError = callback;

  bool get supportsRollback => true;
  Future<void> rollback(ActionExecutionContext context) async {}
}

enum Status { success, failed }

class HActionResult<TSuccess, TError> {
  final Status status;
  final String? message;
  final TError? error;
  final TSuccess? data;

  const HActionResult({
    required this.status,
    this.message,
    this.error,
    this.data,
  });

  HActionResult.success(TSuccess this.data, {this.message})
    : status = Status.success,
      error = null;

  HActionResult.failure(TError this.error, {this.message})
    : status = Status.failed,
      data = null;
}
