import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:hommie/networking/auth_failure.dart';
import 'package:hommie/networking/credential_storage.dart';
import 'package:oauth2/oauth2.dart';

class HAAuthenticator {
  final CredentialStorage _credentialStorage;

  HAAuthenticator(this._credentialStorage);
  String _clientID = "http://192.168.0.106";

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

  AuthorizationCodeGrant createGrant(String haServerURL) {
    return AuthorizationCodeGrant(
      _clientID,
      Uri.parse(haServerURL + "/auth/authorize"),
      Uri.parse(haServerURL + "/auth/token"),
    );
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      final credentials = await _credentialStorage.read();
      var client = HttpClient();
      try {
        var request = await client.postUrl(credentials!.tokenEndpoint!);
        request.headers
            .add("Authorization", "Bearer ${credentials?.accessToken}");
        request.write('token=${credentials?.accessToken}&action=revoke');
        await request.close();
      } on SocketException catch (e) {
        print('Token revocation failed: $e');
      } finally {
        client.close();
      }

      await _credentialStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }
}
