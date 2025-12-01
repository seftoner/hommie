import 'package:hommie/features/auth/infrastructure/repositories/ha_servers_repository.dart';
import 'package:hommie/features/auth/infrastructure/repositories/cached_ha_servers_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ha_servers_repository_provider.g.dart';

@riverpod
CachedHAServersRepository haServersRepository(Ref ref) {
  final baseRepository = HAServersRepository();
  return CachedHAServersRepository(baseRepository: baseRepository);
}
