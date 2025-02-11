// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$credentialsRepositoryHash() =>
    r'154cfa5da488cd918c3e59e85ad26efe2183ad96';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [credentialsRepository].
@ProviderFor(credentialsRepository)
const credentialsRepositoryProvider = CredentialsRepositoryFamily();

/// See also [credentialsRepository].
class CredentialsRepositoryFamily extends Family<ICredentialRepository> {
  /// See also [credentialsRepository].
  const CredentialsRepositoryFamily();

  /// See also [credentialsRepository].
  CredentialsRepositoryProvider call(
    int serverId,
  ) {
    return CredentialsRepositoryProvider(
      serverId,
    );
  }

  @override
  CredentialsRepositoryProvider getProviderOverride(
    covariant CredentialsRepositoryProvider provider,
  ) {
    return call(
      provider.serverId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'credentialsRepositoryProvider';
}

/// See also [credentialsRepository].
class CredentialsRepositoryProvider
    extends AutoDisposeProvider<ICredentialRepository> {
  /// See also [credentialsRepository].
  CredentialsRepositoryProvider(
    int serverId,
  ) : this._internal(
          (ref) => credentialsRepository(
            ref as CredentialsRepositoryRef,
            serverId,
          ),
          from: credentialsRepositoryProvider,
          name: r'credentialsRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$credentialsRepositoryHash,
          dependencies: CredentialsRepositoryFamily._dependencies,
          allTransitiveDependencies:
              CredentialsRepositoryFamily._allTransitiveDependencies,
          serverId: serverId,
        );

  CredentialsRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serverId,
  }) : super.internal();

  final int serverId;

  @override
  Override overrideWith(
    ICredentialRepository Function(CredentialsRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CredentialsRepositoryProvider._internal(
        (ref) => create(ref as CredentialsRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serverId: serverId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ICredentialRepository> createElement() {
    return _CredentialsRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CredentialsRepositoryProvider && other.serverId == serverId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serverId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CredentialsRepositoryRef
    on AutoDisposeProviderRef<ICredentialRepository> {
  /// The parameter `serverId` of this provider.
  int get serverId;
}

class _CredentialsRepositoryProviderElement
    extends AutoDisposeProviderElement<ICredentialRepository>
    with CredentialsRepositoryRef {
  _CredentialsRepositoryProviderElement(super.provider);

  @override
  int get serverId => (origin as CredentialsRepositoryProvider).serverId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
