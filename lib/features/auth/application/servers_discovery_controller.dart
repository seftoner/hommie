import 'dart:async';

import 'package:hommie/features/auth/domain/entities/ha_server.dart';
import 'package:hommie/features/auth/ha_servers_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'servers_discovery_controller.g.dart';

@riverpod
class ServersDiscoveryController extends _$ServersDiscoveryController {
  Timer? _timer;

  @override
  Future<List<HaServer>> build() async {
    _startPeriodicDiscovery();
    return _fetchServers();
  }

  Future<List<HaServer>> _fetchServers() async {
    // state = const AsyncValue.loading();
    final repository = ref.watch(haServersRepositoryProvider);
    return await repository.getAvailableServers();
  }

  Future<void> refresh() async {
    // state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchServers);
  }

  void _startPeriodicDiscovery() {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      refresh();
    });
  }
}
