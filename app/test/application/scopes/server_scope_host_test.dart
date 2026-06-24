import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/scopes/server_scope_host.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/application/command_availability_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

class _FakeConnection implements IHAConnection {
  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) => Future.value(null);

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    return HASubscription(logger: const NoOpLogger(), unsubscribe: () async {});
  }
}

class _ScopeProbe extends ConsumerWidget {
  const _ScopeProbe();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final server = ref.watch(serverScopeServerProvider);
    final id = ref.watch(serverScopeIdProvider);
    final connection = ref.watch(serverScopeConnectionProvider);

    return Text('${server.name}-$id-${connection.runtimeType}');
  }
}

class _ServerProbe extends ConsumerWidget {
  const _ServerProbe();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final server = ref.watch(serverScopeServerProvider);
    final id = ref.watch(serverScopeIdProvider);

    return Text('${server.name}-$id');
  }
}

class _CommandAvailabilityProbe extends ConsumerWidget {
  const _CommandAvailabilityProbe();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availability = ref.watch(commandAvailabilityProvider);

    return Text(availability.canSend ? 'sendable' : 'disabled');
  }
}

class _SessionSource {
  _SessionSource(this.state);

  ActiveServerSessionState state;
}

class _FakeActiveServerSession extends ActiveServerSession {
  _FakeActiveServerSession(this.source);

  final _SessionSource source;

  @override
  ActiveServerSessionState build() => source.state;

  void emit(ActiveServerSessionState state) {
    this.state = state;
  }
}

void main() {
  testWidgets('injects scoped server and connection for online session', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            OnlineServerSession(
              activeServer: const Server(id: 7, name: 'Home'),
              connection: _FakeConnection(),
            ),
          ),
        ],
        child: const MaterialApp(home: ServerScopeHost(child: _ScopeProbe())),
      ),
    );

    expect(find.textContaining('Home-7'), findsOneWidget);
  });

  testWidgets('injects server scope without connection for offline session', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            const OfflineServerSession(
              activeServer: Server(id: 7, name: 'Home'),
            ),
          ),
        ],
        child: const MaterialApp(home: ServerScopeHost(child: _ServerProbe())),
      ),
    );

    expect(find.text('Home-7'), findsOneWidget);
  });

  testWidgets('does not mount child when no server session exists', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            const NoActiveServerSession(),
          ),
        ],
        child: const MaterialApp(home: ServerScopeHost(child: _ScopeProbe())),
      ),
    );

    expect(find.byType(_ScopeProbe), findsNothing);
  });

  testWidgets(
    'updates scoped connection when same server moves from offline to online',
    (tester) async {
      final source = _SessionSource(
        const OfflineServerSession(activeServer: Server(id: 7, name: 'Home')),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            activeServerSessionProvider.overrideWith(
              () => _FakeActiveServerSession(source),
            ),
          ],
          child: const MaterialApp(
            home: ServerScopeHost(child: _CommandAvailabilityProbe()),
          ),
        ),
      );

      expect(find.text('disabled'), findsOneWidget);

      final notifier =
          ProviderScope.containerOf(
                tester.element(find.byType(_CommandAvailabilityProbe)),
              ).read(activeServerSessionProvider.notifier)
              as _FakeActiveServerSession;
      notifier.emit(
        OnlineServerSession(
          activeServer: const Server(id: 7, name: 'Home'),
          connection: _FakeConnection(),
        ),
      );
      await tester.pump();

      expect(find.text('sendable'), findsOneWidget);
    },
  );
}
