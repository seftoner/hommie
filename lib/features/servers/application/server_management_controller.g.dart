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
          authFlowControllerProvider,
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
          ServerManagementControllerProvider.$allTransitiveDependencies9,
          ServerManagementControllerProvider.$allTransitiveDependencies10,
          ServerManagementControllerProvider.$allTransitiveDependencies11,
          ServerManagementControllerProvider.$allTransitiveDependencies12,
          ServerManagementControllerProvider.$allTransitiveDependencies13,
          ServerManagementControllerProvider.$allTransitiveDependencies14,
          ServerManagementControllerProvider.$allTransitiveDependencies15,
          ServerManagementControllerProvider.$allTransitiveDependencies16,
          ServerManagementControllerProvider.$allTransitiveDependencies17,
        },
      );

  static const $allTransitiveDependencies0 = serversListProvider;
  static const $allTransitiveDependencies1 =
      ServersListProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = authFlowControllerProvider;
  static const $allTransitiveDependencies3 =
      AuthFlowControllerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      AuthFlowControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies5 =
      AuthFlowControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies6 =
      AuthFlowControllerProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies7 =
      AuthFlowControllerProvider.$allTransitiveDependencies5;
  static const $allTransitiveDependencies8 =
      AuthFlowControllerProvider.$allTransitiveDependencies6;
  static const $allTransitiveDependencies9 =
      AuthFlowControllerProvider.$allTransitiveDependencies7;
  static const $allTransitiveDependencies10 =
      AuthFlowControllerProvider.$allTransitiveDependencies8;
  static const $allTransitiveDependencies11 =
      AuthFlowControllerProvider.$allTransitiveDependencies9;
  static const $allTransitiveDependencies12 =
      AuthFlowControllerProvider.$allTransitiveDependencies10;
  static const $allTransitiveDependencies13 =
      AuthFlowControllerProvider.$allTransitiveDependencies11;
  static const $allTransitiveDependencies14 =
      AuthFlowControllerProvider.$allTransitiveDependencies12;
  static const $allTransitiveDependencies15 =
      AuthFlowControllerProvider.$allTransitiveDependencies13;
  static const $allTransitiveDependencies16 =
      AuthFlowControllerProvider.$allTransitiveDependencies14;
  static const $allTransitiveDependencies17 =
      AuthFlowControllerProvider.$allTransitiveDependencies15;

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
    r'78fc7696db57bd81a4d194fb0f6f377bb8e11860';

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
