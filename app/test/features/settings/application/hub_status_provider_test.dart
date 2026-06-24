import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/settings/application/hub_status_provider.dart';
import 'package:hommie/features/settings/domain/repository/i_device_info_repository.dart';
import 'package:hommie/features/settings/infrastructure/providers/device_info_repository_provider.dart';

class _FakeDeviceInfoRepository implements IDeviceInfoRepository {
  @override
  Future<String> getDeviceName() async => 'Test device';
}

class _FakeConnection implements IHAConnection {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  test('maps offline session to disconnected hub status', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(activeServer: Server(id: 1, name: 'Home')),
        ),
        authStateProvider.overrideWith(
          (_) => const AuthState.unauthenticated(),
        ),
        deviceInfoRepositoryProvider.overrideWithValue(
          _FakeDeviceInfoRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(hubStatusProvider.future);

    expect(state.server?.name, 'Home');
    expect(state.connectionStatus.kind, HubConnectionStatusKind.offline);
    expect(state.connectionStatus.label, 'Disconnected');
    expect(state.connectionStatus.description, 'Not connected to server');
    expect(state.isOffline, isTrue);
    expect(state.deviceName, 'Test device');
  });

  test('maps connecting session to connecting hub status', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const ConnectingServerSession(Server(id: 1, name: 'Home')),
        ),
        authStateProvider.overrideWith(
          (_) => const AuthState.unauthenticated(),
        ),
        deviceInfoRepositoryProvider.overrideWithValue(
          _FakeDeviceInfoRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(hubStatusProvider.future);

    expect(state.server?.name, 'Home');
    expect(state.connectionStatus.kind, HubConnectionStatusKind.connecting);
    expect(state.connectionStatus.label, 'Connecting');
    expect(state.connectionStatus.description, 'Connecting to server...');
    expect(state.isOnline, isFalse);
    expect(state.isOffline, isFalse);
  });

  test(
    'maps resolving session to connecting hub status without server',
    () async {
      final container = ProviderContainer(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            const ResolvingServerSession(),
          ),
          authStateProvider.overrideWith(
            (_) => const AuthState.unauthenticated(),
          ),
          deviceInfoRepositoryProvider.overrideWithValue(
            _FakeDeviceInfoRepository(),
          ),
        ],
      );
      addTearDown(container.dispose);

      final state = await container.read(hubStatusProvider.future);

      expect(state.server, isNull);
      expect(state.connectionStatus.kind, HubConnectionStatusKind.connecting);
      expect(state.connectionStatus.label, 'Connecting');
      expect(state.connectionStatus.description, 'Connecting to server...');
      expect(state.isOnline, isFalse);
      expect(state.isOffline, isFalse);
    },
  );

  test(
    'maps no active session to no-active hub status without server',
    () async {
      final container = ProviderContainer(
        overrides: [
          activeServerSessionProvider.overrideWithValue(
            const NoActiveServerSession(),
          ),
          authStateProvider.overrideWith(
            (_) => const AuthState.unauthenticated(),
          ),
          deviceInfoRepositoryProvider.overrideWithValue(
            _FakeDeviceInfoRepository(),
          ),
        ],
      );
      addTearDown(container.dispose);

      final state = await container.read(hubStatusProvider.future);

      expect(state.server, isNull);
      expect(state.connectionStatus.kind, HubConnectionStatusKind.noActive);
      expect(state.connectionStatus.label, 'Unknown');
      expect(state.connectionStatus.description, 'Connection status unknown');
      expect(state.isOnline, isFalse);
      expect(state.isOffline, isFalse);
    },
  );

  test('maps online session to connected hub status', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: _FakeConnection(),
          ),
        ),
        authStateProvider.overrideWith(
          (_) => const AuthState.unauthenticated(),
        ),
        deviceInfoRepositoryProvider.overrideWithValue(
          _FakeDeviceInfoRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(hubStatusProvider.future);

    expect(state.server?.name, 'Home');
    expect(state.connectionStatus.kind, HubConnectionStatusKind.online);
    expect(state.connectionStatus.label, 'Connected');
    expect(state.connectionStatus.description, 'Connected to Home Assistant');
    expect(state.isOnline, isTrue);
    expect(state.isOffline, isFalse);
  });

  test('maps auth-revoked session to auth failure hub status', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const AuthRevokedServerSession(Server(id: 1, name: 'Home')),
        ),
        authStateProvider.overrideWith((_) => const AuthState.revoked()),
        deviceInfoRepositoryProvider.overrideWithValue(
          _FakeDeviceInfoRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(hubStatusProvider.future);

    expect(state.server?.name, 'Home');
    expect(state.connectionStatus.kind, HubConnectionStatusKind.authRevoked);
    expect(state.connectionStatus.label, 'Auth failure');
    expect(state.connectionStatus.description, 'Authentication required');
    expect(state.isOnline, isFalse);
    expect(state.isOffline, isFalse);
  });
}
