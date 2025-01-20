import 'package:hommie/services/database/models/ha_server.dart';

abstract interface class IHaServerRepository {
  Future<List<HaServer>> getAll();
  Future<HaServer?> getById(int id);
  Future<HaServer?> getByUri(String uri);
  Future<void> save(HaServer server);
  Future<void> delete(int id);
}
