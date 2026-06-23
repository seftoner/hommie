// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_revocation_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRevocationHandler)
const authRevocationHandlerProvider = AuthRevocationHandlerProvider._();

final class AuthRevocationHandlerProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  const AuthRevocationHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRevocationHandlerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          activeServerSessionProvider,
          serverLifecycleControllerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          AuthRevocationHandlerProvider.$allTransitiveDependencies0,
          AuthRevocationHandlerProvider.$allTransitiveDependencies1,
          AuthRevocationHandlerProvider.$allTransitiveDependencies2,
          AuthRevocationHandlerProvider.$allTransitiveDependencies3,
          AuthRevocationHandlerProvider.$allTransitiveDependencies4,
          AuthRevocationHandlerProvider.$allTransitiveDependencies5,
          AuthRevocationHandlerProvider.$allTransitiveDependencies6,
          AuthRevocationHandlerProvider.$allTransitiveDependencies7,
          AuthRevocationHandlerProvider.$allTransitiveDependencies8,
        },
      );

  static const $allTransitiveDependencies0 = activeServerSessionProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      ActiveServerSessionProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies6 = serverLifecycleControllerProvider;
  static const $allTransitiveDependencies7 =
      ServerLifecycleControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies8 =
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
