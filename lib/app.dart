import 'package:flutter/material.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/ui/screens/widgets/offline_container.dart';
import 'package:hommie/ui/styles/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:hommie/features/auth/application/auth_state_handler.dart';

class HommieApp extends ConsumerWidget {
  const HommieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    ref.watch(authStateHandlerProvider);

    return MaterialApp.router(
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
    );
  }
}
