import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/services/database/models/home_view.dart' as db;
import 'package:hommie/features/home/infrastructure/repositories/mappers/area_mapper.dart';
import 'package:hommie/features/home/infrastructure/repositories/mappers/device_mapper.dart';

extension HomeViewConfigMapper on db.HomeViewConfig {
  HomeViewConf toDomain() {
    return HomeViewConf(
      serverId: haServer.value!.id.toString(),
      areas: areaConfigs.map((a) => a.toDomain()).toList()
        ..sort((a, b) => a.position.compareTo(b.position)),
    );
  }
}

extension AreaHomeConfigMapper on db.AreaHomeConfig {
  AreaHomeConf toDomain() {
    return AreaHomeConf(
      area: area.value!.toDomain(),
      position: position,
      devices: deviceConfigs.map((d) => d.toDomain()).toList()
        ..sort((a, b) => a.position.compareTo(b.position)),
    );
  }
}

extension DeviceHomeConfigMapper on db.DeviceHomeConfig {
  DeviceWidgetConf toDomain() {
    return DeviceWidgetConf(
        device: device.value!.toDomain(),
        position: position,
        size: _toDomain(size));
  }

  DeviceDisplaySize _toDomain(db.DeviceDisplaySize size) {
    return switch (size) {
      db.DeviceDisplaySize.small => DeviceDisplaySize.small,
      db.DeviceDisplaySize.big => DeviceDisplaySize.big,
    };
  }
}

extension HomeViewMapper on HomeViewConf {
  db.HomeViewConfig toDb() {
    final config = db.HomeViewConfig();
    // Note: haServer link needs to be set separately
    return config;
  }
}

extension AreaHomeMapper on AreaHomeConf {
  db.AreaHomeConfig toDb() {
    return db.AreaHomeConfig(position: position);
    // Note: area and homeConfig links need to be set separately
  }
}

extension DeviceHomeMapper on DeviceWidgetConf {
  db.DeviceHomeConfig toDb() {
    return db.DeviceHomeConfig(
      position: position,
      size: size as db.DeviceDisplaySize,
    );
    // Note: device and areaConfig links need to be set separately
  }
}
