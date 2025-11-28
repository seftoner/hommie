import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/home/domain/repositories/i_ha_server_repository.dart';

class DriftServerEntityRepository implements IServerEntityRepository {
  final AppDatabase _database;

  DriftServerEntityRepository(this._database);

  @override
  Future<List<ServerEntity>> getAll() async {
    return _database.select(_database.serverEntities).get();
  }

  @override
  Future<ServerEntity?> getById(int id) async {
    return (_database.select(
      _database.serverEntities,
    )..where((s) => s.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<ServerEntity?> getByUri(String uri) async {
    return (_database.select(
      _database.serverEntities,
    )..where((s) => s.url.equals(uri))).getSingleOrNull();
  }

  @override
  Future<void> save(ServerEntity server) async {
    await _database.transaction(() async {
      await _database
          .into(_database.serverEntities)
          .insert(
            ServerEntitiesCompanion(
              id: Value(server.id),
              name: Value(server.name),
              url: Value(server.url),
              isActive: Value(server.isActive),
              version: Value(server.version),
            ),
            mode: InsertMode.insertOrReplace,
          );
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
}
