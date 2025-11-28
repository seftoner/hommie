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
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ServerConnectionManagerProvider.$allTransitiveDependencies0,
          ServerConnectionManagerProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = serverConnectionStateProvider;
  static const $allTransitiveDependencies1 = serverConfigProvider;

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
    r'ce18c96439e40b7f7f7a39f992bd108b43643c24';
