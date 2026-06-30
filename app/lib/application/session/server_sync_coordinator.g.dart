// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_sync_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServerSyncCoordinator)
final serverSyncCoordinatorProvider = ServerSyncCoordinatorProvider._();

final class ServerSyncCoordinatorProvider
    extends $NotifierProvider<ServerSyncCoordinator, ServerSyncState> {
  ServerSyncCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverSyncCoordinatorProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          activeServerSessionProvider,
          areaRepositoryProvider,
          deviceRepositoryProvider,
          entityRepositoryProvider,
          areaRegistrySyncServiceProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ServerSyncCoordinatorProvider.$allTransitiveDependencies0,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies1,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies2,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies3,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies4,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies5,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies6,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies7,
          ServerSyncCoordinatorProvider.$allTransitiveDependencies8,
        },
      );

  static final $allTransitiveDependencies0 = activeServerSessionProvider;
  static final $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 = areaRepositoryProvider;
  static final $allTransitiveDependencies6 = deviceRepositoryProvider;
  static final $allTransitiveDependencies7 = entityRepositoryProvider;
  static final $allTransitiveDependencies8 = areaRegistrySyncServiceProvider;

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
    r'5945b7da7d5c78184877888b18d8fbdaa2b52480';

abstract class _$ServerSyncCoordinator extends $Notifier<ServerSyncState> {
  ServerSyncState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ServerSyncState, ServerSyncState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ServerSyncState, ServerSyncState>,
              ServerSyncState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
