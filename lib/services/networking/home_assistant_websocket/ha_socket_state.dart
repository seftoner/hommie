sealed class HASocketState {
  const HASocketState();

  factory HASocketState.connecting() => const Connecting();
  factory HASocketState.authenticated() => const Authenticated();
  factory HASocketState.reconnecting() => const Reconnecting();
  factory HASocketState.disconnected({
    String? reason,
    Object? error,
    DisconnectionType type = DisconnectionType.normal,
  }) =>
      Disconnected(reason: reason, error: error, type: type);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is HASocketState && runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class Connecting extends HASocketState {
  const Connecting();
}

class Authenticated extends HASocketState {
  const Authenticated();
}

class Reconnecting extends HASocketState {
  const Reconnecting();
}

enum DisconnectionType {
  normal,
  error,
  authFailure,
}

class Disconnected extends HASocketState {
  final String? reason;
  final Object? error;
  final DisconnectionType type;

  const Disconnected({
    this.reason,
    this.error,
    this.type = DisconnectionType.normal,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Disconnected &&
        other.reason == reason &&
        other.error == error &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason, error, type);

  bool get isAuthFailure => type == DisconnectionType.authFailure;
  bool get isError => type == DisconnectionType.error;
}
