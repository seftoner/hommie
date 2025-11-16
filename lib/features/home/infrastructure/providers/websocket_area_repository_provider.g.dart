// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_area_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides WebSocket-based area repository for a specific server
///
/// This fetches area data directly from Home Assistant via WebSocket API
/// Use this when you need real-time area data from a specific server

@ProviderFor(websocketAreaRepository)
const websocketAreaRepositoryProvider = WebsocketAreaRepositoryFamily._();

/// Provides WebSocket-based area repository for a specific server
///
/// This fetches area data directly from Home Assistant via WebSocket API
/// Use this when you need real-time area data from a specific server

final class WebsocketAreaRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<IAreaRepository>,
          IAreaRepository,
          FutureOr<IAreaRepository>
        >
    with $FutureModifier<IAreaRepository>, $FutureProvider<IAreaRepository> {
  /// Provides WebSocket-based area repository for a specific server
  ///
  /// This fetches area data directly from Home Assistant via WebSocket API
  /// Use this when you need real-time area data from a specific server
  const WebsocketAreaRepositoryProvider._({
    required WebsocketAreaRepositoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'websocketAreaRepositoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = serverConnectionManagerProvider;
  static const $allTransitiveDependencies1 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ServerConnectionManagerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      ServerConnectionManagerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      ServerConnectionManagerProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      ServerConnectionManagerProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$websocketAreaRepositoryHash();

  @override
  String toString() {
    return r'websocketAreaRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<IAreaRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IAreaRepository> create(Ref ref) {
    final argument = this.argument as int;
    return websocketAreaRepository(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WebsocketAreaRepositoryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$websocketAreaRepositoryHash() =>
    r'c6617fad01ad82358a3c53c28f081bf4ab5c95f6';

/// Provides WebSocket-based area repository for a specific server
///
/// This fetches area data directly from Home Assistant via WebSocket API
/// Use this when you need real-time area data from a specific server

final class WebsocketAreaRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<IAreaRepository>, int> {
  const WebsocketAreaRepositoryFamily._()
    : super(
        retry: null,
        name: r'websocketAreaRepositoryProvider',
        dependencies: const <ProviderOrFamily>[serverConnectionManagerProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies0,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies1,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies2,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies3,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies4,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies5,
        },
        isAutoDispose: true,
      );

  /// Provides WebSocket-based area repository for a specific server
  ///
  /// This fetches area data directly from Home Assistant via WebSocket API
  /// Use this when you need real-time area data from a specific server

  WebsocketAreaRepositoryProvider call(int serverId) =>
      WebsocketAreaRepositoryProvider._(argument: serverId, from: this);

  @override
  String toString() => r'websocketAreaRepositoryProvider';
}
