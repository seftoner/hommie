// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boot_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BootStatusController)
const bootStatusControllerProvider = BootStatusControllerProvider._();

final class BootStatusControllerProvider
    extends $AsyncNotifierProvider<BootStatusController, BootStatus> {
  const BootStatusControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bootStatusControllerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[activeServerProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          BootStatusControllerProvider.$allTransitiveDependencies0,
          BootStatusControllerProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = activeServerProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$bootStatusControllerHash();

  @$internal
  @override
  BootStatusController create() => BootStatusController();
}

String _$bootStatusControllerHash() =>
    r'800671f9ba76cae737ceda84af120b230f6b4609';

abstract class _$BootStatusController extends $AsyncNotifier<BootStatus> {
  FutureOr<BootStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<BootStatus>, BootStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BootStatus>, BootStatus>,
              AsyncValue<BootStatus>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
