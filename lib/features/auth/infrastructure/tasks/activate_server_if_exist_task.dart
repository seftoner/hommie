import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

class ActivateServerIfExistTask extends HTask {
  final IServerManager _serverManager;

  ActivateServerIfExistTask(this._serverManager);

  @override
  Future<HTaskResult> execute(TaskExecutionContext context) async {
    final serverId = context.get<int>('serverId');

    final nextServer = await _serverManager.activateNextServer(
      excludingId: serverId,
    );

    if (nextServer != null) {
      logger.i('Activated next server: ${nextServer.id}');
    } else {
      logger.i('No other servers available after sign out');
    }

    return const HTaskResult(status: Status.success);
  }

  @override
  bool get supportsRollback => false;

  @override
  String get name => 'Activate Server If Exists Task';
}
