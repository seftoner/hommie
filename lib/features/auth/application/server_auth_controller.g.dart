// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ServerAuthController)
const serverAuthControllerProvider = ServerAuthControllerProvider._();

final class ServerAuthControllerProvider
    extends $AsyncNotifierProvider<ServerAuthController, AuthState> {
  const ServerAuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverAuthControllerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          serverManagerProvider,
          serverConnectionManagerProvider,
          serverConnectionStateProvider,
          activeServerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerAuthControllerProvider.$allTransitiveDependencies0,
          ServerAuthControllerProvider.$allTransitiveDependencies1,
          ServerAuthControllerProvider.$allTransitiveDependencies2,
          ServerAuthControllerProvider.$allTransitiveDependencies3,
          ServerAuthControllerProvider.$allTransitiveDependencies4,
          ServerAuthControllerProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = serverManagerProvider;
  static const $allTransitiveDependencies1 =
      ServerManagerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = serverConnectionManagerProvider;
  static const $allTransitiveDependencies3 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      ServerConnectionManagerProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      ServerConnectionManagerProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$serverAuthControllerHash();

  @$internal
  @override
  ServerAuthController create() => ServerAuthController();
}

String _$serverAuthControllerHash() =>
    r'e699e9137ab33024d5cfa4567e6c1a64f8f4a9f7';

abstract class _$ServerAuthController extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthState>, AuthState>,
              AsyncValue<AuthState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
