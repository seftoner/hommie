import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_for_server_provider.g.dart';

@Riverpod(dependencies: [areaRepository])
Stream<List<Area>> areasForServer(Ref ref, int serverId) {
  final repo = ref.watch(areaRepositoryProvider);
  return repo.watchByServer(serverId);
}
