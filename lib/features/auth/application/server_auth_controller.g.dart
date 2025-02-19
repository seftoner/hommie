// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverAuthControllerHash() =>
    r'6a71801285d925eb87c7a1345763dd309f9d5214';

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

abstract class _$ServerAuthController
    extends BuildlessAsyncNotifier<AuthState> {
  late final int serverId;

  FutureOr<AuthState> build(
    int serverId,
  );
}

/// See also [ServerAuthController].
@ProviderFor(ServerAuthController)
const serverAuthControllerProvider = ServerAuthControllerFamily();

/// See also [ServerAuthController].
class ServerAuthControllerFamily extends Family<AsyncValue<AuthState>> {
  /// See also [ServerAuthController].
  const ServerAuthControllerFamily();

  /// See also [ServerAuthController].
  ServerAuthControllerProvider call(
    int serverId,
  ) {
    return ServerAuthControllerProvider(
      serverId,
    );
  }

  @override
  ServerAuthControllerProvider getProviderOverride(
    covariant ServerAuthControllerProvider provider,
  ) {
    return call(
      provider.serverId,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies =
      const <ProviderOrFamily>[];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      const <ProviderOrFamily>{};

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'serverAuthControllerProvider';
}

/// See also [ServerAuthController].
class ServerAuthControllerProvider
    extends AsyncNotifierProviderImpl<ServerAuthController, AuthState> {
  /// See also [ServerAuthController].
  ServerAuthControllerProvider(
    int serverId,
  ) : this._internal(
          () => ServerAuthController()..serverId = serverId,
          from: serverAuthControllerProvider,
          name: r'serverAuthControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$serverAuthControllerHash,
          dependencies: ServerAuthControllerFamily._dependencies,
          allTransitiveDependencies:
              ServerAuthControllerFamily._allTransitiveDependencies,
          serverId: serverId,
        );

  ServerAuthControllerProvider._internal(
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
  FutureOr<AuthState> runNotifierBuild(
    covariant ServerAuthController notifier,
  ) {
    return notifier.build(
      serverId,
    );
  }

  @override
  Override overrideWith(ServerAuthController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ServerAuthControllerProvider._internal(
        () => create()..serverId = serverId,
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
  AsyncNotifierProviderElement<ServerAuthController, AuthState>
      createElement() {
    return _ServerAuthControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServerAuthControllerProvider && other.serverId == serverId;
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
mixin ServerAuthControllerRef on AsyncNotifierProviderRef<AuthState> {
  /// The parameter `serverId` of this provider.
  int get serverId;
}

class _ServerAuthControllerProviderElement
    extends AsyncNotifierProviderElement<ServerAuthController, AuthState>
    with ServerAuthControllerRef {
  _ServerAuthControllerProviderElement(super.provider);

  @override
  int get serverId => (origin as ServerAuthControllerProvider).serverId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
