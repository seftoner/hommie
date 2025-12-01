import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/domain/repositories/i_server_repository.dart';
import 'package:hommie/features/servers/infrastructure/repositories/mappers/server_mapper.dart';

class DriftServerRepository implements IServerRepository {
  final AppDatabase _database;

  DriftServerRepository(this._database);

  @override
  Future<List<Server>> getAll() async {
    final servers = await _database.select(_database.serverEntities).get();
    return servers.map((s) => s.toDomain()).toList();
  }

  @override
  Future<Server?> getById(int id) async {
    final server = await (_database.select(
      _database.serverEntities,
    )..where((s) => s.id.equals(id))).getSingleOrNull();
    return server?.toDomain();
  }

  @override
  Future<Server> save(Server server) async {
    return _database.transaction(() async {
      final companion = server.toCompanion();
      final id = await _database
          .into(_database.serverEntities)
          .insert(companion, mode: InsertMode.insertOrReplace);
      return server.copyWith(id: id);
    });
  }

  @override
  Future<void> delete(int id) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.serverEntities,
      )..where((s) => s.id.equals(id))).go();
    });
  }

  @override
  Future<Server?> getActiveServer() async {
    final server = await (_database.select(
      _database.serverEntities,
    )..where((s) => s.isActive.equals(true))).getSingleOrNull();
    return server?.toDomain();
  }

  @override
  Future<Server?> setActiveServer(int? id) async {
    return _database.transaction(() async {
      // First deactivate all servers
      final activeServers = await (_database.select(
        _database.serverEntities,
      )..where((s) => s.isActive.equals(true))).get();

      for (final server in activeServers) {
        await _database
            .update(_database.serverEntities)
            .replace(server.copyWith(isActive: false));
      }

      // Then activate the selected server (if id is not null)
      if (id != null) {
        final serverToActivate = await (_database.select(
          _database.serverEntities,
        )..where((s) => s.id.equals(id))).getSingleOrNull();
        if (serverToActivate != null) {
          final updated = serverToActivate.copyWith(isActive: true);
          await _database.update(_database.serverEntities).replace(updated);
          return updated.toDomain();
        }
      }
      return null;
    });
  }
}
