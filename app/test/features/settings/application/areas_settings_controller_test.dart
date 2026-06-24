import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/settings/application/areas_settings_controller.dart';
import 'package:hommie/features/settings/application/areas_settings_state.dart';

class _Connection implements IHAConnection {
  _Connection({Completer<Map<String, dynamic>?>? commandResponse})
    : _commandResponse = commandResponse;

  final Completer<Map<String, dynamic>?>? _commandResponse;
  final requests = <HARequestMessage>[];

  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) {
    final request = message as HARequestMessage;
    requests.add(request);

    return switch (request.type) {
      'config/area_registry/create' =>
        _commandResponse?.future ??
            Future.value(
              _areaJson(areaId: 'office', name: request.body['name'] as String),
            ),
      'config/area_registry/update' => Future.value(
        _areaJson(
          areaId: request.body['area_id'] as String,
          name: request.body['name'] as String,
        ),
      ),
      'config/area_registry/delete' => Future.value(null),
      'config/area_registry/list' => Future.value([
        _areaJson(areaId: 'kitchen', name: 'Kitchen'),
      ]),
      _ => throw StateError('Unexpected request: ${request.type}'),
    };
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
  Stream<List<Area>> watchByServer(int serverId) => Stream.value(const []);

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
  }) async {
    syncedServerId = serverId;
    syncedAreas = areas;
  }

  @override
  Future<void> upsert({required int serverId, required Area area}) async {}
}

Map<String, dynamic> _areaJson({required String areaId, required String name}) {
  return {
    'created_at': 1.0,
    'modified_at': 1.0,
    'area_id': areaId,
    'name': name,
    'aliases': <String>[],
    'labels': <String>[],
  };
}

ProviderContainer _container({
  required ActiveServerSessionState session,
  required _AreaRepository repository,
}) {
  final container = ProviderContainer(
    overrides: [
      activeServerSessionProvider.overrideWithValue(session),
      areaRepositoryProvider.overrideWithValue(repository),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('create sends area registry create then refreshes list', () async {
    final connection = _Connection();
    final repository = _AreaRepository();
    final container = _container(
      session: OnlineServerSession(
        activeServer: const Server(id: 5, name: 'Home'),
        connection: connection,
      ),
      repository: repository,
    );

    await container
        .read(areasSettingsControllerProvider.notifier)
        .create(' Office ');

    expect(connection.requests.map((request) => request.type), [
      'config/area_registry/create',
      'config/area_registry/list',
    ]);
    expect(connection.requests.first.body['name'], 'Office');
    expect(repository.syncedServerId, 5);
    expect(repository.syncedAreas!.single.name, 'Kitchen');
  });

  test('rename sends area registry update then refreshes list', () async {
    final connection = _Connection();
    final repository = _AreaRepository();
    final container = _container(
      session: OnlineServerSession(
        activeServer: const Server(id: 5, name: 'Home'),
        connection: connection,
      ),
      repository: repository,
    );

    await container
        .read(areasSettingsControllerProvider.notifier)
        .rename(areaId: 'office', name: ' Work room ');

    expect(connection.requests.map((request) => request.type), [
      'config/area_registry/update',
      'config/area_registry/list',
    ]);
    expect(connection.requests.first.body, {
      'area_id': 'office',
      'name': 'Work room',
    });
    expect(repository.syncedServerId, 5);
    expect(repository.syncedAreas!.single.id, 'kitchen');
  });

  test('delete sends area registry delete then refreshes list', () async {
    final connection = _Connection();
    final repository = _AreaRepository();
    final container = _container(
      session: OnlineServerSession(
        activeServer: const Server(id: 5, name: 'Home'),
        connection: connection,
      ),
      repository: repository,
    );

    await container
        .read(areasSettingsControllerProvider.notifier)
        .delete(areaId: 'office');

    expect(connection.requests.map((request) => request.type), [
      'config/area_registry/delete',
      'config/area_registry/list',
    ]);
    expect(connection.requests.first.body, {'area_id': 'office'});
    expect(repository.syncedServerId, 5);
    expect(repository.syncedAreas!.single.name, 'Kitchen');
  });

  test('offline create throws unavailable failure', () async {
    final repository = _AreaRepository();
    final container = _container(
      session: const OfflineServerSession(
        activeServer: Server(id: 5, name: 'Home'),
      ),
      repository: repository,
    );

    await expectLater(
      container.read(areasSettingsControllerProvider.notifier).create('Office'),
      throwsA(isA<AreasSettingsUnavailable>()),
    );
  });

  test('create can complete after listeners are disposed', () async {
    final commandResponse = Completer<Map<String, dynamic>?>();
    final connection = _Connection(commandResponse: commandResponse);
    final repository = _AreaRepository();
    final container = _container(
      session: OnlineServerSession(
        activeServer: const Server(id: 5, name: 'Home'),
        connection: connection,
      ),
      repository: repository,
    );

    final subscription = container.listen(
      areasSettingsControllerProvider,
      (_, _) {},
    );
    final create = container
        .read(areasSettingsControllerProvider.notifier)
        .create('Office');

    subscription.close();
    commandResponse.complete(_areaJson(areaId: 'office', name: 'Office'));

    await expectLater(create, completes);
    expect(connection.requests.map((request) => request.type), [
      'config/area_registry/create',
      'config/area_registry/list',
    ]);
  });
}
