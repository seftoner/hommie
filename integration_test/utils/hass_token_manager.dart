import 'dart:convert';
import 'remote_hass_cli.dart';

class HassTokenManager {
  final RemoteHassCli _cli;
  static const _clientName = 'hommie_integration_test';

  HassTokenManager({RemoteHassCli? cli}) : _cli = cli ?? RemoteHassCli();

  /// Lists all refresh tokens and returns them as a List
  Future<List<dynamic>> _listTokens() async {
    final listTokens = 'raw ws auth/refresh_tokens';
    final result = await _cli.execute(listTokens);

    return result.fold(
      (error) => throw Exception(
          'Failed to list tokens: ${error.message}. ${error.error}'),
      (success) {
        if (!success.isSuccess) {
          throw Exception('Failed to list tokens: ${success.stderr}');
        }
        final response = jsonDecode(success.stdout);
        return response['result'] as List;
      },
    );
  }

  /// Deletes a token by its ID
  Future<bool> _deleteToken(String tokenId) async {
    final deleteToken = [
      'raw',
      'ws',
      'auth/delete_refresh_token',
      '--json={"refresh_token_id":"$tokenId"}'
    ].join(' ');

    final deleteResult = await _cli.execute(deleteToken);
    return deleteResult.fold(
      (error) => throw Exception('Failed to delete token: ${error.message}'),
      (success) {
        if (!success.isSuccess) {
          throw Exception('Failed to delete token: ${success.stderr}');
        }

        final response = jsonDecode(success.stdout);
        if (response['error']?['code'] == 'invalid_token_id') {
          return false;
        }

        return true;
      },
    );
  }

  /// Creates a long-lived Home Assistant access token.
  ///
  /// This method is used to generate a new access token for Home Assistant API authentication.
  /// The token can be created through the Home Assistant web interface:
  /// User Profile -> Security -> Create Long-Lived Access Token
  ///
  /// Returns a [Future<String>] containing the generated access token.
  Future<String> createLongLivedToken() async {
    final createToken = [
      'raw',
      'ws',
      'auth/long_lived_access_token',
      '--json={"lifespan":3650,"client_name":"$_clientName"}'
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

  /// Removes the long-lived access token from Home Assistant.
  ///
  /// This method cleans up by deleting the token associated with the client from
  /// the Home Assistant security settings. Similar to manually removing a token by:
  /// 1. Going to user profile
  /// 2. Navigating to security settings
  /// 3. Finding the long-lived access token with matching client name
  /// 4. Removing the token
  ///
  /// This should be called when the token is no longer needed or during cleanup.
  Future<bool> deleteLongLivedToken() async {
    final tokens = await _listTokens();
    final token = tokens.firstWhere(
      (t) => t['client_name'] == _clientName,
      orElse: () => null,
    );

    if (token != null) {
      return await _deleteToken(token['id']);
    }

    return false;
  }

  /// Removes the refresh token associated with the Hommie client.
  ///
  /// This method finds and removes the refresh token with client_id "https://seftoner.github.io".
  /// Returns true if a token was found and deleted, false if no matching token was found.
  Future<bool> deleteHommieToken() async {
    final tokens = await _listTokens();
    final token = tokens.firstWhere(
      ///TODO: same value is stored in AuthRepository._clientID.
      ///Move it to common file
      (t) => t['client_id'] == 'https://seftoner.github.io',
      orElse: () => null,
    );

    if (token == null) {
      return false;
    }

    return await _deleteToken(token['id']);
  }
}
