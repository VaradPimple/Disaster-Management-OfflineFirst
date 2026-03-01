import 'package:flutter/material.dart';
import 'screens/main_navigation.dart';

void main() {
  runApp(const DisasterApp());
}

class DisasterApp extends StatefulWidget {
  const DisasterApp({super.key});

  @override
  State<DisasterApp> createState() => _DisasterAppState();
}

class _DisasterAppState extends State<DisasterApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RakshaSetu',

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      darkTheme: ThemeData.dark(useMaterial3: true),

      home: MainNavigation(isDarkMode: isDarkMode, onThemeChanged: toggleTheme),
    );
  }
}
