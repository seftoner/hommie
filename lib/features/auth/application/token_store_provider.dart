import 'package:hommie/features/auth/application/server_token_store.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_store_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [credentialRepository])
ServerTokenStore tokenStore(Ref ref, int serverId) {
  final repository = ref.read(credentialRepositoryProvider);
  return ServerTokenStore(repository, serverId);
}
