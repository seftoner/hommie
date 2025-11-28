import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/core/database/tables.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/features/home/domain/repositories/i_home_view_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/area_mapper.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/device_mapper.dart';
import 'mappers/home_view_mapper.dart';

class DriftHomeViewRepository implements IHomeViewRepository {
  final AppDatabase _database;
  final int _serverId;

  DriftHomeViewRepository(this._database, this._serverId);

  @override
  Future<HomeViewConf?> get() async {
    // Get home view config for the server
    final homeConfig = await (_database.select(
      _database.homeViewConfigs,
    )..where((c) => c.serverId.equals(_serverId))).getSingleOrNull();

    if (homeConfig == null) {
      return null;
    }

    // Get area configs with joins to areas
    final areaConfigsQuery =
        (_database.select(_database.areaHomeConfigs)
              ..where((ac) => ac.homeConfigId.equals(homeConfig.id))
              ..orderBy([(ac) => OrderingTerm.asc(ac.order)]))
            .join([
              innerJoin(
                _database.areaEntities,
                _database.areaEntities.id.equalsExp(
                  _database.areaHomeConfigs.areaId,
                ),
              ),
            ]);

    final areaConfigRows = await areaConfigsQuery.get();

    final areas = <AreaHomeConf>[];
    for (final row in areaConfigRows) {
      final areaConfig = row.readTable(_database.areaHomeConfigs);
      final area = row.readTable(_database.areaEntities);

      // Get device configs for this area
      final deviceConfigsQuery =
          (_database.select(_database.deviceHomeConfigs)
                ..where((dc) => dc.areaConfigId.equals(areaConfig.id))
                ..orderBy([(dc) => OrderingTerm.asc(dc.order)]))
              .join([
                innerJoin(
                  _database.deviceEntities,
                  _database.deviceEntities.id.equalsExp(
                    _database.deviceHomeConfigs.deviceId,
                  ),
                ),
              ]);

      final deviceConfigRows = await deviceConfigsQuery.get();
      final devices = deviceConfigRows.map((row) {
        final deviceConfig = row.readTable(_database.deviceHomeConfigs);
        final device = row.readTable(_database.deviceEntities);

        // Map database enum to domain enum
        final domainSize = deviceConfig.size == DeviceDisplaySizeDb.big
            ? DeviceDisplaySize.big
            : DeviceDisplaySize.small;

        return DeviceWidgetConf(
          device: device.toDomain(area.haId),
          position: deviceConfig.order,
          size: domainSize,
        );
      }).toList();

      areas.add(
        AreaHomeConf(
          area: area.toDomain(),
          position: areaConfig.order,
          devices: devices,
        ),
      );
    }

    return HomeViewConf(serverId: _serverId.toString(), areas: areas);
  }

  @override
  Future<HomeViewConf> save(HomeViewConf conf) async {
    return _database.transaction(() async {
      // Delete existing config if any
      final existingConfig = await (_database.select(
        _database.homeViewConfigs,
      )..where((c) => c.serverId.equals(_serverId))).getSingleOrNull();

      if (existingConfig != null) {
        // Delete old device configs
        final oldAreaConfigs = await (_database.select(
          _database.areaHomeConfigs,
        )..where((ac) => ac.homeConfigId.equals(existingConfig.id))).get();

        for (final ac in oldAreaConfigs) {
          await (_database.delete(
            _database.deviceHomeConfigs,
          )..where((dc) => dc.areaConfigId.equals(ac.id))).go();
        }

        // Delete old area configs
        await (_database.delete(
          _database.areaHomeConfigs,
        )..where((ac) => ac.homeConfigId.equals(existingConfig.id))).go();

        // Delete old home config
        await (_database.delete(
          _database.homeViewConfigs,
        )..where((c) => c.id.equals(existingConfig.id))).go();
      }

      // Insert new home config
      final homeConfigId = await _database
          .into(_database.homeViewConfigs)
          .insert(conf.toCompanion());

      // Save area configs
      for (final area in conf.areas) {
        // Get area DB ID from haId
        final areaEntity = await (_database.select(
          _database.areaEntities,
        )..where((a) => a.haId.equals(area.area.id))).getSingleOrNull();

        if (areaEntity == null) {
          throw Exception('Area with haId ${area.area.id} not found');
        }

        final areaConfigId = await _database
            .into(_database.areaHomeConfigs)
            .insert(area.toCompanion(homeConfigId, areaEntity.id));

        // Save device configs
        for (final deviceConf in area.devices) {
          final deviceEntity =
              await (_database.select(_database.deviceEntities)
                    ..where((d) => d.haId.equals(deviceConf.device.id)))
                  .getSingleOrNull();

          if (deviceEntity == null) {
            throw Exception(
              'Device with haId ${deviceConf.device.id} not found',
            );
          }

          await _database
              .into(_database.deviceHomeConfigs)
              .insert(deviceConf.toCompanion(areaConfigId, deviceEntity.id));
        }
      }

      // Return the saved config
      return conf;
    });
  }

  @override
  Future<void> delete() async {
    await _database.transaction(() async {
      final config = await (_database.select(
        _database.homeViewConfigs,
      )..where((c) => c.serverId.equals(_serverId))).getSingleOrNull();

      if (config != null) {
        // Delete device configs
        final areaConfigs = await (_database.select(
          _database.areaHomeConfigs,
        )..where((ac) => ac.homeConfigId.equals(config.id))).get();

        for (final ac in areaConfigs) {
          await (_database.delete(
            _database.deviceHomeConfigs,
          )..where((dc) => dc.areaConfigId.equals(ac.id))).go();
        }

        // Delete area configs
        await (_database.delete(
          _database.areaHomeConfigs,
        )..where((ac) => ac.homeConfigId.equals(config.id))).go();

        // Delete home config
        await (_database.delete(
          _database.homeViewConfigs,
        )..where((c) => c.id.equals(config.id))).go();
      }
    });
  }
}
