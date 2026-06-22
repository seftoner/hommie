import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/server_sync_coordinator.dart';
import 'package:hommie/application/session/server_sync_state.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/domain/repositories/i_entity_repository.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

import '../../utils/tests_logger.dart';

class _FakeConnection implements IHAConnection {
  final subscriptions = <HASubscription>[];

  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) {
    if (message is HARequestMessage &&
        message.type == 'config/area_registry/list') {
      return Future.value([
        {
          'created_at': 1.0,
          'modified_at': 1.0,
          'aliases': <String>[],
          'area_id': 'kitchen',
          'labels': <String>[],
          'name': 'Kitchen',
        },
      ]);
    }

    if (message is HARequestMessage &&
        message.type == 'config/entity_registry/list') {
      return Future.value([
        {
          'entity_id': 'light.kitchen',
          'name': 'Kitchen',
          'disabled_by': null,
          'hidden_by': null,
          'area_id': 'kitchen',
        },
      ]);
    }

    if (message is HARequestMessage &&
        message.type == 'config/device_registry/list') {
      return Future.value(<dynamic>[]);
    }

    return Future.value(null);
  }

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    final subscription = HASubscription(
      logger: const NoOpLogger(),
      unsubscribe: () async {},
    );
    subscriptions.add(subscription);
    return subscription;
  }
}

class _FakeAreaRepo implements IAreaRepository {
  int syncs = 0;
  List<Area> captured = const [];

  @override
  Future<List<Area>> getByServer(int serverId) async => captured;

  @override
  Future<Area?> getByHaId({required int serverId, required String haId}) async {
    for (final area in captured) {
      if (area.id == haId) {
        return area;
      }
    }
    return null;
  }

  @override
  Future<void> syncAll({
    required int serverId,
    required List<Area> areas,
  }) async {
    syncs += 1;
    captured = areas;
  }

  @override
  Future<void> upsert({required int serverId, required Area area}) async {
    captured = [...captured.where((item) => item.id != area.id), area];
  }

  @override
  Stream<List<Area>> watchByServer(int serverId) => Stream.value(captured);
}

class _FakeEntityRepo implements IEntityRepository {
  int syncs = 0;
  List<HaEntity> captured = const [];

  @override
  Future<List<HaEntity>> getByServer(int serverId) async => captured;

  @override
  Future<void> syncAll({
    required int serverId,
    required List<HaEntity> entities,
  }) async {
    syncs += 1;
    captured = entities;
  }

  @override
  Stream<List<HaEntity>> watchByServer(int serverId) => Stream.value(captured);
}

void main() {
  logger = testLogger;

  Future<ServerSyncState> waitForSync(
    ProviderContainer container,
    bool Function(ServerSyncState state) matches,
  ) async {
    for (var i = 0; i < 20; i += 1) {
      final state = container.read(serverSyncCoordinatorProvider);
      if (matches(state)) {
        return state;
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }

    final state = container.read(serverSyncCoordinatorProvider);
    fail('Timed out waiting for sync state. Last state: $state');
  }

  test('runs initial sync when session is online', () async {
    final areaRepo = _FakeAreaRepo();
    final entityRepo = _FakeEntityRepo();
    final connection = _FakeConnection();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: connection,
          ),
        ),
        areaRepositoryProvider.overrideWithValue(areaRepo),
        entityRepositoryProvider.overrideWithValue(entityRepo),
      ],
    );
    addTearDown(container.dispose);

    container.listen(serverSyncCoordinatorProvider, (_, _) {});

    final state = await waitForSync(container, (state) => state is SyncReady);

    expect(state, isA<SyncReady>());
    expect(areaRepo.syncs, 1);
    expect(areaRepo.captured.single.name, 'Kitchen');
    expect(entityRepo.syncs, 1);
    expect(entityRepo.captured.single.entityId, 'light.kitchen');
    expect(connection.subscriptions.length, 3);
  });

  test('does not start remote sync while offline', () async {
    final areaRepo = _FakeAreaRepo();
    final entityRepo = _FakeEntityRepo();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(activeServer: Server(id: 1, name: 'Home')),
        ),
        areaRepositoryProvider.overrideWithValue(areaRepo),
        entityRepositoryProvider.overrideWithValue(entityRepo),
      ],
    );
    addTearDown(container.dispose);

    final state = container.read(serverSyncCoordinatorProvider);

    expect(state, isA<SyncOfflineWithCache>());
    expect(areaRepo.syncs, 0);
    expect(entityRepo.syncs, 0);
  });
}
