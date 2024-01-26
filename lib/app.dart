import 'package:flutter/material.dart';
import 'package:hommie/router.dart';
import 'package:hommie/ui/styles/theme.dart';

class HommieApp extends StatelessWidget {
  const HommieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.routerDelegate,
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        theme: HommieMaterialTheme(
                Typography.material2021(platform: TargetPlatform.iOS).black)
            .light(),
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ]);
  }
}
