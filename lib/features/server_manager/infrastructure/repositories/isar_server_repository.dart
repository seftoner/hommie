import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_server_repository.dart';
import 'package:hommie/features/server_manager/infrastructure/repositories/mappers/server_mapper.dart';
import 'package:hommie/services/database/models/server_entity.dart';
import 'package:isar/isar.dart';

class IsarServerRepository implements IServerRepository {
  final Isar _isar;

  IsarServerRepository(this._isar);

  @override
  Future<List<Server>> getAll() async {
    final servers = await _isar.serverEntitys.where().findAll();
    return servers.map((s) => s.toDomain()).toList();
  }

  @override
  Future<Server?> getById(int id) async {
    final server = await _isar.serverEntitys.filter().idEqualTo(id).findFirst();
    return server?.toDomain();
  }

  @override
  Future<Server> save(Server server) async {
    return _isar.writeTxn(() async {
      final serverEntity = server.toDb();
      //..id = server.id ?? Isar.autoIncrement;
      final id = await _isar.serverEntitys.put(serverEntity);
      return server.copyWith(id: id);
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.serverEntitys.filter().idEqualTo(id).deleteAll();
    });
  }

  @override
  Future<Server?> getActiveServer() async {
    final server =
        await _isar.serverEntitys.filter().isActiveEqualTo(true).findFirst();
    return server?.toDomain();
  }

  @override
  Stream<Server?> watchActiveServer() {
    final query = _isar.serverEntitys.filter().isActiveEqualTo(true).build();
    return query
        .watch(fireImmediately: true)
        .map((servers) => servers.isNotEmpty ? servers.first.toDomain() : null);
  }

  @override
  Future<void> setActiveServer(int id) async {
    await _isar.writeTxn(() async {
      // Deactivate current active
      final current = await getActiveServer();
      if (current != null) {
        await save(current.copyWith(isActive: false));
      }

      // Activate new
      final newActive = await getById(id);
      if (newActive != null) {
        await save(newActive.copyWith(isActive: true));
      }
    });
  }
}
