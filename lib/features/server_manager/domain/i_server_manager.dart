import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_websocket_repository.dart';

abstract interface class IServerManager {
  Future<Server?> getActiveServer();
  Future<void> setActiveServer(int id);
  Future<Server> addServer(Server config);
  Future<void> removeServer(int id);
  Future<List<Server>> getAvailableServers();
  IWebSocketRepository webSocketRepository(int serverId);
  IAuthRepository getAuthRepository(int serverId);
}
