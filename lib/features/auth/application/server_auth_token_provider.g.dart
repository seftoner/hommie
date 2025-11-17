// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_auth_token_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serverAuthToken)
const serverAuthTokenProvider = ServerAuthTokenFamily._();

final class ServerAuthTokenProvider
    extends
        $FunctionalProvider<
          AsyncValue<HAOAuth2Token>,
          HAOAuth2Token,
          FutureOr<HAOAuth2Token>
        >
    with $FutureModifier<HAOAuth2Token>, $FutureProvider<HAOAuth2Token> {
  const ServerAuthTokenProvider._({
    required ServerAuthTokenFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'serverAuthTokenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = serverCredentialsProvider;

  @override
  String debugGetCreateSourceHash() => _$serverAuthTokenHash();

  @override
  String toString() {
    return r'serverAuthTokenProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<HAOAuth2Token> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HAOAuth2Token> create(Ref ref) {
    final argument = this.argument as int;
    return serverAuthToken(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ServerAuthTokenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$serverAuthTokenHash() => r'cdff06eecc41b46940dd603f0ec1e52d352f46df';

final class ServerAuthTokenFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HAOAuth2Token>, int> {
  const ServerAuthTokenFamily._()
    : super(
        retry: null,
        name: r'serverAuthTokenProvider',
        dependencies: const <ProviderOrFamily>[serverCredentialsProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ServerAuthTokenProvider.$allTransitiveDependencies0,
        ],
        isAutoDispose: true,
      );

  ServerAuthTokenProvider call(int serverId) =>
      ServerAuthTokenProvider._(argument: serverId, from: this);

  @override
  String toString() => r'serverAuthTokenProvider';
}
