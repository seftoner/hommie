import 'package:isar/isar.dart';
import 'ha_server.dart';
import 'area.dart';
import 'device.dart';

part 'home_view.g.dart';

enum DeviceDisplaySize {
  small,
  big,
}

@collection
class HomeViewConfig {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  final haServer = IsarLink<HaServer>();

  @Backlink(to: 'homeConfig')
  final areaConfigs = IsarLinks<AreaHomeConfig>();

  HomeViewConfig();
}

@collection
class AreaHomeConfig {
  Id id = Isar.autoIncrement;

  final area = IsarLink<Area>();
  final homeConfig = IsarLink<HomeViewConfig>();

  int position;

  @Backlink(to: 'areaConfig')
  final deviceConfigs = IsarLinks<DeviceHomeConfig>();

  AreaHomeConfig({
    required this.position,
  });
}

@collection
class DeviceHomeConfig {
  Id id = Isar.autoIncrement;

  final device = IsarLink<Device>();
  final areaConfig = IsarLink<AreaHomeConfig>();

  // @Index(type: IndexType.value)
  int position;

  // @Index(type: IndexType.value)
  @enumerated
  DeviceDisplaySize size;

  DeviceHomeConfig({
    required this.position,
    this.size = DeviceDisplaySize.small,
  });
}
