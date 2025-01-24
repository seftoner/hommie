import 'package:hommie/features/server_manager/domain/models/server_config.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_server_repository.dart';
import 'package:hommie/features/server_manager/infrastructure/repositories/mappers/server_mapper.dart';
import 'package:hommie/services/database/models/ha_server.dart';
import 'package:isar/isar.dart';

class IsarServerRepository implements IServerRepository {
  final Isar _isar;

  IsarServerRepository(this._isar);

  @override
  Future<List<ServerConfig>> getAll() async {
    final servers = await _isar.haServers.where().findAll();
    return servers.map((s) => s.toDomain()).toList();
  }

  @override
  Future<ServerConfig?> getById(int id) async {
    final server = await _isar.haServers.filter().idEqualTo(id).findFirst();
    return server?.toDomain();
  }

  @override
  Future<ServerConfig> save(ServerConfig config) async {
    return _isar.writeTxn(() async {
      final server = config.toDb();
      await _isar.haServers.put(server);
      return config;
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.haServers.filter().idEqualTo(id).deleteAll();
    });
  }

  @override
  Future<ServerConfig?> getActiveServer() async {
    final server =
        await _isar.haServers.filter().isActiveEqualTo(true).findFirst();
    return server?.toDomain();
  }

  @override
  Stream<ServerConfig?> watchActiveServer() {
    final query = _isar.haServers.filter().isActiveEqualTo(true).build();
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
