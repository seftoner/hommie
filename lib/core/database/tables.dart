import 'package:drift/drift.dart';

// Enum for device display size in database
enum DeviceDisplaySizeDb { small, big }

// Server entities table
class ServerEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  TextColumn get url => text()();
  TextColumn get version => text().nullable()();
}

// Area entities table
class AreaEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get haId => text().unique()(); // Home Assistant ID
  TextColumn get name => text()();
  TextColumn get background => text().nullable()();
  TextColumn get image => text().nullable()();
  IntColumn get serverId => integer().references(ServerEntities, #id)();
}

// Device entities table
class DeviceEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get haId => text().unique()(); // Home Assistant ID
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get areaId => integer().references(AreaEntities, #id)();
}

// Home view configuration table
class HomeViewConfigs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get serverId => integer().references(ServerEntities, #id)();
}

// Area home configuration table
class AreaHomeConfigs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get position => integer()();
  IntColumn get areaId => integer().references(AreaEntities, #id)();
  IntColumn get homeConfigId => integer().references(HomeViewConfigs, #id)();
}

// Device home configuration table
class DeviceHomeConfigs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get position => integer()();
  IntColumn get size => intEnum<DeviceDisplaySizeDb>()();
  IntColumn get deviceId => integer().references(DeviceEntities, #id)();
  IntColumn get areaConfigId => integer().references(AreaHomeConfigs, #id)();
}
