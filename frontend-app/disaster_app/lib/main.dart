import 'package:flutter/material.dart';
import 'screens/main_navigation.dart';

void main() {
  runApp(const DisasterApp());
}

class DisasterApp extends StatelessWidget {
  const DisasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disaster Management App',
      home: MainNavigation(),
    );
  }
}
