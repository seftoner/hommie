import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:hommie/services/networking/secure_credentials_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final securityCredentialStorage =
      SecureCredentialStorage(const FlutterSecureStorage());
  return AuthRepository(securityCredentialStorage);
}

sealed class LoginState {}

class Init extends LoginState {}

class Unautenticated extends LoginState {}

class LoggedIn extends LoginState {}

/// Provides a [ValueNotifier] to the app router to redirect on auth state change
final authStateListenable = ValueNotifier<LoginState>(Init());
