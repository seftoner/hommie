sealed class ServerSyncState {
  const ServerSyncState();
}

final class SyncIdle extends ServerSyncState {
  const SyncIdle();
}

final class InitialSyncRunning extends ServerSyncState {
  const InitialSyncRunning();
}

final class SyncReady extends ServerSyncState {
  const SyncReady();
}

final class SyncOfflineWithCache extends ServerSyncState {
  const SyncOfflineWithCache();
}

final class SyncFailed extends ServerSyncState {
  const SyncFailed(this.error);

  final Object error;
}
