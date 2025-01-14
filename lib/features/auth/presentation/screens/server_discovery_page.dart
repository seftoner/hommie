import 'package:flutter/material.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/servers_discovery_controller.dart';
import 'package:hommie/features/auth/domain/entities/ha_server.dart';
import 'package:hommie/features/auth/presentation/widgets/w_available_severs_list_title.dart';
import 'package:hommie/features/auth/presentation/widgets/w_empty_state.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/styles/corners.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServerDiscoveryPage extends HookConsumerWidget {
  const ServerDiscoveryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discoveredServers = ref.watch(serversDiscoveryControllerProvider);

    return Scaffold(
      key: K.serversDiscovery.page,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 24.0,
                ),
                child: Text(
                  'Servers Discovery',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AvailableSeversListTitle(),
                    $h16,
                    Expanded(
                      child: discoveredServers.when(
                        data: (servers) {
                          if (servers.isEmpty) {
                            return EmptyState(
                              text: 'No servers found.',
                              onRefresh: () => ref
                                  .read(serversDiscoveryControllerProvider
                                      .notifier)
                                  .refresh(),
                            );
                          }
                          return SingleChildScrollView(
                            child: DiscoveredHaServersList(
                              servers: servers,
                              onTap: (serverAddress) {
                                ref
                                    .read(authControllerProvider.notifier)
                                    .login(serverAddress.toString());
                              },
                            ),
                          );
                        },
                        loading: () => const SizedBox.shrink(),
                        error: (e, _) => EmptyState(
                          text: 'Error discovering servers.',
                          onRefresh: () => ref
                              .read(serversDiscoveryControllerProvider.notifier)
                              .refresh(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const EnterAddressManually(),
            ],
          ),
        ),
      ),
    );
  }
}

class EnterAddressManually extends StatelessWidget {
  const EnterAddressManually({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Not finding your screen?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        $h16,
        FilledButton.tonal(
          key: K.serversDiscovery.enterManuallyButton,
          onPressed: () => {const EnterAddressRoute().push(context)},
          child: const Text('Enter addres manually'),
        ),
      ],
    );
  }
}

typedef TapCallback = void Function(Uri serverAddress);

class DiscoveredHaServersList extends StatelessWidget {
  final List<HaServer> servers;
  final TapCallback onTap;

  const DiscoveredHaServersList({
    super.key,
    required this.servers,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: corners.radius(Corners.medium),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: servers.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: ListTile(
              title: Text(servers[index].name),
              subtitle: Text(servers[index].uri.toString()),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onTap(servers[index].uri),
            ),
          );
        },
      ),
    );
  }
}
