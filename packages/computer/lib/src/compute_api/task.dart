import 'dart:async';
import 'dart:isolate';

class Task {
  final Function task;
  final dynamic param;
  StreamController? streamController;

  final Capability capability;

  Task(
      {required this.task,
      required this.capability,
      this.param,
      this.streamController});
}

class TaskResult {
  final dynamic result;
  final Capability capability;

  TaskResult({
    required this.result,
    required this.capability,
  });
}
