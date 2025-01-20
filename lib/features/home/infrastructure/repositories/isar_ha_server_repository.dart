import 'package:hommie/features/home/domain/repositories/i_ha_server_repository.dart';
import 'package:hommie/services/database/models/ha_server.dart';
import 'package:isar/isar.dart';

class IsarHaServerRepository implements IHaServerRepository {
  final Isar _isar;

  IsarHaServerRepository(this._isar);

  @override
  Future<List<HaServer>> getAll() => _isar.haServers.where().findAll();

  @override
  Future<HaServer?> getById(int id) => _isar.haServers.get(id);

  @override
  Future<HaServer?> getByUri(String uri) =>
      _isar.haServers.filter().uriEqualTo(uri).findFirst();

  @override
  Future<void> save(HaServer server) =>
      _isar.writeTxn(() => _isar.haServers.put(server));

  @override
  Future<void> delete(int id) =>
      _isar.writeTxn(() => _isar.haServers.delete(id));
}
