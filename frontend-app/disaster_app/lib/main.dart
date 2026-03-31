import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/main_navigation.dart';
import 'screens/admin_login_screen.dart';

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

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  // ✅ LOAD SAVED THEME
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool("isDarkMode") ?? false;
    });
  }

  // ✅ SAVE + APPLY THEME
  void toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", value);

    setState(() {
      isDarkMode = value;
    });
  }

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RakshaSetu',

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F3A5F)),
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

      home: FutureBuilder<bool>(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.data == true) {
            return MainNavigation(
              isDarkMode: isDarkMode,
              onThemeChanged: toggleTheme,
            );
          } else {
            return const AdminLoginScreen();
          }
        },
      ),
    );
  }
}
