import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/server_manager/domain/i_server_manager.dart';
import 'package:hommie/features/server_manager/domain/models/ha_server_config.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_server_repository.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_websocket_repository.dart';

class ServerManager implements IServerManager {
  final IServerRepository _serverRepository;

  const ServerManager(this._serverRepository);

  @override
  Future<HaServerConfig> addServer(HaServerConfig config) {
    return _serverRepository.save(config);
  }

  @override
  Future<HaServerConfig?> getActiveServer() {
    return _serverRepository.getActiveServer();
  }

  @override
  Future<List<HaServerConfig>> getAvailableServers() {
    return _serverRepository.getAll();
  }

  @override
  Future<void> removeServer(int id) {
    return _serverRepository.delete(id);
  }

  @override
  Future<void> setActiveServer(int id) {
    return _serverRepository.setActiveServer(id);
  }

  @override
  Future<IWebSocketRepository> webSocketRepository(int serverId) {
    // TODO: implement webSocketRepository
    throw UnimplementedError();
  }

  @override
  Future<IAuthRepository> getAuthRepository(int serverId) {
    // TODO: implement getAuthRepository
    throw UnimplementedError();
  }
}
