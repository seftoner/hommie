import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';

part 'active_server.g.dart';

@Riverpod(keepAlive: true)
Stream<Server?> activeServer(Ref ref) async* {
  final serverManager = ref.watch(serverManagerProvider);
  final current = await serverManager.getActiveServer();
  // Emit the persisted value first so consumers have synchronous access
  // even if the manager stream hasn't produced an event yet.
  yield current;

  // Forward live updates from the manager stream.
  yield* serverManager.watchActiveServer();
}
