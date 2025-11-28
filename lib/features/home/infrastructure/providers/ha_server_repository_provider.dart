import 'package:hommie/features/home/domain/repositories/i_ha_server_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/drift_ha_server_repository.dart';
import 'package:hommie/services/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ha_server_repository_provider.g.dart';

@riverpod
IServerEntityRepository haServerRepository(Ref ref) {
  final database = ref.read(databaseConnectionProvider);
  return DriftServerEntityRepository(database);
}
