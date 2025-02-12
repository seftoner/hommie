// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'2aae748fe02d1cd1f976e298b2ce7fbf6be36494';

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

/// See also [authRepository].
@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryFamily();

/// See also [authRepository].
class AuthRepositoryFamily extends Family<IAuthRepository> {
  /// See also [authRepository].
  const AuthRepositoryFamily();

  /// See also [authRepository].
  AuthRepositoryProvider call(
    int serverId,
  ) {
    return AuthRepositoryProvider(
      serverId,
    );
  }

  @override
  AuthRepositoryProvider getProviderOverride(
    covariant AuthRepositoryProvider provider,
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
  String? get name => r'authRepositoryProvider';
}

/// See also [authRepository].
class AuthRepositoryProvider extends AutoDisposeProvider<IAuthRepository> {
  /// See also [authRepository].
  AuthRepositoryProvider(
    int serverId,
  ) : this._internal(
          (ref) => authRepository(
            ref as AuthRepositoryRef,
            serverId,
          ),
          from: authRepositoryProvider,
          name: r'authRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authRepositoryHash,
          dependencies: AuthRepositoryFamily._dependencies,
          allTransitiveDependencies:
              AuthRepositoryFamily._allTransitiveDependencies,
          serverId: serverId,
        );

  AuthRepositoryProvider._internal(
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
    IAuthRepository Function(AuthRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthRepositoryProvider._internal(
        (ref) => create(ref as AuthRepositoryRef),
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
  AutoDisposeProviderElement<IAuthRepository> createElement() {
    return _AuthRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthRepositoryProvider && other.serverId == serverId;
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
mixin AuthRepositoryRef on AutoDisposeProviderRef<IAuthRepository> {
  /// The parameter `serverId` of this provider.
  int get serverId;
}

class _AuthRepositoryProviderElement
    extends AutoDisposeProviderElement<IAuthRepository> with AuthRepositoryRef {
  _AuthRepositoryProviderElement(super.provider);

  @override
  int get serverId => (origin as AuthRepositoryProvider).serverId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
