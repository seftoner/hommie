import 'package:hommie/features/server_manager/domain/models/server_config.dart';
import 'package:hommie/features/server_manager/infrastructure/providers/server_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_manager.g.dart';

@riverpod
class ServerManager extends _$ServerManager {
  @override
  Stream<ServerConfig?> build() async* {
    final repository = ref.watch(serverRepositoryProvider);
    yield* repository.watchActiveServer();
  }

  Future<void> setActiveServer(int id) async {
    final repository = ref.read(serverRepositoryProvider);
    await repository.setActiveServer(id);
  }

  Future<void> addServer(ServerConfig config) async {
    final repository = ref.read(serverRepositoryProvider);
    await repository.save(config);
  }

  Future<void> removeServer(int id) async {
    final repository = ref.read(serverRepositoryProvider);
    await repository.delete(id);
  }

  // Get all available servers for selection
  Future<List<ServerConfig>> getAvailableServers() async {
    final repository = ref.read(serverRepositoryProvider);
    return repository.getAll();
  }

/*   IWebSocketRepository getWebSocketRepository(String serverId) {
    return ref.read(webSocketRepositoryProvider(serverId));
  } */
}
