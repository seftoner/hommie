// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connection_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serverConnectionManager)
const serverConnectionManagerProvider = ServerConnectionManagerProvider._();

final class ServerConnectionManagerProvider
    extends
        $FunctionalProvider<
          IServerConnectionManager,
          IServerConnectionManager,
          IServerConnectionManager
        >
    with $Provider<IServerConnectionManager> {
  const ServerConnectionManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverConnectionManagerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
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
        },
      );

  static const $allTransitiveDependencies0 = serverConnectionStateProvider;
  static const $allTransitiveDependencies1 = serverConfigProvider;
  static const $allTransitiveDependencies2 = serverAuthTokenProvider;
  static const $allTransitiveDependencies3 =
      ServerAuthTokenProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      ServerAuthTokenProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$serverConnectionManagerHash();

  @$internal
  @override
  $ProviderElement<IServerConnectionManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IServerConnectionManager create(Ref ref) {
    return serverConnectionManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IServerConnectionManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IServerConnectionManager>(value),
    );
  }
}

String _$serverConnectionManagerHash() =>
    r'2f05f52fd96349f52095ff0ca945d5e7ff4d754b';
