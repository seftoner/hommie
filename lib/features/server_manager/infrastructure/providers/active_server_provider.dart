import 'package:hommie/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/features/server_manager/infrastructure/providers/server_manager_provider.dart';

part 'active_server_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
class ActiveServer extends _$ActiveServer {
  @override
  Future<Server?> build() async {
    final serverManager = ref.read(serverManagerProvider);
    return serverManager.getActiveServer();
  }

  Future<void> setActive(int serverId) async {
    final serverManager = ref.read(serverManagerProvider);
    await serverManager.setActiveServer(serverId);

    logger.i('Setting active server with ID: $serverId');
    final activeServer = await serverManager.getActiveServer();
    state = AsyncData(activeServer);
  }
}
