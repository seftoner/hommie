sealed class HASocketState {
  const HASocketState();
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

  bool get isAuthFailure => type == DisconnectionType.authFailure;
  bool get isError => type == DisconnectionType.error;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Disconnected &&
        other.reason == reason &&
        other.error == error &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hash(reason, error, type);
}
