// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_reachability_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(networkReachability)
final networkReachabilityProvider = NetworkReachabilityProvider._();

final class NetworkReachabilityProvider
    extends
        $FunctionalProvider<
          INetworkReachabilityRepository,
          INetworkReachabilityRepository,
          INetworkReachabilityRepository
        >
    with $Provider<INetworkReachabilityRepository> {
  NetworkReachabilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkReachabilityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkReachabilityHash();

  @$internal
  @override
  $ProviderElement<INetworkReachabilityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  INetworkReachabilityRepository create(Ref ref) {
    return networkReachability(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(INetworkReachabilityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<INetworkReachabilityRepository>(
        value,
      ),
    );
  }
}

String _$networkReachabilityHash() =>
    r'70bae34bed8829f1f63c64d382704c07e9f9936f';
