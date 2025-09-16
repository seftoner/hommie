// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(logsRepository)
const logsRepositoryProvider = LogsRepositoryProvider._();

final class LogsRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ILogsRepository>,
          ILogsRepository,
          FutureOr<ILogsRepository>
        >
    with $FutureModifier<ILogsRepository>, $FutureProvider<ILogsRepository> {
  const LogsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ILogsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ILogsRepository> create(Ref ref) {
    return logsRepository(ref);
  }
}

String _$logsRepositoryHash() => r'ec415373032ba2b1a6450d258263883884b93514';
