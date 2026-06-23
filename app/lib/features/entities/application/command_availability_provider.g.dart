// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_availability_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commandAvailability)
const commandAvailabilityProvider = CommandAvailabilityProvider._();

final class CommandAvailabilityProvider
    extends
        $FunctionalProvider<
          CommandAvailability,
          CommandAvailability,
          CommandAvailability
        >
    with $Provider<CommandAvailability> {
  const CommandAvailabilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commandAvailabilityProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[serverScopeConnectionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          CommandAvailabilityProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeConnectionProvider;

  @override
  String debugGetCreateSourceHash() => _$commandAvailabilityHash();

  @$internal
  @override
  $ProviderElement<CommandAvailability> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommandAvailability create(Ref ref) {
    return commandAvailability(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommandAvailability value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommandAvailability>(value),
    );
  }
}

String _$commandAvailabilityHash() =>
    r'af121f8dfe6b42df9f10abc282c4d2c57d59c692';
