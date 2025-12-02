import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/domain/entities/server_url.dart';

void main() {
  late ServerUrlValidator validator;

  setUp(() {
    validator = const ServerUrlValidator();
  });

  group('ServerUrlValidator.validate', () {
    test('returns error for empty input', () {
      expect(
        validator.validate(''),
        equals('Please enter a server address'),
      );
      expect(
        validator.validate(null),
        equals('Please enter a server address'),
      );
    });

    test('returns error for whitespace-only input', () {
      expect(
        validator.validate('   '),
        equals('Please enter a server address'),
      );
      expect(
        validator.validate('\t\n'),
        equals('Please enter a server address'),
      );
    });

    test('returns error for missing scheme', () {
      expect(
        validator.validate('localhost:8123'),
        equals('Address must start with http:// or https://'),
      );
    });

    test('returns error for invalid scheme', () {
      expect(
        validator.validate('ftp://localhost:8123'),
        equals('Address must start with http:// or https://'),
      );
    });

    test('returns error for missing host', () {
      expect(
        validator.validate('http://'),
        equals('Please enter a valid host address'),
      );
    });

    test('returns error for invalid URL format with double port', () {
      expect(
        validator.validate('http://localhost:81:23'),
        equals('Invalid server address format'),
      );
    });

    test('returns null for valid http URL', () {
      expect(
        validator.validate('http://localhost:8123'),
        isNull,
      );
    });

    test('returns null for valid https URL', () {
      expect(
        validator.validate('https://homeassistant.local:8123'),
        isNull,
      );
    });

    test('returns null for valid URL with IP address', () {
      expect(
        validator.validate('http://192.168.1.100:8123'),
        isNull,
      );
    });

    test('returns null for valid URL without port', () {
      expect(
        validator.validate('http://homeassistant.local'),
        isNull,
      );
    });

    test('trims whitespace and validates correctly', () {
      expect(
        validator.validate(' http://localhost:8123 '),
        isNull,
      );
      expect(
        validator.validate('  http://localhost:8123  '),
        isNull,
      );
    });
  });

  group('ServerUrlValidator.parse', () {
    test('returns Left with ValueFailure for invalid URL', () {
      final result = validator.parse('http://localhost:81:23');
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure.message, 'Invalid server address format'),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left with ValueFailure for empty input', () {
      final result = validator.parse('');
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure.message, 'Please enter a server address'),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Right with ServerUrl for valid URL', () {
      final result = validator.parse('http://localhost:8123');
      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (serverUrl) => expect(serverUrl.value, 'http://localhost:8123'),
      );
    });

    test('trims whitespace and stores trimmed value', () {
      final result = validator.parse(' http://localhost:8123 ');
      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (serverUrl) => expect(serverUrl.value, 'http://localhost:8123'),
      );
    });
  });

  group('ServerUrlValidator.tryParse', () {
    test('returns null for invalid URL', () {
      expect(validator.tryParse('http://localhost:81:23'), isNull);
      expect(validator.tryParse(''), isNull);
      expect(validator.tryParse(null), isNull);
    });

    test('returns ServerUrl for valid URL', () {
      final serverUrl = validator.tryParse('http://localhost:8123');
      expect(serverUrl, isNotNull);
      expect(serverUrl!.value, equals('http://localhost:8123'));
      expect(serverUrl.toString(), equals('http://localhost:8123'));
    });

    test('trims whitespace in parsed URL', () {
      final serverUrl = validator.tryParse(' http://localhost:8123 ');
      expect(serverUrl, isNotNull);
      expect(serverUrl!.value, equals('http://localhost:8123'));
    });
  });

  group('ServerUrl equality', () {
    test('two ServerUrl with same value are equal', () {
      final url1 = validator.tryParse('http://localhost:8123');
      final url2 = validator.tryParse('http://localhost:8123');
      expect(url1, equals(url2));
      expect(url1.hashCode, equals(url2.hashCode));
    });

    test('two ServerUrl with different values are not equal', () {
      final url1 = validator.tryParse('http://localhost:8123');
      final url2 = validator.tryParse('http://localhost:8124');
      expect(url1, isNot(equals(url2)));
    });
  });
}
