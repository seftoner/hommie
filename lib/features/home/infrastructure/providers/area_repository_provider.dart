import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/isar_area_repository.dart';
import 'package:hommie/services/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'area_repository_provider.g.dart';

@riverpod
Future<IAreaRepository> areaRepository(Ref ref) async {
  final isar = await ref.read(databaseConnectionProvider.future);
  return IsarAreaRepository(isar);
}
