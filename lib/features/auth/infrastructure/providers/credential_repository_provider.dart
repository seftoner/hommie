import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:hommie/features/auth/infrastructure/repositories/secure_credentials_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'credential_repository_provider.g.dart';

@riverpod
ICredentialRepository credentialsRepository(Ref ref, int serverId) {
  return SecureCredentialRepository(const FlutterSecureStorage(), serverId);
}
