import 'package:flutter/material.dart';
import 'admin_login_screen.dart';

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
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🌙 Dark Mode Toggle
                SwitchListTile(
                  title: const Text("Dark Mode"),
                  value: widget.isDarkMode,
                  onChanged: (value) {
                    widget.onThemeChanged(value);
                  },
                ),

                const Divider(),

                // 🚨 Auto Alert Toggle
                SwitchListTile(
                  title: const Text("Enable Auto Alerts"),
                  value: autoAlert,
                  onChanged: (value) {
                    setState(() {
                      autoAlert = value;
                    });
                  },
                ),

                // 🆘 Auto SOS Toggle
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

                // 🔐 Admin Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminLoginScreen(),
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
