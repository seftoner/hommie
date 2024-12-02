import 'package:computer/computer.dart';
import 'package:hommie/core/infrastructure/parallelism/i_parallel_executor.dart';

class ComputerExecutor implements IParallelExecutor {
  final Computer _computer;

  ComputerExecutor(this._computer);

//TODO: Add error handliung
/* @override
  Future<R> execute<P, R>(Function task, {P? param}) async {
    try {
      return await _computer.compute<P, R>(task, param: param);
    } catch (e, stack) {
      // Add logging or error handling here if needed
      rethrow;
    }
  } */

  @override
  Future<R> execute<P, R>(Function task, {P? param}) {
    return _computer.compute<P, R>(task, param: param);
  }

  @override
  Future<Stream<R>> executeStream<P, R>(Stream<R> Function(P param) task,
      {P? param}) {
    return _computer.computeStream<P, R>(task, param: param);
  }

  @override
  Future<Stream<R>> executeStreamNoArgs<R>(Stream<R> Function() task) {
    return _computer.computeStream<void, R>((void _) {
      return task();
    });
  }
}
