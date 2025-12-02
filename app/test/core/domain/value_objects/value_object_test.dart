import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/domain/entities/server_url.dart';

void main() {
  group('ServerUrl', () {
    group('Valid URLs', () {
      test('accepts valid http URL', () {
        final serverUrl = ServerUrl('http://example.com');
        expect(serverUrl.value.isRight(), isTrue);
        expect(serverUrl.validate, isNull);
        expect(serverUrl.toString(), equals('http://example.com'));
      });

      test('accepts valid https URL', () {
        final serverUrl = ServerUrl('https://example.com');
        expect(serverUrl.value.isRight(), isTrue);
        expect(serverUrl.validate, isNull);
      });

      test('accepts URL with port', () {
        final serverUrl = ServerUrl('http://localhost:8123');
        expect(serverUrl.value.isRight(), isTrue);
        expect(serverUrl.validate, isNull);
      });

      test('accepts URL with IP address', () {
        final serverUrl = ServerUrl('http://192.168.1.1');
        expect(serverUrl.value.isRight(), isTrue);
        expect(serverUrl.validate, isNull);
      });

      test('accepts URL with path', () {
        final serverUrl = ServerUrl('http://example.com/api');
        expect(serverUrl.value.isRight(), isTrue);
        expect(serverUrl.validate, isNull);
      });

      test('removes trailing slash from base URL', () {
        final serverUrl = ServerUrl('http://localhost:8123/');
        expect(serverUrl.value.isRight(), isTrue);
        serverUrl.value.fold(
          (_) => fail('Expected valid URL'),
          (url) => expect(url, equals('http://localhost:8123')),
        );
      });

      test('removes trailing slash from URL with path', () {
        final serverUrl = ServerUrl('http://example.com/api/');
        expect(serverUrl.value.isRight(), isTrue);
        serverUrl.value.fold(
          (_) => fail('Expected valid URL'),
          (url) => expect(url, equals('http://example.com/api')),
        );
      });

      test('trims whitespace', () {
        final serverUrl = ServerUrl('  http://example.com  ');
        expect(serverUrl.value.isRight(), isTrue);
        serverUrl.value.fold(
          (_) => fail('Expected valid URL'),
          (url) => expect(url, equals('http://example.com')),
        );
      });
    });

    group('Invalid URLs', () {
      test('rejects null input', () {
        final serverUrl = ServerUrl(null);
        expect(serverUrl.value.isLeft(), isTrue);
        expect(serverUrl.validate, equals('Please enter a server address'));
      });

      test('rejects empty string', () {
        final serverUrl = ServerUrl('');
        expect(serverUrl.value.isLeft(), isTrue);
        expect(serverUrl.validate, equals('Please enter a server address'));
      });

      test('rejects whitespace-only string', () {
        final serverUrl = ServerUrl('   ');
        expect(serverUrl.value.isLeft(), isTrue);
        expect(serverUrl.validate, equals('Please enter a server address'));
      });

      test('rejects URL without scheme', () {
        final serverUrl = ServerUrl('example.com');
        expect(serverUrl.value.isLeft(), isTrue);
        expect(
          serverUrl.validate,
          equals('Address must start with http:// or https://'),
        );
      });

      test('rejects ftp:// scheme', () {
        final serverUrl = ServerUrl('ftp://example.com');
        expect(serverUrl.value.isLeft(), isTrue);
        expect(
          serverUrl.validate,
          equals('Address must start with http:// or https://'),
        );
      });

      test('rejects URL without host', () {
        final serverUrl = ServerUrl('http://');
        expect(serverUrl.value.isLeft(), isTrue);
        expect(serverUrl.validate, equals('Please enter a valid host address'));
      });

      test('rejects malformed URL', () {
        final serverUrl = ServerUrl('http://[invalid');
        expect(serverUrl.value.isLeft(), isTrue);
        expect(serverUrl.validate, equals('Invalid server address format'));
      });
    });

    group('toString', () {
      test('returns URL when valid', () {
        final serverUrl = ServerUrl('http://example.com');
        expect(serverUrl.toString(), equals('http://example.com'));
      });

      test('returns error message when invalid', () {
        final serverUrl = ServerUrl(null);
        expect(serverUrl.toString(), equals('Please enter a server address'));
      });
    });

    group('value getter', () {
      test('returns Right with URL for valid input', () {
        final serverUrl = ServerUrl('http://example.com');
        serverUrl.value.fold(
          (_) => fail('Expected Right'),
          (url) => expect(url, equals('http://example.com')),
        );
      });

      test('returns Left with failure for invalid input', () {
        final serverUrl = ServerUrl('invalid');
        serverUrl.value.fold(
          (failure) => expect(
            failure.message,
            equals('Address must start with http:// or https://'),
          ),
          (_) => fail('Expected Left'),
        );
      });
    });
  });
}
