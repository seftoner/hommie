import 'package:hommie/features/home/domain/entities/device.dart';

class Area {
  final String id;
  final String name;
  final String? imageUrl;
  final String? backgroundUrl;
  final int position;
  final List<Device> devices;

  const Area({
    required this.id,
    required this.name,
    this.imageUrl,
    this.backgroundUrl,
    required this.position,
    this.devices = const [],
  });
}
