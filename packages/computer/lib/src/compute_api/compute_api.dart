import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

import '../errors.dart';
import '../logger.dart';
import 'task.dart';
import 'worker.dart';

class ComputeAPI {
  final _workers = <Worker>[];
  final _taskQueue = Queue<Task>();
  final _activeTaskCompleters = <Capability, Completer>{};
  Logger? _logger;

  bool isRunning = false;
  bool _allowCreatingWorkers = false;

  Future<void> turnOn({
    int workersCount = 2,
    bool verbose = false,
  }) async {
    _logger = Logger(enabled: verbose);
    _logger?.log('Turning on ComputeAPI');

    _allowCreatingWorkers = true;
    for (var i = 0; i < workersCount; i++) {
      if (!_allowCreatingWorkers) return;
      await _startWorker(i);
    }

    isRunning = true;
  }

  Future<void> _startWorker(int index) async {
    _logger?.log('Starting worker $index...');
    final worker = Worker('worker #$index');
    await worker.init(onResult: _onTaskFinished, onError: _onTaskFailed);

    if (!_allowCreatingWorkers) {
      await worker.dispose();
      return;
    }

    _workers.add(worker);
    _logger?.log('Worker $index has started');
    _assignTaskToWorker(worker);
  }

  Future<R> compute<P, R>(Function fn, {P? param}) async {
    _logger?.log('Started computation');
    return _enqueueFutureTask<P, R>(fn, param: param);
  }

  Future<Stream<R>> computeStream<P, R>(Stream<R> Function(P param) fn,
      {P? param}) async {
    _logger?.log('Started stream computation');
    final streamController = StreamController<R>();
    _enqueueStreamTask<P, R>(fn,
        param: param, streamController: streamController);
    return streamController.stream;
  }

  Future<R> _enqueueFutureTask<P, R>(
    Function task, {
    P? param,
  }) {
    final taskCapability = Capability();
    final taskCompleter = Completer<R>();

    final newTask = _createTask(
      task: task,
      param: param,
      capability: taskCapability,
    );

    _activeTaskCompleters[taskCapability] = taskCompleter;

    _processTask(newTask);
    return taskCompleter.future;
  }

  void _enqueueStreamTask<P, R>(
    Stream<R> Function(P param) task, {
    P? param,
    required StreamController<R> streamController,
  }) {
    final taskCapability = Capability();

    final newTask = _createTask(
      task: task,
      param: param,
      capability: taskCapability,
      streamController: streamController,
    );

    _processTask(newTask);
  }

  Task _createTask<P, T>({
    required Function task,
    P? param,
    required Capability capability,
    StreamController<T>? streamController,
  }) {
    return Task(
      task: task,
      param: param,
      capability: capability,
      streamController: streamController,
    );
  }

  void _processTask(Task task) {
    final freeWorker = _findFreeWorker();

    if (freeWorker != null) {
      _logger?.log('Found free worker, executing task');
      _assignTask(freeWorker, task);
    } else {
      _logger?.log('No free workers, adding task to the queue');
      _taskQueue.add(task);
    }
  }

  Future<void> turnOff() async {
    _logger?.log('Turning off ComputeAPI');
    _allowCreatingWorkers = false;

    for (final worker in _workers) {
      await worker.dispose();
    }

    _cancelAllPendingTasks();
    _workers.clear();
    _taskQueue.clear();
    isRunning = false;
    _logger?.log('ComputeAPI turned off');
  }

  void _cancelAllPendingTasks() {
    _activeTaskCompleters.forEach((capability, completer) {
      if (!completer.isCompleted) {
        completer.completeError(CancelExecutionError(
          'Canceled due to ComputeAPI turn off',
          capability,
        ));
      }
    });
    _activeTaskCompleters.clear();
  }

  Worker? _findFreeWorker() {
    for (final worker in _workers) {
      if (worker.status == WorkerStatus.idle) return worker;
    }
    return null;
  }

  void _assignTaskToWorker(Worker worker) {
    if (_taskQueue.isNotEmpty) {
      _logger?.log('Assigning task from queue to worker ${worker.name}');
      final task = _taskQueue.removeFirst();
      _assignTask(worker, task);
    }
  }

  void _assignTask(Worker worker, Task task) {
    if (task.streamController != null) {
      worker.executeStream(
          task, (message) => _handleStreamMessage(worker, task, message));
    } else {
      worker.execute(task);
    }
  }

  void _handleStreamMessage(Worker worker, Task task, dynamic message) {
    //BUG: insteadof TaskResult recieve null
    if (message is TaskResult) {
      task.streamController!.close();
      _onTaskFinished(message, worker);
    } else if (message is RemoteExecutionError) {
      task.streamController!.addError(message);
      worker.status = WorkerStatus.idle;
    } else {
      task.streamController!.add(message);
    }

    _assignTaskToWorker(worker);
  }

  void _onTaskFinished(TaskResult result, Worker worker) {
    final taskCompleter = _activeTaskCompleters.remove(result.capability);
    taskCompleter?.complete(result.result);

    _logger?.log("Worker #${worker.name} successfully completed the task");
    worker.status = WorkerStatus.idle;
    _assignTaskToWorker(worker);
  }

  void _onTaskFailed(RemoteExecutionError error, Worker worker) {
    final taskCompleter = _activeTaskCompleters.remove(error.taskCapability);
    taskCompleter?.completeError(error);

    _logger?.log(
        "Worker #${worker.name} failed to complete the task: ${error.message}");
    worker.status = WorkerStatus.idle;
    _assignTaskToWorker(worker);
  }
}
