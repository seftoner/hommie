import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/services/networking/ha_authenticator.dart';
import 'package:hommie/services/networking/secure_credentials_storage.dart';

final uaAuthenticatorProvider = Provider((ref) {
  final securityCredentialStorage =
      SecureCredentialStorage(const FlutterSecureStorage());
  return HAAuthenticator(securityCredentialStorage);
});
