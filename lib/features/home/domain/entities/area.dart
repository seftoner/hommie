import 'package:hommie/features/home/domain/entities/device.dart';

class Area {
  final String id;
  final String name;
  final String? imageUrl;
  final String? backgroundUrl;
  final List<Device> devices;

  const Area({
    required this.id,
    required this.name,
    this.imageUrl,
    this.backgroundUrl,
    this.devices = const [],
  });
}
