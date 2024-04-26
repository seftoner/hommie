import 'package:flutter/material.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';
import 'package:hommie/features/settings/presentation/screens/sensors_provide.dart';
import 'package:hommie/router/routes.dart';
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
                  // leading: const Icon(Icons.cloud),
                  title: Text(data[index].name),
                  // subtitle: const Text('Username'),
                  trailing: Text(data[index].state.toString()),
                  // onTap: () => {const HubRouteData().push(context)},
                );
              },
            ),
          AsyncError() => const Text('Oops, something unexpected happened'),
          AsyncLoading() => const CircularProgressIndicator(),
          _ => const Text("Whoops!"),
        }

        /* ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Hub name'),
            subtitle: const Text('Username'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => {const HubRouteData().push(context)},
          ),
          
        ],
      ), */
        );
  }
}
