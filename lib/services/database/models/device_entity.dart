import 'package:isar_community/isar.dart';

import 'area_entity.dart';
import 'server_entity.dart';

part 'device_entity.g.dart';

@collection
class DeviceEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  final String haId;

  String name;
  String type;

  final area = IsarLink<AreaEntity>();

  @ignore
  ServerEntity get server => area.value!.server.value!;

  DeviceEntity({required this.haId, required this.name, required this.type});
}
