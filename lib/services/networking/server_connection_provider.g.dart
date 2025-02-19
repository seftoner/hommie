// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverConnectionHash() => r'ddeeca7bdcf21e6b8f46da0f68a7526a73a345a3';

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

/// See also [serverConnection].
@ProviderFor(serverConnection)
const serverConnectionProvider = ServerConnectionFamily();

/// See also [serverConnection].
class ServerConnectionFamily extends Family<AsyncValue<HAConnection>> {
  /// See also [serverConnection].
  const ServerConnectionFamily();

  /// See also [serverConnection].
  ServerConnectionProvider call(
    int serverId,
  ) {
    return ServerConnectionProvider(
      serverId,
    );
  }

  @override
  ServerConnectionProvider getProviderOverride(
    covariant ServerConnectionProvider provider,
  ) {
    return call(
      provider.serverId,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    serverConnectionManagerProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    serverConnectionManagerProvider,
    ...?serverConnectionManagerProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'serverConnectionProvider';
}

/// See also [serverConnection].
class ServerConnectionProvider extends FutureProvider<HAConnection> {
  /// See also [serverConnection].
  ServerConnectionProvider(
    int serverId,
  ) : this._internal(
          (ref) => serverConnection(
            ref as ServerConnectionRef,
            serverId,
          ),
          from: serverConnectionProvider,
          name: r'serverConnectionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$serverConnectionHash,
          dependencies: ServerConnectionFamily._dependencies,
          allTransitiveDependencies:
              ServerConnectionFamily._allTransitiveDependencies,
          serverId: serverId,
        );

  ServerConnectionProvider._internal(
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
    FutureOr<HAConnection> Function(ServerConnectionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ServerConnectionProvider._internal(
        (ref) => create(ref as ServerConnectionRef),
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
  FutureProviderElement<HAConnection> createElement() {
    return _ServerConnectionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServerConnectionProvider && other.serverId == serverId;
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
mixin ServerConnectionRef on FutureProviderRef<HAConnection> {
  /// The parameter `serverId` of this provider.
  int get serverId;
}

class _ServerConnectionProviderElement
    extends FutureProviderElement<HAConnection> with ServerConnectionRef {
  _ServerConnectionProviderElement(super.provider);

  @override
  int get serverId => (origin as ServerConnectionProvider).serverId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
