import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

class ActivateServerTask extends HTask {
  final IServerManager _serverManager;

  ActivateServerTask(this._serverManager);

  @override
  Future<HTaskResult> execute(TaskExecutionContext context) async {
    try {
      final Server server = context.get('server');
      await _serverManager.activateServer(server.id!);
      return HTaskResult.success(null);
    } catch (e) {
      return HTaskResult.failure(e);
    }
  }

  @override
  String get name => 'ActivateServerTask';

  @override
  Future<void> rollback(TaskExecutionContext context) async {
    throw UnimplementedError();
  }

  @override
  bool get supportsRollback => false;
}
