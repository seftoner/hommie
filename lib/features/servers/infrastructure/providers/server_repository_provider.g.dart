// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serverRepository)
const serverRepositoryProvider = ServerRepositoryProvider._();

final class ServerRepositoryProvider
    extends
        $FunctionalProvider<
          IServerRepository,
          IServerRepository,
          IServerRepository
        >
    with $Provider<IServerRepository> {
  const ServerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serverRepositoryHash();

  @$internal
  @override
  $ProviderElement<IServerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IServerRepository create(Ref ref) {
    return serverRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IServerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IServerRepository>(value),
    );
  }
}

String _$serverRepositoryHash() => r'4823452b3ed063537b1a0f11a9eff295a7660d09';
