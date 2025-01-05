import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppScaffoldPage extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const AppScaffoldPage({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        selectedIndex: navigationShell.currentIndex,
        destinations: <Widget>[
          NavigationDestination(
            key: K.appScaffold.homeButton,
            icon: const Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            key: K.appScaffold.settingsButton,
            icon: const Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
