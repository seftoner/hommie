// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_management_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
        dependencies: null,
        $allTransitiveDependencies: null,
      );

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
    r'dac4b1ceab577f40884be8c88da75df38862a41d';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
