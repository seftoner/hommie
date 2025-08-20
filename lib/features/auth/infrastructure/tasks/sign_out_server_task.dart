import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/servers/infrastructure/server_manager.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

class SignOutServerTask extends HTask {
  final ServerManager _serverManager;

  SignOutServerTask(this._serverManager);

  @override
  Future<HTaskResult> execute(TaskExecutionContext context) async {
    final serverId = context.get<int>('serverId')!;

    // Step 1: Clear credentials from repository
    final repository = _serverManager.getAuthRepository(serverId);
    await repository.signOut();
    logger.i('Successfully signed out from server: $serverId');

    return const HTaskResult(status: Status.success);
  }

  @override
  bool get supportsRollback => false;

  @override
  String get name => 'Clear Server Credentials Task';
}
