// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_session_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Coordinates everything related to a server "session":
/// - eagerly opens a websocket connection after the user authenticates
/// - watches for auth revocations from credential or transport layers and
///   triggers the logout flow so persisted data gets wiped

@ProviderFor(serverSessionCoordinator)
const serverSessionCoordinatorProvider = ServerSessionCoordinatorProvider._();

/// Coordinates everything related to a server "session":
/// - eagerly opens a websocket connection after the user authenticates
/// - watches for auth revocations from credential or transport layers and
///   triggers the logout flow so persisted data gets wiped

final class ServerSessionCoordinatorProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Coordinates everything related to a server "session":
  /// - eagerly opens a websocket connection after the user authenticates
  /// - watches for auth revocations from credential or transport layers and
  ///   triggers the logout flow so persisted data gets wiped
  const ServerSessionCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverSessionCoordinatorProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          authFlowControllerProvider,
          serverConnectionManagerProvider,
          serverConnectionStateProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerSessionCoordinatorProvider.$allTransitiveDependencies0,
          ServerSessionCoordinatorProvider.$allTransitiveDependencies1,
          ServerSessionCoordinatorProvider.$allTransitiveDependencies2,
          ServerSessionCoordinatorProvider.$allTransitiveDependencies3,
          ServerSessionCoordinatorProvider.$allTransitiveDependencies4,
        },
      );

  static const $allTransitiveDependencies0 = authFlowControllerProvider;
  static const $allTransitiveDependencies1 =
      AuthFlowControllerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      AuthFlowControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      AuthFlowControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      AuthFlowControllerProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$serverSessionCoordinatorHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return serverSessionCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$serverSessionCoordinatorHash() =>
    r'81cecb62f6e1e6cd8d82bfb3aa57d404d7d5e1e7';
