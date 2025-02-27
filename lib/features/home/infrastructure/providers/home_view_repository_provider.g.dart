// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeViewRepositoryHash() =>
    r'2fffce619323f43dcf25ba24d3c2c72d1039a031';

/// See also [homeViewRepository].
@ProviderFor(homeViewRepository)
final homeViewRepositoryProvider =
    AutoDisposeFutureProvider<IHomeViewRepository>.internal(
  homeViewRepository,
  name: r'homeViewRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeViewRepositoryRef
    = AutoDisposeFutureProviderRef<IHomeViewRepository>;
String _$homeViewRepositoryForServerHash() =>
    r'50182a0e435575b188b26fe2e83c419b3b396a84';

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

/// See also [homeViewRepositoryForServer].
@ProviderFor(homeViewRepositoryForServer)
const homeViewRepositoryForServerProvider = HomeViewRepositoryForServerFamily();

/// See also [homeViewRepositoryForServer].
class HomeViewRepositoryForServerFamily extends Family<IHomeViewRepository> {
  /// See also [homeViewRepositoryForServer].
  const HomeViewRepositoryForServerFamily();

  /// See also [homeViewRepositoryForServer].
  HomeViewRepositoryForServerProvider call(
    int serverId,
  ) {
    return HomeViewRepositoryForServerProvider(
      serverId,
    );
  }

  @override
  HomeViewRepositoryForServerProvider getProviderOverride(
    covariant HomeViewRepositoryForServerProvider provider,
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
  String? get name => r'homeViewRepositoryForServerProvider';
}

/// See also [homeViewRepositoryForServer].
class HomeViewRepositoryForServerProvider
    extends AutoDisposeProvider<IHomeViewRepository> {
  /// See also [homeViewRepositoryForServer].
  HomeViewRepositoryForServerProvider(
    int serverId,
  ) : this._internal(
          (ref) => homeViewRepositoryForServer(
            ref as HomeViewRepositoryForServerRef,
            serverId,
          ),
          from: homeViewRepositoryForServerProvider,
          name: r'homeViewRepositoryForServerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$homeViewRepositoryForServerHash,
          dependencies: HomeViewRepositoryForServerFamily._dependencies,
          allTransitiveDependencies:
              HomeViewRepositoryForServerFamily._allTransitiveDependencies,
          serverId: serverId,
        );

  HomeViewRepositoryForServerProvider._internal(
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
    IHomeViewRepository Function(HomeViewRepositoryForServerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HomeViewRepositoryForServerProvider._internal(
        (ref) => create(ref as HomeViewRepositoryForServerRef),
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
  AutoDisposeProviderElement<IHomeViewRepository> createElement() {
    return _HomeViewRepositoryForServerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeViewRepositoryForServerProvider &&
        other.serverId == serverId;
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
mixin HomeViewRepositoryForServerRef
    on AutoDisposeProviderRef<IHomeViewRepository> {
  /// The parameter `serverId` of this provider.
  int get serverId;
}

class _HomeViewRepositoryForServerProviderElement
    extends AutoDisposeProviderElement<IHomeViewRepository>
    with HomeViewRepositoryForServerRef {
  _HomeViewRepositoryForServerProviderElement(super.provider);

  @override
  int get serverId => (origin as HomeViewRepositoryForServerProvider).serverId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
