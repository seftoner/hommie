// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
        isAutoDispose: false,
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

String _$httpClientHash() => r'93c2abbd5c09cf0a1ee118b362e22d2449134043';
