import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/server_manager/domain/i_server_manager.dart';
import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_server_repository.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_websocket_repository.dart';
import 'package:hommie/features/server_manager/infrastructure/repositories/websocket_repository.dart';
import 'package:hommie/services/networking/server_connection_provider.dart';

class ServerManager implements IServerManager {
  final IServerRepository _serverRepository;
  final Ref _ref;

  ServerManager(this._serverRepository, this._ref);

  @override
  Future<Server> addServer(Server config) {
    return _serverRepository.save(config);
  }

  @override
  Future<Server?> getActiveServer() {
    return _serverRepository.getActiveServer();
  }

  @override
  Future<List<Server>> getAvailableServers() {
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
  Future<IWebSocketRepository> webSocketRepository(int serverId) async {
    final connection =
        await _ref.read(serverConnectionProvider(serverId).future);
    return WebSocketRepository(connection);
  }

  @override
  IAuthRepository getAuthRepository(int serverId) {
    return _ref.read(authRepositoryProvider(serverId));
  }
}
