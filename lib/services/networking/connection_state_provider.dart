import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection_state_provider.g.dart';

/// Represents different states of network connectivity.
///
/// [connected] - Device has active network connection
/// [disconnected] - Device has no network connection
/// [connecting] - Device is attempting to establish network connection
enum NetworkConnectionState {
  connected,
  disconnected,
  connecting,
}

/// A Riverpod provider that manages the network connection state of the application.
///
/// This provider keeps track of the current network connectivity status and
/// provides methods to update the connection state. It is marked as keepAlive
/// to ensure the state persists across widget rebuilds.
@Riverpod(keepAlive: true)
class ConnectionState extends _$ConnectionState {
  /// Initializes the connection state as disconnected.
  ///
  /// Returns [NetworkConnectionState.disconnected] as the initial state.
  @override
  NetworkConnectionState build() {
    return NetworkConnectionState.disconnected;
  }

  /// Updates the connection state to connected.
  void setConnected() {
    state = NetworkConnectionState.connected;
  }

  /// Updates the connection state to disconnected.
  void setDisconnected() {
    state = NetworkConnectionState.disconnected;
  }

  /// Updates the connection state to connecting.
  void setConnecting() {
    state = NetworkConnectionState.connecting;
  }
}
