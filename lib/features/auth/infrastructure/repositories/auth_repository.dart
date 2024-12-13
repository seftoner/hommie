import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/services/networking/credential_storage.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:oauth2/oauth2.dart';
import 'package:http/http.dart' as http;

class AuthRepository implements IAuthRepository {
  final CredentialStorage _credentialStorage;
  final http.Client _httpClient;

  final String _clientID = "https://seftoner.github.io";

  AuthRepository(this._credentialStorage, this._httpClient);

  @override
  Future<Either<AuthFailure, Credentials>> login(
      {required String serverUrl,
      required Uri redirectUrl,
      required AuthResponseHandler handler}) async {
    final grant = AuthorizationCodeGrant(
        _clientID,
        Uri.parse("$serverUrl/auth/authorize"),
        Uri.parse("$serverUrl/auth/token"));

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
        //TODO: handle internet connection error
        await client.post(credentials!.tokenEndpoint!, body: {
          'token': credentials.accessToken,
          'action': 'revoke',
        });
      } on SocketException catch (e) {
        logger.e('Token revocation failed: $e');
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
  Future<Either<AuthFailure, Credentials>> getCredentials() async {
    try {
      final storedCredentials = await _credentialStorage.read();
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          logger.i("Access token is expired 🌚");
          final failureOrCredentials = await _refreshToken(storedCredentials);

          return failureOrCredentials.fold(
            (failure) {
              logger.e("Token refresh failed: $failure");
              // Return the stored credentials even if refresh failed
              if (failure is Connection) {
                logger.i("Using stored credentials for offline access");
                return right(storedCredentials);
              }
              return left(AuthFailure.refreshToken());
            },
            (newCredentials) {
              logger.i("Token refreshed successfully");
              return right(newCredentials);
            },
          );
        }
        return right(storedCredentials);
      }
    } on PlatformException catch (e) {
      return left(AuthFailure.server(e.message));
    }

    return left(const AuthFailure.missingCredentials());
  }

  Future<Either<AuthFailure, Credentials>> _refreshToken(
      Credentials storedCredentials) async {
    try {
      logger.i("Try to refresh token 🔄");
      final refreshedCredentials = await storedCredentials.refresh(
        identifier: _clientID,
        basicAuth: false,
        httpClient: _httpClient,
      );

      await _credentialStorage.save(refreshedCredentials);
      return right(refreshedCredentials);
    } on TimeoutException catch (e) {
      logger.e(
          'Timeout error. Refresh takes more than: ${e.duration!.inSeconds.toString()}');
      return left(const AuthFailure.connection());
    } on FormatException catch (e) {
      logger.e('Error parsing credentials: $e');
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      logger.e('Error refreshing token: $e');
      return left(AuthFailure.server("${e.error}:${e.description}"));
    } on SocketException catch (e) {
      logger.e('Token refresh failed: $e');
      return left(AuthFailure.server("$e"));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final storedCredentials = await _credentialStorage.read();
    return storedCredentials != null;
  }
}
