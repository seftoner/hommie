import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Dependencies([ActiveServer])
class ActivateServerIfExistTask extends HTask {
  final IServerManager _serverManager;
  final Ref _ref;

  ActivateServerIfExistTask(this._serverManager, this._ref);

  @override
  Future<HTaskResult> execute(TaskExecutionContext context) async {
    final serverId = context.get<int>('serverId')!;

    // Step 1: Get all available servers
    final servers = await _serverManager.getAvailableServers();

    // Step 2: Find next available server (excluding the one being signed out)
    final availableServers = servers
        .where((server) => server.id != serverId)
        .toList();

    // Step 3: Activate next server if available
    if (availableServers.isNotEmpty) {
      final nextServer = availableServers.first;
      await _ref.read(activeServerProvider.notifier).setActive(nextServer.id!);
      logger.i('Activated next server: ${nextServer.id}');
    } else {
      logger.i('No other servers available after sign out');
    }

    return const HTaskResult(status: Status.success);
  }

  @override
  bool get supportsRollback => false;

  @override
  String get name => 'Activate Server If Exists Task';
}
