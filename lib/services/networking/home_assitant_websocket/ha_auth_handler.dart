import 'package:oauth2/oauth2.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';

class HAAuthHandler {
  static const _authRequired = "auth_required";
  static const _authInvalid = "auth_invalid";
  static const _authOk = "auth_ok";

  final Credentials credentials;
  void Function(AuthResult)? onAuthResult;
  void Function(HABaseMessgae)? sendMessage;

  HAAuthHandler({
    required this.credentials,
    this.onAuthResult,
    this.sendMessage,
  });

  void handleAuthMessage(Map<String, dynamic> message) {
    assert(onAuthResult != null && sendMessage != null,
        'Auth handler not properly initialized');

    try {
      final messageType = message["type"] as String;
      final authResult = switch (messageType) {
        _authRequired => _handleAuthRequired(),
        _authInvalid => _handleAuthInvalid(message["message"] as String),
        _authOk => _handleAuthOk(message["ha_version"] as String),
        _ => throw UnknownAuthMessageException(messageType),
      };

      onAuthResult!(authResult);
    } catch (e) {
      logger.e("Authentication error", error: e);
      onAuthResult!(AuthResult.error(e.toString()));
    }
  }

  AuthResult _handleAuthRequired() {
    logger.i("Auth required, sending credentials");
    sendMessage!(AuthMessage(accessToken: credentials.accessToken));
    return AuthResult.pending();
  }

  AuthResult _handleAuthInvalid(String message) {
    logger.e("Authentication invalid: $message");
    return AuthResult.invalid(message);
  }

  AuthResult _handleAuthOk(String version) {
    logger.i("Authentication successful. HA version: $version");
    return AuthResult.success(version);
  }
}

class AuthResult {
  final AuthStatus status;
  final String? message;
  final String? haVersion;

  const AuthResult._({
    required this.status,
    this.message,
    this.haVersion,
  });

  factory AuthResult.pending() => AuthResult._(status: AuthStatus.pending);

  factory AuthResult.success(String version) => AuthResult._(
        status: AuthStatus.success,
        haVersion: version,
      );

  factory AuthResult.invalid(String message) => AuthResult._(
        status: AuthStatus.invalid,
        message: message,
      );

  factory AuthResult.error(String message) => AuthResult._(
        status: AuthStatus.error,
        message: message,
      );
}

enum AuthStatus {
  pending,
  success,
  invalid,
  error,
}

class UnknownAuthMessageException implements Exception {
  final String type;
  UnknownAuthMessageException(this.type);

  @override
  String toString() => 'Unknown auth message type: $type';
}
