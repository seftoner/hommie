import 'package:hommie/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';

part 'active_server_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [serverManager])
class ActiveServer extends _$ActiveServer {
  @override
  Future<Server?> build() async {
    final serverManager = ref.read(serverManagerProvider);
    return serverManager.getActiveServer();
  }

  Future<void> setActive(int serverId) async {
    final serverManager = ref.read(serverManagerProvider);
    final previousServer = state.value;

    logger.i(
      'Switching active server from ${previousServer?.name} to server ID: $serverId',
    );

    // Update the active server in the database
    await serverManager.setActiveServer(serverId);

    // Get the new active server
    final activeServer = await serverManager.getActiveServer();
    state = AsyncData(activeServer);

    logger.i('Active server switched to: ${activeServer?.name}');
  }
}
