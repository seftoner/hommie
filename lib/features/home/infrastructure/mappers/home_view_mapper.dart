import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/services/database/models/home_view.dart' as db;

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
      areaId: area.value!.haId,
      position: position,
      devices: deviceConfigs.map((d) => d.toDomain()).toList()
        ..sort((a, b) => a.position.compareTo(b.position)),
    );
  }
}

extension DeviceHomeConfigMapper on db.DeviceHomeConfig {
  DeviceWidgetConf toDomain() {
    return DeviceWidgetConf(
      deviceId: device.value!.haId,
      position: position,
      size: size as DeviceDisplaySize,
    );
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
