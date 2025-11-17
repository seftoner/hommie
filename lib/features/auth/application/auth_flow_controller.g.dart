// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthFlowController)
const authFlowControllerProvider = AuthFlowControllerProvider._();

final class AuthFlowControllerProvider
    extends $NotifierProvider<AuthFlowController, void> {
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
  AuthFlowController create() => AuthFlowController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$authFlowControllerHash() =>
    r'0fdca1d52517cc1c60ab345e7045ec29d0ca2fc4';

abstract class _$AuthFlowController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
