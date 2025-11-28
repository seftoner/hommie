import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';

class ActivateServerIfExistAction extends HAction {
  final IServerManager _serverManager;

  ActivateServerIfExistAction(this._serverManager);

  @override
  Future<HActionResult> execute(ActionExecutionContext context) async {
    final serverId = context.get<int>('serverId');

    final nextServer = await _serverManager.activateNextServer(
      excludingId: serverId,
    );

    if (nextServer != null) {
      logger.i('Activated next server: ${nextServer.id}');
    } else {
      logger.i('No other servers available after sign out');
    }

    return const HActionResult(status: Status.success);
  }

  @override
  bool get supportsRollback => false;

  @override
  String get name => 'Activate Server If Exists Task';
}
