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
  static const $allTransitiveDependencies6 =
      ServerConnectionProvider.$allTransitiveDependencies5;
  static const $allTransitiveDependencies7 =
      ServerConnectionProvider.$allTransitiveDependencies6;
  static const $allTransitiveDependencies8 =
      ServerConnectionProvider.$allTransitiveDependencies7;

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
    r'f5c55144c8af2d245a1b10cd450b21baca1e3dd1';

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
        dependencies: const <ProviderOrFamily>[serverConnectionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies0,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies1,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies2,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies3,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies4,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies5,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies6,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies7,
          WebsocketAreaRepositoryProvider.$allTransitiveDependencies8,
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
