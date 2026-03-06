import 'package:flutter/material.dart';
import 'screens/main_navigation.dart';

void main() {
  runApp(const RakshaSetuApp());
}

class RakshaSetuApp extends StatefulWidget {
  const RakshaSetuApp({super.key});

  @override
  State<RakshaSetuApp> createState() => _RakshaSetuAppState();
}

class _RakshaSetuAppState extends State<RakshaSetuApp> {
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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F3A5F), // professional navy tone
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F3A5F),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1F3A5F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),

      darkTheme: ThemeData.dark(useMaterial3: true),

      home: MainNavigation(isDarkMode: isDarkMode, onThemeChanged: toggleTheme),
    );
  }
}
