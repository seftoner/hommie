import 'package:hommie/features/auth/domain/entities/ha_version.dart';
import 'package:hommie/features/server_manager/domain/i_server_manager.dart';
import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';

class GetConfigTask extends HTask {
  final IServerManager _serverManager;

  GetConfigTask(this._serverManager);

  @override
  Future<HTaskResult> execute(TaskExecutionContext context) async {
    final server = context.get<Server>('server')!;

    final webSocketRepository =
        await _serverManager.webSocketRepository(server.id!);
    final serverConfig = await webSocketRepository.getConfig();

    _serverManager.addServer(
      server.copyWith(
        name: serverConfig.location_name,
        version: HaVersion.fromString(serverConfig.version),
        internalUrl: serverConfig.internal_url,
        externalUrl: serverConfig.external_url,
      ),
    );

    return const HTaskResult(status: Status.success);
  }

  @override
  String get name => 'GetConfigTask';
}
