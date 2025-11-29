import 'package:hommie/features/servers/domain/repositories/i_server_repository.dart';
import 'package:hommie/features/servers/infrastructure/repositories/drift_server_repository.dart';
import 'package:hommie/core/infrastructure/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_repository_provider.g.dart';

@Riverpod(keepAlive: true)
IServerRepository serverRepository(Ref ref) {
  final database = ref.read(databaseConnectionProvider);
  return DriftServerRepository(database);
}
