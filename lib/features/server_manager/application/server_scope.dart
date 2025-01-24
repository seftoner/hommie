import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/auth_state_handler.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/repositories/secure_credentials_storage.dart';
import 'package:hommie/features/server_manager/application/server_manager.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/services/networking/server_connection_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';

class ServerScope extends ConsumerWidget {
  final Widget child;

  const ServerScope({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverState = ref.watch(serverManagerProvider);
    // final router = ref.read(goRouterProvider);

    return serverState.when(
      data: (server) {
        if (server == null) {
          // return const ServerSetupScreen();
        }

        final credentialsStorage = SecureCredentialRepository(
            const FlutterSecureStorage(), server!.id);

        return ProviderScope(
          overrides: [
            // credentialsRepositoryProvider.overrideWith(
            //   (ref) {
            //     ref.
            //     return SecureCredentialRepository(const FlutterSecureStorage(), server.id!);
            //     // return ref.read(credentialsRepositoryProvider(server.id!));
            //   },
            // ),

            credentialsRepositoryProvider.overrideWithValue(
              credentialsStorage,
            ),

            // serverConnectionProvider
            //     .overrideWith((ref) {

            //     }),
            // authStateHandlerProvider.overrideWithValue(AuthState(server)),
            // connectionStateProvider.overrideWithValue(ConnectionState(server)),
          ],
          child: child,
        );
      },
      loading: () => const LoadingScreen(),
      error: (e, s) => ErrorScreen(error: e),
    );
  }
}
