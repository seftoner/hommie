import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/application/session/session_status_projections.dart';
import 'package:hommie/application/session/server_sync_coordinator.dart';
import 'package:hommie/application/session/server_sync_state.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/home/application/cached_areas_provider.dart';
import 'package:hommie/features/home/application/cached_devices_provider.dart';
import 'package:hommie/features/home/application/home_tile_overrides_provider.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

void main() {
  ProviderContainer makeContainer({
    required List<Area> areas,
    required List<HaEntity> entities,
    List<Device> devices = const [],
    List<HomeTileOverride> overrides = const [],
    ServerSyncState syncState = const SyncReady(),
    bool homeConnectionLoading = false,
  }) {
    return ProviderContainer(
      overrides: [
        serverScopeServerProvider.overrideWithValue(
          const Server(id: 1, name: 'Home'),
        ),
        cachedAreasProvider.overrideWith((ref) => Stream.value(areas)),
        cachedEntitiesProvider.overrideWith((ref) => Stream.value(entities)),
        cachedDevicesProvider.overrideWith((ref) => Stream.value(devices)),
        homeTileOverridesProvider.overrideWith(
          (ref) => Stream.value(overrides),
        ),
        serverSyncCoordinatorProvider.overrideWithValue(syncState),
        homeConnectionLoadingProvider.overrideWithValue(homeConnectionLoading),
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
    expect(state.tabs.whereType<HomeAreaTab>().map((t) => t.title), [
      'Kitchen',
    ]);
    expect(state.sections.first.entities.single.entityId, 'light.a');
    expect(state.isInitialSyncing, isFalse);
    expect(state.isOffline, isFalse);
    expect(state.syncFailure, isNull);
  });

  test(
    'projects device sections from mirrored devices and persisted overrides',
    () async {
      final container = makeContainer(
        areas: [const Area(id: 'kitchen', name: 'Kitchen')],
        devices: const [
          Device(
            id: 'dev-lamp',
            name: 'Raw lamp',
            nameByUser: 'Counter lamp',
            areaId: 'kitchen',
          ),
        ],
        overrides: const [
          HomeTileOverride(
            kind: HomeTileKind.device,
            targetId: 'dev-lamp',
            areaId: 'kitchen',
            size: HomeTileSize.large,
            order: 4,
          ),
        ],
        entities: const [
          HaEntity(
            registryId: 'reg-light',
            uniqueId: 'uid-light',
            platform: 'hue',
            entityId: 'light.kitchen_lamp',
            domain: 'light',
            name: 'Kitchen lamp',
            deviceId: 'dev-lamp',
            areaId: 'kitchen',
          ),
          HaEntity(
            registryId: 'reg-signal',
            uniqueId: 'uid-signal',
            platform: 'hue',
            entityId: 'sensor.kitchen_lamp_signal',
            domain: 'sensor',
            name: 'Signal',
            deviceId: 'dev-lamp',
            areaId: 'kitchen',
            entityCategory: 'diagnostic',
          ),
          HaEntity(
            registryId: 'reg-scene',
            uniqueId: 'uid-scene',
            platform: 'scene',
            entityId: 'scene.movie_time',
            domain: 'scene',
            name: 'Movie time',
            areaId: 'kitchen',
          ),
        ],
      );
      addTearDown(container.dispose);

      container.listen(homePageControllerProvider, (_, _) {});
      await Future<void>.delayed(const Duration(milliseconds: 20));

      final state = container.read(homePageControllerProvider);
      expect(state.sections.first.entities, hasLength(3));
      expect(state.deviceSections, hasLength(1));
      expect(state.deviceSections.single.areaId, 'kitchen');
      expect(state.deviceSections.single.tiles, hasLength(1));
      final tile = state.deviceSections.single.tiles.single;
      expect(tile.targetId, 'dev-lamp');
      expect(tile.name, 'Counter lamp');
      expect(tile.size, HomeTileSize.large);
      expect(tile.order, 4);
      expect(tile.resolution, HomeTileResolution.active);
      expect(tile.primaryEntity?.registryId, 'reg-light');
    },
  );

  test(
    'does not derive device sections from entity device ids alone',
    () async {
      final container = makeContainer(
        areas: [const Area(id: 'kitchen', name: 'Kitchen')],
        entities: const [
          HaEntity(
            registryId: 'reg-light',
            uniqueId: 'uid-light',
            platform: 'hue',
            entityId: 'light.kitchen_lamp',
            domain: 'light',
            name: 'Kitchen lamp',
            deviceId: 'dev-lamp',
            areaId: 'kitchen',
          ),
        ],
      );
      addTearDown(container.dispose);

      container.listen(homePageControllerProvider, (_, _) {});
      await Future<void>.delayed(const Duration(milliseconds: 20));

      final state = container.read(homePageControllerProvider);
      expect(
        state.sections.first.entities.single.entityId,
        'light.kitchen_lamp',
      );
      expect(state.deviceSections, hasLength(1));
      expect(state.deviceSections.single.tiles, isEmpty);
    },
  );

  test('keeps missing override tiles for rebind', () async {
    final container = makeContainer(
      areas: [const Area(id: 'kitchen', name: 'Kitchen')],
      entities: const [],
      overrides: const [
        HomeTileOverride(
          kind: HomeTileKind.device,
          targetId: 'dev-missing',
          areaId: 'kitchen',
          size: HomeTileSize.large,
          order: 2,
          lastKnownName: 'Old lamp',
          lastKnownAreaId: 'kitchen',
        ),
      ],
    );
    addTearDown(container.dispose);

    container.listen(homePageControllerProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final state = container.read(homePageControllerProvider);
    expect(state.deviceSections, hasLength(1));
    final tile = state.deviceSections.single.tiles.single;
    expect(tile.targetId, 'dev-missing');
    expect(tile.name, 'Old lamp');
    expect(tile.areaId, 'kitchen');
    expect(tile.size, HomeTileSize.large);
    expect(tile.order, 2);
    expect(tile.resolution, HomeTileResolution.missing);
  });

  test('isInitialSyncing while entities empty and initial sync runs', () async {
    final container = makeContainer(
      areas: const [],
      entities: const [],
      syncState: const InitialSyncRunning(),
    );
    addTearDown(container.dispose);

    container.listen(homePageControllerProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final state = container.read(homePageControllerProvider);
    expect(state.isInitialSyncing, isTrue);
    expect(state.isOffline, isFalse);
  });

  test(
    'isInitialSyncing while entities empty and connection is loading',
    () async {
      final container = makeContainer(
        areas: const [],
        entities: const [],
        syncState: const SyncIdle(),
        homeConnectionLoading: true,
      );
      addTearDown(container.dispose);

      container.listen(homePageControllerProvider, (_, _) {});
      await Future<void>.delayed(const Duration(milliseconds: 20));

      final state = container.read(homePageControllerProvider);
      expect(state.isInitialSyncing, isTrue);
      expect(state.isOffline, isFalse);
    },
  );

  test('keeps cached sections visible while offline', () async {
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
      syncState: const SyncOfflineWithCache(),
    );
    addTearDown(container.dispose);

    container.listen(homePageControllerProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final state = container.read(homePageControllerProvider);
    expect(state.isOffline, isTrue);
    expect(state.isInitialSyncing, isFalse);
    expect(state.sections.first.entities.single.entityId, 'light.a');
  });

  test('captures sync failure while cache is empty', () async {
    final failure = Object();
    final container = makeContainer(
      areas: const [],
      entities: const [],
      syncState: SyncFailed(failure),
    );
    addTearDown(container.dispose);

    container.listen(homePageControllerProvider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final state = container.read(homePageControllerProvider);
    expect(state.syncFailure, same(failure));
    expect(state.isInitialSyncing, isFalse);
  });
}
