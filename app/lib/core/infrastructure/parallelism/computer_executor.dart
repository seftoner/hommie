import 'package:computer/computer.dart';
import 'package:hommie/core/infrastructure/parallelism/i_parallel_executor.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';

class ComputerExecutor implements IParallelExecutor {
  final Computer _computer;

  ComputerExecutor(this._computer);

  @override
  Future<R> execute<P, R>(Function task, {P? param}) async {
    try {
      return await _computer.compute<P, R>(task, param: param);
    } catch (e, _) {
      // Add logging or error handling here if needed
      logger.e('Error during task execution: $e');
      rethrow;
    }
  }

  @override
  Future<Stream<R>> executeStream<P, R>(
    Stream<R> Function(P param) task, {
    P? param,
  }) async {
    try {
      return await _computer.computeStream<P, R>(task, param: param);
    } catch (e, _) {
      logger.e('Error during stream task execution: $e');
      rethrow;
    }
  }

  @override
  Future<Stream<R>> executeStreamNoArgs<R>(Stream<R> Function() task) async {
    try {
      return await _computer.computeStream<void, R>((_) => task());
    } catch (e, _) {
      logger.e('Error during no-args stream task execution: $e');
      rethrow;
    }
  }
}
