import 'dart:async';

import 'package:hommie/features/auth/domain/entities/ha_server.dart';
import 'package:hommie/features/auth/infrastructure/providers/ha_servers_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'servers_discovery_controller.g.dart';

@riverpod
class ServersDiscoveryController extends _$ServersDiscoveryController {
  Timer? _timer;
  static const Duration _discoveryInterval = Duration(seconds: 10);

  @override
  Future<List<HaServer>> build() async {
    ref.onDispose(() {
      _timer?.cancel();
      _timer = null;
    });

    ref.onCancel(() {
      _timer?.cancel();
      _timer = null;
    });

    ref.onResume(() {
      _startPeriodicDiscovery();
    });

    _startPeriodicDiscovery();
    return _fetchServers();
  }

  Future<List<HaServer>> _fetchServers() async {
    // state = const AsyncValue.loading();
    final repository = ref.watch(haServersRepositoryProvider);
    return repository.getAvailableServers();
  }

  Future<void> refresh() async {
    if (!ref.mounted) {
      return;
    }

    state = await AsyncValue.guard(_fetchServers);
  }

  Future<void> forceRefresh() async {
    final repository = ref.read(haServersRepositoryProvider);
    repository.clearCache();

    await refresh();
  }

  void _startPeriodicDiscovery() {
    if (_timer != null) {
      return;
    }

    _timer = Timer.periodic(_discoveryInterval, (_) async {
      await refresh();
    });
  }
}
