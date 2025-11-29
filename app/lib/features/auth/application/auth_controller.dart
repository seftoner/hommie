import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/actions/activate_server_if_exist_action.dart';
import 'package:hommie/features/auth/infrastructure/actions/activate_server_action.dart';
import 'package:hommie/features/auth/infrastructure/actions/create_server_action.dart';
import 'package:hommie/features/auth/infrastructure/actions/delete_server_action.dart';
import 'package:hommie/features/auth/infrastructure/actions/get_config_action.dart';
import 'package:hommie/features/auth/infrastructure/actions/oauth_login_attempt_action.dart';
import 'package:hommie/features/auth/infrastructure/actions/sign_out_server_action.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';
import 'package:hommie/core/infrastructure/actions/action_chain.dart';
import 'package:hommie/core/infrastructure/actions/action_runner.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Dependencies([websocketConfigRepository, serverConnectionManager])
class AuthController {
  final Ref ref;

  AuthController(this.ref);

  Future<void> login(String serverUrl) async {
    final serverManager = ref.read(serverManagerProvider);
    final authRepository = ref.read(authRepositoryProvider);

    final loginAction = ActionChain.builder()
        .withContext('serverUrl', serverUrl)
        .addAction(CreateServerAction(serverManager))
        .addAction(OAuthLoginAttemptAction(authRepository))
        .addAction(GetConfigAction(serverManager, ref))
        .addAction(ActivateServerAction(serverManager))
        .onAnyError((failure) {
          logger.e('Auth failure occurred: $failure');
        })
        .build();

    await ActionRunner(loginAction).run();
  }

  Future<void> signOut(int serverId) async {
    final serverManager = ref.read(serverManagerProvider);
    final serverConnectionManager = ref.read(serverConnectionManagerProvider);
    final authRepository = ref.read(authRepositoryProvider);

    final signOutAction = ActionChain.builder()
        .withContext('serverId', serverId)
        .addAction(SignOutServerAction(authRepository, serverConnectionManager))
        .addAction(DeleteServerAction(serverManager, ref))
        .addAction(ActivateServerIfExistAction(serverManager))
        .onAnyError((failure) {
          logger.e('Sign out failure occurred: $failure');
        })
        .build();

    await ActionRunner(signOutAction).run();
  }
}

@Riverpod(
  keepAlive: true,
  dependencies: [websocketConfigRepository, serverConnectionManager],
)
AuthController authController(Ref ref) {
  return AuthController(ref);
}
