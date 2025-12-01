import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hommie/core/domain/value_objects/value_object.dart';

// Test implementation of ValueObject
class TestValueObject extends ValueObject<String> {
  const TestValueObject._(super.value);

  static Either<ValueFailure, TestValueObject> create(String? input) {
    if (input == null || input.isEmpty) {
      return left(const ValueFailure('Value cannot be empty'));
    }
    return right(TestValueObject._(input));
  }
}

void main() {
  group('ValueObject', () {
    test('toString returns the value', () {
      final result = TestValueObject.create('test');
      expect(result.isRight(), isTrue);
      final vo = result.getOrElse((_) => fail('Expected Right'));
      expect(vo.toString(), equals('test'));
    });

    test('two value objects with same value are equal', () {
      final result1 = TestValueObject.create('test');
      final result2 = TestValueObject.create('test');
      expect(result1.isRight(), isTrue);
      expect(result2.isRight(), isTrue);
      final vo1 = result1.getOrElse((_) => fail('Expected Right'));
      final vo2 = result2.getOrElse((_) => fail('Expected Right'));
      expect(vo1, equals(vo2));
      expect(vo1.hashCode, equals(vo2.hashCode));
    });

    test('two value objects with different values are not equal', () {
      final result1 = TestValueObject.create('test1');
      final result2 = TestValueObject.create('test2');
      expect(result1.isRight(), isTrue);
      expect(result2.isRight(), isTrue);
      final vo1 = result1.getOrElse((_) => fail('Expected Right'));
      final vo2 = result2.getOrElse((_) => fail('Expected Right'));
      expect(vo1, isNot(equals(vo2)));
    });
  });

  group('ValueFailure', () {
    test('toString returns the message', () {
      const failure = ValueFailure('Error message');
      expect(failure.toString(), equals('Error message'));
    });

    test('two failures with same message are equal', () {
      const failure1 = ValueFailure('Error');
      const failure2 = ValueFailure('Error');
      expect(failure1, equals(failure2));
      expect(failure1.hashCode, equals(failure2.hashCode));
    });

    test('two failures with different messages are not equal', () {
      const failure1 = ValueFailure('Error 1');
      const failure2 = ValueFailure('Error 2');
      expect(failure1, isNot(equals(failure2)));
    });
  });
}
