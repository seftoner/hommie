// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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

String _$serverManagerHash() => r'6912a9d2aa492475253e107d6361467fe6257033';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
