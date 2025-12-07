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
      return device.toDomain(area?.haId ?? '');
    }).toList();
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
    return device.toDomain(area?.haId ?? '');
  }

  @override
  Future<domain.Device?> getByHaId(String haId) async {
    final query =
        (_database.select(
          _database.deviceEntities,
        )..where((d) => d.haId.equals(haId))).join([
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
    return device.toDomain(area?.haId ?? '');
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
      return device.toDomain(area?.haId ?? '');
    }).toList();
  }

  @override
  Future<void> save(domain.Device device) async {
    // Need to find the area's DB ID from its haId
    final area = await (_database.select(
      _database.areaEntities,
    )..where((a) => a.haId.equals(device.areaId))).getSingleOrNull();

    if (area == null) {
      throw Exception('Area with haId ${device.areaId} not found');
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
