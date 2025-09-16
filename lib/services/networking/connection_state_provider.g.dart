// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A Riverpod provider that manages the network connection state of the application.
///
/// This provider keeps track of the current network connectivity status and
/// provides methods to update the connection state. It is marked as keepAlive
/// to ensure the state persists across widget rebuilds.

@ProviderFor(ServerConnectionState)
const serverConnectionStateProvider = ServerConnectionStateProvider._();

/// A Riverpod provider that manages the network connection state of the application.
///
/// This provider keeps track of the current network connectivity status and
/// provides methods to update the connection state. It is marked as keepAlive
/// to ensure the state persists across widget rebuilds.
final class ServerConnectionStateProvider
    extends $NotifierProvider<ServerConnectionState, HAServerConnectionState> {
  /// A Riverpod provider that manages the network connection state of the application.
  ///
  /// This provider keeps track of the current network connectivity status and
  /// provides methods to update the connection state. It is marked as keepAlive
  /// to ensure the state persists across widget rebuilds.
  const ServerConnectionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverConnectionStateProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$serverConnectionStateHash();

  @$internal
  @override
  ServerConnectionState create() => ServerConnectionState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HAServerConnectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HAServerConnectionState>(value),
    );
  }
}

String _$serverConnectionStateHash() =>
    r'32ad7d257501aa0b8214e92822984ff4df1b6fbe';

/// A Riverpod provider that manages the network connection state of the application.
///
/// This provider keeps track of the current network connectivity status and
/// provides methods to update the connection state. It is marked as keepAlive
/// to ensure the state persists across widget rebuilds.

abstract class _$ServerConnectionState
    extends $Notifier<HAServerConnectionState> {
  HAServerConnectionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<HAServerConnectionState, HAServerConnectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HAServerConnectionState, HAServerConnectionState>,
              HAServerConnectionState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
