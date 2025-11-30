import 'ha_auth_token.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'ha_messages.dart';

class HAAuthHandler {
  static const _authRequired = 'auth_required';
  static const _authInvalid = 'auth_invalid';
  static const _authOk = 'auth_ok';

  final HAAuthToken authToken;
  void Function(AuthResult)? onAuthResult;
  void Function(HABaseMessage)? sendMessage;

  HAAuthHandler({required this.authToken, this.onAuthResult, this.sendMessage});

  void handleAuthMessage(Map<String, dynamic> message) {
    assert(
      onAuthResult != null && sendMessage != null,
      'Auth handler not properly initialized',
    );

    try {
      final messageType = message['type'] as String;
      final authResult = switch (messageType) {
        _authRequired => _handleAuthRequired(),
        _authInvalid => _handleAuthInvalid(message['message'] as String),
        _authOk => _handleAuthOk(message['ha_version'] as String),
        _ => throw UnknownAuthMessageException(messageType),
      };

      onAuthResult!(authResult);
    } catch (e) {
      logger.e('Authentication error', error: e);
      onAuthResult!(AuthResult.error(e.toString()));
    }
  }

  AuthResult _handleAuthRequired() {
    logger.i('Auth required, sending credentials');
    sendMessage!(AuthMessage(accessToken: authToken.accessToken));
    return AuthResult.pending();
  }

  AuthResult _handleAuthInvalid(String message) {
    // message = Invalid access token or password
    // need handle this response properly -> log out from app
    logger.e('Authentication invalid: $message');
    return AuthResult.invalid(message);
  }

  AuthResult _handleAuthOk(String version) {
    logger.i('Authentication successful. HA version: $version');
    return AuthResult.success(version);
  }
}

sealed class AuthResult {
  const AuthResult();

  factory AuthResult.pending() => const AuthResultPending();
  factory AuthResult.success(String version) => AuthResultSuccess(version);
  factory AuthResult.invalid(String message) => AuthResultInvalid(message);
  factory AuthResult.error(String message) => AuthResultError(message);
}

final class AuthResultPending extends AuthResult {
  const AuthResultPending();
}

final class AuthResultSuccess extends AuthResult {
  final String haVersion;
  const AuthResultSuccess(this.haVersion);
}

final class AuthResultInvalid extends AuthResult {
  final String message;
  const AuthResultInvalid(this.message);
}

final class AuthResultError extends AuthResult {
  final String message;
  const AuthResultError(this.message);
}

class UnknownAuthMessageException implements Exception {
  final String type;
  UnknownAuthMessageException(this.type);

  @override
  String toString() => 'Unknown auth message type: $type';
}
