import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/server_manager/domain/models/ha_server_config.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_websocket_repository.dart';

abstract interface class IServerManager {
  Future<HaServerConfig?> getActiveServer();
  Future<void> setActiveServer(int id);
  Future<HaServerConfig> addServer(HaServerConfig config);
  Future<void> removeServer(int id);
  Future<List<HaServerConfig>> getAvailableServers();
  Future<IWebSocketRepository> webSocketRepository(int serverId);
  Future<IAuthRepository> getAuthRepository(int serverId);
}
