import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_repository_provider.dart';
import 'package:hommie/features/servers/infrastructure/server_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_manager_provider.g.dart';

@Riverpod(keepAlive: true)
IServerManager serverManager(Ref ref) {
  final serverRepository = ref.read(serverRepositoryProvider);
  return ServerManager(serverRepository);
}
