import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/application/command_availability_provider.dart';
import 'package:riverpod/misc.dart';

class _Connection implements IHAConnection {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

Matcher _providerExceptionWith(Object exceptionMatcher) {
  return isA<ProviderException>().having(
    (error) => error.exception,
    'exception',
    exceptionMatcher,
  );
}

void main() {
  test('live scoped connection is sendable', () {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWithValue(_Connection()),
      ],
    );
    addTearDown(container.dispose);

    final availability = container.read(commandAvailabilityProvider);

    expect(availability.canSend, isTrue);
    expect(availability.reason, CommandAvailabilityReason.available);
  });

  test('typed unavailable scoped connection is not sendable', () {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWith(
          (_) => throw const ServerScopeConnectionUnavailableException(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final availability = container.read(commandAvailabilityProvider);

    expect(availability.canSend, isFalse);
    expect(
      availability.reason,
      CommandAvailabilityReason.serverConnectionUnavailable,
    );
  });

  test('unrelated scoped connection provider failures surface', () {
    final container = ProviderContainer(
      overrides: [
        serverScopeConnectionProvider.overrideWith(
          (_) => throw StateError('provider wiring broke'),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(
      () => container.read(commandAvailabilityProvider),
      throwsA(_providerExceptionWith(isStateError)),
    );
  });
}
