// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(databaseConnection)
const databaseConnectionProvider = DatabaseConnectionProvider._();

final class DatabaseConnectionProvider
    extends $FunctionalProvider<Isar, Isar, Isar>
    with $Provider<Isar> {
  const DatabaseConnectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseConnectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseConnectionHash();

  @$internal
  @override
  $ProviderElement<Isar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Isar create(Ref ref) {
    return databaseConnection(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Isar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Isar>(value),
    );
  }
}

String _$databaseConnectionHash() =>
    r'762e131d5c0e767fbcbd601cd4e3da5cb89ccf6b';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
