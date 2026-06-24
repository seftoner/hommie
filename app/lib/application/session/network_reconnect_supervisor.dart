import 'dart:async';

import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/network_reachability_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_reconnect_supervisor.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [serverConnectionManager, networkReachability],
)
void networkReconnectSupervisor(Ref ref) {
  final manager = ref.read(serverConnectionManagerProvider);
  final reachability = ref.watch(networkReachabilityProvider);
  var lastAvailabilityResolved = false;
  var lastAvailable = false;

  unawaited(
    reachability.isAvailable.then((isAvailable) {
      if (!ref.mounted) {
        return;
      }

      lastAvailabilityResolved = true;
      lastAvailable = isAvailable;
      manager.setNetworkAvailable(isAvailable: isAvailable);
    }),
  );

  final subscription = reachability.availability.listen((isAvailable) {
    if (!lastAvailabilityResolved) {
      lastAvailabilityResolved = true;
      lastAvailable = isAvailable;
      manager.setNetworkAvailable(isAvailable: isAvailable);
      return;
    }

    if (lastAvailable == isAvailable) {
      return;
    }

    final wasAvailable = lastAvailable;
    lastAvailable = isAvailable;
    manager.setNetworkAvailable(isAvailable: isAvailable);

    if (!wasAvailable && isAvailable) {
      manager.retryActiveConnection();
    }
  });

  ref.onDispose(subscription.cancel);
}
