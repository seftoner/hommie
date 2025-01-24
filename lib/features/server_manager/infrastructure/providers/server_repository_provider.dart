import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_server_repository.dart';
import 'package:hommie/features/server_manager/infrastructure/repositories/isar_server_repository.dart';
import 'package:hommie/services/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_repository_provider.g.dart';

@riverpod
IServerRepository serverRepository(Ref ref) {
  final isar = ref.read(databaseConnectionProvider);
  return IsarServerRepository(isar);
}
