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
          serverConnectionManagerProvider,
          authControllerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerSessionCoordinatorProvider.$allTransitiveDependencies0,
          ServerSessionCoordinatorProvider.$allTransitiveDependencies1,
          ServerSessionCoordinatorProvider.$allTransitiveDependencies2,
          ServerSessionCoordinatorProvider.$allTransitiveDependencies3,
        },
      );

  static const $allTransitiveDependencies0 = serverConnectionManagerProvider;
  static const $allTransitiveDependencies1 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = authControllerProvider;
  static const $allTransitiveDependencies3 =
      AuthControllerProvider.$allTransitiveDependencies0;

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
    r'74dc15b250304f820ce8118134a6701aa0bb5f02';
