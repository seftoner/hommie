// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_server_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveServer)
const activeServerProvider = ActiveServerProvider._();

final class ActiveServerProvider
    extends $AsyncNotifierProvider<ActiveServer, Server?> {
  const ActiveServerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeServerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeServerHash();

  @$internal
  @override
  ActiveServer create() => ActiveServer();
}

String _$activeServerHash() => r'41504888b73b0aa8a8910700d0f85cc11dea6320';

abstract class _$ActiveServer extends $AsyncNotifier<Server?> {
  FutureOr<Server?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Server?>, Server?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Server?>, Server?>,
              AsyncValue<Server?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
