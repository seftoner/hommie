import 'package:hommie/features/servers/domain/models/server.dart';

abstract interface class IServerManager {
  Future<Server?> getActiveServer();
  Future<void> setActiveServer(int id);
  Future<Server> addServer(Server config);
  Future<void> removeServer(int id);
  Future<void> forceRemoveServer(int id);
  Future<List<Server>> getAvailableServers();
}
