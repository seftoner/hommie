import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/isar_area_repository.dart';
import 'package:hommie/services/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'area_repository_provider.g.dart';

@riverpod
IAreaRepository areaRepository(Ref ref) {
  final isar = ref.read(databaseConnectionProvider);
  return IsarAreaRepository(isar);
}
