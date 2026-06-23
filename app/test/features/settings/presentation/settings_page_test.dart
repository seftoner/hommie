import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/features/settings/presentation/screens/settings_page.dart';
import 'package:hommie/ui/keys.dart';

class _FakeServerLifecycleController implements IServerLifecycleController {
  _FakeServerLifecycleController({this.signOutFailure});

  final Exception? signOutFailure;

  @override
  Future<void> deleteServer(int serverId) async {}

  @override
  Future<void> signOutActiveServer() async {
    final failure = signOutFailure;
    if (failure != null) {
      throw failure;
    }
  }

  @override
  Future<void> signOutServer(int serverId) async {}
}

void main() {
  testWidgets('shows snackbar when sign out fails', (tester) async {
    final lifecycle = _FakeServerLifecycleController(
      signOutFailure: Exception('boom'),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          serverLifecycleControllerProvider.overrideWithValue(lifecycle),
        ],
        child: const MaterialApp(home: SettingsPage()),
      ),
    );

    await tester.tap(find.byKey(K.hub.signOutButton));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TextButton, 'Sign Out'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Failed to sign out:'), findsOneWidget);
  });
}
