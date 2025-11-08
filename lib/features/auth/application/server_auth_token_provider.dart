import 'package:hommie/features/auth/application/server_credentials_provider.dart';
import 'package:hommie/services/networking/ha_oauth2_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_auth_token_provider.g.dart';

@Riverpod(dependencies: [serverCredentials])
Future<HAOAuth2Token> serverAuthToken(Ref ref, int serverId) async {
  final credentials = await ref.watch(
    serverCredentialsProvider(serverId).future,
  );
  return HAOAuth2Token(credentials);
}
