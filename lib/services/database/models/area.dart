import 'package:hommie/services/database/models/device.dart';
import 'package:isar/isar.dart';
import 'ha_server.dart';

part 'area.g.dart';

@collection
class Area {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  final String haId; // Home Assistant ID

  @Index(type: IndexType.value)
  String name;

  String? background;
  String? image;

  @Backlink(to: 'area')
  final devices = IsarLinks<Device>();

  @Index(type: IndexType.value)
  final haServer = IsarLink<HaServer>();

  Area({
    required this.haId,
    required this.name,
    this.background,
    this.image,
  });

  @ignore
  HaServer get server => haServer.value!;
}
