import 'package:drift/drift.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/core/database/tables.dart' as db;

// Note: For Drift, we'll need to manually join and construct these complex objects
// in the repository since Drift doesn't have the same backlink concept as Isar

extension HomeViewMapper on HomeViewConf {
  HomeViewConfigsCompanion toCompanion() {
    return HomeViewConfigsCompanion(serverId: Value(int.parse(serverId)));
  }
}

extension AreaHomeMapper on AreaHomeConf {
  AreaHomeConfigsCompanion toCompanion(int homeConfigId, int areaDbId) {
    return AreaHomeConfigsCompanion(
      position: Value(position),
      areaId: Value(areaDbId),
      homeConfigId: Value(homeConfigId),
    );
  }
}

extension DeviceHomeMapper on DeviceWidgetConf {
  DeviceHomeConfigsCompanion toCompanion(int areaConfigId, int deviceDbId) {
    // Map domain enum to database enum
    final dbSize = size == DeviceDisplaySize.big
        ? db.DeviceDisplaySizeDb.big
        : db.DeviceDisplaySizeDb.small;

    return DeviceHomeConfigsCompanion(
      position: Value(position),
      size: Value(dbSize),
      deviceId: Value(deviceDbId),
      areaConfigId: Value(areaConfigId),
    );
  }
}
