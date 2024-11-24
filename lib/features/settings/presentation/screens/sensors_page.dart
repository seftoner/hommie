import 'package:flutter/material.dart';
import 'package:hommie/features/settings/presentation/screens/sensors_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SensorsPage extends HookConsumerWidget {
  const SensorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensors = ref.watch(sensorsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: switch (sensors) {
        AsyncData(value: var data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index].name),
                trailing: Text(data[index].state.toString()),
              );
            },
          ),
        AsyncError() => const Text('Oops, something unexpected happened'),
        AsyncLoading() => const CircularProgressIndicator(),
        _ => const Text("Whoops!"),
      },
    );
  }
}
