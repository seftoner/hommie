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
    final repository = ref.watch(haServersRepositoryProvider);
    final servers = await repository.getAvailableServers();
    _startPeriodicDiscovery();

    ref.onDispose(() {
      _timer?.cancel();
      _timer = null;
    });

    return servers;
  }

  void _startPeriodicDiscovery() {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      ref.invalidateSelf(); // Invalidate and rebuild the controller
    });
  }
}
