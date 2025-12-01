import 'dart:isolate';

class ComputerError implements Exception {
  final String message;

  ComputerError(this.message);

  @override
  String toString() => message;
}

class RemoteExecutionError extends ComputerError {
  final Capability taskCapability;

  RemoteExecutionError(
    super.message,
    this.taskCapability,
  );
}

class CancelExecutionError extends ComputerError {
  final Capability taskCapability;

  CancelExecutionError(
    super.message,
    this.taskCapability,
  );
}
