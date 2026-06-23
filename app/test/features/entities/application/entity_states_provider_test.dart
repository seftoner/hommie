import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:riverpod/misc.dart';

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

class _ThrowingSubscribeConnection implements IHAConnection {
  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) => Future.value(null);

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    throw StateError('subscribe setup broke');
  }
}

class _ClosedSubscribeConnection implements IHAConnection {
  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) => Future.value(null);

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    throw ConnectionClosedError('subscribe connection closed');
  }
}

Matcher _providerExceptionWith(Object exceptionMatcher) {
  return isA<ProviderException>().having(
    (error) => error.exception,
    'exception',
    exceptionMatcher,
  );
}

void main() {
  test('does not subscribe when scoped connection is unavailable', () {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWith(
          (_) => throw const ServerScopeConnectionUnavailableException(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(entityStatesProvider), isEmpty);
  });

  test('subscribes and applies updates while session is online', () async {
    final connection = _FakeConnection();
    final container = ProviderContainer(
      overrides: [serverScopeConnectionProvider.overrideWithValue(connection)],
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

  test('surfaces unrelated scoped connection provider failures', () {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWith(
          (_) => throw StateError('provider wiring broke'),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(
      () => container.read(entityStatesProvider),
      throwsA(_providerExceptionWith(isStateError)),
    );
  });

  test('surfaces unexpected subscribe setup failures', () {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWithValue(
          _ThrowingSubscribeConnection(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(
      () => container.read(entityStatesProvider),
      throwsA(_providerExceptionWith(isStateError)),
    );
  });

  test('surfaces closed connection subscribe setup failures', () {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWithValue(
          _ClosedSubscribeConnection(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(
      () => container.read(entityStatesProvider),
      throwsA(_providerExceptionWith(isA<ConnectionClosedError>())),
    );
  });
}
