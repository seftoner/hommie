import 'dart:convert';
import 'remote_hass_cli.dart';

class HassTokenManager {
  final RemoteHassCli _cli;
  static const clientName = 'hommie_integration_test';

  HassTokenManager({RemoteHassCli? cli}) : _cli = cli ?? RemoteHassCli();

  Future<String> createToken() async {
    final createToken = [
      'raw',
      'ws',
      'auth/long_lived_access_token',
      '--json={"lifespan":3650,"client_name":"$clientName"}'
    ].join(' ');

    final result = await _cli.execute(createToken);

    return result.fold(
      (error) => throw Exception(
          'Failed to create token: ${error.message}. ${error.error}'),
      (success) {
        if (!success.isSuccess) {
          throw Exception('Failed to create token: ${success.stderr}');
        }
        final response = jsonDecode(success.stdout);
        return response['result'] as String;
      },
    );
  }

  Future<void> cleanupToken() async {
    final listTokens = 'raw ws auth/refresh_tokens';
    final result = await _cli.execute(listTokens);

    final tokenId = result.fold(
      (error) => throw Exception('Failed to list tokens: ${error.message}'),
      (success) {
        if (!success.isSuccess) {
          throw Exception('Failed to list tokens: ${success.stderr}');
        }
        final response = jsonDecode(success.stdout);
        final tokens = response['result'] as List;
        final token = tokens.firstWhere(
          (t) => t['client_name'] == clientName,
          orElse: () => null,
        );
        return token == null ? null : token['id'] as String;
      },
    );

    if (tokenId == null) {
      return;
    }

    final deleteToken = [
      'raw',
      'ws',
      'auth/delete_refresh_token',
      '--json={"refresh_token_id":"$tokenId"}'
    ].join(' ');

    final deleteResult = await _cli.execute(deleteToken);
    deleteResult.fold(
      (error) => throw Exception('Failed to delete token: ${error.message}'),
      (success) {
        if (!success.isSuccess) {
          throw Exception('Failed to delete token: ${success.stderr}');
        }
      },
    );
  }
}
