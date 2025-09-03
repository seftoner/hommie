import 'package:hommie/features/auth/domain/entities/ha_version.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([websocketConfigRepository])
class GetConfigTask extends HTask {
  final IServerManager _serverManager;
  final Ref _ref;

  GetConfigTask(this._serverManager, this._ref);

  @override
  Future<HTaskResult> execute(TaskExecutionContext context) async {
    final server = context.get<Server>('server');

    if (server == null) {
      throw Exception('Server is not provided');
    }

    try {
      logger.i('Getting configuration for server ${server.id}');

      // Use the WebSocket config repository instead of direct HACommands
      final configRepository = await _ref.read(
        websocketConfigRepositoryProvider(server.id!).future,
      );
      final serverConfig = await configRepository.getConfig();

      // Update server with configuration details
      final updatedServer = await _serverManager.addServer(
        server.copyWith(
          name: serverConfig.location_name,
          version: HaVersion.fromString(serverConfig.version),
          internalUrl: serverConfig.internal_url,
          externalUrl: serverConfig.external_url,
        ),
      );

      context.set<Server>('server', updatedServer);

      logger.i('Retrieved configuration for server: ${updatedServer.name}');

      return const HTaskResult(status: Status.success);
    } catch (e) {
      logger.e('Failed to get server configuration: $e');
      return HTaskResult.failure(e);
    }
  }

  @override
  String get name => 'GetConfigTask';
}
