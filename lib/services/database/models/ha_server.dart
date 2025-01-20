import 'package:isar/isar.dart';
import 'home_view.dart';

part 'ha_server.g.dart';

@collection
class HaServer {
  Id id = Isar.autoIncrement;

  String name;

  @Index(unique: true)
  String uri;

  @Backlink(to: 'haServer')
  final homeConfig = IsarLink<HomeViewConfig>();

  HaServer({
    required this.name,
    required this.uri,
  });
}
