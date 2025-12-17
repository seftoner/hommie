// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_scope_host.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getServerConnection)
const getServerConnectionProvider = GetServerConnectionFamily._();

final class GetServerConnectionProvider
    extends
        $FunctionalProvider<
          AsyncValue<IHAConnection>,
          IHAConnection,
          FutureOr<IHAConnection>
        >
    with $FutureModifier<IHAConnection>, $FutureProvider<IHAConnection> {
  const GetServerConnectionProvider._({
    required GetServerConnectionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'getServerConnectionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = serverConnectionManagerProvider;
  static const $allTransitiveDependencies1 =
      ServerConnectionManagerProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$getServerConnectionHash();

  @override
  String toString() {
    return r'getServerConnectionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<IHAConnection> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IHAConnection> create(Ref ref) {
    final argument = this.argument as int;
    return getServerConnection(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetServerConnectionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getServerConnectionHash() =>
    r'3e75daa7aa96e53163b671cc16d467b8efa50da9';

final class GetServerConnectionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<IHAConnection>, int> {
  const GetServerConnectionFamily._()
    : super(
        retry: null,
        name: r'getServerConnectionProvider',
        dependencies: const <ProviderOrFamily>[serverConnectionManagerProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          GetServerConnectionProvider.$allTransitiveDependencies0,
          GetServerConnectionProvider.$allTransitiveDependencies1,
        ],
        isAutoDispose: true,
      );

  GetServerConnectionProvider call(int serverId) =>
      GetServerConnectionProvider._(argument: serverId, from: this);

  @override
  String toString() => r'getServerConnectionProvider';
}
