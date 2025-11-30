import 'dart:async';
import 'dart:isolate';

import '../errors.dart';

import 'task.dart';

typedef OnResultCallback = void Function(
  TaskResult result,
  Worker worker,
);

typedef OnErrorCallback = void Function(
  RemoteExecutionError error,
  Worker worker,
);

enum WorkerStatus { idle, processing }

class IsolateInitParams {
  SendPort commands;

  IsolateInitParams({required this.commands});
}

class Worker {
  final String name;

  WorkerStatus status = WorkerStatus.idle;

  late final Isolate _isolate;
  late final SendPort _commands;
  late final ReceivePort _responses;
  late final Stream _broadcastResponses;
  late final StreamSubscription _broadcastPortSubscription;

  Worker(this.name);

  Future<void> init({
    required OnResultCallback onResult,
    required OnErrorCallback onError,
  }) async {
    _responses = ReceivePort();
    _isolate = await Isolate.spawn(
      isolateEntryPoint,
      IsolateInitParams(
        commands: _responses.sendPort,
      ),
      debugName: name,
      errorsAreFatal: false,
    );

    _broadcastResponses = _responses.asBroadcastStream();

    _commands = await _getHandshake();

    _broadcastPortSubscription = _broadcastResponses.listen((dynamic res) {
      _handleResponse(res, onResult, onError);
    });
  }

  Future<SendPort> _getHandshake() async {
    return await _broadcastResponses.first as SendPort;
  }

  void _handleResponse(
    dynamic response,
    OnResultCallback onResult,
    OnErrorCallback onError,
  ) {
    if (response is RemoteExecutionError) {
      onError(response, this);
      return;
    }

    status = WorkerStatus.idle;
    onResult(response as TaskResult, this);
  }

  void execute(Task task) {
    _setStatusAndSend(task);
  }

  void executeStream(Task task, void Function(dynamic) onStreamResult) {
    _setStatusAndHandleStream(task, onStreamResult);
  }

  void _setStatusAndSend(Task task) {
    status = WorkerStatus.processing;
    _commands.send(task);
  }

  void _setStatusAndHandleStream(
      Task task, void Function(dynamic) onStreamResult) {
    status = WorkerStatus.processing;

    final stream = _extractStream(task);

    stream.listen(
      onStreamResult,
      onDone: () => _finalizeStream(task, onStreamResult),
      onError: (e) => _handleStreamError(e, task, onStreamResult),
    );
  }

  Stream _extractStream(Task task) {
    return task.task(task.param) as Stream;
  }

  void _finalizeStream(Task task, void Function(dynamic) onStreamResult) {
    // Send a TaskResult to signal the end of the stream
    final result = TaskResult(result: null, capability: task.capability);
    onStreamResult(result);
    status = WorkerStatus.idle;
  }

  void _handleStreamError(
    dynamic error,
    Task task,
    void Function(dynamic) onStreamResult,
  ) {
    final executionError =
        RemoteExecutionError(error.toString(), task.capability);
    onStreamResult(executionError);
  }

  Future<void> dispose() async {
    await _broadcastPortSubscription.cancel();
    _isolate.kill();
    _responses.close();
  }
}

Future<void> isolateEntryPoint(IsolateInitParams params) async {
  final responses = ReceivePort();
  final commands = params.commands;

  commands.send(responses.sendPort);

  await for (final Task task in responses.cast<Task>()) {
    try {
      final result = await _executeTask(task);
      commands.send(result);
    } catch (error) {
      commands.send(RemoteExecutionError(error.toString(), task.capability));
    }
  }
}

Future<TaskResult> _executeTask(Task task) async {
  final shouldPassParam = task.param != null;
  final dynamic computationResult =
      shouldPassParam ? await task.task(task.param) : await task.task();

  return TaskResult(
    result: computationResult,
    capability: task.capability,
  );
}
