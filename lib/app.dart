import 'package:flutter/material.dart';
import 'package:hommie/app/scopes/server_scope_host.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/ui/screens/widgets/offline_container.dart';
import 'package:hommie/ui/styles/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([ServerConnectionState])
class HommieApp extends StatelessWidget {
  const HommieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ServiceInitializer(
      child: ServerScopeHost(child: _RootAppWidget()),
    );
  }
}

@Dependencies([goRouter, ServerConnectionState])
class _RootAppWidget extends ConsumerWidget {
  const _RootAppWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Hommie',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      routerConfig: ref.read(goRouterProvider),
      theme: HommieMaterialTheme.platform().light(),
      darkTheme: HommieMaterialTheme.platformDark().dark(),
      supportedLocales: const [Locale('en', '')],
      builder: (context, child) => OfflineContainer(child: child),
    );
  }
}

@Dependencies([ServerConnectionState])
class _ServiceInitializer extends ConsumerWidget {
  const _ServiceInitializer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(serverConnectionStateProvider);
    return child;
  }
}
