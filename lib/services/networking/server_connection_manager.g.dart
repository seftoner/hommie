// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connection_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ServerConnectionManager)
const serverConnectionManagerProvider = ServerConnectionManagerProvider._();

final class ServerConnectionManagerProvider
    extends $NotifierProvider<ServerConnectionManager, void> {
  const ServerConnectionManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverConnectionManagerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          activeServerProvider,
          serverConnectionStateProvider,
          serverManagerProvider,
          authRepositoryProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerConnectionManagerProvider.$allTransitiveDependencies0,
          ServerConnectionManagerProvider.$allTransitiveDependencies1,
          ServerConnectionManagerProvider.$allTransitiveDependencies2,
          ServerConnectionManagerProvider.$allTransitiveDependencies3,
          ServerConnectionManagerProvider.$allTransitiveDependencies4,
        },
      );

  static const $allTransitiveDependencies0 = activeServerProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = serverConnectionStateProvider;
  static const $allTransitiveDependencies4 = authRepositoryProvider;

  @override
  String debugGetCreateSourceHash() => _$serverConnectionManagerHash();

  @$internal
  @override
  ServerConnectionManager create() => ServerConnectionManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$serverConnectionManagerHash() =>
    r'd5b55ec05abbe4da625b92a80cddc49069aa8749';

abstract class _$ServerConnectionManager extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
