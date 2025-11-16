import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';

part 'active_server_provider.g.dart';

@Riverpod(keepAlive: true)
class ActiveServer extends _$ActiveServer {
  StreamSubscription<Server?>? _subscription;

  @override
  Future<Server?> build() async {
    final serverManager = ref.watch(serverManagerProvider);
    _subscription?.cancel();

    final stream = serverManager.watchActiveServer();
    _subscription = stream.listen(
      (server) => state = AsyncData(server),
      onError: (error, stack) => state = AsyncError(error, stack),
    );

    ref.onDispose(() {
      _subscription?.cancel();
      _subscription = null;
    });
    ref.onCancel(() => _subscription?.pause());
    ref.onResume(() => _subscription?.resume());

    return serverManager.getActiveServer();
  }
}
