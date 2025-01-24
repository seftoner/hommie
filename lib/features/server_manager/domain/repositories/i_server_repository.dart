import 'package:hommie/features/server_manager/domain/models/server_config.dart';

abstract interface class IServerRepository {
  Future<List<ServerConfig>> getAll();
  Future<ServerConfig?> getById(int id);
  Future<ServerConfig> save(ServerConfig config);
  Future<void> delete(int id);
  Future<ServerConfig?> getActiveServer();
  Stream<ServerConfig?> watchActiveServer();
  Future<void> setActiveServer(int id);
}
