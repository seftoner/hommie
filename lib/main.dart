import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/initializer.dart';

Future<void> main() async {
  runApp(
    UncontrolledProviderScope(
      container: await initialize(),
      child: const HommieApp(),
    ),
  );
}
