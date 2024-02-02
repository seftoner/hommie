import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/networking/ha_authenticator.dart';
import 'package:hommie/networking/secure_credentials_storage.dart';

final uaAuthenticatorProvider = Provider((ref) =>
    HAAuthenticator(SecureCredentialStorage(const FlutterSecureStorage())));
