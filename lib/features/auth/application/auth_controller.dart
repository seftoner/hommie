import 'dart:async';

import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/infrastructure/tasks/attempt_oauth_login.dart';
import 'package:hommie/features/auth/infrastructure/tasks/create_server_task.dart';
import 'package:hommie/features/auth/infrastructure/tasks/get_config_task.dart';
import 'package:hommie/features/server_manager/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/features/settings/infrastructure/providers/server_settings_provider.dart';
import 'package:hommie/features/shared/domain/models/task_chain.dart';
import 'package:hommie/features/shared/infrastructure/runner/task_executor.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/features/auth/application/auth_state.dart';

part 'auth_controller.g.dart';

@Riverpod(dependencies: [ServerConnectionManager])
class AuthController extends _$AuthController {
  @override
  Future<AuthState> build() async {
    return const AuthState.initial();
  }

  Future<void> initialize() async {
    final repository = ref.read(authRepositoryProvider);
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
    final connectionManager =
        ref.read(serverConnectionManagerProvider.notifier);
    connectionManager.disconnectAndCleanup();

    final serverSettings = ref.read(serverSettingsProvider);
    await serverSettings.clear();

    final failureOrSuccess = await ref.read(authRepositoryProvider).signOut();
    failureOrSuccess.fold(
      (l) => state = AsyncData(AuthState.failure(l)),
      (r) => {state = const AsyncData(AuthState.unauthenticated())},
    );
  }

  Future<void> login(String haServerURL) async {
    final serverManager = ref.read(serverManagerProvider);

    final chain = TaskChain.builder()
        .withContext('serverUrl', haServerURL)
        .addTask(CreateServerTask(serverManager))
        .addTask(AttemptOAuthLogin(serverManager))
        .addTask(GetConfigTask(serverManager))
        .onTaskError<AttemptOAuthLogin, AuthFailure>((error) {
          state = AsyncData(AuthState.failure(error));
        })
        .onAnyError((error) => logger.e('An error occurred: $error'))
        .onSuccess(() => state = const AsyncData(AuthState.authenticated()))
        .build();

    await TaskExecutor(chain).execute();
  }
}
