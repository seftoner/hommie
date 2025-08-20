import 'dart:async';

import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/infrastructure/tasks/oauth_login_attempt_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/create_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/get_config_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/activate_server_task.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/settings/infrastructure/providers/server_settings_provider.dart';
import 'package:hommie/features/shared/domain/models/task_chain.dart';
import 'package:hommie/features/shared/infrastructure/runner/task_executor.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/features/auth/application/auth_state.dart';

part 'auth_controller.g.dart';

// THIS CLASS IS DEPRECATED
// Use the new ServerAuthController class instead
@Riverpod(dependencies: [ServerConnectionManager])
class AuthController extends _$AuthController {
  @override
  Future<AuthState> build() async {
    return const AuthState.initial();
  }

  Future<void> initialize() async {
    final serverManager = ref.read(serverManagerProvider);
    final server = await serverManager.getActiveServer();
    if (server == null) {
      state = const AsyncData(AuthState.unauthenticated());
      return;
    }

    final repository = serverManager.getAuthRepository(server.id!);
    final credentialsOrFailure = await repository.getCredentials();

    state = await credentialsOrFailure.fold(
      (failure) async {
        switch (failure) {
          case MissingCredentials():
            return const AsyncData(AuthState.unauthenticated());
          case InvalidToken():
            signOut();
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

  Future<void> signOut() async {
    logger.i('Sign out');

    final serverSettings = ref.read(serverSettingsProvider);
    await serverSettings.clear();

    final serverManager = ref.read(serverManagerProvider);
    final server = await serverManager.getActiveServer();
    if (server == null) {
      return;
    }

    final failureOrSuccess =
        await serverManager.getAuthRepository(server.id!).signOut();
    failureOrSuccess.fold(
      (l) => state = AsyncData(AuthState.failure(l)),
      (r) => {state = const AsyncData(AuthState.unauthenticated())},
    );
    await serverManager.removeServer(server.id!);
  }

  Future<void> login(String haServerURL) async {
    try {
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
          .onAnyError((error) {
            logger.e('An error occurred: $error');
            state = AsyncData(AuthState.failure(AuthFailure.server(
                error.toString()))); // Provide a more specific error
          })
          .onSuccess(() => state = const AsyncData(AuthState.authenticated()))
          .build();

      await TaskExecutor(loginAction).execute();
    } catch (e, stack) {
      logger.e('Login failed: $e', stackTrace: stack);
      state = AsyncData(AuthState.failure(
          AuthFailure.server(e.toString()))); // Provide a more specific error
    }
  }
}
