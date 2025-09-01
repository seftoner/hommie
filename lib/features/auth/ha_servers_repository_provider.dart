import 'package:hommie/features/auth/domain/repository/i_ha_servers_repository.dart';
import 'package:hommie/features/auth/infrastructure/repositories/ha_servers_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ha_servers_repository_provider.g.dart';

@riverpod
IHAServersRepository haServersRepository(Ref ref) {
  return HAServersRepository();
}
