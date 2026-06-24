import 'dart:async';

import 'package:home_assistant_client/src/connection/backoff.dart';
import 'package:home_assistant_client/src/connection/connection_orchestrator.dart';
import 'package:home_assistant_client/src/connection/ha_socket_state.dart';
import 'package:home_assistant_client/src/logging/logger_interface.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'fakes/fake_ha_socket.dart';
import 'ha_connection_test.mocks.dart';

void main() {
  late MockHAConnectionOption options;
  late List<FakeHASocket> sockets;

  setUp(() {
    options = MockHAConnectionOption();
    sockets = <FakeHASocket>[];

    when(options.logger).thenReturn(const NoOpLogger());
    when(options.createSocket()).thenAnswer((_) async {
      final socket = FakeHASocket(initialState: const Authenticated());
      sockets.add(socket);
      return socket;
    });
  });

  test(
    'default mobile backoff retries immediately then caps at 30 seconds',
    () {
      final backoff = MobileReconnectBackoff(jitterFactor: 0);

      expect(backoff.next, Duration.zero);
      expect(backoff.next, const Duration(seconds: 1));
      expect(backoff.next, const Duration(seconds: 2));
      expect(backoff.next, const Duration(seconds: 5));
      expect(backoff.next, const Duration(seconds: 10));
      expect(backoff.next, const Duration(seconds: 30));
      expect(backoff.next, const Duration(seconds: 30));
    },
  );

  test('retryNow cancels pending backoff and reconnects immediately', () async {
    final orchestrator = ConnectionOrchestrator(
      options,
      const ConstantBackoff(Duration(milliseconds: 50)),
    );
    final states = <HASocketState>[];
    final subscription = orchestrator.state.listen(states.add);

    await orchestrator.connect();
    await Future<void>.delayed(Duration.zero);

    expect(sockets, hasLength(1));

    await sockets.single.closeFromServer();
    await Future<void>.delayed(Duration.zero);

    expect(states.whereType<Reconnecting>(), hasLength(1));
    expect(sockets, hasLength(1));

    orchestrator.retryNow();
    await Future<void>.delayed(Duration.zero);

    expect(sockets, hasLength(2));

    await Future<void>.delayed(const Duration(milliseconds: 80));

    expect(sockets, hasLength(2));
    await subscription.cancel();
    await orchestrator.close();
  });

  test('network unavailable pauses reconnect until network returns', () async {
    final orchestrator = ConnectionOrchestrator(
      options,
      const ConstantBackoff(Duration(milliseconds: 1)),
    );

    await orchestrator.connect();
    await Future<void>.delayed(Duration.zero);

    expect(sockets, hasLength(1));

    orchestrator.setNetworkAvailable(isAvailable: false);
    await sockets.single.closeFromServer();
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(sockets, hasLength(1));

    orchestrator.setNetworkAvailable(isAvailable: true);
    await Future<void>.delayed(Duration.zero);

    expect(sockets, hasLength(2));
    await orchestrator.close();
  });

  test('auth failure remains terminal for retryNow', () async {
    final orchestrator = ConnectionOrchestrator(
      options,
      const ConstantBackoff(Duration.zero),
    );

    await orchestrator.connect();
    await Future<void>.delayed(Duration.zero);

    expect(sockets, hasLength(1));

    sockets.single.setState(
      const Disconnected(type: DisconnectionType.authFailure),
    );
    await Future<void>.delayed(Duration.zero);

    orchestrator.retryNow();
    orchestrator.setNetworkAvailable(isAvailable: false);
    orchestrator.setNetworkAvailable(isAvailable: true);
    await Future<void>.delayed(Duration.zero);

    expect(sockets, hasLength(1));
    await orchestrator.close();
  });
}
