import 'package:isar/isar.dart';

part 'ha_server.g.dart';

@collection
class HaServer {
  Id id = Isar.autoIncrement;

  String name;

  @Index(unique: true)
  String uri;

  HaServer({
    required this.name,
    required this.uri,
  });
}
