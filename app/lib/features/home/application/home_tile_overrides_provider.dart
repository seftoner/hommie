import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
import 'package:hommie/features/home/infrastructure/providers/home_tile_override_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tile_overrides_provider.g.dart';

/// Reactive list of local tile layout overrides for the active server.
@Riverpod(dependencies: [serverScopeId])
Stream<List<HomeTileOverride>> homeTileOverrides(Ref ref) {
  final serverId = ref.watch(serverScopeIdProvider);
  return ref.watch(homeTileOverrideRepositoryProvider).watchByServer(serverId);
}
