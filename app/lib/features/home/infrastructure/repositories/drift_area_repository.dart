import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/area_mapper.dart';

class DriftAreaRepository implements IAreaRepository {
  final AppDatabase _database;

  DriftAreaRepository(this._database);

  @override
  Future<List<Area>> getAll() async {
    final areas = await _database.select(_database.areaEntities).get();
    return areas.map((a) => a.toDomain()).toList();
  }

  @override
  Future<Area?> getById(int id) async {
    final area = await (_database.select(
      _database.areaEntities,
    )..where((a) => a.id.equals(id))).getSingleOrNull();
    return area?.toDomain();
  }

  @override
  Future<Area?> getByHaId(String haId) async {
    final area = await (_database.select(
      _database.areaEntities,
    )..where((a) => a.haId.equals(haId))).getSingleOrNull();
    return area?.toDomain();
  }

  @override
  Future<void> save(Area area) async {
    // Need to get the serverId - for now, we'll get the first server or throw
    final server = await (_database.select(
      _database.serverEntities,
    )..where((s) => s.isActive.equals(true))).getSingleOrNull();

    if (server == null) {
      throw Exception('No active server found');
    }

    await _database.transaction(() async {
      await _database
          .into(_database.areaEntities)
          .insert(
            area.toCompanion(server.id),
            mode: InsertMode.insertOrReplace,
          );
    });
  }

  @override
  Future<void> delete(int id) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.areaEntities,
      )..where((a) => a.id.equals(id))).go();
    });
  }

  @override
  Future<List<Area>> getByServer(int serverId) async {
    final areas = await (_database.select(
      _database.areaEntities,
    )..where((a) => a.serverId.equals(serverId))).get();
    return areas.map((a) => a.toDomain()).toList();
  }
}
