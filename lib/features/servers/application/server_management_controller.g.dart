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
        },
      );

  static const $allTransitiveDependencies0 = serversListProvider;
  static const $allTransitiveDependencies1 = authFlowControllerProvider;
  static const $allTransitiveDependencies2 =
      AuthFlowControllerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies3 =
      AuthFlowControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies4 =
      AuthFlowControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies5 =
      AuthFlowControllerProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies6 =
      AuthFlowControllerProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies7 =
      AuthFlowControllerProvider.$allTransitiveDependencies5;
  static const $allTransitiveDependencies8 = activeServerProvider;

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
    r'08c244a1dcdd9590f3eacda968f20877a7bc0e56';

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
