abstract class IParallelExecutor {
  Future<R> execute<P, R>(Function task, {P? param});
  Future<Stream<R>> executeStream<P, R>(Stream<R> Function(P param) task,
      {P? param});

  Future<Stream<R>> executeStreamNoArgs<R>(Stream<R> Function() task);
}
