import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registry_repository_provider.g.dart';

@Riverpod(dependencies: [serverScopeConnection])
HaRegistryRepository registryRepository(Ref ref) {
  final connection = ref.watch(serverScopeConnectionProvider);
  return HaRegistryRepository(connection);
}
