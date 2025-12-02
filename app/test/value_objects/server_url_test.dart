import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';

void main() {
  group('ServerUrl validation', () {
    test('returns error for empty input', () {
      final result1 = ServerUrl('');
      expect(result1.value.isLeft(), isTrue);
      result1.value.fold(
        (failure) => expect(failure.message, 'Please enter a server address'),
        (_) => fail('Expected Left'),
      );

      final result2 = ServerUrl(null);
      expect(result2.value.isLeft(), isTrue);
      result2.value.fold(
        (failure) => expect(failure.message, 'Please enter a server address'),
        (_) => fail('Expected Left'),
      );
    });

    test('returns error for whitespace-only input', () {
      final result1 = ServerUrl('   ');
      expect(result1.value.isLeft(), isTrue);
      result1.value.fold(
        (failure) => expect(failure.message, 'Please enter a server address'),
        (_) => fail('Expected Left'),
      );

      final result2 = ServerUrl('\t\n');
      expect(result2.value.isLeft(), isTrue);
      result2.value.fold(
        (failure) => expect(failure.message, 'Please enter a server address'),
        (_) => fail('Expected Left'),
      );
    });

    test('returns error for missing scheme', () {
      final result = ServerUrl('localhost:8123');
      expect(result.value.isLeft(), isTrue);
      result.value.fold(
        (failure) => expect(
          failure.message,
          'Address must start with http:// or https://',
        ),
        (_) => fail('Expected Left'),
      );
    });

    test('returns error for invalid scheme', () {
      final result = ServerUrl('ftp://localhost:8123');
      expect(result.value.isLeft(), isTrue);
      result.value.fold(
        (failure) => expect(
          failure.message,
          'Address must start with http:// or https://',
        ),
        (_) => fail('Expected Left'),
      );
    });

    test('returns error for missing host', () {
      final result = ServerUrl('http://');
      expect(result.value.isLeft(), isTrue);
      result.value.fold(
        (failure) =>
            expect(failure.message, 'Please enter a valid host address'),
        (_) => fail('Expected Left'),
      );
    });

    test('returns error for invalid URL format with double port', () {
      final result = ServerUrl('http://localhost:81:23');
      expect(result.value.isLeft(), isTrue);
      result.value.fold(
        (failure) => expect(failure.message, 'Invalid server address format'),
        (_) => fail('Expected Left'),
      );
    });

    test('returns valid URL for http URL', () {
      final result = ServerUrl('http://localhost:8123');
      expect(result.value.isRight(), isTrue);
      result.value.fold(
        (_) => fail('Expected Right'),
        (url) => expect(url, 'http://localhost:8123'),
      );
    });

    test('returns valid URL for https URL', () {
      final result = ServerUrl('https://homeassistant.local:8123');
      expect(result.value.isRight(), isTrue);
      result.value.fold(
        (_) => fail('Expected Right'),
        (url) => expect(url, 'https://homeassistant.local:8123'),
      );
    });

    test('returns valid URL with IP address', () {
      final result = ServerUrl('http://192.168.1.100:8123');
      expect(result.value.isRight(), isTrue);
      result.value.fold(
        (_) => fail('Expected Right'),
        (url) => expect(url, 'http://192.168.1.100:8123'),
      );
    });

    test('returns valid URL without port', () {
      final result = ServerUrl('http://homeassistant.local');
      expect(result.value.isRight(), isTrue);
      result.value.fold(
        (_) => fail('Expected Right'),
        (url) => expect(url, 'http://homeassistant.local'),
      );
    });

    test('trims whitespace and validates correctly', () {
      final result1 = ServerUrl(' http://localhost:8123 ');
      expect(result1.value.isRight(), isTrue);
      result1.value.fold(
        (_) => fail('Expected Right'),
        (url) => expect(url, 'http://localhost:8123'),
      );

      final result2 = ServerUrl('  http://localhost:8123  ');
      expect(result2.value.isRight(), isTrue);
      result2.value.fold(
        (_) => fail('Expected Right'),
        (url) => expect(url, 'http://localhost:8123'),
      );
    });

    test('removes trailing slashes', () {
      final result = ServerUrl('http://localhost:8123/');
      expect(result.value.isRight(), isTrue);
      result.value.fold(
        (_) => fail('Expected Right'),
        (url) => expect(url, 'http://localhost:8123'),
      );
    });
  });

  group('ServerUrl equality', () {
    test('two ServerUrl with same value are equal', () {
      final url1 = ServerUrl('http://localhost:8123');
      final url2 = ServerUrl('http://localhost:8123');
      expect(url1, equals(url2));
      expect(url1.hashCode, equals(url2.hashCode));
    });

    test('two ServerUrl with different values are not equal', () {
      final url1 = ServerUrl('http://localhost:8123');
      final url2 = ServerUrl('http://localhost:8124');
      expect(url1, isNot(equals(url2)));
    });
  });
}
