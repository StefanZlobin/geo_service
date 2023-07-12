import 'package:flutter/material.dart';
import 'package:geo_service/presentation/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'GEO service',
      home: Home(),
    );
  }
}
