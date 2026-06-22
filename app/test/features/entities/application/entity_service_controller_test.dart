import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/entities/application/entity_service_controller.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

class _CapturingConnection implements IHAConnection {
  HARequestMessage? sent;

  @override
  HAResponse sendMessage(HAMessage message) async {
    sent = message as HARequestMessage;
    return {
      'context': {'id': 'x'},
    };
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  test('call derives domain and targets the entity', () async {
    final conn = _CapturingConnection();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: conn,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final controller = container.read(entityServiceControllerProvider);

    await controller.call('light.kitchen', 'toggle');

    expect(conn.sent!.type, 'call_service');
    final body = conn.sent!.body;
    expect(body['domain'], 'light');
    expect(body['service'], 'toggle');
    expect(body['target'], {'entity_id': 'light.kitchen'});
  });

  test('domainOverride and data are forwarded', () async {
    final conn = _CapturingConnection();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: conn,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final controller = container.read(entityServiceControllerProvider);

    await controller.call(
      'light.kitchen',
      'turn_on',
      domainOverride: 'homeassistant',
      data: {'brightness': 128},
    );

    final body = conn.sent!.body;
    expect(body['domain'], 'homeassistant');
    expect(body['service'], 'turn_on');
    expect(body['service_data'], {'brightness': 128});
  });

  test('call fails while session is offline', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(activeServer: Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(entityServiceControllerProvider);

    await expectLater(
      controller.call('light.kitchen', 'toggle'),
      throwsA(isA<ConnectionClosedError>()),
    );
  });
}
