import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/bootstrap.dart';

Future<void> main() async {
  runApp(
    UncontrolledProviderScope(
      container: await bootstrap(),
      child: const HommieApp(),
    ),
  );
}
