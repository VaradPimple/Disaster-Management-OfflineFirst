import 'package:flutter/material.dart';
import 'admin_login_screen.dart';
import 'signup_screen.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool autoAlert = true;
  bool autoSOS = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SwitchListTile(
                  title: const Text("Dark Mode"),
                  value: widget.isDarkMode,
                  onChanged: (value) {
                    widget.onThemeChanged(value);
                  },
                ),

                const Divider(),

                SwitchListTile(
                  title: const Text("Enable Auto Alerts"),
                  value: autoAlert,
                  onChanged: (value) {
                    setState(() {
                      autoAlert = value;
                    });
                  },
                ),

                SwitchListTile(
                  title: const Text("Enable Auto SOS"),
                  value: autoSOS,
                  onChanged: (value) {
                    setState(() {
                      autoSOS = value;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // ✅ SIGNUP BUTTON
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                       builder: (context) => SignupScreen(), // fixed
                      ),
                    );
                  },
                  child: const Text("Create User Account"),
                ),

                const SizedBox(height: 15),

                // ✅ LOGIN BUTTON
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminLoginScreen(), // fixed
                      ),
                    );
                  },
                  child: const Text("Admin Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
