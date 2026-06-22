// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_server_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveServerSession)
const activeServerSessionProvider = ActiveServerSessionProvider._();

final class ActiveServerSessionProvider
    extends $NotifierProvider<ActiveServerSession, ActiveServerSessionState> {
  const ActiveServerSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeServerSessionProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          serverConnectionManagerProvider,
          authControllerProvider,
          activeServerProvider,
          authStateProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ActiveServerSessionProvider.$allTransitiveDependencies0,
          ActiveServerSessionProvider.$allTransitiveDependencies1,
          ActiveServerSessionProvider.$allTransitiveDependencies2,
          ActiveServerSessionProvider.$allTransitiveDependencies3,
          ActiveServerSessionProvider.$allTransitiveDependencies4,
          ActiveServerSessionProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = serverConnectionManagerProvider;
  static const $allTransitiveDependencies1 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = authControllerProvider;
  static const $allTransitiveDependencies3 =
      AuthControllerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 = activeServerProvider;
  static const $allTransitiveDependencies5 = authStateProvider;

  @override
  String debugGetCreateSourceHash() => _$activeServerSessionHash();

  @$internal
  @override
  ActiveServerSession create() => ActiveServerSession();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActiveServerSessionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActiveServerSessionState>(value),
    );
  }
}

String _$activeServerSessionHash() =>
    r'ebba1de2391893108eedb0aaf34358a6bb4c30f2';

abstract class _$ActiveServerSession
    extends $Notifier<ActiveServerSessionState> {
  ActiveServerSessionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<ActiveServerSessionState, ActiveServerSessionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ActiveServerSessionState, ActiveServerSessionState>,
              ActiveServerSessionState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
