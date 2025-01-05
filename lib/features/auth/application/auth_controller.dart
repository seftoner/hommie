import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/settings/infrastructure/providers/server_settings_provider.dart';
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
    final authRepository = ref.read(authRepositoryProvider);
    final serverSettings = ref.read(serverSettingsProvider);

    final Uri redirectUrl = Uri.parse('hommie://');

    try {
      final authResult = await authRepository.login(
          serverUrl: haServerURL,
          redirectUrl: redirectUrl,
          handler: (uri) async {
            ///TODO: handle sing in brake event here
            final authenticateResult = await FlutterWebAuth2.authenticate(
                url: uri.toString(), callbackUrlScheme: redirectUrl.scheme);

            return Uri.parse(authenticateResult).queryParameters;
          });

      authResult.fold(
        (l) => {state = AsyncData(AuthState.failure(l))},
        (r) async {
          await serverSettings.saveServerUrl(haServerURL);
          state = const AsyncData(AuthState.authenticated());
        },
      );
    } on PlatformException catch (e) {
      //BUG: Not sure that 'CANCELED' message will be return on all platforms
      if (e.code == 'CANCELED') {
        logger.e(e.message);
        state = AsyncData(AuthState.failure(AuthFailure.userBrake(e.message)));
      }
    }
  }
}
