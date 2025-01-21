import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/domain/entities/device.dart';

enum DeviceDisplaySize {
  small,
  big,
}

class HomeViewConf {
  final String serverId;
  final List<AreaHomeConf> areas;

  const HomeViewConf({
    required this.serverId,
    required this.areas,
  });
}

class AreaHomeConf {
  final Area area;
  final int position;
  final List<DeviceWidgetConf> devices;

  const AreaHomeConf({
    required this.area,
    required this.position,
    required this.devices,
  });
}

class DeviceWidgetConf {
  final Device device;
  final int position;
  final DeviceDisplaySize size;

  const DeviceWidgetConf({
    required this.device,
    required this.position,
    this.size = DeviceDisplaySize.small,
  });
}
