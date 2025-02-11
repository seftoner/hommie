import 'package:hommie/features/server_manager/domain/i_server_manager.dart';
import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

class ActivateServerTask extends HTask<void, Object> {
  final IServerManager _serverManager;

  ActivateServerTask(this._serverManager);

  @override
  Future<HTaskResult<void, Object>> execute(
      TaskExecutionContext context) async {
    try {
      final Server server = context.get('server')!;
      await _serverManager.setActiveServer(server.id!);

      return HTaskResult.success(null);
    } catch (e) {
      //TODO: Return some meanigfull error here instead of object
      return HTaskResult.failure(e);
    }
  }

  @override
  String get name => 'SetActiveServer';

  @override
  Future<void> rollback(TaskExecutionContext context) async {
    throw UnimplementedError();
  }

  @override
  bool get supportsRollback => false;
}
