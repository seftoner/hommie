import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/services/networking/credential_storage.dart';
import 'package:oauth2/oauth2.dart';
import 'package:http/http.dart' as http;

class AuthRepository implements IAuthRepository {
  final CredentialStorage _credentialStorage;

  final String _clientID = "https://seftoner.github.io";

  AuthRepository(this._credentialStorage);

  @override
  Future<Either<AuthFailure, Credentials>> login(
      {required String serverUrl,
      required Uri redirectUrl,
      required AuthResponseHandler handler}) async {
    final grant = AuthorizationCodeGrant(
        _clientID,
        Uri.parse(serverUrl + "/auth/authorize"),
        Uri.parse(serverUrl + "/auth/token"));

    try {
      final responseCode =
          await handler(grant.getAuthorizationUrl(redirectUrl));
      final httpClient = await grant.handleAuthorizationResponse(responseCode);
      await _credentialStorage.save(httpClient.credentials);
      // grant.close();
      return right(httpClient.credentials);
    } on FormatException {
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}: ${e.description}'));
    } on PlatformException {
      //User manually cancel login procedure
      return left(const AuthFailure.storage());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      final credentials = await _credentialStorage.read();
      var client = http.Client();
      try {
        //TODO handle internet connection error
        await client.post(credentials!.tokenEndpoint!, body: {
          'token': credentials.accessToken,
          'action': 'revoke',
        });
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

  @override
  Future<Credentials?> getCredentials() async {
    try {
      final storedCredentials = await _credentialStorage.read();
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          final failureOrCredentials = await _refreshToken(storedCredentials);
          return failureOrCredentials.fold((l) => null, (r) => r);
        }
        return storedCredentials;
      }
    } on PlatformException {
      return null;
    }

    return null;
  }

  Future<Either<AuthFailure, Credentials>> _refreshToken(
      Credentials storedCredentials) async {
    try {
      final refreshedCredentials = await storedCredentials.refresh(
          identifier: _clientID, basicAuth: false);

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
}
