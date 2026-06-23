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
        dependencies: const <ProviderOrFamily>[serverConfigProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ServerConnectionManagerProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverConfigProvider;

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
    r'2599a5badfe84f94f9d58bf69d7fd7df9606a00f';
