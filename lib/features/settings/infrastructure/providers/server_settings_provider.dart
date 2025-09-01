import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/settings/domain/repository/i_server_settings_repository.dart';
import 'package:hommie/features/settings/infrastructure/repositories/secure_server_settings_repository.dart';

part 'server_settings_provider.g.dart';

@riverpod
IServerSettingsRepository serverSettings(Ref ref) {
  return SecureServerSettingsRepository(const FlutterSecureStorage());
}
