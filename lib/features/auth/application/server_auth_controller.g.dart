// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
          authRepositoryProvider,
          serverConnectionManagerProvider,
          serverConnectionStateProvider,
          activeServerProvider,
          websocketConfigRepositoryProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerAuthControllerProvider.$allTransitiveDependencies0,
          ServerAuthControllerProvider.$allTransitiveDependencies1,
          ServerAuthControllerProvider.$allTransitiveDependencies2,
          ServerAuthControllerProvider.$allTransitiveDependencies3,
          ServerAuthControllerProvider.$allTransitiveDependencies4,
          ServerAuthControllerProvider.$allTransitiveDependencies5,
          ServerAuthControllerProvider.$allTransitiveDependencies6,
        },
      );

  static const $allTransitiveDependencies0 = serverManagerProvider;
  static const $allTransitiveDependencies1 = authRepositoryProvider;
  static const $allTransitiveDependencies2 = serverConnectionManagerProvider;
  static const $allTransitiveDependencies3 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      ServerConnectionManagerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies5 = websocketConfigRepositoryProvider;
  static const $allTransitiveDependencies6 =
      WebsocketConfigRepositoryProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$serverAuthControllerHash();

  @$internal
  @override
  ServerAuthController create() => ServerAuthController();
}

String _$serverAuthControllerHash() =>
    r'a14f9a1a954dc424c85b8055e397b7b78f6a1f6d';

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
