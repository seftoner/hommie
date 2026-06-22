import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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

void main() {
  test('uses active session state for hub status', () async {
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
    expect(state.isOffline, isTrue);
    expect(state.deviceName, 'Test device');
  });
}
