import 'dart:async';

import 'ha_auth_token.dart';
import 'ha_socket.dart';
import 'ha_socket_state.dart';
import 'logger_interface.dart';

typedef FetchAuthTokenCallback = Future<HAAuthToken> Function();

class HAConnectionOption {
  final Uri _serverUrl;
  final FetchAuthTokenCallback _fetchAuthToken;
  final HaLogger _logger;

  HAConnectionOption._({
    required Uri serverUrl,
    required FetchAuthTokenCallback fetchAuthToken,
    required HaLogger logger,
  }) : _serverUrl = serverUrl,
       _fetchAuthToken = fetchAuthToken,
       _logger = logger;

  /// Creates a HAConnectionOption with default settings.
  /// Uses PrintLogger by default for logging output.
  factory HAConnectionOption({
    required Uri serverUrl,
    required FetchAuthTokenCallback fetchAuthToken,
  }) {
    return HAConnectionOption._(
      serverUrl: serverUrl,
      fetchAuthToken: fetchAuthToken,
      logger: const PrintLogger(),
    );
  }

  /// Creates a HAConnectionOption with custom logger configuration.
  ///
  /// [customLogger] - Optional custom logger implementation. If provided, this logger will be used.
  /// [enableDefaultLogging] - If true and no custom logger is provided, uses PrintLogger.
  ///                          If false and no custom logger is provided, uses NoOpLogger (silent).
  ///                          Defaults to true.
  factory HAConnectionOption.withLogger({
    required Uri serverUrl,
    required FetchAuthTokenCallback fetchAuthToken,
    HaLogger? customLogger,
    bool enableDefaultLogging = true,
  }) {
    final logger =
        customLogger ??
        (enableDefaultLogging ? const PrintLogger() : const NoOpLogger());

    return HAConnectionOption._(
      serverUrl: serverUrl,
      fetchAuthToken: fetchAuthToken,
      logger: logger,
    );
  }

  /// Gets the configured logger instance.
  HaLogger get logger => _logger;

  Future<HASocket> createSocket() async {
    final credentials = await _fetchAuthToken();

    final serverWebSocketUrl = _buildWebSocketUrl(_serverUrl);
    _logger.info('Trying to establish a new connection to $serverWebSocketUrl');

    final completer = Completer<HASocket>();
    _connect(serverWebSocketUrl, credentials, completer);

    return completer.future;
  }

  Uri _buildWebSocketUrl(Uri baseUrl) {
    final scheme = switch (baseUrl.scheme) {
      'http' => 'ws',
      'https' => 'wss',
      _ => throw Exception('Unsupported scheme: ${baseUrl.scheme}'),
    };

    final host = baseUrl.host;
    final port = baseUrl.port;

    return Uri.parse('$scheme://$host:$port/api/websocket');
  }

  void _connect(
    Uri uri,
    HAAuthToken credentials,
    Completer<HASocket> completer,
  ) {
    final socket = HASocket.connect(
      wsUri: uri,
      authToken: credentials,
      logger: _logger,
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

    stateSubscription = socket.stateStream.listen((state) {
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
            ConnectionError('Connection closed before authentication'),
          );

        default:
          // Wait for other states
          break;
      }
    }, onError: handleError);

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

class ConnectionClosedError implements Exception {
  final String message;
  ConnectionClosedError(this.message);
  @override
  String toString() => message;
}
