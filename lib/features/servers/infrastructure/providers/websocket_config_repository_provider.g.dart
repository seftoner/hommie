// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_config_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Provides WebSocket config repository for server-level operations
///
/// This handles ping, config, and other server-wide operations via WebSocket
@ProviderFor(websocketConfigRepository)
const websocketConfigRepositoryProvider = WebsocketConfigRepositoryFamily._();

/// Provides WebSocket config repository for server-level operations
///
/// This handles ping, config, and other server-wide operations via WebSocket
final class WebsocketConfigRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<IWebSocketConfigRepository>,
          IWebSocketConfigRepository,
          FutureOr<IWebSocketConfigRepository>
        >
    with
        $FutureModifier<IWebSocketConfigRepository>,
        $FutureProvider<IWebSocketConfigRepository> {
  /// Provides WebSocket config repository for server-level operations
  ///
  /// This handles ping, config, and other server-wide operations via WebSocket
  const WebsocketConfigRepositoryProvider._({
    required WebsocketConfigRepositoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'websocketConfigRepositoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = serverConnectionProvider;
  static const $allTransitiveDependencies1 =
      ServerConnectionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ServerConnectionProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      ServerConnectionProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      ServerConnectionProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      ServerConnectionProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$websocketConfigRepositoryHash();

  @override
  String toString() {
    return r'websocketConfigRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<IWebSocketConfigRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IWebSocketConfigRepository> create(Ref ref) {
    final argument = this.argument as int;
    return websocketConfigRepository(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WebsocketConfigRepositoryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$websocketConfigRepositoryHash() =>
    r'ba88005b63e6874c3bdcdb49dbc4b01b28ed9279';

/// Provides WebSocket config repository for server-level operations
///
/// This handles ping, config, and other server-wide operations via WebSocket
final class WebsocketConfigRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<IWebSocketConfigRepository>, int> {
  const WebsocketConfigRepositoryFamily._()
    : super(
        retry: null,
        name: r'websocketConfigRepositoryProvider',
        dependencies: const <ProviderOrFamily>[serverConnectionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          WebsocketConfigRepositoryProvider.$allTransitiveDependencies0,
          WebsocketConfigRepositoryProvider.$allTransitiveDependencies1,
          WebsocketConfigRepositoryProvider.$allTransitiveDependencies2,
          WebsocketConfigRepositoryProvider.$allTransitiveDependencies3,
          WebsocketConfigRepositoryProvider.$allTransitiveDependencies4,
          WebsocketConfigRepositoryProvider.$allTransitiveDependencies5,
        },
        isAutoDispose: true,
      );

  /// Provides WebSocket config repository for server-level operations
  ///
  /// This handles ping, config, and other server-wide operations via WebSocket
  WebsocketConfigRepositoryProvider call(int serverId) =>
      WebsocketConfigRepositoryProvider._(argument: serverId, from: this);

  @override
  String toString() => r'websocketConfigRepositoryProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
