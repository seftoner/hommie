import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

class CreateServerTask extends HTask<Server, void> {
  final IServerManager _serverManager;

  CreateServerTask(this._serverManager);

  @override
  Future<HTaskResult<Server, void>> execute(
    TaskExecutionContext context,
  ) async {
    final serverUrl = context.get('serverUrl');

    final newServer = Server.temporary(baseUrl: serverUrl);

    final server = await _serverManager.addServer(newServer);
    context.set<Server>('server', server);

    return HTaskResult.success(server);
  }

  @override
  String get name => 'CreateServerTask';

  @override
  Future<void> rollback(TaskExecutionContext context) async {
    final server = context.get<Server>('server');
    await _serverManager.removeServer(server.id!, allowRemovingLast: true);
  }

  @override
  bool get supportsRollback => true;
}
