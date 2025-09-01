// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_server_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Example of how easy it is to create server-dependent providers with the new approach.
///
/// Before (old approach):
/// - Had to manually invalidate this provider in active_server_provider.dart
/// - Had to remember to add ref.invalidate() calls
/// - Risk of forgetting to invalidate, causing stale data
///
/// Now (ProviderScope approach):
/// - Just depend on the scoped providers
/// - Automatically updates when server changes
/// - No manual invalidation needed
/// - No risk of stale data
@ProviderFor(exampleEntities)
const exampleEntitiesProvider = ExampleEntitiesProvider._();

/// Example of how easy it is to create server-dependent providers with the new approach.
///
/// Before (old approach):
/// - Had to manually invalidate this provider in active_server_provider.dart
/// - Had to remember to add ref.invalidate() calls
/// - Risk of forgetting to invalidate, causing stale data
///
/// Now (ProviderScope approach):
/// - Just depend on the scoped providers
/// - Automatically updates when server changes
/// - No manual invalidation needed
/// - No risk of stale data
final class ExampleEntitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// Example of how easy it is to create server-dependent providers with the new approach.
  ///
  /// Before (old approach):
  /// - Had to manually invalidate this provider in active_server_provider.dart
  /// - Had to remember to add ref.invalidate() calls
  /// - Risk of forgetting to invalidate, causing stale data
  ///
  /// Now (ProviderScope approach):
  /// - Just depend on the scoped providers
  /// - Automatically updates when server changes
  /// - No manual invalidation needed
  /// - No risk of stale data
  const ExampleEntitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exampleEntitiesProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          serverScopeConnectionProvider,
          serverScopeIdProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ExampleEntitiesProvider.$allTransitiveDependencies0,
          ExampleEntitiesProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeConnectionProvider;
  static const $allTransitiveDependencies1 = serverScopeIdProvider;

  @override
  String debugGetCreateSourceHash() => _$exampleEntitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return exampleEntities(ref);
  }
}

String _$exampleEntitiesHash() => r'0ac90308fb5740ba7f90fe75ad32c19656a63fc1';

@ProviderFor(exampleServerInfo)
const exampleServerInfoProvider = ExampleServerInfoProvider._();

final class ExampleServerInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  const ExampleServerInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exampleServerInfoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          serverScopeServerProvider,
          serverScopeIdProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ExampleServerInfoProvider.$allTransitiveDependencies0,
          ExampleServerInfoProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeServerProvider;
  static const $allTransitiveDependencies1 = serverScopeIdProvider;

  @override
  String debugGetCreateSourceHash() => _$exampleServerInfoHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return exampleServerInfo(ref);
  }
}

String _$exampleServerInfoHash() => r'4a835cc548b704421e24627916b75710a60ae49b';

@ProviderFor(exampleServerStatus)
const exampleServerStatusProvider = ExampleServerStatusProvider._();

final class ExampleServerStatusProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  const ExampleServerStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exampleServerStatusProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[serverScopeConnectionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ExampleServerStatusProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeConnectionProvider;

  @override
  String debugGetCreateSourceHash() => _$exampleServerStatusHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return exampleServerStatus(ref);
  }
}

String _$exampleServerStatusHash() =>
    r'baf5fd0b27192e69baf62f2a203e03c55dab8c4a';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
