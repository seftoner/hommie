import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

class TaskChain {
  final List<HTask> tasks;
  final TaskExecutionContext context;
  final Map<Type, void Function(Object error)> errorHandlers;
  final void Function(TaskExecutionContext context)? onSuccess;
  final void Function(Object error)? defaultErrorHandler;

  TaskChain({
    required this.tasks,
    required this.context,
    required this.errorHandlers,
    this.onSuccess,
    this.defaultErrorHandler,
  });

  static TaskChainBuilder builder() => TaskChainBuilder();
}

class TaskChainBuilder {
  final List<HTask> _tasks = [];
  final Map<String, dynamic> _context = {};
  final Map<Type, void Function(Object error)> _errorHandlers = {};
  void Function(TaskExecutionContext context)? _onSuccess;
  void Function(Object error)? _defaultErrorHandler;

  TaskChainBuilder addTask(HTask task) {
    _tasks.add(task);
    return this;
  }

  TaskChainBuilder withContext(String key, dynamic value) {
    _context[key] = value;
    return this;
  }

  TaskChainBuilder onTaskError<T extends HTask<dynamic, TError>, TError>(
    void Function(TError error) handler,
  ) {
    _errorHandlers[T] = (error) => handler(error as TError);
    return this;
  }

  TaskChainBuilder onAnyError(void Function(Object error) handler) {
    _defaultErrorHandler = handler;
    return this;
  }

  TaskChainBuilder onSuccess(
    void Function(TaskExecutionContext context) handler,
  ) {
    _onSuccess = handler;
    return this;
  }

  TaskChain build() => TaskChain(
    tasks: _tasks,
    context: TaskExecutionContext(_context),
    errorHandlers: _errorHandlers,
    onSuccess: _onSuccess,
    defaultErrorHandler: _defaultErrorHandler,
  );
}
