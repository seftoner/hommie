abstract class BaseTask<P, R> {
  /// Parameters required for the task.
  final P params;

  /// Constructor to initialize the task with its parameters.
  BaseTask(this.params);

  /// Method to execute the task logic. Must be overridden in subclasses.
  ///
  /// Returns:
  /// - A `Future<R>` representing the result of the task.
  Future<R> run();
}
