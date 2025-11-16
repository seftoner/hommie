// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_device_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides WebSocket-based device repository for a specific server
///
/// This fetches device data directly from Home Assistant via WebSocket API
/// Use this when you need real-time device data from a specific server

@ProviderFor(websocketDeviceRepository)
const websocketDeviceRepositoryProvider = WebsocketDeviceRepositoryFamily._();

/// Provides WebSocket-based device repository for a specific server
///
/// This fetches device data directly from Home Assistant via WebSocket API
/// Use this when you need real-time device data from a specific server

final class WebsocketDeviceRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<IDeviceRepository>,
          IDeviceRepository,
          FutureOr<IDeviceRepository>
        >
    with
        $FutureModifier<IDeviceRepository>,
        $FutureProvider<IDeviceRepository> {
  /// Provides WebSocket-based device repository for a specific server
  ///
  /// This fetches device data directly from Home Assistant via WebSocket API
  /// Use this when you need real-time device data from a specific server
  const WebsocketDeviceRepositoryProvider._({
    required WebsocketDeviceRepositoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'websocketDeviceRepositoryProvider',
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

  @override
  String debugGetCreateSourceHash() => _$websocketDeviceRepositoryHash();

  @override
  String toString() {
    return r'websocketDeviceRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<IDeviceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IDeviceRepository> create(Ref ref) {
    final argument = this.argument as int;
    return websocketDeviceRepository(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WebsocketDeviceRepositoryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$websocketDeviceRepositoryHash() =>
    r'290f28a4e28ee3c025dbdbbf5034d67e19cc2828';

/// Provides WebSocket-based device repository for a specific server
///
/// This fetches device data directly from Home Assistant via WebSocket API
/// Use this when you need real-time device data from a specific server

final class WebsocketDeviceRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<IDeviceRepository>, int> {
  const WebsocketDeviceRepositoryFamily._()
    : super(
        retry: null,
        name: r'websocketDeviceRepositoryProvider',
        dependencies: const <ProviderOrFamily>[serverConnectionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          WebsocketDeviceRepositoryProvider.$allTransitiveDependencies0,
          WebsocketDeviceRepositoryProvider.$allTransitiveDependencies1,
          WebsocketDeviceRepositoryProvider.$allTransitiveDependencies2,
          WebsocketDeviceRepositoryProvider.$allTransitiveDependencies3,
          WebsocketDeviceRepositoryProvider.$allTransitiveDependencies4,
          WebsocketDeviceRepositoryProvider.$allTransitiveDependencies5,
          WebsocketDeviceRepositoryProvider.$allTransitiveDependencies6,
          WebsocketDeviceRepositoryProvider.$allTransitiveDependencies7,
        },
        isAutoDispose: true,
      );

  /// Provides WebSocket-based device repository for a specific server
  ///
  /// This fetches device data directly from Home Assistant via WebSocket API
  /// Use this when you need real-time device data from a specific server

  WebsocketDeviceRepositoryProvider call(int serverId) =>
      WebsocketDeviceRepositoryProvider._(argument: serverId, from: this);

  @override
  String toString() => r'websocketDeviceRepositoryProvider';
}
