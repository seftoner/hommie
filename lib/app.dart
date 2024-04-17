import 'package:flutter/material.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/ui/styles/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HommieApp extends ConsumerWidget {
  const HommieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: ref.watch(goRouterProvider),
        theme: HommieMaterialTheme(
                Typography.material2021(platform: TargetPlatform.iOS).black)
            .light(),
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ]);
  }
}
