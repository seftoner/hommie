import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'servers_list_provider.g.dart';

@Riverpod(dependencies: [serverManager])
class ServersList extends _$ServersList {
  @override
  Future<List<Server>> build() async {
    final serverManager = ref.watch(serverManagerProvider);
    return serverManager.getServers();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final serverManager = ref.read(serverManagerProvider);
    try {
      final servers = await serverManager.getServers();
      state = AsyncData(servers);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> addServer(Server server) async {
    final serverManager = ref.read(serverManagerProvider);
    await serverManager.addServer(server);
    await refresh();
  }

  Future<void> removeServer(int serverId) async {
    final serverManager = ref.read(serverManagerProvider);
    await serverManager.removeServer(serverId);
    await refresh();
  }
}
