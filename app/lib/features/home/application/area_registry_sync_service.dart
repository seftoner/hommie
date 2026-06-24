import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'area_registry_sync_service.g.dart';

@Riverpod(dependencies: [areaRepository])
AreaRegistrySyncService areaRegistrySyncService(Ref ref) {
  return AreaRegistrySyncService(ref.watch(areaRepositoryProvider));
}

class AreaRegistrySyncService {
  AreaRegistrySyncService(this._areaRepository);

  final IAreaRepository _areaRepository;

  Future<void> refresh({
    required int serverId,
    required IHAConnection connection,
    bool Function()? shouldSync,
  }) async {
    final api = HomeAssistantApi.fromConnection(connection);
    final areas = await api.areas.list();
    if (shouldSync != null && !shouldSync()) {
      return;
    }
    await _areaRepository.syncAll(
      serverId: serverId,
      areas: areas.map(_toDomain).toList(),
    );
  }

  Area _toDomain(HassArea area) {
    return Area(
      id: area.areaId,
      name: area.name,
      icon: area.icon,
      picture: area.picture,
      aliases: area.aliases,
      labels: area.labels,
    );
  }
}
