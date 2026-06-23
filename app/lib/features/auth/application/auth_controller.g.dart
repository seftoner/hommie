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
          loginFlowControllerProvider,
          serverLifecycleControllerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          AuthControllerProvider.$allTransitiveDependencies0,
          AuthControllerProvider.$allTransitiveDependencies1,
          AuthControllerProvider.$allTransitiveDependencies2,
          AuthControllerProvider.$allTransitiveDependencies3,
          AuthControllerProvider.$allTransitiveDependencies4,
          AuthControllerProvider.$allTransitiveDependencies5,
          AuthControllerProvider.$allTransitiveDependencies6,
        },
      );

  static const $allTransitiveDependencies0 = loginFlowControllerProvider;
  static const $allTransitiveDependencies1 =
      LoginFlowControllerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      LoginFlowControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      LoginFlowControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      LoginFlowControllerProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 = serverLifecycleControllerProvider;
  static const $allTransitiveDependencies6 =
      ServerLifecycleControllerProvider.$allTransitiveDependencies3;

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

String _$authControllerHash() => r'70a0440308e6403aecefe40c16c8b8f52e70b3d4';
