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
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

void main() {
  ProviderContainer makeContainer({
    required List<Area> areas,
    required List<HaEntity> entities,
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
