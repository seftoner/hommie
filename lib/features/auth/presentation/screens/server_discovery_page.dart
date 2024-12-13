import 'package:flutter/material.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/servers_discovery_controller.dart';
import 'package:hommie/features/auth/presentation/widgets/w_available_severs_list_title.dart';
import 'package:hommie/features/auth/presentation/widgets/w_empty_state.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServerDiscoveryPage extends HookConsumerWidget {
  const ServerDiscoveryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discoveredServers = ref.watch(serversDiscoveryControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Servers Discovery"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AvailableSeversListTitle(),
            $h16,
            Expanded(
              child: discoveredServers.when(
                data: (servers) {
                  if (servers.isEmpty) {
                    return EmptyState(
                      text: "No servers found.",
                      onRefresh: () => ref
                          .read(serversDiscoveryControllerProvider.notifier)
                          .refresh(),
                    );
                  }
                  return ListView.builder(
                    itemCount: servers.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(servers[index].name),
                            subtitle: Text(servers[index].uri.toString()),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              ref
                                  .read(authControllerProvider.notifier)
                                  .login(servers[index].uri.toString());
                            },
                          ),
                          Divider(),
                        ],
                      );
                    },
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (e, _) => EmptyState(
                  text: "Error discovering servers.",
                  onRefresh: () => ref
                      .read(serversDiscoveryControllerProvider.notifier)
                      .refresh(),
                ),
              ),
            ),
            Text(
              "Not finding your screen?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () => {const EnterAddressRoute().push(context)},
              child: const Text("Enter addres manually"),
            ),
          ],
        ),
      ),
    );
  }
}
