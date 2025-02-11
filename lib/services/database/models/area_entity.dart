import 'package:hommie/services/database/models/device_entity.dart';
import 'package:isar/isar.dart';
import 'server_entity.dart';

part 'area_entity.g.dart';

@collection
class AreaEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  final String haId; // Home Assistant ID

  @Index(type: IndexType.value)
  String name;

  String? background;
  String? image;

  @Backlink(to: 'area')
  final devices = IsarLinks<DeviceEntity>();

  @Index(type: IndexType.value)
  final server = IsarLink<ServerEntity>();

  AreaEntity({
    required this.haId,
    required this.name,
    this.background,
    this.image,
  });

  // @ignore
  // ServerEntity get server => server.value!;
}
