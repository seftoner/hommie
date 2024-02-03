import 'dart:async';

import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hommie/auth/provider.dart';
import 'package:hommie/networking/ha_authenticator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/data/auth_state.dart';

part 'auth_controller.g.dart';

/// This controller is an [AsyncNotifier] that holds and handles our authentication state

@riverpod
class AuthController extends _$AuthController {
  late final HAAuthenticator _haAuthenticator;

  @override
  FutureOr<AuthState> build() async {
    _haAuthenticator = ref.watch(uaAuthenticatorProvider);
    _persistenceRefreshLogic();

    return _loginRecoveryAttempt();
  }

  /// Tries to perform a login with the saved token on the persistant storage.
  /// If _anything_ goes wrong, deletes the internal token and returns a [User.signedOut].
  Future<AuthState> _loginRecoveryAttempt() async {
    return await _haAuthenticator.isSignedIn()
        ? Future.value(const AuthState.authenticated())
        : Future.value(const AuthState.unauthenticated());
  }

  Future<void> signOut() async {
    final failureOrSuccess = await _haAuthenticator.signOut();
    state = failureOrSuccess.fold(
      (l) => AsyncData(AuthState.failure(l)),
      (r) => const AsyncData(AuthState.unauthenticated()),
    );
  }

  /// Mock of a successful login attempt, which results come from the network.
  Future<void> login(String haServerURL) async {
    final grant = _haAuthenticator.createGrant(haServerURL);

    final String redirectScheme = "hommie";
    Uri _redirectUrl = Uri.parse("$redirectScheme://");

    //Exception has occurred.
    //PlatformException (PlatformException(CANCELED, User canceled login, null, null))
    final result = await FlutterWebAuth2.authenticate(
        url: grant.getAuthorizationUrl(_redirectUrl).toString(),
        callbackUrlScheme: redirectScheme);

    final failureOrSuccess = await _haAuthenticator.handleAuthorizationResponse(
        grant, Uri.parse(result).queryParameters);
    state = failureOrSuccess.fold(
      (l) => AsyncData(AuthState.failure(l)),
      (r) => AsyncData(const AuthState.authenticated()),
    );
    grant.close();
  }

  /// Internal method used to listen authentication state changes.
  /// When the auth object is in a loading state, nothing happens.
  /// When the auth object is in an error state, we choose to remove the token
  /// Otherwise, we expect the current auth value to be reflected in our persitence API
  void _persistenceRefreshLogic() {
    ref.listenSelf((_, next) {
      if (next.isLoading) return;
      if (next.hasError) {
        //use haauthenticator to sign out
        // _sharedPreferences.remove(_sharedPrefsKey);
        return;
      }

      //   next.requireValue.map<void>(
      //     authenticated: (signedIn) => {},
      //     // _sharedPreferences.setString(_sharedPrefsKey, signedIn.token),
      //     unauthenticated: (signedOut) {
      //       _haAuthenticator.signOut();
      //       // _sharedPreferences.remove(_sharedPrefsKey);
      //     },
      //     failure: (value) => null,
      //     initial: (value) => null,
      //   );
    });
  }
}

/// Simple mock of a 401 exception
class UnauthorizedException implements Exception {
  const UnauthorizedException(this.message);
  final String message;
}
