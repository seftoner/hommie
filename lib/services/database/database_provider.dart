import 'package:hommie/services/database/models/area.dart';
import 'package:hommie/services/database/models/device.dart';
import 'package:hommie/services/database/models/ha_server.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
class DatabaseConnection extends _$DatabaseConnection {
  @override
  Future<Isar> build() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [AreaSchema, DeviceSchema, HaServerSchema],
      directory: dir.path,
    );
  }
}
