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

String _$serverAuthTokenHash() => r'6af2aafd01444307219e88d440ed355423dc115c';

final class ServerAuthTokenFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HAOAuth2Token>, int> {
  const ServerAuthTokenFamily._()
    : super(
        retry: null,
        name: r'serverAuthTokenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ServerAuthTokenProvider call(int serverId) =>
      ServerAuthTokenProvider._(argument: serverId, from: this);

  @override
  String toString() => r'serverAuthTokenProvider';
}
