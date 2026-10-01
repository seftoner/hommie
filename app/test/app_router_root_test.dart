import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/auth_revocation_handler.dart';
import 'package:hommie/application/session/network_reconnect_supervisor.dart';
import 'package:hommie/application/session/session_status_projections.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/ui/screens/widgets/offline_container.dart';
import 'package:material_ui/material_ui.dart' as material;

void main() {
  testWidgets('standalone app root keeps routes inside offline container', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/first',
      routes: [
        GoRoute(path: '/first', builder: (_, _) => const Text('First route')),
        GoRoute(path: '/next', builder: (_, _) => const Text('Next route')),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            const NoActiveServerSession(),
          ),
          authRevocationHandlerProvider.overrideWithValue(null),
          networkReconnectSupervisorProvider.overrideWithValue(null),
          offlineBannerVisibilityProvider.overrideWithValue(false),
          goRouterProvider.overrideWithValue(router),
        ],
        child: const HommieApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(material.MaterialApp), findsOneWidget);
    expect(find.text('First route'), findsOneWidget);
    expect(
      find.ancestor(
        of: find.text('First route'),
        matching: find.byType(OfflineContainer),
      ),
      findsOneWidget,
    );

    router.go('/next');
    await tester.pumpAndSettle();
    expect(find.text('Next route'), findsOneWidget);
    expect(
      find.ancestor(
        of: find.text('Next route'),
        matching: find.byType(OfflineContainer),
      ),
      findsOneWidget,
    );
  });
}
