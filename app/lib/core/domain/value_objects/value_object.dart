import 'package:fpdart/fpdart.dart';

/// A failure type for value object validation errors.
class ValueFailure {
  final String message;

  const ValueFailure(this.message);

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

/// Base class for value objects that provides validation without exceptions.
///
/// Value objects are immutable objects that are defined by their attributes
/// rather than their identity. They encapsulate validation logic and ensure
/// that invalid states cannot be represented.
///
/// Example usage:
/// ```dart
/// class EmailAddress extends ValueObject<String> {
///   const EmailAddress._(super.value);
/// }
///
/// class EmailAddressValidator {
///   const EmailAddressValidator();
///
///   String? validate(String? input) {
///     if (input == null || input.isEmpty) {
///       return 'Email cannot be empty';
///     }
///     if (!input.contains('@')) {
///       return 'Invalid email format';
///     }
///     return null;
///   }
///
///   Either<ValueFailure, EmailAddress> parse(String? input) {
///     final error = validate(input);
///     if (error != null) {
///       return left(ValueFailure(error));
///     }
///     return right(EmailAddress._(input!));
///   }
/// }
/// ```
abstract class ValueObject<T> {
  final T value;

  const ValueObject(this.value);

  @override
  String toString() => value.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
