// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryFamily._();

final class AuthRepositoryProvider
    extends
        $FunctionalProvider<IAuthRepository, IAuthRepository, IAuthRepository>
    with $Provider<IAuthRepository> {
  const AuthRepositoryProvider._({
    required AuthRepositoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'authRepositoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @override
  String toString() {
    return r'authRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<IAuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IAuthRepository create(Ref ref) {
    final argument = this.argument as int;
    return authRepository(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IAuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IAuthRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AuthRepositoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$authRepositoryHash() => r'2aae748fe02d1cd1f976e298b2ce7fbf6be36494';

final class AuthRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<IAuthRepository, int> {
  const AuthRepositoryFamily._()
    : super(
        retry: null,
        name: r'authRepositoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AuthRepositoryProvider call(int serverId) =>
      AuthRepositoryProvider._(argument: serverId, from: this);

  @override
  String toString() => r'authRepositoryProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
