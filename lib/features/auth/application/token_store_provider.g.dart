// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_store_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tokenStore)
const tokenStoreProvider = TokenStoreFamily._();

final class TokenStoreProvider
    extends
        $FunctionalProvider<
          ServerTokenStore,
          ServerTokenStore,
          ServerTokenStore
        >
    with $Provider<ServerTokenStore> {
  const TokenStoreProvider._({
    required TokenStoreFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'tokenStoreProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = credentialRepositoryProvider;

  @override
  String debugGetCreateSourceHash() => _$tokenStoreHash();

  @override
  String toString() {
    return r'tokenStoreProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<ServerTokenStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ServerTokenStore create(Ref ref) {
    final argument = this.argument as int;
    return tokenStore(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServerTokenStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServerTokenStore>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TokenStoreProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tokenStoreHash() => r'ceedbadd52415cc26fa78c497e65d7d05685160f';

final class TokenStoreFamily extends $Family
    with $FunctionalFamilyOverride<ServerTokenStore, int> {
  const TokenStoreFamily._()
    : super(
        retry: null,
        name: r'tokenStoreProvider',
        dependencies: const <ProviderOrFamily>[credentialRepositoryProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          TokenStoreProvider.$allTransitiveDependencies0,
        ],
        isAutoDispose: false,
      );

  TokenStoreProvider call(int serverId) =>
      TokenStoreProvider._(argument: serverId, from: this);

  @override
  String toString() => r'tokenStoreProvider';
}
