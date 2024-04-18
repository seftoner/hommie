import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/bootstrap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  runApp(
    UncontrolledProviderScope(
      container: await bootstrap(),
      child: const HommieApp(),
    ),
  );
}
