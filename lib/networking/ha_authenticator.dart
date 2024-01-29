import 'dart:html';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:hommie/networking/auth_failure.dart';
import 'package:hommie/networking/credential_storage.dart';
import 'package:oauth2/oauth2.dart';

class HAAuthenticator {
  final CredentialStorage _credentialStorage;
  final String _haURL;

  HAAuthenticator(this._credentialStorage, this._haURL);

  Uri get _authorizeUrl => Uri.parse(_haURL + "/auth/authorize");
  //Token URL used for getting the access token, refreshing the token and revoking the token
  Uri get _tokenUrl => Uri.parse(_haURL + "/auth/token");
  Uri _redirectUrl = Uri.parse("hommie://auth");
  String _clientID = "http://192.168.0.111";

  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialStorage.read();
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          final failureOrCredentials = await refreshToken(storedCredentials);
          return failureOrCredentials.fold((l) => null, (r) => r);
        }
        return storedCredentials;
      }
    } on PlatformException {
      return null;
    }
  }

  Future<Either<AuthFailure, Credentials>> handleAuthorizationResponse(
    AuthorizationCodeGrant grant,
    Map<String, String> queryParams,
  ) async {
    try {
      final httpClient = await grant.handleAuthorizationResponse(queryParams);
      await _credentialStorage.save(httpClient.credentials);
      return right(httpClient.credentials);
    } on FormatException {
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}: ${e.description}'));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Future<Either<AuthFailure, Credentials>> refreshToken(
      Credentials storedCredentials) async {
    try {
      final refreshedCredentials = await storedCredentials.refresh(
        identifier: _clientID,
        basicAuth: false,
      );

      await _credentialStorage.save(refreshedCredentials);
      return right(refreshedCredentials);
    } on FormatException catch (e) {
      print('Error parsing credentials: $e');
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      print('Error refreshing token: $e');
      return left(AuthFailure.server("${e.error}:${e.description}"));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Future<bool> isSignedIn() =>
      getSignedInCredentials().then((value) => value != null);

  AuthorizationCodeGrant createGrant() {
    return AuthorizationCodeGrant(
      _clientID,
      _authorizeUrl,
      _tokenUrl,
    );
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      final accessToken = await _credentialStorage
          .read()
          .then((credentials) => credentials?.accessToken);

      try {
        var client = HttpClient();
        var request = await client.postUrl(_tokenUrl);
        request.headers.add("Authorization", "Bearer $accessToken");
        request.write('token=$accessToken&action=revoke');
        await request.close();
        client.close();
      } on SocketException catch (e) {
        print('Token revocation failed: $e');
      }

      await _credentialStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }
}
