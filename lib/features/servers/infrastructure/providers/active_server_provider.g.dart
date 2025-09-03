// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_server_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
        dependencies: const <ProviderOrFamily>[serverManagerProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ActiveServerProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverManagerProvider;

  @override
  String debugGetCreateSourceHash() => _$activeServerHash();

  @$internal
  @override
  ActiveServer create() => ActiveServer();
}

String _$activeServerHash() => r'750168c9d6cb8d43ffeebc7707be4f55fc8c7810';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
