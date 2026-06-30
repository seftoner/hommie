import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/domain/repositories/i_entity_repository.dart';
import 'package:hommie/features/entities/infrastructure/repositories/mappers/entity_mapper.dart';

class DriftEntityRepository implements IEntityRepository {
  final AppDatabase _database;

  DriftEntityRepository(this._database);

  @override
  Stream<List<HaEntity>> watchByServer(int serverId) {
    return (_database.select(_database.entities)
          ..where((e) => e.serverId.equals(serverId)))
        .watch()
        .map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  @override
  Future<List<HaEntity>> getByServer(int serverId) async {
    final rows = await (_database.select(
      _database.entities,
    )..where((e) => e.serverId.equals(serverId))).get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<void> syncAll({
    required int serverId,
    required List<HaEntity> entities,
  }) async {
    await _database.transaction(() async {
      final existing = await (_database.select(
        _database.entities,
      )..where((e) => e.serverId.equals(serverId))).get();

      final nextIds = entities.map((e) => e.registryId).toSet();

      for (final row in existing) {
        if (!nextIds.contains(row.registryId)) {
          await (_database.delete(
            _database.entities,
          )..where((e) => e.id.equals(row.id))).go();
        }
      }

      for (final entity in entities) {
        await _database
            .into(_database.entities)
            .insert(
              entity.toCompanion(serverId),
              onConflict: DoUpdate(
                (old) => entity.toCompanion(serverId),
                target: [
                  _database.entities.serverId,
                  _database.entities.registryId,
                ],
              ),
            );
      }
    });
  }
}
