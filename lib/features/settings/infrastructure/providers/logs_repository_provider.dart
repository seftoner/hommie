import 'package:hommie/core/infrastructure/parallelism/providers/provider.dart';
import 'package:hommie/core/utils/log_file.dart';
import 'package:hommie/features/settings/domain/repository/i_logs_repository.dart';
import 'package:hommie/features/settings/infrastructure/repositories/logs_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logs_repository_provider.g.dart';

@riverpod
Future<ILogsRepository> logsRepository(Ref ref) async {
  final file = await getLogsPath();
  final computer = ref.watch(parallelismExecutorProvider);
  return LogsRepository(file.path, computer);
}
