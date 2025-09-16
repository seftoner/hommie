// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides a singleton auth repository that can handle multiple servers
///
/// This replaces the family provider pattern with a single repository
/// that accepts server IDs as method parameters

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

/// Provides a singleton auth repository that can handle multiple servers
///
/// This replaces the family provider pattern with a single repository
/// that accepts server IDs as method parameters

final class AuthRepositoryProvider
    extends
        $FunctionalProvider<IAuthRepository, IAuthRepository, IAuthRepository>
    with $Provider<IAuthRepository> {
  /// Provides a singleton auth repository that can handle multiple servers
  ///
  /// This replaces the family provider pattern with a single repository
  /// that accepts server IDs as method parameters
  const AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<IAuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IAuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IAuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IAuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'2974b39cbe410017cd4334a51e5536398adadb2a';
