import 'package:computer/computer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/infrastructure/parallelism/computer_executor.dart';
import 'package:hommie/core/infrastructure/parallelism/i_parallel_executor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
IParallelExecutor parallelismExecutor(Ref ref) {
  final computer = Computer.shared();
  ref.onDispose(() => computer.turnOff());
  return ComputerExecutor(computer);
}
