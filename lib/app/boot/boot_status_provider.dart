import 'dart:async';

import 'package:hommie/app/boot/boot_status.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'boot_status_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [ActiveServer])
class BootStatusController extends _$BootStatusController {
  @override
  Future<BootStatus> build() async {
    try {
      final serverManager = ref.read(serverManagerProvider);

      // Warm up persisted server state so downstream providers can synchronously
      // query configuration during router guards.
      await serverManager.getAvailableServers();

      // Ensure the active server (if any) is hydrated before we declare boot
      // ready. Use `read` to avoid re-running boot when the active server flips.
      await ref.read(activeServerProvider.future);

      return const BootStatus.ready();
    } catch (error, stackTrace) {
      logger.e(
        'Boot process failed: $error',
        error: error,
        stackTrace: stackTrace,
      );
      return BootStatus.failure(error, stackTrace);
    }
  }

  Future<void> retry() async {
    // Allow UI to retry the boot process.
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
