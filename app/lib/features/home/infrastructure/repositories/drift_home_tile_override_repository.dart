import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
import 'package:hommie/features/home/domain/repositories/i_home_tile_override_repository.dart';

class DriftHomeTileOverrideRepository implements IHomeTileOverrideRepository {
  final AppDatabase _database;

  DriftHomeTileOverrideRepository(this._database);

  @override
  Stream<List<HomeTileOverride>> watchByServer(int serverId) {
    return (_database.select(_database.homeTileOverrides)
          ..where((row) => row.serverId.equals(serverId)))
        .watch()
        .map((rows) => rows.map(_rowToDomain).toList());
  }

  @override
  Future<List<HomeTileOverride>> getByServer(int serverId) async {
    final rows = await (_database.select(
      _database.homeTileOverrides,
    )..where((row) => row.serverId.equals(serverId))).get();
    return rows.map(_rowToDomain).toList();
  }

  @override
  Future<void> upsert({
    required int serverId,
    required HomeTileOverride override,
  }) async {
    final companion = _overrideToCompanion(serverId, override);
    await _database
        .into(_database.homeTileOverrides)
        .insert(
          companion,
          onConflict: DoUpdate(
            (old) => companion,
            target: [
              _database.homeTileOverrides.serverId,
              _database.homeTileOverrides.kind,
              _database.homeTileOverrides.targetId,
            ],
          ),
        );
  }

  @override
  Future<void> remove({
    required int serverId,
    required HomeTileKind kind,
    required String targetId,
  }) async {
    await (_database.delete(_database.homeTileOverrides)..where(
          (row) =>
              row.serverId.equals(serverId) &
              row.kind.equals(_kindToDb(kind)) &
              row.targetId.equals(targetId),
        ))
        .go();
  }
}

HomeTileOverride _rowToDomain(HomeTileOverrideRow row) {
  return HomeTileOverride(
    kind: _kindFromDb(row.kind),
    targetId: row.targetId,
    areaId: row.areaHaId,
    size: _sizeFromDb(row.size),
    order: row.order,
    hidden: row.hidden,
    primaryEntityRegistryId: row.primaryEntityRegistryId,
    lastKnownName: row.lastKnownName,
    lastKnownAreaId: row.lastKnownAreaHaId,
    lastKnownDomain: row.lastKnownDomain,
  );
}

HomeTileOverridesCompanion _overrideToCompanion(
  int serverId,
  HomeTileOverride override,
) {
  return HomeTileOverridesCompanion(
    kind: Value(_kindToDb(override.kind)),
    targetId: Value(override.targetId),
    areaHaId: Value(override.areaId),
    size: Value(_sizeToDb(override.size)),
    order: Value(override.order),
    hidden: Value(override.hidden),
    primaryEntityRegistryId: Value(override.primaryEntityRegistryId),
    lastKnownName: Value(override.lastKnownName),
    lastKnownAreaHaId: Value(override.lastKnownAreaId),
    lastKnownDomain: Value(override.lastKnownDomain),
    serverId: Value(serverId),
  );
}

String _kindToDb(HomeTileKind kind) => switch (kind) {
  HomeTileKind.device => 'device',
  HomeTileKind.entity => 'entity',
};

HomeTileKind _kindFromDb(String value) => switch (value) {
  'device' => HomeTileKind.device,
  'entity' => HomeTileKind.entity,
  _ => throw StateError('Unknown home tile kind: $value'),
};

String _sizeToDb(HomeTileSize size) => switch (size) {
  HomeTileSize.small => 'small',
  HomeTileSize.large => 'large',
};

HomeTileSize _sizeFromDb(String value) => switch (value) {
  'small' => HomeTileSize.small,
  'large' => HomeTileSize.large,
  _ => throw StateError('Unknown home tile size: $value'),
};
