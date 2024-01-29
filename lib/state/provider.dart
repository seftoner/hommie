import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/data/auth_state.dart';
import 'package:hommie/networking/credential_storage.dart';
import 'package:hommie/networking/ha_authenticator.dart';
import 'package:hommie/networking/secure_credentials_storage.dart';
import 'package:hommie/state/auth_controller.dart';

final flutterSecureStorage = Provider((ref) => const FlutterSecureStorage());
final credentialStorageProvider = Provider<CredentialStorage>(
  (ref) => SecureCredentialStorage(
    ref.watch(flutterSecureStorage),
  ),
);
final uaAuthenticatorProvider = Provider(
  (ref) => HAAuthenticator(
    ref.watch(credentialStorageProvider),
    "http://192.168.0.109:8123",
  ),
);

final authcontrollerNotifierProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthState>(
        (ref) => AuthController(ref.read(uaAuthenticatorProvider)));
