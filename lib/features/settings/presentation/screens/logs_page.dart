import 'package:flutter/material.dart';
import 'package:hommie/features/settings/application/logs_controller.dart';
import 'package:hommie/features/settings/application/logs_list_controller.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogsPage extends HookConsumerWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLogs = ref.watch(logsListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
        actions: [
          IconButton(
              onPressed: () {
                final box = context.findRenderObject() as RenderBox?;
                final position = box!.localToGlobal(Offset.zero) & box.size;
                ref.read(logsControlerProvider.notifier).shareLogs(position);
              },
              icon: const Icon(Icons.share)),
        ],
      ),
      body: switch (appLogs) {
        // Display all the messages in a scrollable list view.
        AsyncData(:final value) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final message = value[index].msg;
              return Text(message);
            },
          ),
        AsyncError(:final error) => Text(error.toString()),
        _ => const CircularProgressIndicator(),
      },
    );
  }
}
