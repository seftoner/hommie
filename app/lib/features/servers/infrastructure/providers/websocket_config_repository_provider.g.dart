// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_config_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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
    r'ec97afce3340a7a06ea4f749542243d885113667';

/// Provides WebSocket config repository for server-level operations
///
/// This handles ping, config, and other server-wide operations via WebSocket

final class WebsocketConfigRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<IWebSocketConfigRepository>, int> {
  const WebsocketConfigRepositoryFamily._()
    : super(
        retry: null,
        name: r'websocketConfigRepositoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
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
