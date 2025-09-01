// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(httpClient)
const httpClientProvider = HttpClientProvider._();

final class HttpClientProvider
    extends
        $FunctionalProvider<http.BaseClient, http.BaseClient, http.BaseClient>
    with $Provider<http.BaseClient> {
  const HttpClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpClientHash();

  @$internal
  @override
  $ProviderElement<http.BaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  http.BaseClient create(Ref ref) {
    return httpClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(http.BaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<http.BaseClient>(value),
    );
  }
}

String _$httpClientHash() => r'6cd50a42ed5fa83bd674e814b057c34760fe70fb';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
