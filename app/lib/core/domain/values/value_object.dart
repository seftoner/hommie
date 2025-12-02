import 'package:fpdart/fpdart.dart';

/// Represents a validation failure for value objects.
///
/// Contains a human-readable error message describing why validation failed.
/// Used in the [Left] side of [Either<ValueFailure, T>] to represent
/// invalid value objects.
///
/// ## Usage
///
/// ```dart
/// const failure = ValueFailure('Email address is invalid');
/// print(failure.message); // "Email address is invalid"
/// print(failure.toString()); // "Email address is invalid"
/// ```
class ValueFailure {
  /// Creates a [ValueFailure] with the given error [message].
  const ValueFailure(this.message);

  /// The human-readable error message describing the validation failure.
  final String message;

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueFailure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

/// Base class for domain value objects with built-in validation.
///
/// Value objects are immutable domain primitives that encapsulate validation
/// logic and ensure business rules are enforced at the type level.
///
/// ## Why Value Objects?
///
/// - **Type Safety**: Prevent invalid data from entering the domain
/// - **Self-Validation**: Validation logic lives with the data
/// - **Immutability**: Values cannot change once created
/// - **Domain Language**: Express business concepts (ServerUrl, Email, etc.)
///
/// ## Implementation
///
/// Subclasses must implement the [value] getter to return an [Either]:
/// - [Left<ValueFailure>] for invalid values
/// - [Right<T>] for valid values
///
/// ## Example Implementation
///
/// ```dart
/// class Email extends ValueObject<String> {
///   factory Email(String? input) {
///     return Email._(_validate(input));
///   }
///
///   const Email._(this._value);
///
///   @override
///   Either<ValueFailure, String> get value => _value;
///
///   final Either<ValueFailure, String> _value;
/// }
///
/// Either<ValueFailure, String> _validate(String? input) {
///   if (input == null || input.isEmpty) {
///     return left(const ValueFailure('Email is required'));
///   }
///   if (!input.contains('@')) {
///     return left(const ValueFailure('Email must contain @'));
///   }
///   return right(input);
/// }
/// ```
///
/// ## Usage
///
/// ```dart
/// final email = Email('user@example.com');
///
/// // Pattern match on Either
/// email.value.fold(
///   (failure) => print('Invalid: ${failure.message}'),
///   (validEmail) => sendWelcomeEmail(validEmail),
/// );
///
/// // Check if valid
/// if (email.value.isRight()) {
///   print('Email is valid');
/// }
///
/// // Use with forms
/// TextFormField(
///   validator: (value) => Email(value).validate,
/// )
///
/// // Get string representation (value or error)
/// print(email.toString()); // "user@example.com" or error message
/// ```
abstract class ValueObject<T> {
  const ValueObject();

  /// The validated value wrapped in an [Either].
  ///
  /// Returns:
  /// - [Left<ValueFailure>] if validation failed
  /// - [Right<T>] if validation succeeded and contains the valid value
  Either<ValueFailure, T> get value;

  /// Returns a string representation of the value or error message.
  ///
  /// - If [value] is [Right], returns the string representation of the value
  /// - If [value] is [Left], returns the failure message
  @override
  String toString() => value.fold((l) => l.message, (r) => r.toString());

  /// Returns the validation error message, or null if valid.
  ///
  /// This is useful for form field validators:
  /// ```dart
  /// TextFormField(
  ///   validator: (input) => Email(input).validate,
  /// )
  /// ```
  ///
  /// Returns:
  /// - [String] error message if validation failed
  /// - `null` if validation succeeded
  String? get validate => value.fold((l) => l.message, (r) => null);
}
