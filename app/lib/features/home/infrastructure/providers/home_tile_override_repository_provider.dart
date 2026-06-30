import 'package:hommie/core/infrastructure/database/database_provider.dart';
import 'package:hommie/features/home/domain/repositories/i_home_tile_override_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/drift_home_tile_override_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tile_override_repository_provider.g.dart';

@riverpod
IHomeTileOverrideRepository homeTileOverrideRepository(Ref ref) {
  final database = ref.read(databaseConnectionProvider);
  return DriftHomeTileOverrideRepository(database);
}
