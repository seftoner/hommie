import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/isar_area_repository.dart';
import 'package:hommie/services/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'area_repository_provider.g.dart';

@Riverpod(keepAlive: true)
IAreaRepository areaRepository(Ref ref) {
  final isar = ref.watch(databaseConnectionProvider);
  return IsarAreaRepository(isar);
}
