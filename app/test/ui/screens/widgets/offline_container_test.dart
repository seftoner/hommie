import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/session_status_projections.dart';
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
  test('projection shows banner for offline session', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(activeServer: Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(offlineBannerVisibilityProvider), isTrue);
  });

  test('projection shows banner for connecting session', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const ConnectingServerSession(Server(id: 1, name: 'Home')),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(offlineBannerVisibilityProvider), isTrue);
  });

  test('projection hides banner for online session', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: _FakeConnection(),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(offlineBannerVisibilityProvider), isFalse);
  });

  test('projection hides banner for no active session', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const NoActiveServerSession(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(offlineBannerVisibilityProvider), isFalse);
  });

  test('projection hides banner for resolving session', () {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const ResolvingServerSession(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(offlineBannerVisibilityProvider), isFalse);
  });

  testWidgets('shows banner for offline session', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [offlineBannerVisibilityProvider.overrideWithValue(true)],
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
        overrides: [offlineBannerVisibilityProvider.overrideWithValue(false)],
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
