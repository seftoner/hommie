// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(credentialsRepository)
const credentialsRepositoryProvider = CredentialsRepositoryFamily._();

final class CredentialsRepositoryProvider
    extends
        $FunctionalProvider<
          ICredentialRepository,
          ICredentialRepository,
          ICredentialRepository
        >
    with $Provider<ICredentialRepository> {
  const CredentialsRepositoryProvider._({
    required CredentialsRepositoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'credentialsRepositoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$credentialsRepositoryHash();

  @override
  String toString() {
    return r'credentialsRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<ICredentialRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ICredentialRepository create(Ref ref) {
    final argument = this.argument as int;
    return credentialsRepository(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ICredentialRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ICredentialRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CredentialsRepositoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$credentialsRepositoryHash() =>
    r'154cfa5da488cd918c3e59e85ad26efe2183ad96';

final class CredentialsRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<ICredentialRepository, int> {
  const CredentialsRepositoryFamily._()
    : super(
        retry: null,
        name: r'credentialsRepositoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CredentialsRepositoryProvider call(int serverId) =>
      CredentialsRepositoryProvider._(argument: serverId, from: this);

  @override
  String toString() => r'credentialsRepositoryProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
