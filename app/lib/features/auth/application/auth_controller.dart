import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/features/auth/application/login_flow_controller.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Dependencies([loginFlowController, serverLifecycleController])
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
    return ref.read(serverLifecycleControllerProvider).signOutServer(serverId);
  }
}

@Riverpod(
  keepAlive: true,
  dependencies: [loginFlowController, serverLifecycleController],
)
AuthController authController(Ref ref) {
  return AuthController(ref);
}
