import 'package:example/example_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      home: ExamplePage(),
    );
  }
}
