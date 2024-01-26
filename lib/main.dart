import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/app.dart';
import 'package:hommie/utils/state_logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(observers: [StateLogger()], child: HommieApp()));
}
