import 'package:flutter/material.dart';
import 'package:hommie/src/router.dart';

class HommieApp extends StatelessWidget {
  const HommieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.routerDelegate,
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        // theme: const Material(),
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ]);
  }
}
