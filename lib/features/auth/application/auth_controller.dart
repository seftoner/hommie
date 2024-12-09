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
  @override
  Future<AuthState> build() async {
    final repository = ref.watch(authRepositoryProvider);
    final credentialsOrError = await repository.getCredentials();

    return credentialsOrError.fold(
      (failure) {
        switch (failure) {
          case MissingCredentials():
            return const AuthState.unauthenticated();
          default:
            logger.e("Authentication failure: $failure");
            return AuthState.failure(failure);
        }
      },
      (credentials) {
        logger.i("User authenticated successfully");
        return AuthState.authenticated();
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
