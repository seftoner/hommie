import 'package:fpdart/fpdart.dart';
import 'package:hommie/core/domain/values/value_object.dart';

class ServerUrl extends ValueObject<String> {
  /// Creates a [ServerUrl] from the given [input] string.
  ///
  /// The URL is validated and normalized during construction.
  /// Use the [value] getter to check if validation succeeded.
  factory ServerUrl(String? input) {
    return ServerUrl._(_validate(input));
  }

  const ServerUrl._(this._value);

  @override
  Either<ValueFailure, String> get value => _value;

  final Either<ValueFailure, String> _value;
}

/// Validates and normalizes a server URL string.
///
/// Returns [Left] with a [ValueFailure] if validation fails,
/// or [Right] with the normalized URL string if validation succeeds.
///
/// ## Validation Steps
///
/// 1. Check for null or empty input
/// 2. Trim whitespace
/// 3. Remove trailing slashes
/// 4. Parse as URI and validate scheme (http/https only)
/// 5. Validate host is present
///
/// ## Error Messages
///
/// - `"Please enter a server address"` - Input is null, empty, or whitespace
/// - `"Address must start with http:// or https://"` - Invalid or missing scheme
/// - `"Please enter a valid host address"` - Host is empty
/// - `"Invalid server address format"` - URI parsing failed (malformed URL)
Either<ValueFailure, String> _validate(String? input) {
  if (input == null || input.isEmpty) {
    return left(const ValueFailure('Please enter a server address'));
  }

  final trimmed = input.trim();
  if (trimmed.isEmpty) {
    return left(const ValueFailure('Please enter a server address'));
  }

  // Remove trailing slashes
  final normalized = trimmed.endsWith('/')
      ? trimmed.substring(0, trimmed.length - 1)
      : trimmed;

  try {
    final uri = Uri.parse(normalized);
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

  return right(normalized);
}
