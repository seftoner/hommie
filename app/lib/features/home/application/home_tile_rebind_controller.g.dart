// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tile_rebind_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeTileRebindController)
final homeTileRebindControllerProvider = HomeTileRebindControllerProvider._();

final class HomeTileRebindControllerProvider
    extends $NotifierProvider<HomeTileRebindController, void> {
  HomeTileRebindControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeTileRebindControllerProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[serverScopeIdProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          HomeTileRebindControllerProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = serverScopeIdProvider;

  @override
  String debugGetCreateSourceHash() => _$homeTileRebindControllerHash();

  @$internal
  @override
  HomeTileRebindController create() => HomeTileRebindController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$homeTileRebindControllerHash() =>
    r'aea40897598c0b00f0b76650ab4fa5b22199ea84';

abstract class _$HomeTileRebindController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
