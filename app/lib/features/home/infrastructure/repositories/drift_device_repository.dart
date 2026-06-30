import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/home/domain/entities/device.dart' as domain;
import 'package:hommie/features/home/domain/repositories/i_device_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/device_mapper.dart';

class DriftDeviceRepository implements IDeviceRepository {
  final AppDatabase _database;

  DriftDeviceRepository(this._database);

  @override
  Future<List<domain.Device>> getAll() async {
    // Need to join with areas through DeviceAreaConfigs to get areaHaId
    final query = _database.select(_database.deviceEntities).join([
      leftOuterJoin(
        _database.deviceAreaConfigs,
        _database.deviceAreaConfigs.deviceId.equalsExp(
          _database.deviceEntities.id,
        ),
      ),
      leftOuterJoin(
        _database.areaEntities,
        _database.areaEntities.id.equalsExp(_database.deviceAreaConfigs.areaId),
      ),
    ]);

    final results = await query.get();
    return results.map((row) {
      final device = row.readTable(_database.deviceEntities);
      final area = row.readTableOrNull(_database.areaEntities);
      return device.toDomain(area?.haId);
    }).toList();
  }

  @override
  Stream<List<domain.Device>> watchByServer(int serverId) {
    return (_database.select(_database.deviceEntities)
          ..where((d) => d.serverId.equals(serverId)))
        .watch()
        .map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<List<domain.Device>> getByServer(int serverId) async {
    final rows = await (_database.select(
      _database.deviceEntities,
    )..where((d) => d.serverId.equals(serverId))).get();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<domain.Device?> getById(int id) async {
    final query =
        (_database.select(
          _database.deviceEntities,
        )..where((d) => d.id.equals(id))).join([
          leftOuterJoin(
            _database.deviceAreaConfigs,
            _database.deviceAreaConfigs.deviceId.equalsExp(
              _database.deviceEntities.id,
            ),
          ),
          leftOuterJoin(
            _database.areaEntities,
            _database.areaEntities.id.equalsExp(
              _database.deviceAreaConfigs.areaId,
            ),
          ),
        ]);

    final result = await query.getSingleOrNull();
    if (result == null) {
      return null;
    }

    final device = result.readTable(_database.deviceEntities);
    final area = result.readTableOrNull(_database.areaEntities);
    return device.toDomain(area?.haId);
  }

  @override
  Future<domain.Device?> getByHaId({
    required int serverId,
    required String haId,
  }) async {
    final query =
        (_database.select(_database.deviceEntities)
              ..where((d) => d.serverId.equals(serverId) & d.haId.equals(haId)))
            .join([
              leftOuterJoin(
                _database.deviceAreaConfigs,
                _database.deviceAreaConfigs.deviceId.equalsExp(
                  _database.deviceEntities.id,
                ),
              ),
              leftOuterJoin(
                _database.areaEntities,
                _database.areaEntities.id.equalsExp(
                  _database.deviceAreaConfigs.areaId,
                ),
              ),
            ]);

    final results = await query.get();
    if (results.isEmpty) {
      return null;
    }

    final result = results.first;
    final device = result.readTable(_database.deviceEntities);
    final area = result.readTableOrNull(_database.areaEntities);
    return device.toDomain(area?.haId);
  }

  @override
  Future<List<domain.Device>> getByArea(int areaId) async {
    final query = (_database.select(_database.deviceEntities)).join([
      innerJoin(
        _database.deviceAreaConfigs,
        _database.deviceAreaConfigs.deviceId.equalsExp(
              _database.deviceEntities.id,
            ) &
            _database.deviceAreaConfigs.areaId.equals(areaId),
      ),
      leftOuterJoin(
        _database.areaEntities,
        _database.areaEntities.id.equalsExp(_database.deviceAreaConfigs.areaId),
      ),
    ]);

    final results = await query.get();
    return results.map((row) {
      final device = row.readTable(_database.deviceEntities);
      final area = row.readTableOrNull(_database.areaEntities);
      return device.toDomain(area?.haId);
    }).toList();
  }

  @override
  Future<void> syncRegistry({
    required int serverId,
    required List<domain.Device> devices,
  }) async {
    await _database.transaction(() async {
      final existing = await (_database.select(
        _database.deviceEntities,
      )..where((d) => d.serverId.equals(serverId))).get();

      final nextIds = devices.map((device) => device.id).toSet();
      for (final row in existing) {
        if (!nextIds.contains(row.haId)) {
          await (_database.delete(
            _database.deviceEntities,
          )..where((d) => d.id.equals(row.id))).go();
        }
      }

      for (final device in devices) {
        await _database
            .into(_database.deviceEntities)
            .insert(
              device.toCompanion(serverId),
              onConflict: DoUpdate(
                (old) => device.toCompanion(serverId),
                target: [
                  _database.deviceEntities.serverId,
                  _database.deviceEntities.haId,
                ],
              ),
            );
      }
    });
  }

  @override
  Future<void> save(domain.Device device) async {
    // Need to find the area's DB ID from its haId
    final areaId = device.areaId;
    if (areaId == null) {
      throw Exception('Cannot save unassigned device ${device.id}');
    }

    final area = await (_database.select(
      _database.areaEntities,
    )..where((a) => a.haId.equals(areaId))).getSingleOrNull();

    if (area == null) {
      throw Exception('Area with haId $areaId not found');
    }

    await _database.transaction(() async {
      // Insert or update the device
      final deviceId = await _database
          .into(_database.deviceEntities)
          .insertReturning(
            device.toCompanion(area.serverId),
            mode: InsertMode.insertOrReplace,
          )
          .then((row) => row.id);

      // Create or update the device-area association
      await _database
          .into(_database.deviceAreaConfigs)
          .insert(
            DeviceAreaConfigsCompanion(
              deviceId: Value(deviceId),
              areaId: Value(area.id),
            ),
            mode: InsertMode.insertOrReplace,
          );
    });
  }

  @override
  Future<void> delete(int id) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.deviceEntities,
      )..where((d) => d.id.equals(id))).go();
    });
  }
}
