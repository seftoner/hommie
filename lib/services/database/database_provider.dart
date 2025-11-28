import 'package:hommie/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase databaseConnection(Ref ref) {
  return AppDatabase();
}
