import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cached_areas_provider.g.dart';

@Riverpod(dependencies: [serverScopeId])
Stream<List<Area>> cachedAreas(Ref ref) {
  final serverId = ref.watch(serverScopeIdProvider);
  final repo = ref.watch(areaRepositoryProvider);
  return repo.watchByServer(serverId);
}
