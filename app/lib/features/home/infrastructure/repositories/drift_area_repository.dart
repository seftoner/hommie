import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/area_mapper.dart';

class DriftAreaRepository implements IAreaRepository {
  final AppDatabase _database;

  DriftAreaRepository(this._database);

  @override
  Stream<List<Area>> watchByServer(int serverId) {
    return (_database.select(_database.areaEntities)
          ..where((a) => a.serverId.equals(serverId)))
        .watch()
        .map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  @override
  Future<List<Area>> getByServer(int serverId) async {
    final rows = await (_database.select(
      _database.areaEntities,
    )..where((a) => a.serverId.equals(serverId))).get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<Area?> getByHaId({required int serverId, required String haId}) async {
    final row =
        await (_database.select(_database.areaEntities)
              ..where((a) => a.serverId.equals(serverId) & a.haId.equals(haId)))
            .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<void> upsert({required int serverId, required Area area}) async {
    await _database
        .into(_database.areaEntities)
        .insert(
          area.toCompanion(serverId),
          onConflict: DoUpdate(
            (old) => area.toCompanion(serverId),
            target: [
              _database.areaEntities.serverId,
              _database.areaEntities.haId,
            ],
          ),
        );
  }

  @override
  Future<void> syncAll({
    required int serverId,
    required List<Area> areas,
  }) async {
    await _database.transaction(() async {
      final existing = await (_database.select(
        _database.areaEntities,
      )..where((a) => a.serverId.equals(serverId))).get();

      final nextIds = areas.map((a) => a.id).toSet();

      // Delete removed areas (cascades to home/device configs).
      for (final row in existing) {
        if (!nextIds.contains(row.haId)) {
          await (_database.delete(
            _database.areaEntities,
          )..where((a) => a.id.equals(row.id))).go();
        }
      }

      // Upsert current registry entries.
      for (final area in areas) {
        await _database
            .into(_database.areaEntities)
            .insert(
              area.toCompanion(serverId),
              onConflict: DoUpdate(
                (old) => area.toCompanion(serverId),
                target: [
                  _database.areaEntities.serverId,
                  _database.areaEntities.haId,
                ],
              ),
            );
      }
    });
  }
}
