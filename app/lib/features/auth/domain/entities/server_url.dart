/// A value object representing a validated server URL.
///
/// This class validates that the URL:
/// - Is not empty
/// - Has a valid http or https scheme
/// - Has a valid host
/// - Has a valid format (no malformed ports, etc.)
class ServerUrl {
  final String value;

  const ServerUrl._(this.value);

  /// Creates a [ServerUrl] from a string value.
  /// Returns null if the value is invalid.
  static ServerUrl? tryParse(String? value) {
    final error = validate(value);
    if (error != null) {
      return null;
    }
    return ServerUrl._(value!);
  }

  /// Validates the given URL string.
  /// Returns an error message if invalid, or null if valid.
  /// This can be used directly as a form field validator.
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a server address';
    }

    try {
      final uri = Uri.parse(value);
      if (!uri.hasScheme || (uri.scheme != 'http' && uri.scheme != 'https')) {
        return 'Address must start with http:// or https://';
      }
      if (uri.host.isEmpty) {
        return 'Please enter a valid host address';
      }
    } on FormatException {
      return 'Invalid server address format';
    }

    return null;
  }

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerUrl &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
