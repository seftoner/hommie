// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeViewRepository)
const homeViewRepositoryProvider = HomeViewRepositoryProvider._();

final class HomeViewRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<IHomeViewRepository>,
          IHomeViewRepository,
          FutureOr<IHomeViewRepository>
        >
    with
        $FutureModifier<IHomeViewRepository>,
        $FutureProvider<IHomeViewRepository> {
  const HomeViewRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeViewRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeViewRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<IHomeViewRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IHomeViewRepository> create(Ref ref) {
    return homeViewRepository(ref);
  }
}

String _$homeViewRepositoryHash() =>
    r'7b4ee71f267e059c446f4b6157a903f1c68bf8b3';

@ProviderFor(homeViewRepositoryForServer)
const homeViewRepositoryForServerProvider =
    HomeViewRepositoryForServerFamily._();

final class HomeViewRepositoryForServerProvider
    extends
        $FunctionalProvider<
          IHomeViewRepository,
          IHomeViewRepository,
          IHomeViewRepository
        >
    with $Provider<IHomeViewRepository> {
  const HomeViewRepositoryForServerProvider._({
    required HomeViewRepositoryForServerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'homeViewRepositoryForServerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$homeViewRepositoryForServerHash();

  @override
  String toString() {
    return r'homeViewRepositoryForServerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<IHomeViewRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IHomeViewRepository create(Ref ref) {
    final argument = this.argument as int;
    return homeViewRepositoryForServer(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IHomeViewRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IHomeViewRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HomeViewRepositoryForServerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$homeViewRepositoryForServerHash() =>
    r'a297356dda947e813d7a3fcbe82dcf302a019c5e';

final class HomeViewRepositoryForServerFamily extends $Family
    with $FunctionalFamilyOverride<IHomeViewRepository, int> {
  const HomeViewRepositoryForServerFamily._()
    : super(
        retry: null,
        name: r'homeViewRepositoryForServerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HomeViewRepositoryForServerProvider call(int serverId) =>
      HomeViewRepositoryForServerProvider._(argument: serverId, from: this);

  @override
  String toString() => r'homeViewRepositoryForServerProvider';
}
