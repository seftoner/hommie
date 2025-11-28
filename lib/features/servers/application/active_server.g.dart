// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_server.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeServer)
const activeServerProvider = ActiveServerProvider._();

final class ActiveServerProvider
    extends $FunctionalProvider<AsyncValue<Server?>, Server?, Stream<Server?>>
    with $FutureModifier<Server?>, $StreamProvider<Server?> {
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
  $StreamProviderElement<Server?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Server?> create(Ref ref) {
    return activeServer(ref);
  }
}

String _$activeServerHash() => r'6f4c0c91d55b350152b728e7212cb3e691aa0ef9';
