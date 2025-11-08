import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/auth_state_machine.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_auth_state_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [ActiveServer, AuthStateMachine])
AsyncValue<AuthState> activeAuthState(Ref ref) {
  final activeServer = ref.watch(activeServerProvider);

  return activeServer.when(
    data: (server) {
      if (server?.id == null) {
        return const AsyncData(AuthState.unauthenticated());
      }
      return ref.watch(authStateMachineProvider(server!.id!));
    },
    loading: () => const AsyncLoading(),
    error: (error, stackTrace) => AsyncError(error, stackTrace),
  );
}
