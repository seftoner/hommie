import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/bootstrap.dart';
import 'package:hommie/services/networking/provider.dart';

Future<void> main() async {
/*   final c = ProviderScope(
    child: Consumer(builder: (context, ref, child) {
      final hy = ref.watch(hAServerConnectionProvider);
      return hy.when(
        data: (data) => UncontrolledProviderScope(
          container: ProviderContainer(overrides: [
            haProviderProvider.overrideWithValue(data),
          ]),
          child: const HommieApp(),
        ),
        error: (error, stackTrace) => SizedBox(),
        loading: () => SizedBox(),
      );
    }),
  ); */

  // runApp(c);
  runApp(
    UncontrolledProviderScope(
      container: await bootstrap(),
      child: const HommieApp(),
    ),
  );
}
