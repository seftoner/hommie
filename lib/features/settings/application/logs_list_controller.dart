import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/settings/domain/entities/logs.dart';
import 'package:hommie/features/settings/infrastructure/providers/logs_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logs_list_controller.g.dart';

@riverpod
Stream<List<Log>> logsListController(Ref ref) async* {
  final repository = await ref.watch(logsRepositoryProvider.future);

  var logs = const <Log>[];
  await for (final newLog in repository.streamLogs()) {
    // A new message has been received. Let's add it to the list of all messages.
    logs = [...logs, newLog];
    yield logs;
  }
}
