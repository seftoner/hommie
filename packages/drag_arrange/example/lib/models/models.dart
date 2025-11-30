enum GridType {
  list,
  count,
  extent,
}

enum DeviceSize {
  small, // 1x2
  square, // 2x2
  wide // 1x4
}

class DeviceWidget {
  final String name;
  final String id;
  final DeviceSize? size;

  DeviceWidget({
    required this.name,
    required this.id,
    this.size,
  });
}
