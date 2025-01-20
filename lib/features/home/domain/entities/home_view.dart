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
  final String areaId;
  final int position;
  final List<DeviceWidgetConf> devices;

  const AreaHomeConf({
    required this.areaId,
    required this.position,
    required this.devices,
  });
}

class DeviceWidgetConf {
  final String deviceId;
  final int position;
  final DeviceDisplaySize size;

  const DeviceWidgetConf({
    required this.deviceId,
    required this.position,
    this.size = DeviceDisplaySize.small,
  });
}
