import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';
import 'package:hommie/features/auth/domain/entities/server_url.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/domain/models/server.dart';

class CreateServerAction extends HAction<Server, void> {
  final IServerManager _serverManager;

  CreateServerAction(this._serverManager);

  @override
  Future<HActionResult<Server, void>> execute(
    ActionExecutionContext context,
  ) async {
    final serverUrl = context.get<ServerUrl>('serverUrl');

    final newServer = Server.temporary(
      baseUrl: serverUrl.value.getOrElse((_) => ''),
    );

    final server = await _serverManager.addServer(newServer);
    context.set<Server>('server', server);

    return HActionResult.success(server);
  }

  @override
  String get name => 'CreateServerTask';

  @override
  Future<void> rollback(ActionExecutionContext context) async {
    final server = context.get<Server>('server');
    await _serverManager.removeServer(server.id!, allowRemovingLast: true);
  }

  @override
  bool get supportsRollback => true;
}
