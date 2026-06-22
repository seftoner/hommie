import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/entities/application/entity_registry_sync_controller.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/domain/repositories/i_entity_repository.dart';
import 'package:hommie/features/entities/infrastructure/providers/entity_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/providers/registry_repository_provider.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';

class _FakeRegistry implements HaRegistryRepository {
  @override
  Future<List<EntityRegistryRecord>> getEntities() async =>
      [const EntityRegistryRecord(entityId: 'light.a', areaId: 'kitchen')];

  @override
  Future<List<DeviceRegistryRecord>> getDevices() async => const [];
}

class _FakeEntityRepo implements IEntityRepository {
  final captured = <HaEntity>[];

  @override
  Future<void> syncAll({
    required int serverId,
    required List<HaEntity> entities,
  }) async {
    captured
      ..clear()
      ..addAll(entities);
  }

  @override
  Future<List<HaEntity>> getByServer(int serverId) async => captured;

  @override
  Stream<List<HaEntity>> watchByServer(int serverId) => Stream.value(captured);
}

class _UnusedConnection implements IHAConnection {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  ProviderContainer makeContainer({
    required HAServerConnectionState connectionState,
    required IEntityRepository entityRepo,
  }) {
    return ProviderContainer(
      overrides: [
        serverScopeIdProvider.overrideWithValue(1),
        serverScopeConnectionProvider.overrideWithValue(_UnusedConnection()),
        registryRepositoryProvider.overrideWithValue(_FakeRegistry()),
        entityRepositoryProvider.overrideWithValue(entityRepo),
        serverConnectionStateProvider.overrideWithValue(connectionState),
      ],
    );
  }

  test('does not sync when disconnected', () async {
    final repo = _FakeEntityRepo();
    final container = makeContainer(
      connectionState: HAServerConnectionState.disconnected,
      entityRepo: repo,
    );
    addTearDown(container.dispose);

    final status = container.read(entityRegistrySyncControllerProvider);
    expect(status, EntitySyncStatus.notStarted);
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(repo.captured, isEmpty);
  });

  test('initial sync writes resolved entities when connected', () async {
    final repo = _FakeEntityRepo();
    final container = makeContainer(
      connectionState: HAServerConnectionState.connected,
      entityRepo: repo,
    );
    addTearDown(container.dispose);

    container.read(entityRegistrySyncControllerProvider);
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(repo.captured.map((e) => e.entityId), ['light.a']);
    expect(repo.captured.single.areaId, 'kitchen');
  });
}
