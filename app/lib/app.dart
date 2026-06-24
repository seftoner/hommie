import 'package:flutter/material.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/auth_revocation_handler.dart';
import 'package:hommie/application/session/network_reconnect_supervisor.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/ui/screens/widgets/offline_container.dart';
import 'package:hommie/ui/styles/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([ActiveServerSession, authRevocationHandler])
class HommieApp extends StatelessWidget {
  const HommieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ServiceInitializer(child: _RootAppWidget());
  }
}

class _RootAppWidget extends ConsumerWidget {
  const _RootAppWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Hommie',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      routerConfig: ref.watch(goRouterProvider),
      theme: HommieMaterialTheme.platform().light(),
      darkTheme: HommieMaterialTheme.platformDark().dark(),
      supportedLocales: const [Locale('en', '')],
      builder: (context, child) => OfflineContainer(child: child),
    );
  }
}

@Dependencies([ActiveServerSession, authRevocationHandler])
class _ServiceInitializer extends ConsumerWidget {
  const _ServiceInitializer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(activeServerSessionProvider);
    ref.watch(authRevocationHandlerProvider);
    ref.watch(networkReconnectSupervisorProvider);
    return child;
  }
}
