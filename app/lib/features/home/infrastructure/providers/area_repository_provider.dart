import 'package:hommie/core/infrastructure/database/database_provider.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/drift_area_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'area_repository_provider.g.dart';

@Riverpod(keepAlive: true)
IAreaRepository areaRepository(Ref ref) {
  final database = ref.watch(databaseConnectionProvider);
  return DriftAreaRepository(database);
}
