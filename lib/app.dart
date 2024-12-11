import 'package:flutter/material.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/ui/screens/widgets/offline_container.dart';
import 'package:hommie/ui/styles/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';

class HommieApp extends ConsumerWidget {
  const HommieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return _EagerInitialization(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: HommieMaterialTheme(
                Typography.material2021(platform: defaultTargetPlatform).black)
            .light(),
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],
        builder: (context, child) {
          return OfflineContainer(child: child);
        },
      ),
    );
  }
}

//TODO: Revise this
class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.

    return child;
  }
}
