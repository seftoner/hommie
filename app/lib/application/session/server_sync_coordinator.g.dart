// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_sync_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServerSyncCoordinator)
const serverSyncCoordinatorProvider = ServerSyncCoordinatorProvider._();

final class ServerSyncCoordinatorProvider
    extends $NotifierProvider<ServerSyncCoordinator, ServerSyncState> {
  const ServerSyncCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverSyncCoordinatorProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          activeServerSessionProvider,
          areaRepositoryProvider,
          entityRepositoryProvider,
          areaRegistrySyncServiceProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerSyncCoordinatorProvider.$allTransitiveDependencies0,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies1,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies2,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies3,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies4,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies5,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies6,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies7,
        },
      );

  static const $allTransitiveDependencies0 = activeServerSessionProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 = areaRepositoryProvider;
  static const $allTransitiveDependencies6 = entityRepositoryProvider;
  static const $allTransitiveDependencies7 = areaRegistrySyncServiceProvider;

  @override
  String debugGetCreateSourceHash() => _$serverSyncCoordinatorHash();

  @$internal
  @override
  ServerSyncCoordinator create() => ServerSyncCoordinator();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServerSyncState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServerSyncState>(value),
    );
  }
}

String _$serverSyncCoordinatorHash() =>
    r'dc50e7eb856588fa4c97b7e2d83a67ea31b36a3d';

abstract class _$ServerSyncCoordinator extends $Notifier<ServerSyncState> {
  ServerSyncState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ServerSyncState, ServerSyncState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ServerSyncState, ServerSyncState>,
              ServerSyncState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
