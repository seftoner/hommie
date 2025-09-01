import 'package:hommie/services/database/models/models.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
Isar databaseConnection(Ref ref) {
  final instance = DatabaseInitializer._instance;
  if (instance == null) {
    throw StateError(
      'Database not initialized. Call DatabaseInitializer.initialize() first.',
    );
  }
  return instance;
}

class DatabaseInitializer {
  static Isar? _instance;

  static Isar get instance {
    if (_instance == null) {
      throw StateError(
        'Database not initialized. Call DatabaseInitializer.initialize() first.',
      );
    }
    return _instance!;
  }

  static Future<Isar> initialize() async {
    if (_instance != null) {
      return _instance!;
    }

    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open([
      AreaEntitySchema,
      DeviceEntitySchema,
      ServerEntitySchema,
      AreaHomeConfigSchema,
      HomeViewConfigSchema,
      DeviceHomeConfigSchema,
    ], directory: dir.path);

    // await _instance!.writeTxn(() async => _instance!.clear());

    // Populate test data if database is empty (debug mode only)
    // if (kDebugMode && (await _instance!.serverEntitys.count()) == 0) {
    //   await _populateTestData(_instance!);
    // }

    return _instance!;
  }
}
