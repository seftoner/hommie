import 'package:hommie/core/infrastructure/parallelism/i_parallel_executor.dart';

abstract class BaseRepository {
  final IParallelExecutor executor;

  BaseRepository(this.executor);
}
