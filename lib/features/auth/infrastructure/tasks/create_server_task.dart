import 'package:hommie/features/server_manager/domain/i_server_manager.dart';
import 'package:hommie/features/server_manager/domain/models/ha_server_config.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

class CreateServerTask extends HTask<HaServerConfig, void> {
  final IServerManager _serverManager;

  CreateServerTask(this._serverManager);

  @override
  Future<HTaskResult<HaServerConfig, void>> execute(
      TaskExecutionContext context) async {
    final serverUrl = context.get('serverUrl');

    final newServer = HaServerConfig(
      id: -1,
      name: HaServerConfig.defaultName,
      baseUrl: serverUrl,
    );

    final server = await _serverManager.addServer(newServer);
    context.set<HaServerConfig>('server', server);

    return HTaskResult.success(server);
  }

  @override
  String get name => 'CreateServerTask';

  @override
  Future<void> rollback(TaskExecutionContext context) async {
    final server = context.get<HaServerConfig>('server');
    if (server != null) {
      await _serverManager.removeServer(server.id);
    }
  }

  @override
  bool get supportsRollback => true;
}
