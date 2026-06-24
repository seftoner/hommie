// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_revocation_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRevocationHandler)
final authRevocationHandlerProvider = AuthRevocationHandlerProvider._();

final class AuthRevocationHandlerProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  AuthRevocationHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRevocationHandlerProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          activeServerSessionProvider,
          serverLifecycleControllerProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AuthRevocationHandlerProvider.$allTransitiveDependencies0,
          AuthRevocationHandlerProvider.$allTransitiveDependencies1,
          AuthRevocationHandlerProvider.$allTransitiveDependencies2,
          AuthRevocationHandlerProvider.$allTransitiveDependencies3,
          AuthRevocationHandlerProvider.$allTransitiveDependencies4,
          AuthRevocationHandlerProvider.$allTransitiveDependencies5,
          AuthRevocationHandlerProvider.$allTransitiveDependencies6,
          AuthRevocationHandlerProvider.$allTransitiveDependencies7,
        },
      );

  static final $allTransitiveDependencies0 = activeServerSessionProvider;
  static final $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 = serverLifecycleControllerProvider;
  static final $allTransitiveDependencies6 =
      ServerLifecycleControllerProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies7 =
      ServerLifecycleControllerProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$authRevocationHandlerHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return authRevocationHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$authRevocationHandlerHash() =>
    r'adf869504d3a591d3ab4ab28972238fff6ac822f';
