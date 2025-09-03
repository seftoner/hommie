import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/tasks/activate_server_if_exist_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/activate_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/sign_out_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/create_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/delete_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/get_config_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/oauth_login_attempt_task.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/websocket_config_repository_provider.dart';
import 'package:hommie/features/shared/domain/models/task_chain.dart';
import 'package:hommie/features/shared/infrastructure/runner/task_executor.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_auth_controller.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [
    serverManager,
    authRepository,
    ServerConnectionManager,
    ServerConnectionState,
    ActiveServer,
    websocketConfigRepository,
  ],
)
class ServerAuthController extends _$ServerAuthController {
  @override
  Future<AuthState> build() async {
    return const AuthState.initial();
  }

  Future<void> initialize(int serverId) async {
    final authRepository = ref.read(authRepositoryProvider);
    final credentialsOrFailure = await authRepository.getCredentials(serverId);

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
            final isLoggedIn = await authRepository.isLoggedIn(serverId);
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
    final authRepository = ref.read(authRepositoryProvider);

    final signOutAction = TaskChain.builder()
        .withContext('serverId', serverId)
        .addTask(SignOutServerTask(authRepository, ref))
        .addTask(DeleteServerTask(serverManager, ref))
        .addTask(ActivateServerIfExistTask(serverManager, ref))
        .onAnyError((error) {
          logger.e('An error occurred during sign out: $error');
          state = AsyncData(
            AuthState.failure(AuthFailure.server(error.toString())),
          ); // Provide a more specific error
        })
        .onSuccess(() {
          state = const AsyncData(AuthState.unauthenticated());
        })
        .build();

    try {
      await TaskExecutor(signOutAction).execute();
    } catch (e, stack) {
      state = AsyncError(e, stack);
      logger.e('Sign out failed: $e', stackTrace: stack);
    }
  }

  Future<void> login(String haServerURL) async {
    final serverManager = ref.read(serverManagerProvider);
    final authRepository = ref.read(authRepositoryProvider);

    final loginAction = TaskChain.builder()
        .withContext('serverUrl', haServerURL)
        .addTask(CreateServerTask(serverManager))
        .addTask(OAuthLoginAttemptTask(authRepository))
        .addTask(GetConfigTask(serverManager, ref))
        .addTask(ActivateServerTask(ref))
        .onTaskError<OAuthLoginAttemptTask, AuthFailure>((error) {
          state = AsyncData(AuthState.failure(error));
        })
        .onAnyError((error) => logger.e('An error occurred: $error'))
        .onSuccess(() {
          // The ActivateServerTask should have set the active server
          // Set auth state to authenticated - navigation will handle the rest
          state = const AsyncData(AuthState.authenticated());
        })
        .build();

    try {
      await TaskExecutor(loginAction).execute();
    } catch (e, stack) {
      state = AsyncError(e, stack);
      logger.e('An error occurred: $e', stackTrace: stack);
    }
  }
}
