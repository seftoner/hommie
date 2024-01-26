import 'package:flutter/material.dart';
import 'package:hommie/router.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/ui/styles/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HommieApp extends ConsumerWidget {
  const HommieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: HommieMaterialTheme(
                Typography.material2021(platform: TargetPlatform.iOS).black)
            .light(),
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ]);
  }
}
