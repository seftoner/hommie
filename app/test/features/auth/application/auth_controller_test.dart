import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';

class _FakeServerLifecycleController implements IServerLifecycleController {
  final signOutCalls = <int>[];

  @override
  Future<void> deleteServer(int serverId) async {}

  @override
  Future<void> signOutActiveServer() async {}

  @override
  Future<void> signOutServer(int serverId) async {
    signOutCalls.add(serverId);
  }
}

void main() {
  test('signOut delegates to server lifecycle controller', () async {
    final lifecycle = _FakeServerLifecycleController();
    final container = ProviderContainer(
      overrides: [
        serverLifecycleControllerProvider.overrideWithValue(lifecycle),
      ],
    );
    addTearDown(container.dispose);

    await container.read(authControllerProvider).signOut(1);

    expect(lifecycle.signOutCalls, [1]);
  });
}
