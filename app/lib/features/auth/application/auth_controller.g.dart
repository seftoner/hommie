// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authController)
final authControllerProvider = AuthControllerProvider._();

final class AuthControllerProvider
    extends $FunctionalProvider<AuthController, AuthController, AuthController>
    with $Provider<AuthController> {
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          loginFlowControllerProvider,
          serverLifecycleControllerProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AuthControllerProvider.$allTransitiveDependencies0,
          AuthControllerProvider.$allTransitiveDependencies1,
          AuthControllerProvider.$allTransitiveDependencies2,
          AuthControllerProvider.$allTransitiveDependencies3,
          AuthControllerProvider.$allTransitiveDependencies4,
          AuthControllerProvider.$allTransitiveDependencies5,
          AuthControllerProvider.$allTransitiveDependencies6,
          AuthControllerProvider.$allTransitiveDependencies7,
          AuthControllerProvider.$allTransitiveDependencies8,
        },
      );

  static final $allTransitiveDependencies0 = loginFlowControllerProvider;
  static final $allTransitiveDependencies1 =
      LoginFlowControllerProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      LoginFlowControllerProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      LoginFlowControllerProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      LoginFlowControllerProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
      LoginFlowControllerProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies6 =
      LoginFlowControllerProvider.$allTransitiveDependencies5;
  static final $allTransitiveDependencies7 = serverLifecycleControllerProvider;
  static final $allTransitiveDependencies8 =
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
