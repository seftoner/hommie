import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/areas/application/area_registry_sync_controller.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/application/entity_registry_sync_controller.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/home/application/cached_areas_provider.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

class _AreaSyncNoop extends AreaRegistrySyncController {
  @override
  void build() {}
}

class _EntitySyncOk extends EntityRegistrySyncController {
  @override
  EntitySyncStatus build() => EntitySyncStatus.success;
}

void main() {
  ProviderContainer makeContainer({
    required List<Area> areas,
    required List<HaEntity> entities,
  }) {
    return ProviderContainer(
      overrides: [
        serverScopeServerProvider.overrideWithValue(
          const Server(id: 1, name: 'Home'),
        ),
        cachedAreasProvider.overrideWith((ref) => Stream.value(areas)),
        cachedEntitiesProvider.overrideWith((ref) => Stream.value(entities)),
        areaRegistrySyncControllerProvider.overrideWith(_AreaSyncNoop.new),
        entityRegistrySyncControllerProvider.overrideWith(_EntitySyncOk.new),
      ],
    );
  }

  test('builds summary + per-area tabs and grouped sections', () async {
    final container = makeContainer(
      areas: [const Area(id: 'kitchen', name: 'Kitchen')],
      entities: [
        const HaEntity(
          entityId: 'light.a',
          domain: 'light',
          name: 'A',
          areaId: 'kitchen',
        ),
      ],
    );
    addTearDown(container.dispose);

    // Keep the controller (and its watched stream providers) alive while the
    // Stream.value overrides emit their first value.
    container.listen(homePageControllerProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final state = container.read(homePageControllerProvider);
    expect(state.serverName, 'Home');
    expect(state.tabs.whereType<HomeAreaTab>().map((t) => t.title), ['Kitchen']);
    expect(state.sections.first.entities.single.entityId, 'light.a');
    expect(state.isSyncing, isFalse);
  });

  test('isSyncing while entities empty and sync not finished', () async {
    final container = ProviderContainer(
      overrides: [
        serverScopeServerProvider.overrideWithValue(
          const Server(id: 1, name: 'Home'),
        ),
        cachedAreasProvider.overrideWith((ref) => Stream.value(const [])),
        cachedEntitiesProvider.overrideWith((ref) => Stream.value(const [])),
        areaRegistrySyncControllerProvider.overrideWith(_AreaSyncNoop.new),
        // Default (real) entity sync starts in `syncing`/`notStarted`; stub it.
        entityRegistrySyncControllerProvider.overrideWith(_EntitySyncing.new),
      ],
    );
    addTearDown(container.dispose);

    container.listen(homePageControllerProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final state = container.read(homePageControllerProvider);
    expect(state.isSyncing, isTrue);
  });
}

class _EntitySyncing extends EntityRegistrySyncController {
  @override
  EntitySyncStatus build() => EntitySyncStatus.syncing;
}
