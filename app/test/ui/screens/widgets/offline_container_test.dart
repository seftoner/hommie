import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/screens/widgets/offline_container.dart';

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

void main() {
  testWidgets('shows banner for offline session', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            const OfflineServerSession(
              activeServer: Server(id: 1, name: 'Home'),
            ),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(body: OfflineContainer(child: Text('content'))),
        ),
      ),
    );

    final banner = tester.widget<AnimatedAlign>(
      find.ancestor(
        of: find.byKey(K.common.offlineBanner),
        matching: find.byType(AnimatedAlign),
      ),
    );
    expect(banner.heightFactor, 1);
  });

  testWidgets('hides banner for online session', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            OnlineServerSession(
              activeServer: const Server(id: 1, name: 'Home'),
              connection: _FakeConnection(),
            ),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(body: OfflineContainer(child: Text('content'))),
        ),
      ),
    );

    final banner = tester.widget<AnimatedAlign>(
      find.ancestor(
        of: find.byKey(K.common.offlineBanner),
        matching: find.byType(AnimatedAlign),
      ),
    );
    expect(banner.heightFactor, 0);
  });
}
