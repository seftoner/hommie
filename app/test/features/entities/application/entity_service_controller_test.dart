import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/application/entity_service_controller.dart';

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
      overrides: [serverScopeConnectionProvider.overrideWithValue(conn)],
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
      overrides: [serverScopeConnectionProvider.overrideWithValue(conn)],
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

  test(
    'call throws typed unavailable exception when scoped connection is absent',
    () async {
      final container = ProviderContainer(
        overrides: [
          serverScopeConnectionProvider.overrideWith(
            (_) => throw const ServerScopeConnectionUnavailableException(),
          ),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(entityServiceControllerProvider);

      await expectLater(
        controller.call('light.kitchen', 'toggle'),
        throwsA(isA<RemoteCommandUnavailableException>()),
      );
    },
  );

  test('call surfaces unrelated scoped connection provider failures', () async {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWith(
          (_) => throw StateError('provider wiring broke'),
        ),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(entityServiceControllerProvider);

    await expectLater(
      controller.call('light.kitchen', 'toggle'),
      throwsA(isStateError),
    );
  });
}
