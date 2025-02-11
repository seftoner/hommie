import 'package:hommie/services/database/models/server_entity.dart';

abstract interface class IServerEntityRepository {
  Future<List<ServerEntity>> getAll();
  Future<ServerEntity?> getById(int id);
  Future<ServerEntity?> getByUri(String uri);
  Future<void> save(ServerEntity server);
  Future<void> delete(int id);
}
