import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/ui/keys.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class AppScaffoldPage extends ConsumerWidget {
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
        destinations: [
          NavigationDestination(
            key: K.appScaffold.homeButton,
            icon: Icon(
              Symbols.home_rounded,
              fill: navigationShell.currentIndex == 0 ? 1 : 0,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            key: K.appScaffold.automationButton,
            icon: Icon(
              Symbols.bolt_rounded,
              fill: navigationShell.currentIndex == 1 ? 1 : 0,
            ),
            label: 'Automations',
          ),
        ],
      ),
    );
  }
}
