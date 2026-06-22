import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hommie/core/infrastructure/actions/action_chain.dart';
import 'package:hommie/core/infrastructure/actions/action_runner.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/features/auth/application/login_flow_controller.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/auth/infrastructure/actions/activate_server_if_exist_action.dart';
import 'package:hommie/features/auth/infrastructure/actions/delete_server_action.dart';
import 'package:hommie/features/auth/infrastructure/actions/sign_out_server_action.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Dependencies([
  loginFlowController,
  websocketConfigRepository,
  serverConnectionManager,
])
class AuthController {
  final Ref ref;

  AuthController(this.ref);

  Future<void> login(ServerUrl serverUrl) async {
    await ref
        .read(loginFlowControllerProvider)
        .login(
          serverUrl,
          handler: (uri) async {
            final authenticateResult = await FlutterWebAuth2.authenticate(
              url: uri.toString(),
              callbackUrlScheme: LoginFlowController.redirectUrl.scheme,
            );
            return Uri.parse(authenticateResult).queryParameters;
          },
        );
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
  dependencies: [
    loginFlowController,
    websocketConfigRepository,
    serverConnectionManager,
  ],
)
AuthController authController(Ref ref) {
  return AuthController(ref);
}
