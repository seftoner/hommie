// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connection_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
          serverConfigProvider,
          serverAuthTokenProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerConnectionManagerProvider.$allTransitiveDependencies0,
          ServerConnectionManagerProvider.$allTransitiveDependencies1,
          ServerConnectionManagerProvider.$allTransitiveDependencies2,
          ServerConnectionManagerProvider.$allTransitiveDependencies3,
          ServerConnectionManagerProvider.$allTransitiveDependencies4,
          ServerConnectionManagerProvider.$allTransitiveDependencies5,
          ServerConnectionManagerProvider.$allTransitiveDependencies6,
        },
      );

  static const $allTransitiveDependencies0 = activeServerProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = serverConnectionStateProvider;
  static const $allTransitiveDependencies3 = serverConfigProvider;
  static const $allTransitiveDependencies4 = serverAuthTokenProvider;
  static const $allTransitiveDependencies5 =
      ServerAuthTokenProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies6 =
      ServerAuthTokenProvider.$allTransitiveDependencies1;

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
    r'ce8e4827ccc9a26714b3630aaf086c6cb469ca04';

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
