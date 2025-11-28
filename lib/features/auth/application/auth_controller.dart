import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/tasks/activate_server_if_exist_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/activate_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/create_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/delete_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/get_config_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/oauth_login_attempt_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/sign_out_server_task.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';
import 'package:hommie/features/shared/domain/models/task_chain.dart';
import 'package:hommie/features/shared/infrastructure/runner/task_executor.dart';
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

    final loginAction = TaskChain.builder()
        .withContext('serverUrl', serverUrl)
        .addTask(CreateServerTask(serverManager))
        .addTask(OAuthLoginAttemptTask(authRepository))
        .addTask(GetConfigTask(serverManager, ref))
        .addTask(ActivateServerTask(serverManager))
        .onAnyError((failure) {
          logger.e('Auth failure occurred: $failure');
        })
        .build();

    await TaskExecutor(loginAction).execute();
  }

  Future<void> signOut(int serverId) async {
    final serverManager = ref.read(serverManagerProvider);
    final serverConnectionManager = ref.read(serverConnectionManagerProvider);
    final authRepository = ref.read(authRepositoryProvider);

    final signOutAction = TaskChain.builder()
        .withContext('serverId', serverId)
        .addTask(SignOutServerTask(authRepository, serverConnectionManager))
        .addTask(DeleteServerTask(serverManager, ref))
        .addTask(ActivateServerIfExistTask(serverManager))
        .onAnyError((failure) {
          logger.e('Sign out failure occurred: $failure');
        })
        .build();

    await TaskExecutor(signOutAction).execute();
  }
}

@Riverpod(dependencies: [websocketConfigRepository, serverConnectionManager])
AuthController authController(Ref ref) {
  return AuthController(ref);
}
