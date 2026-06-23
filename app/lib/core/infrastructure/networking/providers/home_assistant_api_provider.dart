import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/http/http_client_provider.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_config_provider.dart';
import 'package:hommie/features/auth/infrastructure/providers/server_auth_token_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_assistant_api_provider.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [serverConfig, serverAuthToken, httpClient],
)
Future<HomeAssistantApi> homeAssistantApi(Ref ref, int serverId) async {
  final server = await ref.watch(serverConfigProvider(serverId).future);
  final token = await ref.watch(serverAuthTokenProvider(serverId).future);
  final httpClient = ref.watch(httpClientProvider);

  return HomeAssistantApi(
    serverUri: Uri.parse(server.url),
    tokenProvider: () => token.accessToken,
    httpClient: httpClient,
  );
}
