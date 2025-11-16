// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serverManager)
const serverManagerProvider = ServerManagerProvider._();

final class ServerManagerProvider
    extends $FunctionalProvider<IServerManager, IServerManager, IServerManager>
    with $Provider<IServerManager> {
  const ServerManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serverManagerHash();

  @$internal
  @override
  $ProviderElement<IServerManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IServerManager create(Ref ref) {
    return serverManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IServerManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IServerManager>(value),
    );
  }
}

String _$serverManagerHash() => r'b479ded34c769a2f3a2c8374ff9987e5e233d92c';
