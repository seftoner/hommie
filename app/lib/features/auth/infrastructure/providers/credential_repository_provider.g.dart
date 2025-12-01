// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(credentialRepository)
const credentialRepositoryProvider = CredentialRepositoryProvider._();

final class CredentialRepositoryProvider
    extends
        $FunctionalProvider<
          ICredentialRepository,
          ICredentialRepository,
          ICredentialRepository
        >
    with $Provider<ICredentialRepository> {
  const CredentialRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'credentialRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$credentialRepositoryHash();

  @$internal
  @override
  $ProviderElement<ICredentialRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ICredentialRepository create(Ref ref) {
    return credentialRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ICredentialRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ICredentialRepository>(value),
    );
  }
}

String _$credentialRepositoryHash() =>
    r'a36c0e526b1fbccd043ee6d0a362cbc945ff5020';
