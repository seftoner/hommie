// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(serverSettings)
const serverSettingsProvider = ServerSettingsProvider._();

final class ServerSettingsProvider
    extends
        $FunctionalProvider<
          IServerSettingsRepository,
          IServerSettingsRepository,
          IServerSettingsRepository
        >
    with $Provider<IServerSettingsRepository> {
  const ServerSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serverSettingsHash();

  @$internal
  @override
  $ProviderElement<IServerSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IServerSettingsRepository create(Ref ref) {
    return serverSettings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IServerSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IServerSettingsRepository>(value),
    );
  }
}

String _$serverSettingsHash() => r'4422529a3c7a06b14861fe31945a2334b61156be';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
