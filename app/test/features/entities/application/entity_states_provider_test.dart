import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

class _FakeConnection implements IHAConnection {
  final subscriptions = <HASubscription>[];

  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) => Future.value(null);

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

void main() {
  test('does not subscribe while session is offline', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(activeServer: Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(entityStatesProvider), isEmpty);
  });

  test('subscribes and applies updates while session is online', () async {
    final connection = _FakeConnection();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: connection,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    container.listen(entityStatesProvider, (_, _) {});

    expect(connection.subscriptions, hasLength(1));

    connection.subscriptions.single.emit(
      StatesUpdates(add: {'light.kitchen': EntityState(state: 'on')}),
    );
    await container.pump();

    final states = container.read(entityStatesProvider);
    expect(states['light.kitchen']?.state, 'on');
  });
}
