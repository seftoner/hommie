import 'dart:async';

import 'package:hommie/features/auth/domain/entities/ha_server.dart';
import 'package:hommie/features/auth/ha_servers_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'servers_discovery_controller.g.dart';

@riverpod
class ServersDiscoveryController extends _$ServersDiscoveryController {
  @override
  Future<List<HaServer>> build() async {
    final repository = ref.watch(haServersRepositoryProvider);

    return repository.getAvailableServers();
  }
}
