import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/application/area_registry_sync_service.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';

class _Connection implements IHAConnection {
  _Connection({Completer<List<Map<String, dynamic>>>? response})
    : _response = response;

  final Completer<List<Map<String, dynamic>>>? _response;

  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) {
    expect(message, isA<HARequestMessage>());
    expect((message as HARequestMessage).type, 'config/area_registry/list');
    if (_response != null) {
      return _response.future;
    }
    return Future.value([
      {
        'created_at': 1.0,
        'modified_at': 1.0,
        'area_id': 'office',
        'name': 'Office',
        'aliases': <String>[],
        'labels': <String>[],
      },
    ]);
  }

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    throw UnimplementedError();
  }
}

class _AreaRepository implements IAreaRepository {
  int? syncedServerId;
  List<Area>? syncedAreas;

  @override
  Future<void> syncAll({
    required int serverId,
    required List<Area> areas,
  }) async {
    syncedServerId = serverId;
    syncedAreas = areas;
  }

  @override
  Stream<List<Area>> watchByServer(int serverId) => Stream.value(const []);

  @override
  Future<List<Area>> getByServer(int serverId) async => const [];

  @override
  Future<Area?> getByHaId({
    required int serverId,
    required String haId,
  }) async => null;

  @override
  Future<void> upsert({required int serverId, required Area area}) async {}
}

void main() {
  test('refresh fetches remote areas and syncs repository', () async {
    final repo = _AreaRepository();
    final container = ProviderContainer(
      overrides: [areaRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    await container
        .read(areaRegistrySyncServiceProvider)
        .refresh(serverId: 7, connection: _Connection());

    expect(repo.syncedServerId, 7);
    expect(repo.syncedAreas!.single.id, 'office');
    expect(repo.syncedAreas!.single.name, 'Office');
  });

  test('refresh skips sync when guard rejects after remote fetch', () async {
    final response = Completer<List<Map<String, dynamic>>>();
    final repo = _AreaRepository();
    final container = ProviderContainer(
      overrides: [areaRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    var shouldSync = true;
    final refresh = container
        .read(areaRegistrySyncServiceProvider)
        .refresh(
          serverId: 7,
          connection: _Connection(response: response),
          shouldSync: () => shouldSync,
        );

    shouldSync = false;
    response.complete([
      {
        'created_at': 1.0,
        'modified_at': 1.0,
        'area_id': 'office',
        'name': 'Office',
        'aliases': <String>[],
        'labels': <String>[],
      },
    ]);
    await refresh;

    expect(repo.syncedServerId, isNull);
    expect(repo.syncedAreas, isNull);
  });
}
