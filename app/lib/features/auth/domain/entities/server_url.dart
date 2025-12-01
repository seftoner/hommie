import 'package:fpdart/fpdart.dart';
import 'package:hommie/core/domain/value_objects/value_object.dart';

/// A value object representing a validated server URL.
///
/// This class validates that the URL:
/// - Is not empty
/// - Has a valid http or https scheme
/// - Has a valid host
/// - Has a valid format (no malformed ports, etc.)
class ServerUrl extends ValueObject<String> {
  const ServerUrl._(super.value);

  /// Creates a [ServerUrl] from a string value.
  /// Returns [Left] with [ValueFailure] if invalid, [Right] with [ServerUrl] if valid.
  static Either<ValueFailure, ServerUrl> create(String? input) {
    if (input == null || input.isEmpty) {
      return left(const ValueFailure('Please enter a server address'));
    }

    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return left(const ValueFailure('Please enter a server address'));
    }

    try {
      final uri = Uri.parse(trimmed);
      if (!uri.hasScheme || (uri.scheme != 'http' && uri.scheme != 'https')) {
        return left(
          const ValueFailure('Address must start with http:// or https://'),
        );
      }
      if (uri.host.isEmpty) {
        return left(const ValueFailure('Please enter a valid host address'));
      }
    } on FormatException {
      return left(const ValueFailure('Invalid server address format'));
    }

    return right(ServerUrl._(trimmed));
  }

  /// Creates a [ServerUrl] from a string value.
  /// Returns null if the value is invalid.
  static ServerUrl? tryParse(String? value) {
    return create(value).fold(
      (_) => null,
      (serverUrl) => serverUrl,
    );
  }

  /// Validates the given URL string.
  /// Returns an error message if invalid, or null if valid.
  /// This can be used directly as a form field validator.
  static String? validate(String? value) {
    return create(value).fold(
      (failure) => failure.message,
      (_) => null,
    );
  }
}
