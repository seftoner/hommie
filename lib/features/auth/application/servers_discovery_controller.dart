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

    final repository = ref.watch(haServersRepositoryProvider);

    ref.onDispose(() {
      _timer?.cancel(); // Cancel the timer if it exists
      _timer = null;
    });

    return repository.getAvailableServers();
  }

  void _startPeriodicDiscovery() {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      ref.invalidateSelf(); // Invalidate and rebuild the controller
    });
  }
}
