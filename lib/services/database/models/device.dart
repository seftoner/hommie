import 'package:isar/isar.dart';
import 'area.dart';
import 'ha_server.dart';

part 'device.g.dart';

@collection
class Device {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  final String haId; // Home Assistant ID

  String name;
  String type;

  @Index(type: IndexType.value)
  bool isHidden;

  @Index(type: IndexType.value)
  int position;

  final area = IsarLink<Area>();

  @ignore
  HaServer get server => area.value!.server;

  Device({
    required this.haId,
    required this.name,
    required this.type,
    this.isHidden = false,
    required this.position,
  });
}
