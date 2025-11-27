// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authFlowController)
const authFlowControllerProvider = AuthFlowControllerProvider._();

final class AuthFlowControllerProvider
    extends
        $FunctionalProvider<
          AuthFlowController,
          AuthFlowController,
          AuthFlowController
        >
    with $Provider<AuthFlowController> {
  const AuthFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authFlowControllerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          websocketConfigRepositoryProvider,
          serverConnectionManagerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          AuthFlowControllerProvider.$allTransitiveDependencies0,
          AuthFlowControllerProvider.$allTransitiveDependencies1,
          AuthFlowControllerProvider.$allTransitiveDependencies2,
          AuthFlowControllerProvider.$allTransitiveDependencies3,
          AuthFlowControllerProvider.$allTransitiveDependencies4,
          AuthFlowControllerProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = websocketConfigRepositoryProvider;
  static const $allTransitiveDependencies1 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$authFlowControllerHash();

  @$internal
  @override
  $ProviderElement<AuthFlowController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthFlowController create(Ref ref) {
    return authFlowController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthFlowController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthFlowController>(value),
    );
  }
}

String _$authFlowControllerHash() =>
    r'5ac3abfbd5b8ac3675f07b1e4a981e4ae3ecc224';
