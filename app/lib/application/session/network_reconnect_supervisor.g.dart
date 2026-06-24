// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_reconnect_supervisor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(networkReconnectSupervisor)
final networkReconnectSupervisorProvider =
    NetworkReconnectSupervisorProvider._();

final class NetworkReconnectSupervisorProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  NetworkReconnectSupervisorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkReconnectSupervisorProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          serverConnectionManagerProvider,
          networkReachabilityProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>[
          NetworkReconnectSupervisorProvider.$allTransitiveDependencies0,
          NetworkReconnectSupervisorProvider.$allTransitiveDependencies1,
          NetworkReconnectSupervisorProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = serverConnectionManagerProvider;
  static final $allTransitiveDependencies1 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = networkReachabilityProvider;

  @override
  String debugGetCreateSourceHash() => _$networkReconnectSupervisorHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return networkReconnectSupervisor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$networkReconnectSupervisorHash() =>
    r'd97c983753722163b5a7d0b431a887e183a7d22e';
