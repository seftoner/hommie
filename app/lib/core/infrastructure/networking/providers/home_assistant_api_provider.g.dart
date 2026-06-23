// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_assistant_api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeAssistantApi)
const homeAssistantApiProvider = HomeAssistantApiFamily._();

final class HomeAssistantApiProvider
    extends
        $FunctionalProvider<
          AsyncValue<HomeAssistantApi>,
          HomeAssistantApi,
          FutureOr<HomeAssistantApi>
        >
    with $FutureModifier<HomeAssistantApi>, $FutureProvider<HomeAssistantApi> {
  const HomeAssistantApiProvider._({
    required HomeAssistantApiFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'homeAssistantApiProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = serverConfigProvider;
  static const $allTransitiveDependencies1 = serverAuthTokenProvider;
  static const $allTransitiveDependencies2 = httpClientProvider;

  @override
  String debugGetCreateSourceHash() => _$homeAssistantApiHash();

  @override
  String toString() {
    return r'homeAssistantApiProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<HomeAssistantApi> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HomeAssistantApi> create(Ref ref) {
    final argument = this.argument as int;
    return homeAssistantApi(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeAssistantApiProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$homeAssistantApiHash() => r'810729372c214c5e920d2b0dc2b68a478e6234fe';

final class HomeAssistantApiFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HomeAssistantApi>, int> {
  const HomeAssistantApiFamily._()
    : super(
        retry: null,
        name: r'homeAssistantApiProvider',
        dependencies: const <ProviderOrFamily>[
          serverConfigProvider,
          serverAuthTokenProvider,
          httpClientProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          HomeAssistantApiProvider.$allTransitiveDependencies0,
          HomeAssistantApiProvider.$allTransitiveDependencies1,
          HomeAssistantApiProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: false,
      );

  HomeAssistantApiProvider call(int serverId) =>
      HomeAssistantApiProvider._(argument: serverId, from: this);

  @override
  String toString() => r'homeAssistantApiProvider';
}
