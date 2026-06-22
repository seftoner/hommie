import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/scopes/server_scope_host.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
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
}
