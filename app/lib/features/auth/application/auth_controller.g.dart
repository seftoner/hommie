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
        isAutoDispose: false,
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
  static const $allTransitiveDependencies1 = serverConnectionManagerProvider;
  static const $allTransitiveDependencies2 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;

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

String _$authControllerHash() => r'32fbff39d39dc9a508d00b7542c52df539cf6f1f';
