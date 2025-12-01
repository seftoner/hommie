import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/presentation/screens/enter_address_page.dart';

void main() {
  group('EnterAddressPage.validateServerUrl', () {
    test('returns error for empty input', () {
      expect(
        EnterAddressPage.validateServerUrl(''),
        equals('Please enter a server address'),
      );
      expect(
        EnterAddressPage.validateServerUrl(null),
        equals('Please enter a server address'),
      );
    });

    test('returns error for missing scheme', () {
      expect(
        EnterAddressPage.validateServerUrl('localhost:8123'),
        equals('Address must start with http:// or https://'),
      );
    });

    test('returns error for invalid scheme', () {
      expect(
        EnterAddressPage.validateServerUrl('ftp://localhost:8123'),
        equals('Address must start with http:// or https://'),
      );
    });

    test('returns error for missing host', () {
      expect(
        EnterAddressPage.validateServerUrl('http://'),
        equals('Please enter a valid host address'),
      );
    });

    test('returns error for invalid URL format with double port', () {
      expect(
        EnterAddressPage.validateServerUrl('http://localhost:81:23'),
        equals('Invalid server address format'),
      );
    });

    test('returns null for valid http URL', () {
      expect(
        EnterAddressPage.validateServerUrl('http://localhost:8123'),
        isNull,
      );
    });

    test('returns null for valid https URL', () {
      expect(
        EnterAddressPage.validateServerUrl('https://homeassistant.local:8123'),
        isNull,
      );
    });

    test('returns null for valid URL with IP address', () {
      expect(
        EnterAddressPage.validateServerUrl('http://192.168.1.100:8123'),
        isNull,
      );
    });

    test('returns null for valid URL without port', () {
      expect(
        EnterAddressPage.validateServerUrl('http://homeassistant.local'),
        isNull,
      );
    });
  });
}
