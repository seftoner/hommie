// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_for_server_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(areasForServer)
final areasForServerProvider = AreasForServerFamily._();

final class AreasForServerProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Area>>,
          List<Area>,
          Stream<List<Area>>
        >
    with $FutureModifier<List<Area>>, $StreamProvider<List<Area>> {
  AreasForServerProvider._({
    required AreasForServerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'areasForServerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = areaRepositoryProvider;

  @override
  String debugGetCreateSourceHash() => _$areasForServerHash();

  @override
  String toString() {
    return r'areasForServerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Area>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Area>> create(Ref ref) {
    final argument = this.argument as int;
    return areasForServer(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AreasForServerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$areasForServerHash() => r'6385afe49edb87355920b653014d9bce6cf40caf';

final class AreasForServerFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Area>>, int> {
  AreasForServerFamily._()
    : super(
        retry: null,
        name: r'areasForServerProvider',
        dependencies: <ProviderOrFamily>[areaRepositoryProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          AreasForServerProvider.$allTransitiveDependencies0,
        ],
        isAutoDispose: true,
      );

  AreasForServerProvider call(int serverId) =>
      AreasForServerProvider._(argument: serverId, from: this);

  @override
  String toString() => r'areasForServerProvider';
}
