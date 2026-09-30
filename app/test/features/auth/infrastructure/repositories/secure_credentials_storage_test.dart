import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/infrastructure/repositories/secure_credentials_storage.dart';
import 'package:oauth2/oauth2.dart';

void main() {
  test(
    'replacement waits for delete before writing and remains readable',
    () async {
      final storage = _GatedStorage();
      final repository = SecureCredentialRepository(storage);
      final credentials = Credentials(
        'new-token',
        refreshToken: 'refresh-token',
        tokenEndpoint: Uri.parse('https://example.test/auth/token'),
      );

      final save = repository.save(7, credentials);
      await Future<void>.delayed(Duration.zero);
      final eventsBeforeDeleteCompletes = [...storage.events];
      storage.completeDelete();
      await save;

      expect(eventsBeforeDeleteCompletes, [
        'delete:oauthCredentialsForServer:7',
      ]);
      expect(storage.events, [
        'delete:oauthCredentialsForServer:7',
        'write:oauthCredentialsForServer:7',
      ]);
      final freshRepository = SecureCredentialRepository(storage);
      expect((await freshRepository.read(7))?.accessToken, 'new-token');
    },
  );
}

class _GatedStorage extends FlutterSecureStorage {
  final events = <String>[];
  final values = <String, String>{};
  final _deleteGate = Completer<void>();

  void completeDelete() => _deleteGate.complete();

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    events.add('delete:$key');
    await _deleteGate.future;
    values.remove(key);
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    events.add('write:$key');
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  }

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async => values[key];
}
