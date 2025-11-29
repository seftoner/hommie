// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serverConfig)
const serverConfigProvider = ServerConfigFamily._();

final class ServerConfigProvider
    extends $FunctionalProvider<AsyncValue<Server>, Server, FutureOr<Server>>
    with $FutureModifier<Server>, $FutureProvider<Server> {
  const ServerConfigProvider._({
    required ServerConfigFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'serverConfigProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$serverConfigHash();

  @override
  String toString() {
    return r'serverConfigProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Server> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Server> create(Ref ref) {
    final argument = this.argument as int;
    return serverConfig(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ServerConfigProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$serverConfigHash() => r'0350c6de12d9c0d61ee474c926979fac49e8c87e';

final class ServerConfigFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Server>, int> {
  const ServerConfigFamily._()
    : super(
        retry: null,
        name: r'serverConfigProvider',
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
        isAutoDispose: false,
      );

  ServerConfigProvider call(int serverId) =>
      ServerConfigProvider._(argument: serverId, from: this);

  @override
  String toString() => r'serverConfigProvider';
}
