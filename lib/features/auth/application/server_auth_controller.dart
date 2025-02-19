import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/tasks/activate_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/create_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/get_config_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/oauth_login_attempt_task.dart';
import 'package:hommie/features/server_manager/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/shared/domain/models/task_chain.dart';
import 'package:hommie/features/shared/infrastructure/runner/task_executor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_auth_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
class ServerAuthController extends _$ServerAuthController {
  @override
  Future<AuthState> build(int serverId) async {
    return const AuthState.initial();
  }

  Future<void> initialize(int serverId) async {
    final serverManager = ref.read(serverManagerProvider);
    final repository = serverManager.getAuthRepository(serverId);
    final credentialsOrFailure = await repository.getCredentials();

    state = await credentialsOrFailure.fold(
      (failure) async {
        switch (failure) {
          case MissingCredentials():
            return const AsyncData(AuthState.unauthenticated());
          case InvalidToken():
            signOut(serverId);
            return AsyncData(AuthState.failure(failure));
          case Connection():
            // Allow access if we have stored credentials
            final isLoggedIn = await repository.isLoggedIn();
            if (isLoggedIn) {
              return const AsyncData(AuthState.authenticated());
            }
            return AsyncData(AuthState.failure(failure));
          default:
            logger.e('Authentication failure: $failure');
            return AsyncData(AuthState.failure(failure));
        }
      },
      (credentials) async {
        return const AsyncData(AuthState.authenticated());
      },
    );
  }

  Future<void> signOut(int serverId) async {
    logger.i('Sign out server $serverId');
    final serverManager = ref.read(serverManagerProvider);
    final repository = serverManager.getAuthRepository(serverId);

    await repository.signOut();
    // ref.read(serverConnectionStateProvider(serverId).notifier).remove(serverId);

    state = const AsyncData(AuthState.unauthenticated());
  }

  Future<void> login(String haServerURL) async {
    final serverManager = ref.read(serverManagerProvider);

    final loginAction = TaskChain.builder()
        .withContext('serverUrl', haServerURL)
        .addTask(CreateServerTask(serverManager))
        .addTask(OAuthLoginAttemptTask(serverManager))
        .addTask(GetConfigTask(serverManager))
        .addTask(ActivateServerTask(ref))
        .onTaskError<OAuthLoginAttemptTask, AuthFailure>((error) {
          state = AsyncData(AuthState.failure(error));
        })
        .onAnyError((error) => logger.e('An error occurred: $error'))
        .onSuccess(() => state = const AsyncData(AuthState.authenticated()))
        .build();

    await TaskExecutor(loginAction).execute();
  }
}
