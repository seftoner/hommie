import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hommie/networking/ha_authenticator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/data/auth_state.dart';

part 'auth_controller.g.dart';

/// A mock of an Authenticated User
const _dummyUser = AuthState.signedIn(token: "dummy_token");

/// This controller is an [AsyncNotifier] that holds and handles our authentication state
@riverpod
class AuthController extends _$AuthController {
  final HAAuthenticator _haAuthenticator;

  AuthController(this._haAuthenticator);

  @override
  FutureOr<AuthState> build() async {
    _persistenceRefreshLogic();

    return _loginRecoveryAttempt();
  }

  /// Tries to perform a login with the saved token on the persistant storage.
  /// If _anything_ goes wrong, deletes the internal token and returns a [User.signedOut].
  Future<AuthState> _loginRecoveryAttempt() {
    try {
      // final savedToken = _sharedPreferences.getString(_sharedPrefsKey);
      var savedToken = "savedToken";
      if (savedToken == null)
        throw const UnauthorizedException('No auth token found');

      return _loginWithToken("savedToken");
    } catch (_, __) {
      // _sharedPreferences.remove(_sharedPrefsKey).ignore();
      return Future.value(const AuthState.signedOut());
    }
  }

  Future<void> signOut() async {
    final failureOrSuccess = await _haAuthenticator.signOut();
    state = failureOrSuccess.fold(
      (l) => AsyncData(AuthState.failure(l)),
      (r) => const AsyncData(AuthState.unauthenticated()),
    );
  }

  /// Mock of a successful login attempt, which results come from the network.
  Future<void> login() async {
    final grant = _haAuthenticator.createGrant();

    final result = await FlutterWebAuth2.authenticate(
        url: grant.authorizationEndpoint.toString(),
        callbackUrlScheme: "hommie");

    final failureOrSuccess = await _haAuthenticator.handleAuthorizationResponse(
        grant, Uri.parse(result).queryParameters);
    state = failureOrSuccess.fold(
      (l) => AsyncData(AuthState.failure(l)),
      (r) => AsyncData(AuthState.signedIn(token: r.accessToken)),
    );
    grant.close();
  }

  /// Mock of a login request performed with a saved token.
  /// If such request fails, this method will throw an [UnauthorizedException].
  Future<AuthState> _loginWithToken(String token) async {
    //Make websocket connection here

    // final logInAttempt = await Future.delayed(
    //   networkRoundTripTime,
    //   () => true, // edit this if you wanna play around
    // );

    // if (logInAttempt)
    return _dummyUser;

    throw const UnauthorizedException('401 Unauthorized or something');
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

      next.requireValue.map<void>(
        signedIn: (signedIn) => {},
        // _sharedPreferences.setString(_sharedPrefsKey, signedIn.token),
        signedOut: (signedOut) {
          // _sharedPreferences.remove(_sharedPrefsKey);
        },
        failure: (value) => null,
        unauthenticated: (value) => null,
        initial: (value) => null,
      );
    });
  }
}

/// Simple mock of a 401 exception
class UnauthorizedException implements Exception {
  const UnauthorizedException(this.message);
  final String message;
}
