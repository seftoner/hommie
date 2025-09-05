// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toast_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(toastService)
const toastServiceProvider = ToastServiceProvider._();

final class ToastServiceProvider
    extends $FunctionalProvider<ToastService, ToastService, ToastService>
    with $Provider<ToastService> {
  const ToastServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toastServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toastServiceHash();

  @$internal
  @override
  $ProviderElement<ToastService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ToastService create(Ref ref) {
    return toastService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToastService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToastService>(value),
    );
  }
}

String _$toastServiceHash() => r'7a5b2d93bec3a375c11b31d6045fd75762e867ba';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
