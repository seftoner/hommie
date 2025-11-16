// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serverConnection)
const serverConnectionProvider = ServerConnectionFamily._();

final class ServerConnectionProvider
    extends
        $FunctionalProvider<
          AsyncValue<HAConnection>,
          HAConnection,
          FutureOr<HAConnection>
        >
    with $FutureModifier<HAConnection>, $FutureProvider<HAConnection> {
  const ServerConnectionProvider._({
    required ServerConnectionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'serverConnectionProvider',
         isAutoDispose: false,
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
  static const $allTransitiveDependencies6 =
      ServerConnectionManagerProvider.$allTransitiveDependencies5;

  @override
  String debugGetCreateSourceHash() => _$serverConnectionHash();

  @override
  String toString() {
    return r'serverConnectionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<HAConnection> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HAConnection> create(Ref ref) {
    final argument = this.argument as int;
    return serverConnection(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ServerConnectionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$serverConnectionHash() => r'ddeeca7bdcf21e6b8f46da0f68a7526a73a345a3';

final class ServerConnectionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HAConnection>, int> {
  const ServerConnectionFamily._()
    : super(
        retry: null,
        name: r'serverConnectionProvider',
        dependencies: const <ProviderOrFamily>[serverConnectionManagerProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ServerConnectionProvider.$allTransitiveDependencies0,
          ServerConnectionProvider.$allTransitiveDependencies1,
          ServerConnectionProvider.$allTransitiveDependencies2,
          ServerConnectionProvider.$allTransitiveDependencies3,
          ServerConnectionProvider.$allTransitiveDependencies4,
          ServerConnectionProvider.$allTransitiveDependencies5,
          ServerConnectionProvider.$allTransitiveDependencies6,
        },
        isAutoDispose: false,
      );

  ServerConnectionProvider call(int serverId) =>
      ServerConnectionProvider._(argument: serverId, from: this);

  @override
  String toString() => r'serverConnectionProvider';
}
