import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Dependencies([ActiveServer])
class ActivateServerTask extends HTask<void, Object> {
  final Ref _ref;

  ActivateServerTask(this._ref);

  @override
  Future<HTaskResult<void, Object>> execute(
    TaskExecutionContext context,
  ) async {
    try {
      final Server server = context.get('server')!;
      // Use ActiveServerProvider instead of direct repository access
      await _ref.read(activeServerProvider.notifier).setActive(server.id!);
      return HTaskResult.success(null);
    } catch (e) {
      return HTaskResult.failure(e);
    }
  }

  @override
  String get name => 'ActivateServerTask';

  @override
  Future<void> rollback(TaskExecutionContext context) async {
    throw UnimplementedError();
  }

  @override
  bool get supportsRollback => false;
}
