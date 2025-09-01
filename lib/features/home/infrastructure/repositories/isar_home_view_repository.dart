import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/features/home/domain/repositories/i_home_view_repository.dart';
import 'package:hommie/services/database/models/area_entity.dart';
import 'package:hommie/services/database/models/device_entity.dart';
import 'package:hommie/services/database/models/server_entity.dart';
import 'package:hommie/services/database/models/home_view.dart';
import 'package:isar_community/isar.dart';
import 'mappers/home_view_mapper.dart';

class IsarHomeViewRepository implements IHomeViewRepository {
  final Isar _isar;
  final int _serverId;

  IsarHomeViewRepository(this._isar, this._serverId);

  @override
  Future<HomeViewConf?> get() async {
    final config = await _isar.homeViewConfigs
        .filter()
        .server((q) => q.idEqualTo(_serverId))
        .findFirst();
    return config?.toDomain();
  }

  @override
  Future<HomeViewConf> save(HomeViewConf conf) async {
    return _isar.writeTxn(() async {
      final dbConf = conf.toDb();

      // Set server relationship
      final server = await _isar.serverEntitys
          .filter()
          .idEqualTo(int.parse(conf.serverId))
          .findFirst();
      dbConf.server.value = server;

      // Save areas
      for (final area in conf.areas) {
        final dbArea = area.toDb();
        dbArea.homeConfig.value = dbConf;

        final areaEntity = await _isar.areaEntitys
            .filter()
            .haIdEqualTo(area.area.id)
            .findFirst();
        dbArea.area.value = areaEntity;

        // Save devices
        for (final deviceConf in area.devices) {
          final dbDevice = deviceConf.toDb();
          dbDevice.areaConfig.value = dbArea;

          final deviceEntity = await _isar.deviceEntitys
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
  Future<void> delete() async {
    await _isar.writeTxn(() async {
      final config = await _isar.homeViewConfigs
          .filter()
          .server((q) => q.idEqualTo(_serverId))
          .findFirst();
      if (config != null) {
        await _isar.homeViewConfigs.delete(config.id);
      }
    });
  }
}
