// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(loginFlowController)
const loginFlowControllerProvider = LoginFlowControllerProvider._();

final class LoginFlowControllerProvider
    extends
        $FunctionalProvider<
          LoginFlowController,
          LoginFlowController,
          LoginFlowController
        >
    with $Provider<LoginFlowController> {
  const LoginFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginFlowControllerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          authRepositoryProvider,
          websocketConfigRepositoryProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          LoginFlowControllerProvider.$allTransitiveDependencies0,
          LoginFlowControllerProvider.$allTransitiveDependencies1,
          LoginFlowControllerProvider.$allTransitiveDependencies2,
          LoginFlowControllerProvider.$allTransitiveDependencies3,
        },
      );

  static const $allTransitiveDependencies0 = authRepositoryProvider;
  static const $allTransitiveDependencies1 = websocketConfigRepositoryProvider;
  static const $allTransitiveDependencies2 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies3 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$loginFlowControllerHash();

  @$internal
  @override
  $ProviderElement<LoginFlowController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LoginFlowController create(Ref ref) {
    return loginFlowController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginFlowController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginFlowController>(value),
    );
  }
}

String _$loginFlowControllerHash() =>
    r'8d9e2bd1f50b6b71fc964cc8fb554c07fefa3115';
