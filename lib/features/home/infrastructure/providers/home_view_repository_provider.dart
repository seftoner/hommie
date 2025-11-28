import 'package:hommie/features/home/domain/repositories/i_home_view_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/drift_home_view_repository.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/services/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_repository_provider.g.dart';

@riverpod
Future<IHomeViewRepository> homeViewRepository(Ref ref) async {
  final database = ref.read(databaseConnectionProvider);
  final serverManager = ref.read(serverManagerProvider);
  final activeServer = await serverManager.getActiveServer();

  if (activeServer == null) {
    throw Exception('No active server found.');
  }

  return DriftHomeViewRepository(database, activeServer.id!);
}

@riverpod
IHomeViewRepository homeViewRepositoryForServer(Ref ref, int serverId) {
  final database = ref.read(databaseConnectionProvider);
  return DriftHomeViewRepository(database, serverId);
}
