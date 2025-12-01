import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/domain/entities/server_url.dart';

void main() {
  group('ServerUrl.validate', () {
    test('returns error for empty input', () {
      expect(
        ServerUrl.validate(''),
        equals('Please enter a server address'),
      );
      expect(
        ServerUrl.validate(null),
        equals('Please enter a server address'),
      );
    });

    test('returns error for missing scheme', () {
      expect(
        ServerUrl.validate('localhost:8123'),
        equals('Address must start with http:// or https://'),
      );
    });

    test('returns error for invalid scheme', () {
      expect(
        ServerUrl.validate('ftp://localhost:8123'),
        equals('Address must start with http:// or https://'),
      );
    });

    test('returns error for missing host', () {
      expect(
        ServerUrl.validate('http://'),
        equals('Please enter a valid host address'),
      );
    });

    test('returns error for invalid URL format with double port', () {
      expect(
        ServerUrl.validate('http://localhost:81:23'),
        equals('Invalid server address format'),
      );
    });

    test('returns null for valid http URL', () {
      expect(
        ServerUrl.validate('http://localhost:8123'),
        isNull,
      );
    });

    test('returns null for valid https URL', () {
      expect(
        ServerUrl.validate('https://homeassistant.local:8123'),
        isNull,
      );
    });

    test('returns null for valid URL with IP address', () {
      expect(
        ServerUrl.validate('http://192.168.1.100:8123'),
        isNull,
      );
    });

    test('returns null for valid URL without port', () {
      expect(
        ServerUrl.validate('http://homeassistant.local'),
        isNull,
      );
    });
  });

  group('ServerUrl.tryParse', () {
    test('returns null for invalid URL', () {
      expect(ServerUrl.tryParse('http://localhost:81:23'), isNull);
      expect(ServerUrl.tryParse(''), isNull);
      expect(ServerUrl.tryParse(null), isNull);
    });

    test('returns ServerUrl for valid URL', () {
      final serverUrl = ServerUrl.tryParse('http://localhost:8123');
      expect(serverUrl, isNotNull);
      expect(serverUrl!.value, equals('http://localhost:8123'));
      expect(serverUrl.toString(), equals('http://localhost:8123'));
    });
  });

  group('ServerUrl equality', () {
    test('two ServerUrl with same value are equal', () {
      final url1 = ServerUrl.tryParse('http://localhost:8123');
      final url2 = ServerUrl.tryParse('http://localhost:8123');
      expect(url1, equals(url2));
      expect(url1.hashCode, equals(url2.hashCode));
    });

    test('two ServerUrl with different values are not equal', () {
      final url1 = ServerUrl.tryParse('http://localhost:8123');
      final url2 = ServerUrl.tryParse('http://localhost:8124');
      expect(url1, isNot(equals(url2)));
    });
  });
}
