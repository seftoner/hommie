// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_credentials_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serverCredentials)
const serverCredentialsProvider = ServerCredentialsFamily._();

final class ServerCredentialsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Credentials>,
          Credentials,
          FutureOr<Credentials>
        >
    with $FutureModifier<Credentials>, $FutureProvider<Credentials> {
  const ServerCredentialsProvider._({
    required ServerCredentialsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'serverCredentialsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = authRepositoryProvider;

  @override
  String debugGetCreateSourceHash() => _$serverCredentialsHash();

  @override
  String toString() {
    return r'serverCredentialsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Credentials> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Credentials> create(Ref ref) {
    final argument = this.argument as int;
    return serverCredentials(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ServerCredentialsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$serverCredentialsHash() => r'2d54716680388f23b49ce6835e480ef968fcbef0';

final class ServerCredentialsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Credentials>, int> {
  const ServerCredentialsFamily._()
    : super(
        retry: null,
        name: r'serverCredentialsProvider',
        dependencies: const <ProviderOrFamily>[authRepositoryProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ServerCredentialsProvider.$allTransitiveDependencies0,
        ],
        isAutoDispose: true,
      );

  ServerCredentialsProvider call(int serverId) =>
      ServerCredentialsProvider._(argument: serverId, from: this);

  @override
  String toString() => r'serverCredentialsProvider';
}
