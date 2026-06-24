import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/settings/application/active_server_areas_provider.dart';

class _Connection implements IHAConnection {
  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) => Future.value(null);

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    throw UnimplementedError();
  }
}

class _AreaRepository implements IAreaRepository {
  @override
  Stream<List<Area>> watchByServer(int serverId) {
    return Stream.value([Area(id: 'server-$serverId', name: 'Kitchen')]);
  }

  @override
  Future<List<Area>> getByServer(int serverId) async => const [];

  @override
  Future<Area?> getByHaId({
    required int serverId,
    required String haId,
  }) async => null;

  @override
  Future<void> syncAll({
    required int serverId,
    required List<Area> areas,
  }) async {}

  @override
  Future<void> upsert({required int serverId, required Area area}) async {}
}

void main() {
  test(
    'returns cached active-server areas and editable online state',
    () async {
      final container = ProviderContainer(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            OnlineServerSession(
              activeServer: const Server(id: 5, name: 'Home'),
              connection: _Connection(),
            ),
          ),
          areaRepositoryProvider.overrideWithValue(_AreaRepository()),
        ],
      );
      addTearDown(container.dispose);

      final subscription = container.listen(
        activeServerAreasProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      final state = await container.read(activeServerAreasProvider.future);

      expect(state.canEdit, isTrue);
      expect(state.areas.single.id, 'server-5');
    },
  );

  test('returns cached active-server areas read-only while offline', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(activeServer: Server(id: 5, name: 'Home')),
        ),
        areaRepositoryProvider.overrideWithValue(_AreaRepository()),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(activeServerAreasProvider, (_, _) {});
    addTearDown(subscription.close);

    final state = await container.read(activeServerAreasProvider.future);

    expect(state.canEdit, isFalse);
    expect(state.areas.single.name, 'Kitchen');
  });
}
