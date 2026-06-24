import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/home/application/areas_for_server_provider.dart';
import 'package:hommie/features/home/application/cached_areas_provider.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';

class _FakeAreaRepository implements IAreaRepository {
  int? watchedServerId;
  final _controller = StreamController<List<Area>>();

  @override
  Stream<List<Area>> watchByServer(int serverId) {
    watchedServerId = serverId;
    return _controller.stream;
  }

  @override
  Future<List<Area>> getByServer(int serverId) async => const [];

  @override
  Future<Area?> getByHaId({
    required int serverId,
    required String haId,
  }) async => null;

  @override
  Future<void> upsert({required int serverId, required Area area}) async {}

  @override
  Future<void> syncAll({
    required int serverId,
    required List<Area> areas,
  }) async {}

  void emit(List<Area> areas) => _controller.add(areas);

  Future<void> close() => _controller.close();
}

void main() {
  test('areasForServer watches repository by explicit server id', () async {
    final repo = _FakeAreaRepository();
    final container = ProviderContainer(
      overrides: [areaRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(repo.close);
    addTearDown(container.dispose);

    final subscription = container.listen(
      areasForServerProvider(42),
      (_, _) {},
    );
    addTearDown(subscription.close);

    repo.emit(const [Area(id: 'kitchen', name: 'Kitchen')]);
    final areas = await container.read(areasForServerProvider(42).future);

    expect(repo.watchedServerId, 42);
    expect(areas.single.name, 'Kitchen');
  });

  test('cachedAreas forwards live updates for scoped server id', () async {
    final repo = _FakeAreaRepository();
    final container = ProviderContainer(
      overrides: [
        areaRepositoryProvider.overrideWithValue(repo),
        serverScopeIdProvider.overrideWithValue(7),
      ],
    );
    addTearDown(repo.close);
    addTearDown(container.dispose);

    final values = <List<Area>>[];
    final subscription = container.listen(
      cachedAreasProvider,
      (_, next) => next.whenData(values.add),
    );
    addTearDown(subscription.close);

    repo.emit(const [Area(id: 'kitchen', name: 'Kitchen')]);
    await expectLater(
      container.read(cachedAreasProvider.future),
      completion(hasLength(1)),
    );

    repo.emit(const [Area(id: 'office', name: 'Office')]);
    await expectLater(
      Stream.periodic(
        Duration.zero,
        (_) => values.length,
      ).firstWhere((length) => length == 2).timeout(const Duration(seconds: 1)),
      completion(2),
    );

    expect(repo.watchedServerId, 7);
    expect(values.first.single.name, 'Kitchen');
    expect(values.last.single.name, 'Office');
  });

  test('cachedAreas emits current area value for late subscribers', () async {
    final repo = _FakeAreaRepository();
    final container = ProviderContainer(
      overrides: [
        areaRepositoryProvider.overrideWithValue(repo),
        serverScopeIdProvider.overrideWithValue(7),
      ],
    );
    addTearDown(repo.close);
    addTearDown(container.dispose);

    final explicitSubscription = container.listen(
      areasForServerProvider(7),
      (_, _) {},
    );
    addTearDown(explicitSubscription.close);

    repo.emit(const [Area(id: 'kitchen', name: 'Kitchen')]);
    await expectLater(
      container.read(areasForServerProvider(7).future),
      completion(hasLength(1)),
    );

    final cachedSubscription = container.listen(cachedAreasProvider, (_, _) {});
    addTearDown(cachedSubscription.close);

    final cachedAreas = await container.read(cachedAreasProvider.future);

    expect(cachedAreas.single.name, 'Kitchen');
  });
}
