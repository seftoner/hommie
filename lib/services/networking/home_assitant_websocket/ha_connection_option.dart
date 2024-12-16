import 'dart:async';

import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_auth_token.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket_state.dart';

typedef TokenRefreshCallback = Future<HAAuthToken> Function();

class HAConnectionOption {
  HAAuthToken _credentials;
  final TokenRefreshCallback? _onTokenRefresh;

  HAConnectionOption(this._credentials, {TokenRefreshCallback? onTokenRefresh})
      : _onTokenRefresh = onTokenRefresh;

  Future<HASocket> createSocket() async {
    await _refreshTokenIfNeeded();

    final serverUri = _credentials.serverUri;
    if (serverUri == null) {
      throw Exception('Token endpoint is null');
    }

    final serverUrl = _buildWebSocketUrl(serverUri);
    logger.i('Trying to establish a new connection to $serverUrl');

    final completer = Completer<HASocket>();
    _connect(Uri.parse(serverUrl), completer);

    return completer.future;
  }

  Future<void> _refreshTokenIfNeeded() async {
    if (_credentials.isExpired && _onTokenRefresh != null) {
      try {
        _credentials = await _onTokenRefresh();
        logger.i('Token refreshed successfully');
      } catch (e) {
        logger.e('Failed to refresh token', error: e);
        rethrow;
      }
    }
  }

  String _buildWebSocketUrl(Uri baseUrl) {
    final scheme = switch (baseUrl.scheme) {
      'http' => 'ws',
      'https' => 'wss',
      _ => throw Exception('Unsupported scheme: ${baseUrl.scheme}'),
    };

    final host = baseUrl.host;
    final port = baseUrl.port;

    return '$scheme://$host:$port/api/websocket';
  }

  void _connect(Uri uri, Completer<HASocket> completer) {
    final socket = HASocket.connect(
      wsUri: uri,
      authToken: _credentials,
    );

    StreamSubscription<HASocketState>? stateSubscription;
    StreamSubscription<dynamic>? messageSubscription;

    void cleanup() {
      stateSubscription?.cancel();
      messageSubscription?.cancel();
    }

    void handleError(Object error) {
      if (!completer.isCompleted) {
        cleanup();
        _completeWithError(completer, error);
      }
    }

    stateSubscription = socket.stateStream.listen(
      (state) {
        switch (state) {
          case Authenticated():
            cleanup();
            completer.complete(socket);

          case Disconnected(:final type)
              when type == DisconnectionType.authFailure:
            handleError(AuthenticationError('Authentication failed'));

          case Disconnected() when !completer.isCompleted:
            // Only handle non-auth disconnections if we haven't completed yet
            handleError(
                ConnectionError('Connection closed before authentication'));

          default:
            // Wait for other states
            break;
        }
      },
      onError: handleError,
    );

    messageSubscription = socket.stream.listen(
      null, // We don't need to handle messages here as auth is handled by HASocket
      onError: handleError,
      // Don't handle onDone since disconnection is handled via state
    );
  }

  void _completeWithError(Completer completer, Object error) {
    if (!completer.isCompleted) {
      completer.completeError(error);
    }
  }
}

class AuthenticationError implements Exception {
  final String message;
  AuthenticationError(this.message);
  @override
  String toString() => message;
}

class ConnectionError implements Exception {
  final String message;
  ConnectionError(this.message);
  @override
  String toString() => message;
}
