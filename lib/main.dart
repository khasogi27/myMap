import 'package:flutter/material.dart';
import 'package:flutter_ol/feature/presentation/page/home/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Map',
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}
