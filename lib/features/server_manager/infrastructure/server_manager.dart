import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/repositories/secure_credentials_storage.dart';
import 'package:hommie/features/server_manager/domain/i_server_manager.dart';
import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_server_repository.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_websocket_repository.dart';

class ServerManager implements IServerManager {
  final IServerRepository _serverRepository;
  final Map<int, IAuthRepository> _authRepositoryCache = {};

  ServerManager(this._serverRepository);

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
  Future<IWebSocketRepository> webSocketRepository(int serverId) {
    // TODO: implement webSocketRepository
    throw UnimplementedError();
  }

  @override
  Future<IAuthRepository> getAuthRepository(int serverId) async {
    if (_authRepositoryCache.containsKey(serverId)) {
      return _authRepositoryCache[serverId]!;
    }

    final server = await _serverRepository.getById(serverId);
    if (server == null) {
      throw StateError('Server with id $serverId not found');
    }

    final authRepository = AuthRepository(
      SecureCredentialRepository(
        const FlutterSecureStorage(),
        serverId,
      ),
      http.Client(),
    );

    _authRepositoryCache[serverId] = authRepository;
    return authRepository;
  }
}
