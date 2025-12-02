import 'package:fpdart/fpdart.dart';
import 'package:hommie/core/domain/value_objects/value_object.dart';

/// A value object representing a validated server URL.
///
/// This class validates that the URL:
/// - Is not empty
/// - Has a valid http or https scheme
/// - Has a valid host
/// - Has a valid format (no malformed ports, etc.)
///
/// Use [ServerUrlValidator] to create instances.
class ServerUrl extends ValueObject<String> {
  const ServerUrl._(super.value);
}

/// A reusable validator for server URLs.
///
/// This class can be instantiated and used as a form field validator.
/// Example:
/// ```dart
/// final validator = ServerUrlValidator();
/// TextFormField(
///   validator: validator.validate,
/// )
/// ```
class ServerUrlValidator {
  const ServerUrlValidator();

  /// Validates the given URL string.
  /// Returns an error message if invalid, or null if valid.
  /// This can be used directly as a form field validator.
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a server address';
    }

    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 'Please enter a server address';
    }

    try {
      final uri = Uri.parse(trimmed);
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

  /// Creates a [ServerUrl] from a string value.
  /// Returns [Left] with [ValueFailure] if invalid, [Right] with [ServerUrl] if valid.
  Either<ValueFailure, ServerUrl> parse(String? input) {
    final error = validate(input);
    if (error != null) {
      return left(ValueFailure(error));
    }
    return right(ServerUrl._(input!.trim()));
  }

  /// Creates a [ServerUrl] from a string value.
  /// Returns null if the value is invalid.
  ServerUrl? tryParse(String? value) {
    return parse(value).fold(
      (_) => null,
      (serverUrl) => serverUrl,
    );
  }
}
