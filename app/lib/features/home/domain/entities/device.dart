class Device {
  final String id;
  final String name;
  final String type;
  final String? areaId;
  final String? nameByUser;
  final String? manufacturer;
  final String? model;
  final bool disabled;

  const Device({
    required this.id,
    required this.name,
    this.type = 'device',
    this.areaId,
    this.nameByUser,
    this.manufacturer,
    this.model,
    this.disabled = false,
  });
}
