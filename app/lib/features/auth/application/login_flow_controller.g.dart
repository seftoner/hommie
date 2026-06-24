// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(loginFlowController)
final loginFlowControllerProvider = LoginFlowControllerProvider._();

final class LoginFlowControllerProvider
    extends
        $FunctionalProvider<
          LoginFlowController,
          LoginFlowController,
          LoginFlowController
        >
    with $Provider<LoginFlowController> {
  LoginFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginFlowControllerProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          authRepositoryProvider,
          serverConnectionManagerProvider,
          homeAssistantApiProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          LoginFlowControllerProvider.$allTransitiveDependencies0,
          LoginFlowControllerProvider.$allTransitiveDependencies1,
          LoginFlowControllerProvider.$allTransitiveDependencies2,
          LoginFlowControllerProvider.$allTransitiveDependencies3,
          LoginFlowControllerProvider.$allTransitiveDependencies4,
          LoginFlowControllerProvider.$allTransitiveDependencies5,
        },
      );

  static final $allTransitiveDependencies0 = authRepositoryProvider;
  static final $allTransitiveDependencies1 = serverConnectionManagerProvider;
  static final $allTransitiveDependencies2 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies3 = homeAssistantApiProvider;
  static final $allTransitiveDependencies4 =
      HomeAssistantApiProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies5 =
      HomeAssistantApiProvider.$allTransitiveDependencies2;

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
    r'acb584345d8e854589beac8d144b0268ad79b7ab';
