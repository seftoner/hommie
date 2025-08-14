import 'package:flutter/material.dart';
import 'package:hommie/features/auth/application/app_state_handler.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:hommie/core/bootstrap/app_startup.dart';
// import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
// import 'package:hommie/features/auth/infrastructure/repositories/secure_credentials_storage.dart';
// import 'package:hommie/features/auth/presentation/screens/server_discovery_page.dart';
// import 'package:hommie/features/server_manager/infrastructure/providers/server_manager_provider.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/ui/screens/widgets/offline_container.dart';
import 'package:hommie/ui/styles/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HommieApp extends StatelessWidget {
  const HommieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ServiceInitializer(
      child: _RootAppWidget(),
    );
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
      routerConfig: ref.read(goRouterProvider),
      theme: HommieMaterialTheme.platform().light(),
      darkTheme: HommieMaterialTheme.platformDark().dark(),
      supportedLocales: const [
        Locale('en', ''),
      ],
      builder: (context, child) => OfflineContainer(child: child),
    );
  }
}

class _ServiceInitializer extends ConsumerWidget {
  const _ServiceInitializer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appStateHandlerProvider);
    ref.watch(connectionStateProvider);
    return child;
  }
}

/* class HommieAppV2 extends ConsumerWidget {
  const HommieAppV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final activeServer = ref.watch(serverManagerProvider);

    // return activeServer.when(
    //   data: (server) {
    //     if (server == null) {
    //       return const ServerDiscoveryPage();
    //     }
    //     final crendetialStorage =
    //         SecureCredentialRepository(const FlutterSecureStorage(), server.id);

    //     return ProviderScope(
    //       overrides: [
    //         credentialsRepositoryProvider.overrideWithValue(crendetialStorage),
    //       ],
    //       child: const _RootAppWidget(),
    //     );
    //   },
    //   loading: () => MaterialApp(home: const AppStartup()),
    //   error: (error, stack) => MaterialApp(home: ErrorWidget('Error: $error')),
    // );

    return ProviderScope(
      child: Consumer(builder: (context, ref, _) {
        final activeServer = ref.watch(serverManagerProvider);
        // return SecureCredentialRepository(const FlutterSecureStorage(), serverId);

        return activeServer.when(
          data: (server) {
            if (server == null) {
              return const ServerDiscoveryPage();
            }

            // ref.watch(credentialsRepositoryProvider);

            return MaterialApp.router(
              title: 'Hommie',
              debugShowCheckedModeBanner: false,
              showPerformanceOverlay: false,
              routerConfig: ref.read(goRouterProvider),
              theme: HommieMaterialTheme.platform().light(),
              darkTheme: HommieMaterialTheme.platformDark().dark(),
              supportedLocales: const [
                Locale('en', ''),
              ],
              builder: (context, child) => OfflineContainer(child: child),
            );
          },
          loading: () => const AppStartup(),
          error: (error, stack) => Text('Error: $error'),
        );
      }),
    );
  }
}
 */
