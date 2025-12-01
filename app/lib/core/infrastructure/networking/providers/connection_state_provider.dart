import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection_state_provider.g.dart';

/// Represents different states of network connectivity.
///
/// [connected] - Device has active network connection
///
/// [reconnecting] - Connection lost, attempting to re-establish connection automatically.
/// This state indicates that the previous connection was lost and the client
/// is actively trying to restore the connection with the home assistant server.
///
/// [disconnected] - Device has no network connection
///
/// [connecting] - Device is attempting to establish network connection
///
/// [unknown] - Initial state when app launches, before any connection attempt is made.
/// This state indicates that the connection status to the home assistant server
/// has not been determined yet.
///
/// [authFailure] - Authentication failure occurred. This state fires when:
/// - The access token has been revoked on the Home Assistant server
/// - The user account has been deleted from the Home Assistant server
/// - The authentication credentials are no longer valid
/// When this state is triggered, the app MUST log out the user from the selected
/// server, clear all stored credentials, and redirect to the login/authentication flow.
enum HAServerConnectionState {
  unknown,
  connected,
  disconnected,
  connecting,
  reconnecting,
  authFailure,
}

/// A Riverpod provider that manages the network connection state of the application.
///
/// This provider keeps track of the current network connectivity status and
/// provides methods to update the connection state. It is marked as keepAlive
/// to ensure the state persists across widget rebuilds.
@Riverpod(keepAlive: true)
class ServerConnectionState extends _$ServerConnectionState {
  /// Initializes the connection state as disconnected.
  ///
  /// Returns [HAServerConnectionState.disconnected] as the initial state.
  @override
  HAServerConnectionState build() {
    return HAServerConnectionState.unknown;
  }

  /// Resets the state of the connection to its initial value (unknown).
  ///
  /// This method sets the internal connection state back to [HAServerConnectionState.unknown],
  /// which represents an undefined connection status. This can be useful when
  /// cleaning up resources or preparing for a new connection attempt.
  void reset() {
    state = HAServerConnectionState.unknown;
  }

  /// Updates the connection state to connected.
  void setConnected() {
    state = HAServerConnectionState.connected;
  }

  /// Updates the connection state to disconnected.
  void setDisconnected() {
    state = HAServerConnectionState.disconnected;
  }

  /// Updates the connection state to connecting.
  void setConnecting() {
    state = HAServerConnectionState.connecting;
  }

  void setReconnecting() {
    state = HAServerConnectionState.reconnecting;
  }

  void setAuthFailure() {
    state = HAServerConnectionState.authFailure;
  }
}
