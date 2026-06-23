// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_status_projections.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(offlineBannerVisibility)
const offlineBannerVisibilityProvider = OfflineBannerVisibilityProvider._();

final class OfflineBannerVisibilityProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const OfflineBannerVisibilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineBannerVisibilityProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[activeServerSessionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          OfflineBannerVisibilityProvider.$allTransitiveDependencies0,
          OfflineBannerVisibilityProvider.$allTransitiveDependencies1,
          OfflineBannerVisibilityProvider.$allTransitiveDependencies2,
          OfflineBannerVisibilityProvider.$allTransitiveDependencies3,
          OfflineBannerVisibilityProvider.$allTransitiveDependencies4,
        },
      );

  static const $allTransitiveDependencies0 = activeServerSessionProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$offlineBannerVisibilityHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return offlineBannerVisibility(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$offlineBannerVisibilityHash() =>
    r'57f04c16b5875ebedaf2ce953391580528d473f9';

@ProviderFor(homeConnectionLoading)
const homeConnectionLoadingProvider = HomeConnectionLoadingProvider._();

final class HomeConnectionLoadingProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const HomeConnectionLoadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeConnectionLoadingProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[activeServerSessionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          HomeConnectionLoadingProvider.$allTransitiveDependencies0,
          HomeConnectionLoadingProvider.$allTransitiveDependencies1,
          HomeConnectionLoadingProvider.$allTransitiveDependencies2,
          HomeConnectionLoadingProvider.$allTransitiveDependencies3,
          HomeConnectionLoadingProvider.$allTransitiveDependencies4,
        },
      );

  static const $allTransitiveDependencies0 = activeServerSessionProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$homeConnectionLoadingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return homeConnectionLoading(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$homeConnectionLoadingHash() =>
    r'c165f8d4ae82e1a1ae3a3da26708f9b89e3573e1';
