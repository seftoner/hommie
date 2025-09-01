import 'package:hommie/features/home/domain/repositories/i_ha_server_repository.dart';
import 'package:hommie/services/database/models/server_entity.dart';
import 'package:isar_community/isar.dart';

class IsarServerEntityRepository implements IServerEntityRepository {
  final Isar _isar;

  IsarServerEntityRepository(this._isar);

  @override
  Future<List<ServerEntity>> getAll() => _isar.serverEntitys.where().findAll();

  @override
  Future<ServerEntity?> getById(int id) => _isar.serverEntitys.get(id);

  @override
  Future<ServerEntity?> getByUri(String uri) =>
      _isar.serverEntitys.filter().urlEqualTo(uri).findFirst();

  @override
  Future<void> save(ServerEntity server) =>
      _isar.writeTxn(() => _isar.serverEntitys.put(server));

  @override
  Future<void> delete(int id) =>
      _isar.writeTxn(() => _isar.serverEntitys.delete(id));
}
