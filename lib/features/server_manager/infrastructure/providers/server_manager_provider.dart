import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/server_manager/domain/i_server_manager.dart';
import 'package:hommie/features/server_manager/infrastructure/providers/server_repository_provider.dart';
import 'package:hommie/features/server_manager/infrastructure/server_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_manager_provider.g.dart';

@riverpod
IServerManager serverManager(Ref ref) {
  final serverRepository = ref.read(serverRepositoryProvider);
  return ServerManager(serverRepository, ref);
}
