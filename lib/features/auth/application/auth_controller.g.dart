// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authController)
const authControllerProvider = AuthControllerProvider._();

final class AuthControllerProvider
    extends $FunctionalProvider<AuthController, AuthController, AuthController>
    with $Provider<AuthController> {
  const AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          websocketConfigRepositoryProvider,
          serverConnectionManagerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AuthControllerProvider.$allTransitiveDependencies0,
          AuthControllerProvider.$allTransitiveDependencies1,
          AuthControllerProvider.$allTransitiveDependencies2,
        ],
      );

  static const $allTransitiveDependencies0 = websocketConfigRepositoryProvider;
  static const $allTransitiveDependencies1 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  $ProviderElement<AuthController> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthController create(Ref ref) {
    return authController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthController>(value),
    );
  }
}

String _$authControllerHash() => r'74e2b9476cc9306b7f5552765487e64d4315efa0';
