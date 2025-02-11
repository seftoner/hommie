import 'package:hommie/features/server_manager/domain/models/ha_server_config.dart';

abstract interface class IServerRepository {
  Future<List<HaServerConfig>> getAll();
  Future<HaServerConfig?> getById(int id);
  Future<HaServerConfig> save(HaServerConfig config);
  Future<void> delete(int id);
  Future<HaServerConfig?> getActiveServer();
  Stream<HaServerConfig?> watchActiveServer();
  Future<void> setActiveServer(int id);
}
