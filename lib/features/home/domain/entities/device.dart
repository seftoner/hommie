class Device {
  final String id;
  final String name;
  final String type;
  final bool isHidden;
  final int position;
  final String areaId;

  const Device({
    required this.id,
    required this.name,
    required this.type,
    required this.isHidden,
    required this.position,
    required this.areaId,
  });
}
