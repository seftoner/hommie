import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/settings/application/hub_status_provider.dart';
import 'package:hommie/features/settings/presentation/screens/hub_page.dart';

void main() {
  testWidgets('shows connecting status for resolving session without server', (
    tester,
  ) async {
    await tester.pumpHubPage(
      const HubStatusState(
        connectionStatus: HubConnectionStatus(
          kind: HubConnectionStatusKind.connecting,
          label: 'Connecting',
          description: 'Connecting to server...',
          server: null,
        ),
        authState: AuthState.unauthenticated(),
        deviceName: 'Test device',
      ),
    );

    expect(find.text('No active server'), findsNothing);
    expect(find.text('Connecting'), findsWidgets);
    expect(find.text('Connecting to server...'), findsOneWidget);
  });

  testWidgets(
    'renders external-only server without requiring internal or base URL',
    (tester) async {
      await tester.pumpHubPage(
        const HubStatusState(
          connectionStatus: HubConnectionStatus(
            kind: HubConnectionStatusKind.offline,
            label: 'Disconnected',
            description: 'Not connected to server',
            server: Server(
              id: 1,
              name: 'Home',
              externalUrl: 'https://home.example.com',
            ),
          ),
          authState: AuthState.unauthenticated(),
          deviceName: 'Test device',
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.text('External URL'), findsWidgets);
      expect(find.text('https://home.example.com'), findsOneWidget);
      expect(find.text('Internal URL'), findsOneWidget);
      expect(find.text('Not configured'), findsOneWidget);
    },
  );
}

extension on WidgetTester {
  Future<void> pumpHubPage(HubStatusState status) async {
    await pumpWidget(
      ProviderScope(
        overrides: [hubStatusProvider.overrideWith((_) async => status)],
        child: const MaterialApp(home: HubPage()),
      ),
    );
    await pumpAndSettle();
  }
}
