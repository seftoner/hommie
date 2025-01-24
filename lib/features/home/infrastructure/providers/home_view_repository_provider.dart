import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/home/domain/repositories/i_home_view_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/isar_home_view_repository.dart';
import 'package:hommie/features/server_manager/domain/models/server_config.dart';
import 'package:hommie/services/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_repository_provider.g.dart';

@riverpod
IHomeViewRepository homeViewRepository(Ref ref) {
  final isar = ref.read(databaseConnectionProvider);
  return IsarHomeViewRepository(isar, ServerConfig(id: 0, name: '', uri: ''));
}
