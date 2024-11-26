import 'package:flutter/material.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/servers_discovery_controller.dart';
import 'package:hommie/features/auth/presentation/widgets/w_empty_state.dart';
import 'package:hommie/router/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServerDiscoveryPage extends HookConsumerWidget {
  const ServerDiscoveryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discoveredServers = ref.watch(serversDiscoveryControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Server Discovery"),
        // toolbarHeight: 112,
        centerTitle: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'Show Snackbar',
              onPressed: () =>
                  ref.invalidate(serversDiscoveryControllerProvider))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: discoveredServers.when(
                data: (servers) {
                  if (servers.isEmpty) {
                    return EmptyState(
                      text: "No servers found.",
                      onRefresh: () =>
                          ref.invalidate(serversDiscoveryControllerProvider),
                    );
                  }
                  return ListView.builder(
                    itemCount: servers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(servers[index].name),
                        subtitle: Text(servers[index].uri.toString()),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          ref
                              .read(authControllerProvider.notifier)
                              .login(servers[index].uri.toString());
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) =>
                    const Center(child: Text("Error discovering servers.")),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () => {const EnterAddressRoute().push(context)},
              child: const Text("Enter Manually"),
            ),
          ],
        ),
      ),
    );
  }
}
