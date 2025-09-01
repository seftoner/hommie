import 'package:isar_community/isar.dart';

import 'home_view.dart';

part 'server_entity.g.dart';

@collection
class ServerEntity {
  Id id = Isar.autoIncrement;

  String name;

  bool isActive;

  // @Index(unique: true)
  String url;

  @Backlink(to: 'server')
  final homeConfig = IsarLink<HomeViewConfig>();

  ServerEntity({required this.name, required this.url, this.isActive = false});
}
