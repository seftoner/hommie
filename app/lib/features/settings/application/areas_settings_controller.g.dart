// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AreasSettingsController)
final areasSettingsControllerProvider = AreasSettingsControllerProvider._();

final class AreasSettingsControllerProvider
    extends $AsyncNotifierProvider<AreasSettingsController, void> {
  AreasSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'areasSettingsControllerProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          activeServerSessionProvider,
          areaRegistrySyncServiceProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AreasSettingsControllerProvider.$allTransitiveDependencies0,
          AreasSettingsControllerProvider.$allTransitiveDependencies1,
          AreasSettingsControllerProvider.$allTransitiveDependencies2,
          AreasSettingsControllerProvider.$allTransitiveDependencies3,
          AreasSettingsControllerProvider.$allTransitiveDependencies4,
          AreasSettingsControllerProvider.$allTransitiveDependencies5,
          AreasSettingsControllerProvider.$allTransitiveDependencies6,
        },
      );

  static final $allTransitiveDependencies0 = activeServerSessionProvider;
  static final $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 = areaRegistrySyncServiceProvider;
  static final $allTransitiveDependencies6 =
      AreaRegistrySyncServiceProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$areasSettingsControllerHash();

  @$internal
  @override
  AreasSettingsController create() => AreasSettingsController();
}

String _$areasSettingsControllerHash() =>
    r'7454453a447f55bdac916ee9880251b14c159812';

abstract class _$AreasSettingsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
