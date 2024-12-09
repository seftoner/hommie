import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/ui/screens/widgets/offline_banner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainPage extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(connectionStateProvider);

    return Scaffold(
      body: Column(
        children: [
          if (connectionState != NetworkConnectionState.connected)
            OfflineBanner(
              message: switch (connectionState) {
                NetworkConnectionState.connecting => "Trying to reconnect...",
                NetworkConnectionState.disconnected =>
                  "Connection lost. Retrying in 5 seconds...",
                _ => "",
              },
            ),
          Expanded(
            child: navigationShell,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        selectedIndex: navigationShell.currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
