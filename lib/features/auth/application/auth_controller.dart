import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/features/auth/application/auth_state.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  Timer? _connectionCheckTimer;

  @override
  Future<AuthState> build() async {
    ref.onDispose(() {
      _connectionCheckTimer?.cancel();
    });
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
          case Connection():
            // Allow access if we have stored credentials
            final isLoggedIn = await repository.isLoggedIn();
            if (isLoggedIn) {
              return const AsyncData(AuthState.authenticated());
            }
            return AsyncData(AuthState.failure(failure));
          default:
            logger.e("Authentication failure: $failure");
            return AsyncData(AuthState.failure(failure));
        }
      },
      (credentials) async {
        return const AsyncData(AuthState.authenticated());
      },
    );
  }

  Future<void> signOut() async {
    logger.i("Sign out");
    final failureOrSuccess = await ref.watch(authRepositoryProvider).signOut();
    failureOrSuccess.fold(
      (l) => state = AsyncData(AuthState.failure(l)),
      (r) => {state = const AsyncData(AuthState.unauthenticated())},
    );
  }

  Future<void> login(String haServerURL) async {
    final authRepository = ref.watch(authRepositoryProvider);

    Uri redirectUrl = Uri.parse("hommie://");

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
        (r) => {state = const AsyncData(AuthState.authenticated())},
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
