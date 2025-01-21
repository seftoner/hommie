import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/features/home/domain/repositories/i_home_view_repository.dart';
import 'package:hommie/services/database/models/area.dart';
import 'package:hommie/services/database/models/device.dart';
import 'package:hommie/services/database/models/ha_server.dart';
import 'package:hommie/services/database/models/home_view.dart';
import 'package:isar/isar.dart';
import 'mappers/home_view_mapper.dart';

class IsarHomeViewRepository implements IHomeViewRepository {
  final Isar _isar;

  IsarHomeViewRepository(this._isar);

  @override
  Future<HomeViewConf?> getByServerId(String serverId) async {
    final config = await _isar.homeViewConfigs
        .filter()
        .haServer((q) => q.idEqualTo(int.parse(serverId)))
        .findFirst();
    return config?.toDomain();
  }

  @override
  Future<HomeViewConf> save(HomeViewConf conf) async {
    return _isar.writeTxn(() async {
      final dbConf = conf.toDb();

      // Set server relationship
      final server = await _isar.haServers
          .filter()
          .idEqualTo(int.parse(conf.serverId))
          .findFirst();
      dbConf.haServer.value = server;

      // Save areas
      for (final area in conf.areas) {
        final dbArea = area.toDb();
        dbArea.homeConfig.value = dbConf;

        final areaEntity =
            await _isar.areas.filter().haIdEqualTo(area.area.id).findFirst();
        dbArea.area.value = areaEntity;

        // Save devices
        for (final deviceConf in area.devices) {
          final dbDevice = deviceConf.toDb();
          dbDevice.areaConfig.value = dbArea;

          final deviceEntity = await _isar.devices
              .filter()
              .haIdEqualTo(deviceConf.device.id)
              .findFirst();
          dbDevice.device.value = deviceEntity;

          await _isar.deviceHomeConfigs.put(dbDevice);
        }

        await _isar.areaHomeConfigs.put(dbArea);
      }

      await _isar.homeViewConfigs.put(dbConf);
      return dbConf.toDomain();
    });
  }

  @override
  Future<void> delete(String serverId) async {
    await _isar.writeTxn(() async {
      final config = await _isar.homeViewConfigs
          .filter()
          .haServer((q) => q.idEqualTo(int.parse(serverId)))
          .findFirst();
      if (config != null) {
        await _isar.homeViewConfigs.delete(config.id);
      }
    });
  }

  @override
  Future<List<HomeViewConf>> getAll() async {
    final configs = await _isar.homeViewConfigs.where().findAll();
    return configs.map((c) => c.toDomain()).toList();
  }
}
