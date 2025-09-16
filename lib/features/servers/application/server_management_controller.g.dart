// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_management_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServerManagementController)
const serverManagementControllerProvider =
    ServerManagementControllerProvider._();

final class ServerManagementControllerProvider
    extends $NotifierProvider<ServerManagementController, ServerTestResult> {
  const ServerManagementControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverManagementControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          serversListProvider,
          serverAuthControllerProvider,
          activeServerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerManagementControllerProvider.$allTransitiveDependencies0,
          ServerManagementControllerProvider.$allTransitiveDependencies1,
          ServerManagementControllerProvider.$allTransitiveDependencies2,
          ServerManagementControllerProvider.$allTransitiveDependencies3,
          ServerManagementControllerProvider.$allTransitiveDependencies4,
          ServerManagementControllerProvider.$allTransitiveDependencies5,
          ServerManagementControllerProvider.$allTransitiveDependencies6,
          ServerManagementControllerProvider.$allTransitiveDependencies7,
          ServerManagementControllerProvider.$allTransitiveDependencies8,
        },
      );

  static const $allTransitiveDependencies0 = serversListProvider;
  static const $allTransitiveDependencies1 =
      ServersListProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = serverAuthControllerProvider;
  static const $allTransitiveDependencies3 =
      ServerAuthControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies4 =
      ServerAuthControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies5 =
      ServerAuthControllerProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies6 =
      ServerAuthControllerProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies7 =
      ServerAuthControllerProvider.$allTransitiveDependencies5;
  static const $allTransitiveDependencies8 =
      ServerAuthControllerProvider.$allTransitiveDependencies6;

  @override
  String debugGetCreateSourceHash() => _$serverManagementControllerHash();

  @$internal
  @override
  ServerManagementController create() => ServerManagementController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServerTestResult value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServerTestResult>(value),
    );
  }
}

String _$serverManagementControllerHash() =>
    r'e3c7e97dae80bbe343527633dd7695df970fd318';

abstract class _$ServerManagementController
    extends $Notifier<ServerTestResult> {
  ServerTestResult build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ServerTestResult, ServerTestResult>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ServerTestResult, ServerTestResult>,
              ServerTestResult,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
