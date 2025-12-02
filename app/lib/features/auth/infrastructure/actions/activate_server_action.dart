import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';

class ActivateServerAction extends HAction {
  final IServerManager _serverManager;

  ActivateServerAction(this._serverManager);

  @override
  Future<HActionResult> execute(ActionExecutionContext context) async {
    try {
      final Server server = context.get('server');
      await _serverManager.activateServer(server.id!);
      return HActionResult.success(null);
    } catch (e) {
      return HActionResult.failure(e);
    }
  }

  @override
  String get name => 'ActivateServerTask';

  @override
  Future<void> rollback(ActionExecutionContext context) async {
    throw UnimplementedError();
  }

  @override
  bool get supportsRollback => false;
}
